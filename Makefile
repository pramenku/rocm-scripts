HIP_PATH?= $(wildcard /opt/rocm/hip)
ifeq (,$(HIP_PATH))
        HIP_PATH=../../..
endif

HIPCC=$(HIP_PATH)/bin/hipcc

TARGET=hcc

SOURCES = hw.cpp
OBJECTS = $(SOURCES:.cpp=.o)

EXECUTABLE=./hw

.PHONY: test


all: $(EXECUTABLE) test

# Need the -DHIP_ENABLE_PRINTF to turn on printf in the kernel function
CXXFLAGS =-g -DHIP_ENABLE_PRINTF -I/opt/rocm/include
CXX=$(HIPCC)


$(EXECUTABLE): $(OBJECTS)
	$(HIPCC) $(OBJECTS) -o $@


run: $(EXECUTABLE)
	HCC_ENABLE_PRINTF=1 $(EXECUTABLE)


clean:
	rm -f $(EXECUTABLE)
	rm -f $(OBJECTS)

