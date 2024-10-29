# Genkai-tutorial
Official document: https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/

portal site: https://genkai-portal.hpc.kyushu-u.ac.jp/

## Setup
### create account and join projects
2.利用申請ポータル ~ 3.ログインまで  
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/

### ssh setup
```bash
vim ~/.ssh/config  
# replace ku*** with your own account id
```
```
Host genkai
  HostName genkai.hpc.kyushu-u.ac.jp
  User ku***
  ServerAliveInterval 60
  ServerAliveCountMax 3
  TCPKeepAlive yes
  ForwardAgent yes
```

```bash
ssh genkai
# set group id
GROUP_ID=$(id -ng)
echo "export GROUP_ID=$GROUP_ID" >> ~/.bashrc
source ~/.bashrc
```

## Storage
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/storage.html
```bash
# ストレージの使用状況
show_quota
# home領域
ls /home/$GROUP_ID/$USER
# グループ領域(同じグループ内ならユーザー間で触れる)
ls /home/$GROUP_ID/share
mkdir /home/$GROUP_ID/share/$USER
# 高速ストレージ(同じグループ内ならユーザー間で触れる)
ls /fast/$GROUP_ID
# 高速ストレージ内に自分のディレクトリを作る
mkdir /fast/$GROUP_ID/$USER
```

## Hardware
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/hardware/  
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/resource_group.html  
ノードグループA(a-batch, a-inter): CPUのみ  

ノードグループB(b-batch, b-inter): H100 4枚挿 38 nodes  
最長実行時間  
b-batch  
1ノード以下：168時間  
2~3ノード：96時間  
4ノード：48時間  
b-inter  
2ノード: 6時間  

ノードグループC(c-batch, c-inter): H100 8枚挿 2 nodes, 化け物メモリ  
最長実行時間  
c-batch  
1ノード: 168時間  
c-inter  
1ノード: 6時間  

ノードグループA  30pt / 1ノード時間積
ノードグループB 120pt / 1ノード時間積
ノードグループC  40pt / 1GPU時間積

予約  
https://genkai-reserve.hpc.kyushu-u.ac.jp/reserve/  
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/nodereserve.html  
```bash
# 混雑状況確認
pjshowrsc --rg
show_rsc
```

## Environment
### Module
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/software/module.html  
```bash
module avail
show_module -k cuda
# pythonはすでにある
# https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/software/python.html

pjsub --interact -L rscgrp=b-inter,gpu=1,elapse=01:00:00
python3.11 -m venv /fast/$GROUP_ID/$USER/playground_env
source /home/$GROUP_ID/$USER/playground_env/bin/activate

module load cuda/12.2.2 cudnn/9.2.0 nccl/2.22.3 gcc/8 ompi-cuda/4.1.6-12.2.2 
pip install torch torchvision torchaudio
python test.py

pjsub test.sh
```

登録しておく
```bash
echo 'cd /home/$GROUP_ID/$USER' >> ~/.bashrc
echo source '/home/$GROUP_ID/$USER/playground_env/bin/activate' >> ~/.bashrc
echo 'module load cuda/12.2.2 cudnn/9.2.0 nccl/2.22.3 gcc/8 ompi-cuda/4.1.6-12.2.2' >> ~/.bashrc
```

## commands  
https://www.cc.kyushu-u.ac.jp/scp/system/Genkai/howto/job.html
```
pjsub --interact -L rscgrp=b-inter,gpu=1,elapse=01:00:00
pjsub test.sh
# ジョブ状態参照
pjstat
# ジョブ削除
pjdel
# 混雑状況確認
pjshowrsc --rg
show_rsc
```
