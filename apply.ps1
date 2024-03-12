docker build ./ -t 192.168.50.203:32000/mc:latest
docker push 192.168.50.203:32000/mc:latest

kubectl apply -f ./kube/namespace.yaml
kubectl apply -f ./kube/deployment.yaml
kubectl apply -f ./kube/service.yaml
kubectl apply -f ./kube/ingress.yaml