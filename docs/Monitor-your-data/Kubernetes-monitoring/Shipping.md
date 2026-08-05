# Shipping Kubernetes monitoring data to OpsPilot



## Introduction

This guide explains how to deploy the Kubernetes-Prometheus-Stack to send metric data from your Kubernetes cluster(s) directly to OpsPilot.  This data can then be visualized in the **Kubernetes** dashboard set.

![!Screenshot](/Monitor-your-data/Kubernetes-monitoring/images/K8scluster.png)

The [Kubernetes-Prometheus-Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) is a deployable Helm
chart which enables monitoring of Kubernetes clusters in OpsPilot.


Many aspects of the deployment can be customized using the Helm `values` input file. 

!!! note "Compatibility"
    These instructions have been checked against Kube-Prometheus-Stack Helm chart version 52.0.1 (Application Version v0.68.0).

!!! info "Learn more"
    [Configuration documentation](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) 



## Prerequisites

Prior to beginning, ensure you have the following:

-   Access to your cluster via `kubectl` and `helm`.

-   A valid OpsPilot account, and an API key for the account.

-   A valid OpsPilot user in your account, with access to OpsPilot.

!!! tip
    API keys can be managed under **OpsPilot** \> **User Menu** \> **Account** \> **API Keys**


## Procedure

This is the procedure for configuring the Kubernetes-Prometheus-Stack to ship metrics data directly to OpsPilot.

### **Step 1**: Download files 

Download the following files from [our GitHub repo](https://github.com/intergral/fr-cloud-kps).

 - `fr-cloud-kps-values.yaml`

 - `fr-cloud-kps-authentication-secret.yaml`

### **Step 2**: Customize the two files for installation

- `fr-cloud-kps-values.yaml`

Change `CLUSTER_NAME` to your Kubernetes cluster name.

- `fr-cloud-authentication-secret.yaml`

Change `PASSWORD` to your OpsPilot API key. 

!!! tip
    Ensure you copy and paste the **entire** key.

### **Step 3**: Create new namespace to hold & deploy stack 


Run the following commands to create a new namespace to hold & deploy the stack 

``` bash
kubectl create namespace kube-prometheus-stack
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl apply -n kube-prometheus-stack -f fr-cloud-kps-authentication-secret.yaml
helm upgrade --install -n kube-prometheus-stack -f fr-cloud-kps-values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 52.0.1
```

If the stack deploys correctly, it will begin shipping data to OpsPilot.

!!! tip
    Check this using `kubectl get pods -n kube-prometheus-stack`.

### **Step 4**: View your data

This data can be viewed in **OpsPilot** \>
**Dashboards** \> **Kubernetes** 


!!! tip
    The **Kubernetes Node Exporter for Clusters** dashboard allows you to troubleshoot cluster problems right down to the VM level.



![!Screenshot](/Monitor-your-data/Kubernetes-monitoring/images/k8clusters.png)

## Upgrading from a previous chart

As there are Custom Resource Definitions (CRDs) installed by this chart, both they and the chart itself should be uninstalled prior to upgrading the version.  Failure to remove the CRDs will cause the upgrade to abort. 

The normative information for performing this uninstall is [here](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack#uninstall-helm-chart) and reproduced below for your convenience:

**Step 1**: Uninstall the helm chart


``` bash
helm uninstall -n kube-prometheus-stack kube-prometheus-stack

kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd scrapeconfigs.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
```

**Step 2**:  Install the new chart

```bash
helm upgrade --install -n kube-prometheus-stack -f fr-cloud-kps-values.yaml kube-prometheus-stack prometheus-community/kube-prometheus-stack --version 52.0.1
```



___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist.
