
# GoReal

| Bug ID|  Ref | Patch | Type | SubType | SubsubType |
| ----  | ---- | ----  | ---- | ---- | ---- |
|[serving#5865]|[pull request]|[patch]| NonBlocking | Go-Specific | Channel Misuse |

[serving#5865]:(serving5865_test.go)
[patch]:https://github.com/ knative/serving/pull/5865/files
[pull request]:https://github.com/ knative/serving/pull/5865
 

## Backtrace

```
Write at 0x00c00074a5b0 by goroutine 92:
  runtime.closechan()
      /usr/local/go/src/runtime/chan.go:334 +0x0
  knative.dev/serving/pkg/activator/net.(*revisionWatcher).run()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:318 +0x4ef

Previous read at 0x00c00074a5b0 by goroutine 27:
  runtime.chansend()
      /usr/local/go/src/runtime/chan.go:142 +0x0
  knative.dev/serving/pkg/activator/net.(*revisionBackendsManager).endpointsUpdated()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:450 +0x881
  knative.dev/serving/pkg/activator/net.(*revisionBackendsManager).endpointsUpdated-fm()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:432 +0x55
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*ResourceEventHandlerFuncs).OnAdd()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/controller.go:195 +0x8c
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.FilteringResourceEventHandler.OnAdd()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/controller.go:227 +0x7a
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*FilteringResourceEventHandler).OnAdd()
      <autogenerated>:1 +0x93
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run.func1.1()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:607 +0x39e
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.ExponentialBackoff()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:284 +0x5e
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:601 +0xdb
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.JitterUntil.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:152 +0x6f
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.JitterUntil()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:153 +0x108
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:88 +0xa8
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run-fm()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:593 +0x41
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.(*Group).Start.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:71 +0x6a

Goroutine 92 (running) created at:
  knative.dev/serving/pkg/activator/net.(*revisionBackendsManager).getOrCreateRevisionWatcher()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:423 +0x4b1
  knative.dev/serving/pkg/activator/net.(*revisionBackendsManager).endpointsUpdated()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:443 +0x22b
  knative.dev/serving/pkg/activator/net.(*revisionBackendsManager).endpointsUpdated-fm()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:432 +0x55
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*ResourceEventHandlerFuncs).OnAdd()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/controller.go:195 +0x8c
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.FilteringResourceEventHandler.OnAdd()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/controller.go:227 +0x7a
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*FilteringResourceEventHandler).OnAdd()
      <autogenerated>:1 +0x93
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run.func1.1()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:607 +0x39e
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.ExponentialBackoff()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:284 +0x5e
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:601 +0xdb
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.JitterUntil.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:152 +0x6f
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.JitterUntil()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:153 +0x108
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:88 +0xa8
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*processorListener).run-fm()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:593 +0x41
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.(*Group).Start.func1()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:71 +0x6a

Goroutine 27 (finished) created at:
  knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait.(*Group).Start()
      /go/src/knative.dev/serving/vendor/k8s.io/apimachinery/pkg/util/wait/wait.go:69 +0x6f
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*sharedProcessor).addListener()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:443 +0x2fc
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*sharedIndexInformer).AddEventHandlerWithResyncPeriod()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:391 +0x2ac
  knative.dev/serving/vendor/k8s.io/client-go/tools/cache.(*sharedIndexInformer).AddEventHandler()
      /go/src/knative.dev/serving/vendor/k8s.io/client-go/tools/cache/shared_informer.go:327 +0x69
  knative.dev/serving/pkg/activator/net.newRevisionBackendsManagerWithProbeFrequency()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends.go:364 +0x6b6
  knative.dev/serving/pkg/activator/net.TestRevisionBackendManagerAddEndpoint.func1()
      /go/src/knative.dev/serving/pkg/activator/net/revision_backends_test.go:661 +0x830
  testing.tRunner()
      /usr/local/go/src/testing/testing.go:909 +0x199
```

