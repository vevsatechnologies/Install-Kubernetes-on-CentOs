```
ssh root@MasterIP
```
```
yum update
```
```
rpm -Uhv  https://packages.cloud.google.com/apt/doc/rpm-package-key.gpg

```

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
```
```
setenforce 0
```
```
yum update
```
```
yum install -y docker

systemctl enable docker && systemctl start docker

```
```
yum install -y kubelet kubeadm kubectl

systemctl enable kubelet && systemctl start kubelet
```

##Deploy the Master
```
kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address MasterIP --ignore-preflight-errors=all  
```
Save the token somewhere as it will be used to join slave nodes to the master

```
sudo cp /etc/kubernetes/admin.conf $HOME/
sudo chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf
```


```
curl -sSL "https://github.com/coreos/flannel/blob/master/Documentation/kube-flannel.yml?raw=true" | kubectl --namespace=kube-system create -f -
```


kubectl create -f ./metrics-server
```

```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-legacy.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```
```
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```

#After this pull the docker image from the private registry using docker pull command
