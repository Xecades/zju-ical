LIPO := /usr/bin/x86_64-apple-darwin-lipo
GIT_COMMIT_HASH := $(shell git rev-list -1 HEAD)
LDFLAGS_COMMON := -s -w
all: clean \
	zjuical-windows-amd64 zjuical-linux-amd64 zjuical-linux-arm64 zjuical-darwin-amd64 zjuical-darwin-arm64 \
	zjuicalsrv-windows-amd64 zjuicalsrv-linux-amd64 zjuicalsrv-linux-arm64 zjuicalsrv-darwin-amd64 zjuicalsrv-darwin-arm64 \
	merge-macos-binary

zjuical-windows-amd64:
	GOOS=windows GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON) -X zju-ical/internal/zjuical.version=$(GIT_COMMIT_HASH)" -o build/zjuical-windows-amd64.exe zju-ical/cmd/zjuical

zjuical-linux-amd64:
	GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON) -X zju-ical/internal/zjuical.version=$(GIT_COMMIT_HASH)" -o build/zjuical-linux-amd64 zju-ical/cmd/zjuical

zjuical-linux-arm64:
	GOOS=linux GOARCH=arm64 go build -ldflags "$(LDFLAGS_COMMON) -X zju-ical/internal/zjuical.version=$(GIT_COMMIT_HASH)" -o build/zjuical-linux-arm64 zju-ical/cmd/zjuical

zjuical-darwin-amd64:
	GOOS=darwin GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON) -X zju-ical/internal/zjuical.version=$(GIT_COMMIT_HASH)" -o build/zjuical-darwin-amd64 zju-ical/cmd/zjuical

zjuical-darwin-arm64:
	GOOS=darwin GOARCH=arm64 go build -ldflags "$(LDFLAGS_COMMON) -X zju-ical/internal/zjuical.version=$(GIT_COMMIT_HASH)" -o build/zjuical-darwin-arm64 zju-ical/cmd/zjuical

zjuicalsrv-windows-amd64:
	GOOS=windows GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON)" -o build/zjuicalsrv-windows-amd64.exe zju-ical/cmd/zjuicalsrv

zjuicalsrv-linux-amd64:
	GOOS=linux GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON)" -o build/zjuicalsrv-linux-amd64 zju-ical/cmd/zjuicalsrv

zjuicalsrv-linux-arm64:
	GOOS=linux GOARCH=arm64 go build -ldflags "$(LDFLAGS_COMMON)" -o build/zjuicalsrv-linux-arm64 zju-ical/cmd/zjuicalsrv

zjuicalsrv-darwin-amd64:
	GOOS=darwin GOARCH=amd64 go build -ldflags "$(LDFLAGS_COMMON)" -o build/zjuicalsrv-darwin-amd64 zju-ical/cmd/zjuicalsrv

zjuicalsrv-darwin-arm64:
	GOOS=darwin GOARCH=arm64 go build -ldflags "$(LDFLAGS_COMMON)" -o build/zjuicalsrv-darwin-arm64 zju-ical/cmd/zjuicalsrv

merge-macos-binary:
	$(LIPO) -create build/zjuical-darwin-amd64 build/zjuical-darwin-arm64 -o build/zjuical-darwin-universal
	$(LIPO) -create build/zjuicalsrv-darwin-amd64 build/zjuicalsrv-darwin-arm64 -o build/zjuicalsrv-darwin-universal

clean:
	-rm -f build/*

.PHONY: all clean \
	zjuical-windows-amd64 zjuical-linux-amd64 zjuical-linux-arm64 zjuical-darwin-amd64 zjuical-darwin-arm64 \
	zjuicalsrv-windows-amd64 zjuicalsrv-linux-amd64 zjuicalsrv-linux-arm64 zjuicalsrv-darwin-amd64 zjuicalsrv-darwin-arm64 \
	merge-macos-binary