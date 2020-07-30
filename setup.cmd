:: This demo doesnt use contexts.

::Deploy the nodejs application and clusterip service to two namespaces
kubectl apply -f deployment.yml -f service.yml --namespace=ns1
kubectl apply -f deployment.yml -f service.yml --namespace=ns2

:: Deploy the nginx ingress controller to the default namespace
:: I had to delete the deployment because they can accumulate if one fails to start
kubectl delete deploy nginx-ingress-controller
kubectl delete service nginx-ingress
kubectl apply -f nlb\nginx-ingress-controller.yml -f nlb\nginx-ingress-service.yml


kb delete ingress --all
kb delete ingress --namespace=ns1 --all
kb delete ingress --namespace=ns2 --all

:: Simulate IOT Ingress rules. e.g. ns.localhost/nodejs1
:: Setup ingress rules for each namespace
:: Could use helm or config maps or gradle for this, but thats a todo.
powershell -Command "(gc nlb\ingress-nodejs.yml) -replace '<<namespace>>', 'ns1' | Out-File -encoding ASCII ingress.tmp"
kubectl apply -f ingress.tmp --namespace=ns1
powershell -Command "(gc nlb\ingress-nodejs.yml) -replace '<<namespace>>', 'ns2' | Out-File -encoding ASCII ingress.tmp"
kubectl apply -f ingress.tmp --namespace=ns2

:: Now do what ED proposed with localhost/ns1/nodejs1, with different url rewrites and delegate to correct namespace.
::powershell -Command "(gc nlb\ingress-nodejs-new.yml) -replace '<<namespace>>', 'ns1' | Out-File -encoding ASCII ingress.tmp"
::kubectl apply -f ingress.tmp --namespace=ns1
::powershell -Command "(gc nlb\ingress-nodejs-new.yml) -replace '<<namespace>>', 'ns2' | Out-File -encoding ASCII ingress.tmp"
::kubectl apply -f ingress.tmp --namespace=ns2

kubectl get service