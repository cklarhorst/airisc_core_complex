# Features:
- [x] IBus version
- [x] DBus version
- [x] AHB support (no burst support)
- [x] Count idle cycles
- [x] Compression support (accesses to same/inc address)
- [x] Interrupt support
- [ ] Make illegal transaction recording configurable

# TODOs:
- [ ] How much area will the iTMU/dTMU use? Do we need to reduce size further?
- [ ] Get final base address for iTMU/dTMU and interrupt ids
- [ ] Fix interrupts in the testbench
- [ ] Check compatibility with airisc_core_complex v1.2.0
- [ ] Cleanup interface signal names