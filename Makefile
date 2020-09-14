
.EXPORT_ALL_VARIABLES:

kubectl-create:
	kubectl create deployment hello-world --image=datawire/hello-world

kubectl-expose:
	kubectl expose deployment hello-world --type=LoadBalancer --port=8000

kubectl-delete:
	kubectl delete services,deployments hello-world

kubectl-service:
	$(eval HELLOWORLD = $(shell minikube service --url hello-world))

curl: kubectl-service
	curl $(HELLOWORLD)

telepresense-swap:
	 telepresence --swap-deployment hello-world --expose 8000 --run python3 helloworld.py