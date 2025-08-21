OUTPUT_DIR_MAIN := output

CXX_FLAGS += -std=c++11 -O3 -Wall
PAR_FLAG = -fopenmp

ifneq (,$(findstring icpc,$(CXX)))
	PAR_FLAG = -openmp
endif

ifneq (,$(findstring sunCC,$(CXX)))
	CXX_FLAGS = -std=c++11 -xO3 -m64 -xtarget=native
	PAR_FLAG = -xopenmp
endif

ifneq ($(SERIAL), 1)
	CXX_FLAGS += $(PAR_FLAG)
endif

KERNELS = bc bfs cc cc_sv pr pr_spmv sssp tc
SUITE = $(addprefix $(OUTPUT_DIR_MAIN)/, $(KERNELS) converter)

$(shell mkdir -p $(OUTPUT_DIR_MAIN))

.PHONY: all
all: $(SUITE)

$(OUTPUT_DIR_MAIN)/% : src/%.cc src/*.h
	$(CXX) $(CXX_FLAGS) $< -o $@

# Testing
TEST_OUTPUT := $(OUTPUT_DIR_MAIN)/test_out
$(shell mkdir -p $(TEST_OUTPUT))
include test/test.mk

# Benchmark Automation
BENCH_OUTPUT := $(OUTPUT_DIR_MAIN)/bench_out
$(shell mkdir -p $(BENCH_OUTPUT))
include benchmark/bench.mk

.PHONY: clean
clean:
	rm -rf $(OUTPUT_DIR_MAIN)