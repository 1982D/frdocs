# Pyroscope

FusionReactor 2025.1.0 introduced the ability to view transaction profiles in Pyroscope and on traces in Tempo.
This will display your normal profiles in a queryable flame graph form.

!!! note
    Class names are prepended with an ID so that profiler nodes are displayed chronologically left-to-right. This may change in the future.

| <a href="/Data-insights/Features/Pyroscope/trace.png" target="_blank">![](/Data-insights/Features/Pyroscope/trace.png)</a>                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------|
| Profiles are now included on root spans, when available. This allows the ability to find the root cause of a span's/transaction's duration. |

| <a href="/Data-insights/Features/Pyroscope/profiles_for_span.png" target="_blank">![](/Data-insights/Features/Pyroscope/profiles_for_span.png)</a>                                         |
|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| When a profile's present on the span, clicking the `Profiles for this span` button will open a new view of the profile which can be inspected more easily. |

!!! note
    Profile labels may change in the future. Currently, there's only the transaction's flavor and ID but more could be added.

| <a href="/Data-insights/Features/Pyroscope/group_by_flavour.png" target="_blank">![](/Data-insights/Features/Pyroscope/group_by_flavour.png)</a>                                                           |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| You can group profiles by label for a better look at what's taking a long time. You can filter profiles by adding `key=value` in the query (filters are separated by `,`). |