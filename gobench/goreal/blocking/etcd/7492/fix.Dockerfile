FROM golang:1.13
# Clone the project to local
RUN git clone https://github.com/etcd-io/etcd.git /go/src/github.com/coreos/etcd

# Install package dependencies
RUN apt-get update && \
	apt-get install -y vim python3

# Clone git porject dependencies


# Get go package dependencies


# Checkout the fixed version of this bug
WORKDIR /go/src/github.com/coreos/etcd
RUN git reset --hard 148c923c72c4aa9207173c03b775e2c0b8754067




RUN sed -i '72 igo test ./auth -c -o /go/gobench.test' test && \
	sed -i '73 iexit 0' test && \
	PKG=./auth PASSES='build unit' ./test