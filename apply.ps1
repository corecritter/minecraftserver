docker build ./ -t 192.168.50.247:32000/mc:latest
docker push 192.168.50.247:32000/mc:latest

kubectl delete namespace mc
#kubectl delete pv ftp-pv
./unclaimpvc.ps1

kubectl apply -f ./kube/sc-nfs.yaml
kubectl apply -f ./kube/namespace.yaml
kubectl apply -f ./kube/pvc_claim.yaml
kubectl apply -f ./kube/deployment.yaml
kubectl apply -f ./kube/service.yaml
kubectl apply -f ./kube/ingress.yaml