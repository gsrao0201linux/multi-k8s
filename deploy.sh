docker build -t gsrao0201/multi-client-k8s:latest -t gsrao0201/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t gsrao0201/multi-server-k8s-pgfix:latest -t gsrao0201/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t gsrao0201/multi-worker-k8s:latest -t gsrao0201/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push gsrao0201/multi-client-k8s:latest
docker push gsrao0201/multi-server-k8s-pgfix:latest
docker push gsrao0201/multi-worker-k8s:latest

docker push gsrao0201/multi-client-k8s:$SHA
docker push gsrao0201/multi-server-k8s-pgfix:$SHA
docker push /multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gsrao0201/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=gsrao0201/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=gsrao0201/multi-worker-k8s:$SHA