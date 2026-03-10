#!/bin/bash
# Day02 - kOps 클러스터 세팅 스크립트

# 1. AWS CLI 설치
sudo apt update && sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# 2. kubectl 설치
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/kubectl

# 3. kOps 설치
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops

# 4. 환경변수 설정 (영구 적용)
echo 'export KOPS_STATE_STORE="s3://whiyoung.whi02.cc"' >> ~/.bashrc
source ~/.bashrc

export CONTROL_PLANE_SIZE="t3.medium"
export NODE_SIZE="t3.medium"
export ZONES="ap-southeast-2a,ap-southeast-2b,ap-southeast-2c"

# 5. S3 버킷 생성
aws s3 mb s3://whiyoung.whi02.cc --region ap-southeast-2

# 6. kOps 클러스터 생성
kops create cluster whiyoung.whi02.cc \
  --node-count 2 \
  --zones $ZONES \
  --node-size $NODE_SIZE \
  --control-plane-size $CONTROL_PLANE_SIZE \
  --control-plane-zones $ZONES \
  --networking calico \
  --topology public \
  --yes

# 7. kubeconfig 설정
kops export kubeconfig whiyoung.whi02.cc --admin

# 8. Envoy Gateway 설치
kubectl apply --server-side -f https://github.com/envoyproxy/gateway/releases/download/v1.7.0/install.yaml

# 9. 앱 배포
kubectl apply -f a.yaml

# 10. 접속 주소 확인
kubectl get gateway -n game-2048
