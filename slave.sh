ssh root@slaveNodeIP

yum update

rpm -Uhv  https://packages.cloud.google.com/apt/doc/rpm-package-key.gpg

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

yum update

yum install -y docker
systemctl enable docker && systemctl start docker

yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet

#Use the master token to join the master node
kubeadm join --token tokenGivenbyMaster --discovery-token-unsafe-skip-ca-verification  159.89.169.97:6443



