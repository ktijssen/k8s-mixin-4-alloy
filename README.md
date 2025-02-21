# k8s-mixin-4-alloy
Kubernetes Mixin Generator compatible with Grafana Alloy

# Intro
Grafana Alloy uses different 'Selectors' for the jobLabels. With this change the current Mixin are not compatible with Alloy.

These selectors need to be adjusted in orde to work with Alloy.
I've made a simple Taskfile to generate these files for you.

# Prerequisite
You need 5 additional tools to create these files

## Taskfile
A **Taskfile** is a YAML configuration file for [Task](https://taskfile.dev/), a task runner to automate workflows like building, testing, and deploying. It’s a modern, cross-platform alternative to Makefiles with a clean syntax.. For installation instructions, refer to the [Task installation guide](https://taskfile.dev/installation/).

## yq
**yq** is a lightweight and portable command-line tool for querying, manipulating, and transforming YAML, JSON, and XML files. It simplifies data processing with a syntax similar to `jq`, tailored for YAML. For installation instructions, refer to the [yq installation guide](https://github.com/mikefarah/yq).

## Kustomize
**Kustomize** is a configuration management tool for Kubernetes that lets you customize application manifests without modifying the original YAML files. It supports features like overlays, patches, and resource generators to simplify managing environments. For installation instructions, refer to the [kustomize installation guide](https://kubectl.docs.kubernetes.io/installation/kustomize/).

## Jsonnet
A **Jsonnet** file is a data templating language designed for defining and generating JSON data. It supports powerful features like variables, conditionals, loops, and imports, making it ideal for managing complex configurations. For installation instructions, refer to the [jsonnet installation guide](https://github.com/google/jsonnet).

# Json-bundler
**json-bundler** is a tool for combining multiple JSON files into a single JSON output. It supports modular configuration by resolving references and imports, making it useful for managing complex JSON structures. For installation instructions, refer to the [json-bundler installation guide](https://github.com/jsonnet-bundler/jsonnet-bundler/releases/).

# Usage
There are several commands we can run to reach our destination. All the commands are used with the ```task``` command.

* Install/Update the source directory. ```task update```
* Generate the Alert yaml-files. ```task alerts```
* Generate the Dashboard yaml-files. ```task dashboards```
* Generate the Rules yaml-files. ```task rules```

We can do all these 4 commands at once. ```task all```<br/>
This will install/update the source directory and generate all the yaml-files.

## Windows (Optional)
By default Windows Alerts, Rules & Dashboards are also created. You can disabled this by creating a `.env` file with `DISABLE_WINDOWS=true`.

# Output
The generated files are written in a output directory named ```output```. We can alternate this by adding the parameter ```OUTPUT_DIR=<path>```. 
```
# task all OUTPUT_DIR=./newoutputdir \
GET https://github.com/kubernetes-monitoring/kubernetes-mixin/archive/af5e89820645ab7f99c8be0c247ab2f9f845869d.tar.gz 200 \
GET https://github.com/grafana/grafonnet/archive/d20e609202733790caf5b554c9945d049f243ae3.tar.gz 200 \
GET https://github.com/grafana/grafonnet/archive/d20e609202733790caf5b554c9945d049f243ae3.tar.gz 200 \
GET https://github.com/jsonnet-libs/docsonnet/archive/6ac6c69685b8c29c54515448eaca583da2d88150.tar.gz 200 \
GET https://github.com/jsonnet-libs/xtd/archive/1199b50e9d2ff53d4bb5fb2304ad1fb69d38e609.tar.gz 200 \
Generating PrometheusRules 'Alerts' -- Done \
Generating PrometheusRules 'Rules' -- Done \
Generating Grafana Dashboards -- Done

# tree newoutputdir 
newoutputdir
├── alerts
│   ├── kube-apiserver-slos.yaml
│   ├── kubernetes-apps.yaml
│   ├── kubernetes-resources.yaml
│   ├── kubernetes-storage.yaml
│   ├── kubernetes-system-apiserver.yaml
│   ├── kubernetes-system-controller-manager.yaml
│   ├── kubernetes-system-kube-proxy.yaml
│   ├── kubernetes-system-kubelet.yaml
│   ├── kubernetes-system-scheduler.yaml
│   ├── kubernetes-system.yaml
│   └── kustomization.yaml
├── dashboards
│   ├── apiserver.yaml
│   ├── cluster-total.yaml
│   ├── controller-manager.yaml
│   ├── k8s-resources-cluster.yaml
│   ├── k8s-resources-multicluster.yaml
│   ├── k8s-resources-namespace.yaml
│   ├── k8s-resources-node.yaml
│   ├── k8s-resources-pod.yaml
│   ├── k8s-resources-workload.yaml
│   ├── k8s-resources-workloads-namespace.yaml
│   ├── kubelet.yaml
│   ├── kustomization.yaml
│   ├── namespace-by-pod.yaml
│   ├── namespace-by-workload.yaml
│   ├── persistentvolumesusage.yaml
│   ├── pod-total.yaml
│   ├── proxy.yaml
│   ├── scheduler.yaml
│   └── workload-total.yaml
└── rules
    ├── k8s-rules-container-cpu-limits.yaml
    ├── k8s-rules-container-cpu-requests.yaml
    ├── k8s-rules-container-cpu-usage-seconds-total.yaml
    ├── k8s-rules-container-memory-cache.yaml
    ├── k8s-rules-container-memory-limits.yaml
    ├── k8s-rules-container-memory-requests.yaml
    ├── k8s-rules-container-memory-rss.yaml
    ├── k8s-rules-container-memory-swap.yaml
    ├── k8s-rules-container-memory-working-set-bytes.yaml
    ├── k8s-rules-pod-owner.yaml
    ├── kube-apiserver-availability-rules.yaml
    ├── kube-apiserver-burnrate-rules.yaml
    ├── kube-apiserver-histogram-rules.yaml
    ├── kube-scheduler-rules.yaml
    ├── kubelet-rules.yaml
    ├── kustomization.yaml
    └── node-rules.yaml

4 directories, 47 files
```

Automatically a kustomization.yaml will be created in every folder.
```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
resources:
- apiserver.yaml
- cluster-total.yaml
- controller-manager.yaml
- k8s-resources-cluster.yaml
- k8s-resources-multicluster.yaml
- k8s-resources-namespace.yaml
- k8s-resources-node.yaml
- k8s-resources-pod.yaml
- k8s-resources-workload.yaml
- k8s-resources-workloads-namespace.yaml
- kubelet.yaml
- namespace-by-pod.yaml
- namespace-by-workload.yaml
- persistentvolumesusage.yaml
- pod-total.yaml
- proxy.yaml
- scheduler.yaml
- workload-total.yaml
```