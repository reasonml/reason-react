'use strict';


function unsafeAddProp(style, key, value) {
  var dict = { };
  dict[key] = value;
  return Object.assign(({}), style, dict);
}

exports.unsafeAddProp = unsafeAddProp;
/* No side effect */
