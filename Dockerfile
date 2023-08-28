# syntax=docker/dockerfile:1
FROM golang:1.21 AS debug
WORKDIR /src
COPY <<EOF ./main.go
package main

import "fmt"

func main() {
  fmt.Println("hello, world")
}
EOF
RUN go build -o /bin/hello ./main.go
CMD ["/bin/hello"]

FROM scratch AS prod
COPY --from=0 /bin/hello /bin/hello
CMD ["/bin/hello"]
