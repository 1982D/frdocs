# Katie - Kubernetes Tooling for AI

**Katie** is an AI agent to answer questions about your Kubernetes cluster.

> **Prompt**:  Are any pods in trouble in the demo cluster?

```bash
No pods are in trouble. All pods show:

READY: All containers ready (e.g., 1/1, 2/2)
STATUS: All "Running"
RESTARTS: Only katie-agent has 12 restarts, but it's currently stable

The cluster is healthy.
```

> **Prompt**:  Get me a list of nodes together with their available and used resources.  Are any nodes in trouble?

```bash
Demo cluster nodes status:
ip-172-20-1-159 - Ready - 122/1930 mCores (6%) - 831 MiB/6.9 GiB (12%) - 10/29 pods - ✅ Healthy
ip-172-20-6-214 - Ready - 201/1930 mCores (10%) - 4.3 GiB/6.9 GiB (62%) - 29/29 pods - ⚠️ Pod limit reached
ip-172-20-7-174 - Ready - 104/1930 mCores (5%) - 2.4 GiB/6.9 GiB (35%) - 16/29 pods - ✅ Healthy

Issues identified:

- ip-172-20-6-214: Pod capacity exhausted (29/29 pods) - cannot schedule new pods
- All nodes show low CPU usage (5-10%)
- Memory usage acceptable across all nodes

ip-172-20-6-214 is at risk - no pod scheduling capacity remaining.
```

## Prerequisites

* Katie consists of two elements: an agent, which runs in your Kubernetes cluster, and an MCP tool, which you run locally on your computer.  
* Communication between the two is facilitated by **OpsPilot**.

## Next Steps: Install Katie Components

### Katie Agent

The Katie Agent is a single pod that runs inside your cluster and responds to live data requests from OpsPilot.

As a cluster administrator, you’ll need to install the Katie Agent in each Kubernetes cluster you want to integrate with AI. The easiest way to do this is by using our Helm chart. Installation instructions are available on our [GitHub repository](https://github.com/intergral/katie-helm).



### Katie MCP

Once the agent is installed, you can use the Katie MCP with any compatible MCP host - such as Claude Desktop - to interact with your cluster and gain real-time insights into its performance.

!!! info 
    [Installing Katie MCP](/Monitor-your-data/Katie/install/)