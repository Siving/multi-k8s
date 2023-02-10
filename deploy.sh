docker build -t siving/multi-client:latest -t siving/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t siving/multi-server:latest -t siving/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t siving/multi-worker:latest -t siving/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push siving/multi-client:latest
docker push siving/multi-server:latest
docker push siving/multi-worker:latest

docker push siving/multi-client:$SHA
docker push siving/multi-server:$SHA
docker push siving/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=siving/multi-server:$SHA
kubectl set image deployments/client-deployment client=siving/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=siving/multi-worker:$SHA
