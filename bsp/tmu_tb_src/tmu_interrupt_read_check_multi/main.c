#include <stdint.h>
#include <airisc.h>
#include <ee_printf.h> // use "embedded" ee_printf (much smaller!) instead of stdio's printf

#define CLOCK_HZ   (32000000) // processor clock frequency
#define UART0_BAUD (9600)     // default Baud rate
#define TICK_TIME  (CLOCK_HZ) // timer tick every 1s
#define TMU_MODE_ON    ((3<<4) + 0b0111) // TMU with compression, interrupt and and interrupt threshold of 3
#define TMU_MODE_OFF   ((3<<4) + 0b0000)
#include "../utils.h"

extern volatile uint32_t fixed_addr[12];
asm(".equ fixed_addr, 0x80010008"); //lets put it not at the start of the ram region and last 8bit != 0 to not update debug_out
extern volatile uint32_t debug;
asm(".equ debug, 0x80010000");
int main() {
    cpu_csr_write(CSR_MCOUNTINHIBIT, -1); // stop all counters
    cpu_csr_write(CSR_MCYCLE, 0);
    cpu_csr_write(CSR_MCYCLEH, 0);
    cpu_csr_write(CSR_MINSTRET, 0);
    cpu_csr_write(CSR_MINSTRETH, 0);
    cpu_csr_write(CSR_MCOUNTINHIBIT, 0); // enable all counters

    timer_set_time(timer0, 0); // reset time counter
    timer_set_timecmp(timer0, (uint64_t)(TICK_TIME*8)); // set tick frequency

    // enable CPU interrupts
    uint32_t tmp = 0;
    tmp |= (1 << IRQ_MTI); // machine timer interrupt
    tmp |= (1 << IRQ_XIRQ0) | (1 << IRQ_XIRQ1); // AIRISC-specific external interrupt channel 0 and 1
    tmp |= (1 << IRQ_XIRQ2) | (1 << IRQ_XIRQ3); // AIRISC-specific external interrupt channel 2 and 3
    tmp |= (1 << IRQ_XIRQ4) | (1 << IRQ_XIRQ5); // AIRISC-specific external interrupt channel 4 and 5
    tmp |= (1 << IRQ_XIRQ6) | (1 << IRQ_XIRQ7); // AIRISC-specific external interrupt channel 6 and 7
    cpu_csr_write(CSR_MIE, tmp); // enable interrupt sources
    cpu_csr_set(CSR_MSTATUS, 1 << MSTATUS_MIE); // enable machine-mode interupts

    debug=102;
    tmu_set_mode(TMU_BASE_ADDR, TMU_MODE_ON);

    //Generate specific dbus accesses
    for(;;)
    {
    fixed_addr[0]; //08
    fixed_addr[5]; //1C
    fixed_addr[1]; //0C
    fixed_addr[6]; //20

    fixed_addr[2]; //10
    fixed_addr[7]; //24
    fixed_addr[3]; //14 -- all other runs: 8
    fixed_addr[8]; //28 -- all other runs: real bis hier

    //fixed_addr[4]; //18 -- first run: 10
    //fixed_addr[9]; //2C -- frist run: real, bis hier
    }
    return 0;
}

/**********************************************************************//**
 * Custom interrupt handler (overriding the default DUMMY handler from "airisc.c").
 *
 * @note This is a "normal" function - so NO 'interrupt' attribute!
 *
 * @param[in] cause Exception identifier from mcause CSR.
 * @param[in] epc Exception program counter from mepc CSR.
 **************************************************************************/
static uint8_t i_run = 0;
void interrupt_handler(uint32_t cause, uint32_t epc) {
  // beaware that code here might be get recorded, only put code here for debug purposes
  // possible debug code: debug=55;
  switch(cause) {

    // -------------------------------------------------------
    // Machine timer interrupt (RISC-V-specific)
    // -------------------------------------------------------
    case MCAUSE_TIMER_INT_M:
      debug=91;
      // adjust timer compare register for next interrupt
      // this also clears/acknowledges the current machine timer interrupt
      timer_set_timecmp(timer0, timer_get_time(timer0) + (uint64_t)TICK_TIME);
      break;

    // -------------------------------------------------------
    // External interrupt (AIRISC-specific)
    // -------------------------------------------------------
    case MCAUSE_XIRQ0_INT:
    case MCAUSE_XIRQ1_INT:
        // Turn TMU OFF
        tmu_set_mode(TMU_BASE_ADDR, TMU_MODE_OFF);
        debug=6;
        // Check TMU status
        debug=tmu_get_status(TMU_BASE_ADDR);
        if(tmu_get_status(TMU_BASE_ADDR)!=0b100)
            TB_TEST_FAIL();
        // Drop recording items that are not of interest for this test
        tmu_set_next(TMU_BASE_ADDR, 1); //Drop first item
        if (i_run!=0) { //After the first interrupt we need to drop the second item because it is from stack store/restore
            debug=3;
            tmu_set_next(TMU_BASE_ADDR, 1);
        }
        // Check data 1 (Don't check timing of this element because it is not hard to guess)
        debug=4;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010008)
            TB_TEST_FAIL();
        debug=6;
        // Check data 2
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=7;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x8001001C)
            TB_TEST_FAIL();
        debug=8;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 3
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=9;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x8001000C)
            TB_TEST_FAIL();
        debug=10;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 4
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=11;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010020)
            TB_TEST_FAIL();
        debug=12;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 5
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=13;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010010)
            TB_TEST_FAIL();
        debug=14;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 6
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=15;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010024)
            TB_TEST_FAIL();
        debug=16;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 7
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=17;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010014)
            TB_TEST_FAIL();
        debug=18;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Check data 8
        tmu_set_next(TMU_BASE_ADDR, 1); //readout data
        debug=19;
        if(tmu_get_data0(TMU_BASE_ADDR)!=0x80010028)
            TB_TEST_FAIL();
        debug=20;
        if(tmu_get_data1(TMU_BASE_ADDR)!=0xC004)
            TB_TEST_FAIL();
        // Clear remaining records
        debug=21;
        while(tmu_get_status(TMU_BASE_ADDR)!=0b010) { // fifo needs to be empty!
            debug=22;
            tmu_set_next(TMU_BASE_ADDR, 1); //flush any remaining data
            debug=5; // report error as long as we stay in this loop
        }
        i_run++;
        debug=31;
        if(i_run>=5) { // DO 5 RUNS
            TB_TEST_PASS();
        }
        cpu_csr_write(CSR_MIP, cpu_csr_read(CSR_MIP) & (~(1 << ((cause & 0xf) + IRQ_XIRQ0))));
        // Activate TMU for next run
        tmu_set_mode(TMU_BASE_ADDR, TMU_MODE_ON);
        break; //return as soon as possible! because every dbus access will now be recorded
    case MCAUSE_XIRQ2_INT:
    case MCAUSE_XIRQ3_INT:
    case MCAUSE_XIRQ4_INT:
    case MCAUSE_XIRQ5_INT:
    case MCAUSE_XIRQ6_INT:
    case MCAUSE_XIRQ7_INT:
    case MCAUSE_XIRQ8_INT:
    case MCAUSE_XIRQ9_INT:
    case MCAUSE_XIRQ10_INT:
    case MCAUSE_XIRQ11_INT:
    case MCAUSE_XIRQ12_INT:
    case MCAUSE_XIRQ13_INT:
    case MCAUSE_XIRQ14_INT:
    case MCAUSE_XIRQ15_INT:
      // clear/acknowledge the current interrupt by clearing the according MIP bit
      cpu_csr_write(CSR_MIP, cpu_csr_read(CSR_MIP) & (~(1 << ((cause & 0xf) + IRQ_XIRQ0))));
      TB_TEST_FAIL();
      break;

    // -------------------------------------------------------
    // Invalid (not implemented) interrupt source
    // -------------------------------------------------------
    default:
      debug=66;
      // Push cause to debug output
      debug=cause>>0;
      debug=cause>>8;
      debug=cause>>16;
      debug=cause>>24;
      if (cpu_csr_read(CSR_MCAUSE)!=cause) {
          debug=78;
          TB_TEST_FAIL();
      }
      cpu_csr_write(CSR_MIE, 0); // disable all interrupt sources
      TB_TEST_FAIL();
  }

}


/**********************************************************************//**
 * Custom exception handler (overriding the default DUMMY handler from "airisc.c").
 *
 * @note This is a "normal" function - so NO 'interrupt' attribute!
 *
 * @param[in] cause Exception identifier from mcause CSR.
 * @param[in] epc Exception program counter from mepc CSR.
 * @param[in] tval Trap value from mtval CSR.
 **************************************************************************/
void exception_handler(uint32_t cause, uint32_t epc, uint32_t tval) {
  debug=77;
  cpu_csr_write(CSR_MIE, 0); // disable all interrupt sources
  TB_TEST_FAIL();

}
