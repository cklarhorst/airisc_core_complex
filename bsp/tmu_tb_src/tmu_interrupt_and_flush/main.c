#include <stdint.h>
#include <airisc.h>
#include <ee_printf.h> // use "embedded" ee_printf (much smaller!) instead of stdio's printf

#define CLOCK_HZ   (32000000) // processor clock frequency
#define UART0_BAUD (9600)     // default Baud rate
#define TICK_TIME  (CLOCK_HZ) // timer tick every 1s
#include "../utils.h"

int main() {
    cpu_csr_write(CSR_MCOUNTINHIBIT, -1); // stop all counters
    cpu_csr_write(CSR_MCYCLE, 0);
    cpu_csr_write(CSR_MCYCLEH, 0);
    cpu_csr_write(CSR_MINSTRET, 0);
    cpu_csr_write(CSR_MINSTRETH, 0);
    cpu_csr_write(CSR_MCOUNTINHIBIT, 0); // enable all counters
    
    timer_set_time(timer0, 0); // reset time counter
    timer_set_timecmp(timer0, (uint64_t)(TICK_TIME)); // set tick frequency
    
    // enable CPU interrupts
    uint32_t tmp = 0;
    tmp |= (1 << IRQ_MTI); // machine timer interrupt
    tmp |= (1 << IRQ_XIRQ0) | (1 << IRQ_XIRQ1); // AIRISC-specific external interrupt channel 0 and 1
    tmp |= (1 << IRQ_XIRQ2) | (1 << IRQ_XIRQ3); // AIRISC-specific external interrupt channel 2 and 3
    tmp |= (1 << IRQ_XIRQ4) | (1 << IRQ_XIRQ5); // AIRISC-specific external interrupt channel 4 and 5
    tmp |= (1 << IRQ_XIRQ6) | (1 << IRQ_XIRQ7); // AIRISC-specific external interrupt channel 6 and 7
    cpu_csr_write(CSR_MIE, tmp); // enable interrupt sources
    cpu_csr_set(CSR_MSTATUS, 1 << MSTATUS_MIE); // enable machine-mode interrupts
    
    tmu_set_mode(TMU_BASE_ADDR, (9<<4) + 0b11);
    
    volatile uint32_t* debug = (uint32_t*)0x80010000;
    volatile uint32_t tmp1=0;
    for(;;) {
        tmp1++;
        *debug = 4;
    }
    
}


/**********************************************************************//**
 * Custom interrupt handler (overriding the default DUMMY handler from "airisc.c").
 *
 * @note This is a "normal" function - so NO 'interrupt' attribute!
 *
 * @param[in] cause Exception identifier from mcause CSR.
 * @param[in] epc Exception program counter from mepc CSR.
 **************************************************************************/
void interrupt_handler(uint32_t cause, uint32_t epc) {
  switch(cause) {

    // -------------------------------------------------------
    // Machine timer interrupt (RISC-V-specific)
    // -------------------------------------------------------
    case MCAUSE_TIMER_INT_M:

      // adjust timer compare register for next interrupt
      // this also clears/acknowledges the current machine timer interrupt
      timer_set_timecmp(timer0, timer_get_time(timer0) + (uint64_t)TICK_TIME);


      break;

    // -------------------------------------------------------
    // External interrupt (AIRISC-specific)
    // -------------------------------------------------------
    case MCAUSE_XIRQ0_INT:
    case MCAUSE_XIRQ1_INT:
        tmu_set_mode(TMU_BASE_ADDR, 0);
        while(tmu_get_status(TMU_BASE_ADDR)!=0b010) {
            tmu_set_next(TMU_BASE_ADDR, 1); //flush recorded data
        }
        TB_TEST_PASS();
        break;
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

  cpu_csr_write(CSR_MIE, 0); // disable all interrupt sources
  TB_TEST_FAIL();

}

