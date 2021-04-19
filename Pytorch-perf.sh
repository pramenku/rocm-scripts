#!/bin/bash
cd /root/
git clone https://github.com/ROCmSoftwarePlatform/pytorch-micro-benchmarking && cd pytorch-micro-benchmarking
chmod 775 micro_benchmarking_pytorch.py fp16util.py shufflenet.py shufflenet_v2.py 


#git clone https://github.com/pytorch/vision
#cd vision && git reset --hard 8a2dc6
#pip install --user .

cd /var/lib/jenkins/pytorch/.jenkins/pytorch
VISION_COMMIT=$(grep -nri "TORCHVISION_COMMIT=" common_utils.sh | cut -d'=' -f2)
echo "Vision commit = $VISION_COMMIT"
pip3 install --user git+https://github.com/pytorch/vision.git@$VISION_COMMIT

num_gpus=$(lspci|grep 'controller'|grep 'AMD/ATI'|wc -l)
echo $num_gpus

###############################Below are applicable BS for 32GB Memory GPUs, for 16GB, change BS-of-32GB/2 ######################


#mGPU (for 4 GPU ):
#Batch size depends on number of GPU, (For example : for 128 batchsize, it will be 128*4=512)
cd /root/pytorch-micro-benchmarking
if (( $num_gpus == 1 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 256 --iterations 10 --dataparallel --device_ids 0 2>&1 | tee py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 128 --iterations 10  --dataparallel --device_ids 0 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 32  --iterations 10 --dataparallel --device_ids 0 2>&1 | tee -a py-bms.log

python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 256 --iterations 10 --fp16 1 --dataparallel --device_ids 0 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 128 --iterations 10 --fp16 1 --dataparallel --device_ids 0 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 32 --iterations 10 --fp16 1 --dataparallel --device_ids 0 2>&1 | tee -a py-bms.log
fi

if (( $num_gpus == 2 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 256 --iterations 10  --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 64  --iterations 10 --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log

python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 256 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 64  --iterations 10 --fp16 1 --dataparallel --device_ids 0,1 2>&1 | tee -a py-bms.log
fi

if (( $num_gpus == 4 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10  --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log

python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3 2>&1 | tee -a py-bms.log
fi

if (( $num_gpus == 8 )); then
python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10  --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log

python3.6 micro_benchmarking_pytorch.py --network resnet50 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet101 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network resnet152 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network alexnet --batch-size 4096 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network SqueezeNet --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network inception_v3 --batch-size 1024 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network densenet121 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg16 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
#python3.6 micro_benchmarking_pytorch.py --network vgg19 --batch-size 512 --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
python3.6 micro_benchmarking_pytorch.py --network resnext101 --batch-size 128  --iterations 10 --fp16 1 --dataparallel --device_ids 0,1,2,3,4,5,6,7 2>&1 | tee -a py-bms.log
fi

grep -nir "Microbenchmark" py-bms.log
grep -nir "Throughput" py-bms.log

