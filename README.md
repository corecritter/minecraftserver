I created this because I wanted to run my minecraft server inside of kubernetes. I have always ran it on raspberry pis and have used some sort of gui os to run it on. 
This project was mostly for fun but also made it easier to manage updates to the server version. I couldn't find a way to get the latest java server version, so the url needs to be updated manually.
I used Microk8s and nfs-kernel-server to host nfs storage to backup my world. The following instructions are what I used to get everything working.

sudo apt update
sudo apt upgrade
Installing microk8s
sudo nano /boot/firmware/cmdline.txt
cgroup_enable=memory cgroup_memory=1 //add to cmdline.txt
sudo reboot
sudo snap install microk8s --classic
sudo microk8s start
microk8s config // prints kubeconfig (put this in your kubeconfig and everything should work :) )
microk8s enable registry // enable docker registry
sudo microk8s enable registry --size 40Gi // enable registry with size
sudo microk8s enable ingress //enable ingress
Enabling NFS (https://microk8s.io/docs/how-to-nfs)
microk8s enable helm3
microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update
microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
    --namespace kube-system \
    --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet
microk8s kubectl wait pod --selector app.kubernetes.io/name=csi-driver-nfs --for condition=ready --namespace kube-system

After getting everything setup, you need to change the IP address to point to your NFS file server in sc-nfs.yaml
If running on Windows, change the IP address to your docker registry and run apply.ps1. Everything should now work and you can connect to your minecraft server at <yourIp>:30000

You can also freely change any server settings, operators and whitelist options in /settings to configure the server

NOTE: If exposing this to the internet (port forwarding), you may need to expose 25565 and map it to 30000 internally. That is what I did and outside users can just enter my ip without a port number

If you're using docker desktop, add this to point to your insecure docker registry
add this to DockerEngine settings "insecure-registries": ["<yourIp>:32000"]

If getting Image Pull errors might need to uncheck the "use containerd for pulling and storing images" option in docker desktop
