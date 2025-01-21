local mixin = import 'mixin.libsonnet';

local createGrafanaDashboard(dashboard) =
  local dashboardName = std.rstripChars(dashboard.key, '.json');
  {
    apiVersion: 'v1',
    kind: 'ConfigMap',
    metadata: {
      name: dashboardName,
      labels: {
        grafana_dashboard: '1',
      },
    },
    data: {
      [dashboard.key]: std.toString(dashboard.value),
    },
  };

[
  createGrafanaDashboard(dashboard)
  for dashboard in std.objectKeysValues(mixin.grafanaDashboards)
]
