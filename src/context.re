type t('props);

[@mel.obj]
external makeProps:
  (~value: 'props, ~children: Types.element, unit) =>
  {
    .
    "value": 'props,
    "children": Types.element,
  };

[@mel.get]
external provider:
  t('props) =>
  Types.component({
    .
    "value": 'props,
    "children": Types.element,
  }) =
  "Provider";
