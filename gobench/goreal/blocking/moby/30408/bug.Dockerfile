FROM golang:1.13
# Clone the project to local
RUN git clone https://github.com/moby/moby.git /go/src/github.com/moby/moby




WORKDIR /go/src/github.com/moby/moby

# Rollback to the latest bug-free version
RUN git reset --hard 113e9f07f49e9089df41585aeb355697b4c96120

# Apply the revert patch to this bug
COPY ./bug_patch.diff github.com/moby/moby/bug_patch.diff
RUN git apply github.com/moby/moby/bug_patch.diff

# Pred-build
RUN sed -i '68s/--rm//' Makefile && \
    sed -i '68s/MOUNT)/MOUNT) -v \/go\/test:\/go\/test --name moby_30408_cntr/' Makefile && \
    sed -i '52s/-cover//' hack/make/test-unit && \
    sed -i '52s/go test.*/&\n\t&/' hack/make/test-unit && \
    sed -i '52s/$/ -i/' hack/make/test-unit && \
    sed -i '53s/\$pkg_list//' hack/make/test-unit && \
    sed -i '53s/$/ -c -o \/go\/gobench.test/' hack/make/test-unit


# For entrypoint
WORKDIR /go/src/github.com/moby/moby/.
