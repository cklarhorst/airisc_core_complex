SUBDIRS := $(filter-out memfiles/,$(wildcard */))

.PHONY: all $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	@echo "Entering test directory $@"
	$(MAKE) -C $@ clean
	@echo "Build iTMU"
	$(MAKE) -C $@ USER_FLAGS="-DTMU_BASE_ADDR=0xC0000A00" mem_plain
	cp $@/main.mem memfiles/i_$(patsubst %/,%,$@).mem
	@echo "Copied main.mem to i_$(patsubst %/,%,$@).mem"
	$(MAKE) -C $@ clean
	@echo "Build dTMU"
	$(MAKE) -C $@ USER_FLAGS="-DTMU_BASE_ADDR=0xC0000A20" mem_plain
	cp $@/main.mem memfiles/d_$(patsubst %/,%,$@).mem
	@echo "Copied main.mem to d_$(patsubst %/,%,$@).mem"
	#$(MAKE) -C $@ clean

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done
