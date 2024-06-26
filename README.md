# K8s service broadcasting

[![Github Action](https://github.com/sortlist/k8s-service-broadcasting/actions/workflows/build_tests_and_push.yaml/badge.svg?style=flat-square)](https://github.com/sortlist/k8s-service-broadcasting/actions/workflows/build_tests_and_push.yaml)
[![Docker Pulls](https://img.shields.io/docker/pulls/charlessortlist/k8s-service-broadcasting?style=flat-square)](https://hub.docker.com/repository/docker/charlessortlist/k8s-service-broadcasting)

Tool allowing to broadcast/mirror/duplicate HTTP requests to all ready endpoints of a Kubernetes service.

This project was hacked in order to return an HTTP 200 whenever possible to the upstream (at least one 200 received downstream).

## Usage

```bash
$ ./k8s-service-broadcasting --help
Tool allowing to broadcast/mirror/duplicate HTTP requests to all endpoints of Kubernetes service.
Waits for all of them to end and reports back failed request if any. If not returns last successful.

Usage:
  k8s-service-broadcasting [flags]

Flags:
      --all-must-succeed           By default if any backend fails, the whole request fails. If disabled one succeeded response is enough. (default true)
  -h, --help                       help for k8s-service-broadcasting
  -i, --interface string           Interface to listen on. (default "0.0.0.0:8080")
      --keepalive                  If keepalive should be enabled. (default true)
  -k, --kubeconfig string          Location of the kubeconfig, default if in cluster config or value of KUBECONFIG env variable. (default "/home/fusakla/.kube/conf/kubeconfig.yaml")
  -l, --log-level string           Log level (debug, info, warning, ...) default info. (default "info")
  -m, --metrics-interface string   Interface for exposing metrics. (default "0.0.0.0:8081")
  -n, --namespace string           Namespace to watch for.
  -p, --port-name string           Name of service port to sed the requests to.
  -s, --service string             Name of service to sed the requests to.
  -t, --timeout duration           Timeout for mirrored requests. (default 10s)
```

## Instrumentation
There is second interface for exposing Prometheus metrics and providing lifecycle endpoints.
This interface is running by default on `0.0.0.0:8081`. The endpointa are:
- `/metrics` Prometheus metrics
- `/-/healthy` liveness probe
- `/-/ready` readiness probe 

## Build
**single binary**
```bash
make build
```

## Deployment
See the [`kubernetes/`](./kubernetes) folder with example.
