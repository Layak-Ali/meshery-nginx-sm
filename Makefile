docker:
	docker build -t layer5/meshery-nginx-sm .

docker-run:
	(docker rm -f meshery-nginx-sm) || true
	docker run --name meshery-nginx-sm -d \
	-p 10010:10010 \
	-e DEBUG=true \
	layer5/meshery-nginx-sm


## Build and run Adapter locally
run:
	go$(v) mod tidy; \
	DEBUG=true GOPROXY=direct GOSUMDB=off go run main.go

run-force-dynamic-reg:
	FORCE_DYNAMIC_REG=true DEBUG=true GOPROXY=direct GOSUMDB=off go run main.go

.PHONY: error
error:
	go run github.com/layer5io/meshkit/cmd/errorutil -d . analyze -i ./helpers -o ./helpers
