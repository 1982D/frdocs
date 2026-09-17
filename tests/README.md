# Testing the Go OpenTelemetry Instrumentation Guide

This directory contains automated test scripts to validate that the Go instrumentation documentation is accurate and functional.

## What the tests do

The test scripts validate the complete end-to-end flow:

1. ✅ Verify prerequisites (Docker, Go installed and running)
2. ✅ Create OTel Collector configuration
3. ✅ Set up a test Go project with OpenTelemetry
4. ✅ Verify Go code compiles
5. ✅ Build Docker images
6. ✅ Start OTel Collector
7. ✅ Test collector with telemetrygen
8. ✅ Run the Go application
9. ✅ Verify traces and metrics are received
10. ✅ Clean up all test resources

## Running the tests

### On Windows (PowerShell)

```powershell
.\test-go-otel.ps1
```

### On Linux/Mac (Bash)

```bash
chmod +x test-go-otel.sh
./test-go-otel.sh
```

## Prerequisites

Before running the tests, ensure you have:

- **Docker Desktop** installed and running
- **Go** (version 1.19 or later)
- **Internet connection** (to download Docker images and Go packages)

## What to expect

The test takes approximately **30-40 seconds** to run. You'll see colored output showing:

- 🟢 Green checkmarks for successful steps
- 🔴 Red X marks for failures
- 🟡 Yellow warnings for non-critical issues

### Successful output example

```
🧪 Testing Go OpenTelemetry Instrumentation Guide
==================================================

📋 Step 1: Checking prerequisites...
✅ Docker is installed
✅ Go is installed (go version go1.21.0)
✅ Docker daemon is running

📁 Step 2: Creating test directory...
✅ Test directory created

...

==================================================
✅ Test Complete!
==================================================

Summary:
  ✅ Docker and Go prerequisites verified
  ✅ OTel Collector configuration created
  ✅ Go code compiles successfully
  ✅ Docker images build successfully
  ✅ Collector receives telemetry data
  ✅ Go app sends traces and metrics

The Go instrumentation guide is working correctly! 🎉
```

## Testing with FusionReactor Cloud

The default test uses a **logging exporter** to verify data flow locally without requiring a FusionReactor Cloud account.

To test with **actual FusionReactor Cloud**:

1. Set your API key as an environment variable:
   ```powershell
   # PowerShell
   $env:FR_API_KEY="your-api-key-here"
   ```

2. Modify the generated `test-go-otel-temp/otel-config.yaml` to use the FR Cloud exporter:
   ```yaml
   exporters:
     otlphttp/fusionreactor:
       endpoint: "https://api.fusionreactor.io"
       headers:
         authorization: "${FR_API_KEY}"

   service:
     pipelines:
       traces:
         receivers: [otlp]
         processors: [memory_limiter, batch]
         exporters: [otlphttp/fusionreactor]
       metrics:
         receivers: [otlp]
         processors: [memory_limiter, batch]
         exporters: [otlphttp/fusionreactor]
   ```

3. Re-run the test and check FusionReactor Cloud **Explore > Traces** for the `test-go-server-http` service

## Troubleshooting

### "Docker daemon is not running"
- Start Docker Desktop and wait for it to fully initialize

### "Go is not installed"
- Install Go from https://go.dev/dl/

### "Port already in use"
- Another service may be using ports 4317 or 4318
- Stop conflicting services or change ports in docker-compose.yml

### Tests pass but no data in FR Cloud
- Verify your `FR_API_KEY` is correct
- Check the OTel Collector exporter configuration
- Ensure your network allows outbound HTTPS to api.fusionreactor.io

## Cleanup

The test script automatically cleans up:
- Stops and removes Docker containers
- Deletes the `test-go-otel-temp` directory

If cleanup fails, manually run:

```powershell
# PowerShell
docker-compose -f test-go-otel-temp/docker-compose.yml down -v
Remove-Item -Recurse -Force test-go-otel-temp
```

```bash
# Bash
docker-compose -f test-go-otel-temp/docker-compose.yml down -v
rm -rf test-go-otel-temp
```

## What this validates

Running this test successfully confirms:

✅ The documentation steps are accurate
✅ Code examples compile without errors
✅ Docker configurations are valid
✅ OpenTelemetry SDK integration works
✅ Data flows from Go app → Collector → destination
✅ Both traces and metrics are captured

## Next steps

After validating the test works:

1. Review the generated files in `test-go-otel-temp/` to see the actual implementation
2. Test with your real FusionReactor Cloud account
3. Use this as a reference for your own Go applications

## Questions?

If you encounter issues with the test script or documentation, please contact support or file an issue in the repository.
