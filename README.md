# Orchestrator
This project aims to teach you how to deploy in a cluster using Kubernetes as well as how to use Traefik as a reverse proxy and load balancer.

It is a simple web-based survey application. Poll is a Python Flask web application that collects votes to push them into a Redis queue. The Java Worker consumes the votes stored in the Redis queue, then pushes them into a PostgreSQL database. Finally, the web application Node.js Result retrieves the votes from the database and displays the result.

# Your project will be tested with:
kubectl apply -f cadvisor.daemonset.yaml
kubectl apply -f postgres.secret.yaml \
              -f postgres.configmap.yaml \ 
              -f postgres.volume.yaml \
              -f postgres.deployment.yaml \ 
              -f postgres.service.yaml

kubectl apply -f redis.configmap.yaml \ 
              -f redis.deployment.yaml \ 
              -f redis.service.yaml

kubectl apply -f poll.deployment.yaml \ 
              -f worker.deployment.yaml \ 
              -f result.deployment.yaml \ 
              -f poll.service.yaml \
              -f result.service.yaml \
              -f poll.ingress.yaml \
              -f result.ingress.yaml
kubectl apply -f traefik.rbac.yaml \
              -f traefik.deployment.yaml \ 
              -f traefik.service.yaml

# Create database manually after first deploy
echo 'CREATE TABLE votes (id text PRIMARY KEY, vote text NOT NULL);' \
| kubectl exec -i <postgres -deployment -id> -c <postgres -container -id> <username >
-- psql -U

# Adds 2 fake DNS to /etc/hosts
echo "$(kubectl get nodes -o jsonpath='{ $.items[*].status.addresses[?(@.type=="
ExternalIP")].address }') poll.dop.io result.dop.io" \ | sudo tee -a /etc/hosts
