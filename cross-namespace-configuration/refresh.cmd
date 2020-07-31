kb delete vsr --all --all-namespaces
kb delete vs --all --all-namespaces

kb apply -f .\tea.yaml -f .\coffee.yaml
kb apply -f .\cafe-virtual-server.yaml
kb apply -f .\coffee-virtual-server-route.yaml -f .\tea-virtual-server-route.yaml

kb describe vs cafe -n cafe
