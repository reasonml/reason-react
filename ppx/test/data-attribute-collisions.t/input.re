let distinct = <div dataFoo="first" data_foo="second" />;

let optional = (first, second) => <div dataFoo=?first data_foo=?second />;
let optionalFirst = first => <div dataFoo=?first data_foo="fallback" />;
let requiredFirst = second => <div dataFoo="first" data_foo=?second />;

let effects =
  <div
    className={next("class")}
    dataURL={next("first")}
    data_URL={next("second")}
  />;

let serverNames =
  <div
    dataFoo="plain"
    dataFoo__bar="double"
    dataFoo___="trailing"
    dataFoo_bar="single"
    dataURL="acronym"
    dataURLPath="acronym then word"
    dataVersion2="digit"
    dataVersion20="digits"
    data2="leading digit"
    data_foo="leading underscore"
    datafoo="lowercase"
  />;

let underscoreThenUppercase = <div dataFoo_Bar="underscore then uppercase" />;
