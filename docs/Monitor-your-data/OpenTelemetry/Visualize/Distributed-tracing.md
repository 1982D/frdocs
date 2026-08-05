# Distributed tracing

<iframe src="https://player.vimeo.com/video/838715935?h=8353e18541" width="640" height="363" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>

## What is distributed tracing?


Distributed tracing is a technique of tracking application requests as they move from frontend devices to backend services and databases. Developers use distributed tracing to troubleshoot applications and optimize application performance. You can pinpoint requests with errors or high latency and quickly diagnose performance issues to gain real-time visibility of the user experience.


OpsPilot is able to provide distributed trace information which is captured and displayed in a graphical format, so you can visualize the entire request flow and quickly identify any issues or bottlenecks.  



## How does it work?

Distributed tracing occurs when a single request is assigned a unique trace ID. As user requests travel through a distributed system, sets of spans are generated for every new operation that is required on the journey.

Multiple functions are performed on the request that generate different connected and/or nested spans - all of which have trace data encoded in them. This data can include recorded annotation information like date, time, duration, error messages, service names or any metadata.

This trace data, logs and signal information provides a metric enabling developers to not only debug current systems, but to optimize their code for future service enhancement.

## Benefits

* Immediate root-cause identification of every service impact.

* Effectively measure the overall health of a system.

* Improve end-user customer experience by reducing and swiftly troubleshooting issues.

* Reduce mean time to resolution (MTTR).

* Understand service relationships.

* Improve productivity and collaboration.



## Propagation
In order for instances/services to propagate trace information to other services, they inject trace information as headers on outgoing requests. Receiving instances/services extract this information from the headers and use it when building spans, ensuring that the information is propagated.  


!!! warning "Trace header formats"
    Not all vendors use the same format for propagating trace information in headers, read below for how to specify which header format to use to ensure that trace information is properly propagated by FusionReactor.

### Trace propagators supported by FusionReactor
| Header format | Property value |
| -- | -- |
| W3C Trace context | `tracecontext` |
| W3C Baggage | `baggage` |
| B3 Single | `b3` |
| B3 Multi | `b3multi` |
| Jaeger | `jaeger` |
| AWS X-ray | `xray` |
| OT Trace | `ottrace` |


### Properties used for propagation
Add to JVM arguments/options by prepending with `-D`.

| Property key | Default | Description |
| -- | -- | -------- |
| `fr.observability.trace.propagators` | `"tracecontext,baggage"` | A comma-separated list of propagators to use. Options: `tracecontext`,`baggage`,`b3`,`b3multi`,`jaeger`,`xray`,`ottrace`. Use `all` to use all of them. |

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 