# Installing Katie MCP

**Katie MCP** is a [Model Context Protocol](https://modelcontextprotocol.io/docs/getting-started/intro) server that can be installed into any compatible MCP Client, such as Claude Desktop. It allows **AI Language Models** to access accurate, live information from your Kubernetes cluster - provided you have deployed the **Katie Agent**. 

For a curated list of clients, check out the [Awesome MCP Clients](https://github.com/punkpeye/awesome-mcp-clients) repository. All usage examples provided have been tested with [Claude Desktop](https://claude.ai/download). 


## Prerequisites

- A working local [Docker](https://www.docker.com/) environment:  the [Katie MCP Server](https://hub.docker.com/r/intergral/katie-mcp) is supplied from Docker Hub as a pre-packaged container, in AMD64 and ARM64 architectures.
- An MCP Client, capable of loading and using MCPs with an AI Language Model, for example [Claude Desktop](https://claude.ai/download).



## Configuring Katie MCP

### Using `stdio` transport (Recommended)

Running Katie MCP with the `stdio` transport is the recommended approach. Most MCP clients can automatically start and stop the container as needed, communicating with it directly over `stdio`.

To run Katie MCP in this mode, use the following command:

```bash
API_KEY=YOUR_API_KEY docker run \
        --rm \
        -i \
        -e API_KEY \
        intergral/katie-mcp \
        -t stdio
```

and the environment variable `API_KEY` must be set in the environment.

For **Claude Desktop**, the relevant MCP configuration block is:

```bash
{
  	"mcpServers": {
        "katie-production-docker": {
            "env": {
                "API_KEY": "YOUR_API_KEY"
            },
            "command": "docker",
            "args": [ "run",
                "--rm",
                "-i",
                "-e",
                "API_KEY",
                "intergral/katie-mcp",
                "-t",
                "stdio"
            ]
        }
	  }
}
```

### MCP as `SSE` (shared) transport

It is also possible to run the docker separately, perhaps in a shared environment, and have MCP clients connect to it using the [Server-Sent Events](https://www.mcpevals.io/blog/mcp-server-side-events-explained) (SSE) transport.  

This method has more network and configuration steps, and is **not** recommended if the `stdio` method above works for you.

This method has an **additional prerequisite**: 

- The `npx` command must be available.  This is part of the Node Package Manager, commonly installed with the [NodeJS](https://nodejs.org/en) environment.

The command to run Katie MCP in this mode is:

```bash
API_KEY=YOUR_API_KEY docker run \
        --restart always \
        -i \
        -e API_KEY \
        -p 8000:8000
        intergral/katie-mcp \
        -t sse
```
This will start the SSE listener on port 8000.

For Claude Desktop, the configuration to communicate with this is:

```bash
{
  	"mcpServers": {
        "katie-production-sse": {
            "command": "npx",
            "args": [
                "-y",
                "mcp-remote",
                "http://localhost:8000/sse"
            ]
        }
	  }
}
```


## Configuring Claude Code

This configuration uses the **MCP** in a local Docker container to connect to **OpsPilot**.

### 1. Start the Docker container locally

```bash
docker run \ 
    --restart always \
    --name fr-katie \
    -d \
    -e API_KEY=FR_CLOUD_API_KEY \
    -p 8000:8000 intergral/katie-mcp:main.345584e0.58 \
    -t sse
```

!!! info
    You can get the latest image tag from [here](https://hub.docker.com/r/intergral/katie-mcp/tags).


### 2. Add the MCP to Claude Code

Once the container is running, add the MCP to Claude Code on the command line:

```bash
claude mcp add --scope=user --transport=sse fr-katie-prod "http://localhost:8000/sse"
```


### 3. Validate the connection

Finally, run the following command to validate the connection:

```bash
claude mcp list
```

## Example prompts & workflows



!!! note
    Not all prompts will be available to you if running the Agent with restricted (read-only, or custom) privileges.


### Simple queries

| Prompt | Description |
|-------|-------------|
| `What clusters are connected?` | See what clusters are connected via their Katie Agents to OpsPilot. |
| `What namespaces are available?` | Self-explanatory. |
| `List all the pods in the 'otel-demo' namespace, along with their resource requirements and usage.` | Self-explanatory. |
| `Are any pods in trouble?` | Gets a short summary of any pod problems. |
| `Get the logs for the restarted pod.` | Retrieves and analyzes the logs for the pod that restarted. |
| `List all pods in the namespace, together with their resource requests and usages as a percentage of the available node capacity. Order by percentage node memory used.` | Produces a table of pods, showing how demanding each is on the node they’re running on, with a usage summary. |
| `Show me all Helm deployments` | Gets a list of Helm deployments. |


### More complex operations

| Prompt | Description |
|-------|-------------|
| `Summarize the cluster, thinking about pressure and resource usage.` | Get a summary of the cluster nodes, and a short summary of any problems. |
| `Are any deployments under-replicated?` | Ascertain whether all deployments have their required number of pods. |
| `Scale deployment 'quote' to 2 pods.` | Scale a deployment up or down. |
| `Scale that deployment back again.` | Revert a previous scaling action. |
| `Cordon node ip-172-20-1-159.eu-west-1.compute.internal` | Cordon (make unavailable for scheduling new pods) a node. |
| `Uncordon it again` | Self-explanatory. |



