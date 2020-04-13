#!/bin/bash
cd /root/pytorch/build/
wget  https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/micro_benchmarking_pytorch.py
wget  https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/fp16util.py 
wget https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/shufflenet.py 
wget https://raw.githubusercontent.com/wiki/ROCmSoftwarePlatform/pytorch/shufflenet_v2.py 

chmod 775 micro_benchmarking_pytorch.py fp16util.py shufflenet.py shufflenet_v2.py 

#pip install torchvision==0.2.2.post3

git clone https://github.com/pytorch/vision
cd vision
pip install --user .

N_GPUS=$(lspci|grep 'controller'|grep 'AMD/ATI'|wc -l)
echo $N_GPUS

###############################Below are applicable BS for 32GB Memory GPUs, for 16GB, change BS-of-32GB/2 ######################


#mGPU (for 4 GPU ):
#Batch size depends on number of GPU, (For example : for 128 batchsize, it will be 128*4=512)
if (( $num_gpus == 4 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3
fi

if (( $num_gpus == 8 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7
fi


