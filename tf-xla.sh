#!/bin/bash
current=`pwd`

LOGDIR=/dockerx
BENCHDIR=/root/benchmarks
BASEDIR=/root
#BUILD=346

run_tf_xla_concat_gpu()
{
cd /root/tensorflow
bazel test --compilation_mode=dbg --cache_test_results=no --config=opt --config=rocm --test_tag_filters=-no_gpu,-benchmark-test,-no_oss,-no_rocm //tensorflow/compiler/xla/tests:concat_test_gpu  --test_output=streamed --verbose_test_summary --verbose_failures 2>&1 | tee $LOGDIR/test-concat_gpu-xla-$BUILD.log

}

run_tf_xla_concat_gpu



