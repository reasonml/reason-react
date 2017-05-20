type reactClass;

type reactElement;

type reactRef;

external createElement : reactClass => props::Js.t {..}? => array reactElement => reactElement =
  "createElement" [@@bs.splice] [@@bs.val] [@@bs.module "React"];
