#!/bin/sh
#PJM -L rscgrp=b-batch
#PJM -L gpu=2
#PJM -L elapse=1:00:00
#PJM -j

cd /fast/$GROUP_ID/$USER
source /fast/$GROUP_ID/$USER/playground_env/bin/activate
module load cuda/12.2.2 cudnn/9.2.0 nccl/2.22.3 gcc/8 ompi-cuda/4.1.6-12.2.2
python torch_test.py