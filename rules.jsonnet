local mixin = import 'mixin.libsonnet';

local createPrometheusRule(rule) =
  local ruleName = std.strReplace(std.strReplace(rule.name, '_', '-'), '.', '-');
  {
    apiVersion: 'monitoring.coreos.com/v1',
    kind: 'PrometheusRule',
    metadata: {
      name: ruleName,
    },
    spec: {
      groups: [
        rule,
      ],
    },
  };

[
  createPrometheusRule(rule)
  for rule in mixin.prometheusRules.groups
]
