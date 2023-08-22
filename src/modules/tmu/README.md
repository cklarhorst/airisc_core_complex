## General
The TMU consists of the components *Monitor*, *Detect* and *Respond*.
Its implementation is done in the migen framework, a Python toolbox for building complex digital hardware.

This directory does only include the *Monitor* component.

The *Monitor* component firstly captures the signals of interest from the SoC.
Possible sources are among others the SoC interconnect bus (AHB), built-in self-tests (BIST) or status signals from IP components.
To probe the SoC interconnect, various bus control signals are captured depending on the particular bus implementation.
Internally the component buffers the captured data.
Secondly the captured signals are combined and merged to depict the SoC's system behavior.
Via a control input, the component can be activated to start triggering on input from the probe buffer.
Incoming data is stored in a queue for further processing on-chip or to be transferred off-chip.
To minimize resource usage, lossless compression methods of bus transactions are implemented:
Accesses to the same or consecutive addresses are combined to an access group, either for rising or falling access patterns. 
For bus transactions supplementary metadata in addition to the bus control signals is added on-chip.
The recorded bus communication can be transferred off-chip for further analysis.


## Memory Layout
| Address  | Description                                                                       |
|----------|-----------------------------------------------------------------------------------|
| base + 0 | version identifier                                                                |
| base + 1 | mode configuration (bit 2: compression en, bit 1: interrupt en, bit 0: record en) |
| base + 2 | status (bit 2: interrupt, bit 1: fifo empty, bit 0: fifo full)                    |
| base + 3 | read to pop record fifo                                                           |
| base + 4 | record fifo lower bits                                                            |
| base + 5 | record fifo higher bits                                                           |


## Recording Specification
The TMU stores 64 bits in the following order as two 32-bit words:

| Signalname          | Bitwidth |
|---------------------|----------|
| haddr               | 32       |
| hwrite              | 1        |
| hsize               | 3        |
| error               | 1        |
| compressed_entries  | 9        |
| compression_type    | 2        |
| master_idle_counter | 8        |
| waitstate_counter   | 8        |
|                     |          |
| Sum                 | 64       |

* __haddr__ is the address of an access on the bus
* __hwrite__ indicates the write status of an access
* __hsize__ is the size of the read/written data as specified by the AHB specification
* __error__ is 1 when an error ocurred in the transaction (listens to both ERROR1 and ERROR2 states of hready + hresp)
* __compressed_entries__ is the number of transactions that are compressed into this entry
* __compression_type__ specifies the type of compression: 3 = No compression, 2 = Falling addresses, 1 = Rising addresses, 0 = Same address (CAPS AT MAX VALUE)
* __master_idle_counter__ is the number of master-introduced idle cycles (by setting htrans = IDLE, regardless of whether in a transaction or outside one). This is the actual number - 1, as long as there were any idle cycles (first one does not register) (CAPS AT MAX VALUE)
* __waitstate_counter__ counts the waitstates introduced by the slave (hready low, hresp low) (CAPS AT MAX VALUE)

## Technical Conditions for Recording
* Idle-counter resets on a commit
* Waitstates-counter resets on a commit
* Bus-Idle-bit is 1 if Htrans == IDLE, Hready = OKAY, reset at Htrans == NONSEQ
* Error-bit is 1 if Hresp is ever ERROR
* Record-Condition: Htrans == NONSEQ, Hready == OKAY
* Commit-Condition: Hready == OKAY, HRESP == OKAY, Bus-Idle == 0

## Compression
Compression enables multiple transactions represented in one entry to save memory. Accesses with a spacing of 4 bytes get recognized for same-address, rising-address and falling-address accesses.
A compression is finished when the address changes in a non-4-byte-spacing or when any of the following attributes change: _hwrite_, _hsize_, _error_, _compression-type_. 

__compressed_entries__ starts counting at 0. A count of one represents two transactions. The address is the last address that was accessed. So an address of 0x5 with a falling address compression and 5 entries started at 0x19 -> Addresses get compressed when they are spaced in 4-byte words. So the accesses 0x0, 0x4, 0x8 get compressed, but 0x0, 0x2, 0x4 do _not_ get compressed.

__master_idle_counter__ starts counting at 0. When there is a number != 0 or 1, the number of idle cycles is that plus 1. Notably, in the AHB specification, the master always inserts an IDLE cycle after and ERROR2 cycle, such that an error-entry has one more idle access.

## Example Transaction

| Signal              | Content    |
|---------------------|------------|
| haddr               | 0x8000BC00 |
| hwrite              | 0          |
| hsize               | 2          |
| error               | 0          |
| compressed_entries  | 4          |
| compression_type    | 1          |
| master_idle_counter | 4          |
| waitstate_counter   | 2          |

* Covers 5 transactions at addresses 0x8000bbf0, 0x8000bbf4, 0x8000bbf8, 0x8000bbfc, 0x8000bc00 (rising addresses, last address 0x8000bc00)
* Reading
* 32-bit-sized access
* No error occurred
* 4 Idle cycles occurred before the first address access
* 2 Waitstates were inserted somewhere in the 5 recorded accesses


## Features:
- [x] IBus version
- [x] DBus version
- [x] AHB support (no burst support)
- [x] Count idle cycles
- [x] Compression support (accesses to same/inc/dec address)
- [x] Interrupt support

## TODOs:
- [x] Fix interrupts in the testbench
- [x] Check compatibility with latest airisc_core_complex
- [ ] Get final interrupt ids
- [x] Get final base address for iTMU/dTMU
- [ ] How much area will the iTMU/dTMU use? Do we need to reduce size further?