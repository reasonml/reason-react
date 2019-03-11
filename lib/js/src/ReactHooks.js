'use strict';

var Curry = require("bs-platform/lib/js/curry.js");
var React = require("react");

function useEffect(generator) {
  React.useEffect((function () {
          return Curry._1(generator, /* () */0);
        }), ([]));
  return /* () */0;
}

function useEffect1(generator, key) {
  React.useEffect((function () {
          return Curry._1(generator, key);
        }), /* array */[key]);
  return /* () */0;
}

function useEffect2(generator, k0, k1) {
  React.useEffect((function () {
          return Curry._2(generator, k0, k1);
        }), /* tuple */[
        k0,
        k1
      ]);
  return /* () */0;
}

function useEffect3(generator, k0, k1, k2) {
  React.useEffect((function () {
          return Curry._3(generator, k0, k1, k2);
        }), /* tuple */[
        k0,
        k1,
        k2
      ]);
  return /* () */0;
}

function useEffect4(generator, k0, k1, k2, k3) {
  React.useEffect((function () {
          return Curry._4(generator, k0, k1, k2, k3);
        }), /* tuple */[
        k0,
        k1,
        k2,
        k3
      ]);
  return /* () */0;
}

function useMemo(generator) {
  return React.useMemo((function () {
                return Curry._1(generator, /* () */0);
              }), ([]));
}

function useMemo1(generator, ctx0) {
  return React.useMemo((function () {
                return Curry._1(generator, ctx0);
              }), /* array */[ctx0]);
}

function useMemo2(generator, ctx0, ctx1) {
  return React.useMemo((function () {
                return Curry._2(generator, ctx0, ctx1);
              }), /* tuple */[
              ctx0,
              ctx1
            ]);
}

function useMemo3(generator, ctx0, ctx1, ctx2) {
  return React.useMemo((function () {
                return Curry._3(generator, ctx0, ctx1, ctx2);
              }), /* tuple */[
              ctx0,
              ctx1,
              ctx2
            ]);
}

function useMemo4(generator, ctx0, ctx1, ctx2, ctx3) {
  return React.useMemo((function () {
                return Curry._4(generator, ctx0, ctx1, ctx2, ctx3);
              }), /* tuple */[
              ctx0,
              ctx1,
              ctx2,
              ctx3
            ]);
}

function useMemo5(generator, ctx0, ctx1, ctx2, ctx3, ctx4) {
  return React.useMemo((function () {
                return Curry._5(generator, ctx0, ctx1, ctx2, ctx3, ctx4);
              }), /* tuple */[
              ctx0,
              ctx1,
              ctx2,
              ctx3,
              ctx4
            ]);
}

function useMemo6(generator, ctx0, ctx1, ctx2, ctx3, ctx4, ctx5) {
  return React.useMemo((function () {
                return Curry._6(generator, ctx0, ctx1, ctx2, ctx3, ctx4, ctx5);
              }), /* tuple */[
              ctx0,
              ctx1,
              ctx2,
              ctx3,
              ctx4,
              ctx5
            ]);
}

exports.useEffect = useEffect;
exports.useEffect1 = useEffect1;
exports.useEffect2 = useEffect2;
exports.useEffect3 = useEffect3;
exports.useEffect4 = useEffect4;
exports.useMemo = useMemo;
exports.useMemo1 = useMemo1;
exports.useMemo2 = useMemo2;
exports.useMemo3 = useMemo3;
exports.useMemo4 = useMemo4;
exports.useMemo5 = useMemo5;
exports.useMemo6 = useMemo6;
/* react Not a pure module */
