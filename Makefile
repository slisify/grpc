all: vet test testrace testappengine

build: deps
	go build github.com/slisify/grpc/...

clean:
	go clean -i github.com/slisify/grpc/...

deps:
	go get -d -v github.com/slisify/grpc/...

proto:
	@ if ! which protoc > /dev/null; then \
		echo "error: protoc not installed" >&2; \
		exit 1; \
	fi
	go generate github.com/slisify/grpc/...

test: testdeps
	go test -cpu 1,4 -timeout 5m github.com/slisify/grpc/...

testappengine: testappenginedeps
	goapp test -cpu 1,4 -timeout 5m github.com/slisify/grpc/...

testappenginedeps:
	goapp get -d -v -t -tags 'appengine appenginevm' github.com/slisify/grpc/...

testdeps:
	go get -d -v -t github.com/slisify/grpc/...

testrace: testdeps
	go test -race -cpu 1,4 -timeout 7m github.com/slisify/grpc/...

updatedeps:
	go get -d -v -u -f github.com/slisify/grpc/...

updatetestdeps:
	go get -d -v -t -u -f github.com/slisify/grpc/...

vet: vetdeps
	./vet.sh

vetdeps:
	./vet.sh -install

.PHONY: \
	all \
	build \
	clean \
	deps \
	proto \
	test \
	testappengine \
	testappenginedeps \
	testdeps \
	testrace \
	updatedeps \
	updatetestdeps \
	vet \
	vetdeps
