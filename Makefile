
.EXPORT_ALL_VARIABLES:

PLATFORM := $(shell uname -s)

/usr/local/bin/brew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

install-minikube-linux:
	curl -Lo /tmp/minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	chmod +x /tmp/minikube
	sudo mkdir -p /usr/local/bin/
	sudo install /tmp/minikube /usr/local/bin/

install-minikube-osx: /usr/local/bin/brew
	brew install minikube

install-telepresence-linux:
	sudo apt-get update
	sudo apt-get install -y lsb-release
	sudo add-apt-repository "deb https://packagecloud.io/datawireio/telepresence/ubuntu/ $(shell lsb_release -cs) main"
	sudo apt install --no-install-recommends -y telepresence

install-telepresence-osx: /usr/local/bin/brew
	brew install minikube

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