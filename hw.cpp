#include "hip/hip_runtime.h"
#include "hcc/hc_printf.hpp"

__global__ void hip_hello(){
    printf("Hello World from GPU!\n");
}

int main() {
    hipLaunchKernelGGL((hip_hello), dim3(1), dim3(1), 0, 0 ); 
    hipDeviceSynchronize();
    return 0;
}
