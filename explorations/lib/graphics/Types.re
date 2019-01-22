/**
 * Types shared by all submodules of `Graphics`.
 */
/**
 * Types associated primarily with `Graphics.Geometry`.
 */
type point = {
  x: float,
  y: float,
};

type size = {
  width: float,
  height: float,
};

type rect = {
  origin: point,
  size,
};

type vector = {
  dx: float,
  dy: float,
};

type textStyle = {
  font: option(string),
  fill: option(string),
  align: option(string),
  stroke: option(string),
  strokeThickness: option(float),
  wordWrap: option(string),
  wordWrapWidth: option(float),
  lineHeight: option(float),
  dropShadow: option(bool),
  dropShadowColor: option(string),
  dropShadowAngle: option(float),
  dropShadowDistance: option(float),
  padding: option(float),
  textBaseline: option(string),
  lineJoin: option(string),
  miterLimit: option(float),
};
