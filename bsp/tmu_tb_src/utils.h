/*
    "Memory Map": {
        "0xc0000048": "TMU Version [RO]",
        "0xc000004c": "Mode [0: Enable/Disable recording [RW] (Default: False)]",
        "0xc0000050": "Status [RO] [0: Interrupt, 1: Empty, 2: Full]",
        "0xc0000054": "Write 1 to advance fifo one entry [RW]",
        "0xc0000058": "Data Batch 1 [RO]",
        "0xc000005c": "Data Batch 2 [RO]"
    },
 */

static inline uint32_t tmu_get_version(uint32_t tmu_base) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 0;
	return *tmp;
}

static inline void tmu_set_mode(uint32_t tmu_base, uint32_t mode) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 1;
	*tmp = mode;
}

static inline uint32_t tmu_get_mode(uint32_t tmu_base) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 1;
	return *tmp;
}

static inline uint32_t tmu_get_status(uint32_t tmu_base) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 2;
	return *tmp;
}

static inline void tmu_set_next(uint32_t tmu_base, uint32_t next) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 3;
	*tmp = next;
}

static inline uint32_t tmu_get_data0(uint32_t tmu_base) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 4;
	return *tmp;
}

static inline uint32_t tmu_get_data1(uint32_t tmu_base) {
	volatile uint32_t* tmp = (uint32_t*)tmu_base + 5;
	return *tmp;
}

static inline void TB_TEST_PASS() {
	volatile uint32_t* tmp = (uint32_t*)0x80010000;
	while (1) {
		*tmp = 1;
	}
}

static inline void TB_TEST_FAIL() {
	volatile uint32_t* tmp = (uint32_t*)0x80010000;
	while (1) {
		*tmp = 5;
	}
}

static inline void TB_TEST_FAIL_ERR(uint32_t err) {
	volatile uint32_t* tmp = (uint32_t*)0x80010000;
	while (1) {
		*tmp = err;
	}
}