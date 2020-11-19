
# GoReal

| Bug ID|  Ref | Patch | Type | SubType | SubsubType |
| ----  | ---- | ----  | ---- | ---- | ---- |
|[kubernetes#16851]|[pull request]|[patch]| Blocking | Mixed Deadlock | Channel & Lock |

[kubernetes#16851]:(kubernetes16851_test.go)
[patch]:https://github.com/kubernetes/kubernetes/pull/16851/files
[pull request]:https://github.com/kubernetes/kubernetes/pull/16851
 
## Description

Some description from developers or pervious reseachers.

> The MockPodsListWatch was locking itself for list modifications 
> and then accessed the event channel without unlocking before. 
> This results in a deadlock situation when the listener of the event 
> channel is also the caller of the function which locks. Or in this situation

```go
go func() {
 mock.List()
 mock.Watch()
}()
mock.Add()
```

> This gives a deadlock if the execution order is the following:
> * mock.Add() => lock(), channel<- event => BLOCKED
> * mock.List() => lock() => BLOCKED
> * mock.Watch() is never reached.

It is difficult for goleak to exclude worker goroutines 
through goleak's IgnoreTopFunction(). For example,

```
 Goroutine 192 in state sync.Cond.Wait, with runtime.goparkunlock on top of the stack:
goroutine 192 [sync.Cond.Wait]:
runtime.goparkunlock(...)
    /usr/local/go/src/runtime/proc.go:310
sync.runtime_notifyListWait(0xc0002446f0, 0xc00000000c)
    /usr/local/go/src/runtime/sema.go:510 +0xf8
sync.(*Cond).Wait(0xc0002446e0)
    /usr/local/go/src/sync/cond.go:56 +0x9d
k8s.io/kubernetes/contrib/mesos/pkg/runtime.After.func1(0xc00009ef00, 0xc000240d80)
    /go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes/contrib/mesos/pkg/runtime/util.go:95 +0xc7
created by k8s.io/kubernetes/contrib/mesos/pkg/runtime.After
    /go/src/k8s.io/kubernetes/_output/local/go/src/k8s.io/kubernetes/contrib/mesos/pkg/runtime/util.go:91 +0x62
```

