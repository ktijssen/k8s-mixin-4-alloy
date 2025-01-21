local kubernetes = import 'github.com/kubernetes-monitoring/kubernetes-mixin/mixin.libsonnet';

kubernetes {
  _config+:: {
    cadvisorSelector: 'job="integrations/kubernetes/cadvisor"',
    kubeletSelector: 'job="integrations/kubernetes/kubelet"',
    kubeStateMetricsSelector: 'job="integrations/kubernetes/kube-state-metrics"',
    nodeExporterSelector: 'job="integrations/node_exporter"',
    kubeSchedulerSelector: 'job="kube-scheduler"',
    kubeControllerManagerSelector: 'job="kube-controller-manager"',
    kubeApiserverSelector: 'job="integrations/kubernetes/apiserver"',
    kubeProxySelector: 'job="integrations/kubernetes/kube-proxy"',

    showMultiCluster: true,
    clusterLabel: 'cluster',

    grafanaK8s+:: {
      dashboardNamePrefix: 'Mixin / ',
      dashboardTags: ['kubernetes', 'infrastucture'],
    },
  },
}
