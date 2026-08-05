# Limit data for OpsPilot ingest

OpsPilot enforces rate limits for ingested data.  The ingest system will return `429: Too Many Requests` when this condition occurs; clients can then take appropriate action.

## Metrics

- Standard rate limit:  10,000 metrics/s
- Bursting to: 200,000 metrics/s

## Traces

- Maximum trace size:  10 MB
- Standard rate limit:  50 MB/s
- No burst.

## Logs

- Standard rate limit:  12 MB/s
- Bursting to:  18 MB/s


!!! info 
    [How to reduce billing usage costs in OpsPilot](/Troubleshooting/Optimize-data/)