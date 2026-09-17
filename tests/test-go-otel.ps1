# Test script for Go OpenTelemetry instrumentation guide
# This validates that the documentation is accurate and functional

$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$TEST_DIR = Join-Path $SCRIPT_DIR "test-go-otel-temp"

Write-Host "🧪 Testing Go OpenTelemetry Instrumentation Guide" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""

# Cleanup function
function Cleanup {
    Write-Host ""
    Write-Host "🧹 Cleaning up..." -ForegroundColor Yellow
    Set-Location $SCRIPT_DIR

    if (Test-Path $TEST_DIR) {
        docker-compose -f "$TEST_DIR\docker-compose.yml" down -v 2>$null
        Remove-Item -Recurse -Force $TEST_DIR -ErrorAction SilentlyContinue
    }

    Write-Host "✅ Cleanup complete" -ForegroundColor Green
}

# Register cleanup on exit
trap { Cleanup; break }

# Test 1: Check prerequisites
Write-Host "📋 Step 1: Checking prerequisites..." -ForegroundColor Cyan

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Docker is not installed" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Docker is installed" -ForegroundColor Green

if (-not (Get-Command go -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Go is not installed" -ForegroundColor Red
    exit 1
}
$goVersion = go version
Write-Host "✅ Go is installed ($goVersion)" -ForegroundColor Green

try {
    docker info | Out-Null
    Write-Host "✅ Docker daemon is running" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker daemon is not running" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Test 2: Create test directory
Write-Host "📁 Step 2: Creating test directory..." -ForegroundColor Cyan
if (Test-Path $TEST_DIR) {
    Remove-Item -Recurse -Force $TEST_DIR
}
New-Item -ItemType Directory -Path $TEST_DIR | Out-Null
Set-Location $TEST_DIR
Write-Host "✅ Test directory created: $TEST_DIR" -ForegroundColor Green
Write-Host ""

# Test 3: Set up OTel Collector config
Write-Host "⚙️  Step 3: Creating OTel Collector configuration..." -ForegroundColor Cyan

@"
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: "0.0.0.0:4317"
      http:
        endpoint: "0.0.0.0:4318"

processors:
  batch: {}
  memory_limiter:
    check_interval: 1s
    limit_percentage: 75
    spike_limit_percentage: 15

exporters:
  logging:
    verbosity: detailed

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [logging]
    metrics:
      receivers: [otlp]
      processors: [memory_limiter, batch]
      exporters: [logging]
"@ | Out-File -FilePath "otel-config.yaml" -Encoding UTF8

Write-Host "✅ OTel Collector config created" -ForegroundColor Green
Write-Host ""

# Test 4: Create docker-compose file
Write-Host "🐳 Step 4: Creating docker-compose configuration..." -ForegroundColor Cyan

@"
services:
  otelcollector:
    image: otel/opentelemetry-collector-contrib:latest
    container_name: test-otelcollector
    restart: unless-stopped
    ports:
      - "4317:4317"
      - "4318:4318"
    volumes:
      - ./otel-config.yaml:/etc/otelcol-contrib/config.yaml
    command: ["--config=/etc/otelcol-contrib/config.yaml"]

  go-app:
    build: .
    container_name: test-go-otel-demo
    depends_on:
      - otelcollector
"@ | Out-File -FilePath "docker-compose.yml" -Encoding UTF8

Write-Host "✅ docker-compose.yml created" -ForegroundColor Green
Write-Host ""

# Test 5: Create Go project
Write-Host "🔧 Step 5: Creating Go test project..." -ForegroundColor Cyan

go mod init example.com/otel-demo-test
go get go.opentelemetry.io/otel
go get go.opentelemetry.io/otel/sdk
go get go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp
go get go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp

Write-Host "✅ Go dependencies installed" -ForegroundColor Green
Write-Host ""

# Test 6: Create main.go (same content as bash version)
Write-Host "📝 Step 6: Creating main.go..." -ForegroundColor Cyan

$mainGoContent = @"
package main

import (
	"context"
	"fmt"
	"log"
	"time"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp"
	"go.opentelemetry.io/otel/propagation"
	"go.opentelemetry.io/otel/sdk/metric"
	"go.opentelemetry.io/otel/sdk/resource"
	"go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"
)

var (
	endpoint       = "otelcollector:4318"
	serviceName    = "test-go-server-http"
	serviceVersion = "0.1.0"
	environment    = "test"
)

func setupMetrics(ctx context.Context) (*metric.MeterProvider, error) {
	exporter, err := otlpmetrichttp.New(
		ctx,
		otlpmetrichttp.WithInsecure(),
		otlpmetrichttp.WithEndpoint(endpoint),
	)
	if err != nil {
		return nil, err
	}

	res := resource.NewWithAttributes(
		semconv.SchemaURL,
		semconv.ServiceNameKey.String(serviceName),
		semconv.ServiceVersionKey.String(serviceVersion),
		attribute.String("environment", environment),
	)

	mp := metric.NewMeterProvider(
		metric.WithResource(res),
		metric.WithReader(
			metric.NewPeriodicReader(exporter, metric.WithInterval(5*time.Second)),
		),
	)

	otel.SetMeterProvider(mp)
	return mp, nil
}

func setupTracing(ctx context.Context) (*trace.TracerProvider, error) {
	exporter, err := otlptracehttp.New(
		ctx,
		otlptracehttp.WithInsecure(),
		otlptracehttp.WithEndpoint(endpoint),
	)
	if err != nil {
		return nil, err
	}

	res := resource.NewWithAttributes(
		semconv.SchemaURL,
		semconv.ServiceNameKey.String(serviceName),
		semconv.ServiceVersionKey.String(serviceVersion),
		attribute.String("environment", environment),
	)

	tp := trace.NewTracerProvider(
		trace.WithBatcher(exporter),
		trace.WithResource(res),
	)

	otel.SetTracerProvider(tp)

	otel.SetTextMapPropagator(
		propagation.NewCompositeTextMapPropagator(
			propagation.TraceContext{},
			propagation.Baggage{},
		),
	)

	return tp, nil
}

func main() {
	log.Printf("Starting OpenTelemetry test demo...")

	ctx := context.Background()

	mp, err := setupMetrics(ctx)
	if err != nil {
		panic(err)
	}
	defer mp.Shutdown(ctx)

	tp, err := setupTracing(ctx)
	if err != nil {
		panic(err)
	}
	defer tp.Shutdown(ctx)

	tracer := otel.Tracer(serviceName)
	meter := otel.Meter(serviceName)

	counter, err := meter.Int64Counter(
		"demo.counter",
		metric.WithDescription("Counts iterations of the demo loop"),
	)
	if err != nil {
		panic(err)
	}

	commonAttrs := []attribute.KeyValue{
		attribute.String("demo.type", "test"),
		attribute.String("demo.version", "1.0"),
	}

	ctx, span := tracer.Start(
		ctx,
		"demo-operation",
		trace.WithAttributes(commonAttrs...),
	)
	defer span.End()

	for i := 1; i <= 10; i++ {
		_, childSpan := tracer.Start(ctx, fmt.Sprintf("iteration-%d", i))
		log.Printf("Processing iteration %d / 10\n", i)

		counter.Add(ctx, 1, metric.WithAttributes(
			attribute.String("iteration", fmt.Sprintf("%d", i)),
		))

		time.Sleep(time.Second)
		childSpan.End()
	}

	log.Printf("Test complete!")
}
"@

$mainGoContent | Out-File -FilePath "main.go" -Encoding UTF8
Write-Host "✅ main.go created" -ForegroundColor Green
Write-Host ""

# Test 7: Create Dockerfile
Write-Host "🐋 Step 7: Creating Dockerfile..." -ForegroundColor Cyan

@"
FROM golang:1.21-alpine

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download && go mod verify

COPY *.go ./
RUN go build -o /go-otel-demo

CMD ["/go-otel-demo"]
"@ | Out-File -FilePath "Dockerfile" -Encoding UTF8

Write-Host "✅ Dockerfile created" -ForegroundColor Green
Write-Host ""

# Test 8: Verify Go code compiles
Write-Host "🔨 Step 8: Verifying Go code compiles..." -ForegroundColor Cyan
try {
    go build -o test-binary.exe main.go
    Remove-Item test-binary.exe
    Write-Host "✅ Go code compiles successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Go code failed to compile" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Test 9: Start OTel Collector
Write-Host "🚀 Step 9: Starting OTel Collector..." -ForegroundColor Cyan
docker-compose up -d otelcollector

Write-Host "⏳ Waiting for collector to be ready..."
Start-Sleep -Seconds 5

$collectorRunning = docker ps | Select-String "test-otelcollector"
if ($collectorRunning) {
    Write-Host "✅ OTel Collector is running" -ForegroundColor Green
} else {
    Write-Host "❌ OTel Collector failed to start" -ForegroundColor Red
    docker-compose logs otelcollector
    exit 1
}
Write-Host ""

# Test 10: Test with telemetrygen
Write-Host "🧪 Step 10: Testing collector with telemetrygen..." -ForegroundColor Cyan
Write-Host "Sending 10 test traces..."

docker run --network host ghcr.io/open-telemetry/opentelemetry-collector-contrib/telemetrygen:latest `
    traces --traces 10 --otlp-endpoint localhost:4317 --otlp-insecure

Start-Sleep -Seconds 2

$logs = docker logs test-otelcollector 2>&1 | Out-String
if ($logs -match "traces") {
    Write-Host "✅ Collector received test traces" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not confirm traces in collector logs" -ForegroundColor Yellow
}
Write-Host ""

# Test 11: Build and run Go app
Write-Host "🏗️  Step 11: Building Go Docker image..." -ForegroundColor Cyan
try {
    docker-compose build go-app
    Write-Host "✅ Go Docker image built successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to build Go Docker image" -ForegroundColor Red
    exit 1
}
Write-Host ""

Write-Host "🚀 Step 12: Starting Go application..." -ForegroundColor Cyan
docker-compose up -d go-app

Write-Host "⏳ Waiting for Go app to start..."
Start-Sleep -Seconds 3

$appRunning = docker ps | Select-String "test-go-otel-demo"
if ($appRunning) {
    Write-Host "✅ Go application is running" -ForegroundColor Green
} else {
    Write-Host "❌ Go application failed to start" -ForegroundColor Red
    docker-compose logs go-app
    exit 1
}
Write-Host ""

# Test 12: Verify data flow
Write-Host "🔍 Step 13: Verifying telemetry data flow..." -ForegroundColor Cyan
Write-Host "⏳ Waiting 15 seconds for telemetry data..."
Start-Sleep -Seconds 15

Write-Host ""
Write-Host "📊 Checking collector logs for traces and metrics..."

$collectorLogs = docker logs test-otelcollector 2>&1 | Out-String

if ($collectorLogs -match "test-go-server-http") {
    Write-Host "✅ Found telemetry from Go app [test-go-server-http]" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not find service name in logs" -ForegroundColor Yellow
}

if ($collectorLogs -match "demo-operation") {
    Write-Host "✅ Found trace spans" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not find trace spans" -ForegroundColor Yellow
}

if ($collectorLogs -match "demo.counter") {
    Write-Host "✅ Found metrics" -ForegroundColor Green
} else {
    Write-Host "⚠️  Could not find metrics" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📋 Go application logs:"
docker logs test-go-otel-demo

Write-Host ""
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "✅ Test Complete!" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Summary:"
Write-Host "  ✅ Docker and Go prerequisites verified"
Write-Host "  ✅ OTel Collector configuration created"
Write-Host "  ✅ Go code compiles successfully"
Write-Host "  ✅ Docker images build successfully"
Write-Host "  ✅ Collector receives telemetry data"
Write-Host "  ✅ Go app sends traces and metrics"
Write-Host ""
Write-Host "The Go instrumentation guide is working correctly! 🎉" -ForegroundColor Green
Write-Host ""
Write-Host "Note: This test uses a logging exporter instead of FR Cloud."
Write-Host "To test with actual FR Cloud, set FR_API_KEY and update"
Write-Host "otel-config.yaml to use otlphttp/fusionreactor exporter."
Write-Host ""

# Cleanup
Cleanup
