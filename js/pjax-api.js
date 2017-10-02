/*! pjax-api v3.16.9 https://github.com/falsandtru/pjax-api | (c) 2017, falsandtru | (Apache-2.0 AND MPL-2.0) License */
require = function e(t, n, r) {
    function s(o, u) {
        if (!n[o]) {
            if (!t[o]) {
                var a = typeof require == 'function' && require;
                if (!u && a)
                    return a(o, !0);
                if (i)
                    return i(o, !0);
                var f = new Error('Cannot find module \'' + o + '\'');
                throw f.code = 'MODULE_NOT_FOUND', f;
            }
            var l = n[o] = { exports: {} };
            t[o][0].call(l.exports, function (e) {
                var n = t[o][1][e];
                return s(n ? n : e);
            }, l, l.exports, e, t, n, r);
        }
        return n[o].exports;
    }
    var i = typeof require == 'function' && require;
    for (var o = 0; o < r.length; o++)
        s(r[o]);
    return s;
}({
    1: [
        function (require, module, exports) {
        },
        {}
    ],
    2: [
        function (require, module, exports) {
            arguments[4][1][0].apply(exports, arguments);
        },
        { 'dup': 1 }
    ],
    3: [
        function (require, module, exports) {
            'use strict';
            var __values = this && this.__values || function (o) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator], i = 0;
                if (m)
                    return m.call(o);
                return {
                    next: function () {
                        if (o && i >= o.length)
                            o = void 0;
                        return {
                            value: o && o[i++],
                            done: !o
                        };
                    }
                };
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var type_1 = require('./type');
            exports.assign = template(function (key, target, source) {
                return target[key] = source[key];
            });
            exports.clone = template(function (key, target, source) {
                switch (type_1.type(source[key])) {
                case 'Array':
                    return target[key] = exports.clone([], source[key]);
                case 'Object':
                    return target[key] = exports.clone({}, source[key]);
                default:
                    return target[key] = source[key];
                }
            });
            exports.extend = template(function (key, target, source) {
                switch (type_1.type(source[key])) {
                case 'Array':
                    switch (type_1.type(target[key])) {
                    case 'Array':
                        return target[key] = exports.extend([], source[key]);
                    default:
                        return target[key] = source[key];
                    }
                case 'Object':
                    switch (type_1.type(target[key])) {
                    case 'Object':
                        return target[key] = exports.extend(target[key], source[key]);
                    default:
                        return target[key] = source[key];
                    }
                default:
                    return target[key] = source[key];
                }
            });
            function template(strategy) {
                return walk;
                function walk(target) {
                    var sources = [];
                    for (var _i = 1; _i < arguments.length; _i++) {
                        sources[_i - 1] = arguments[_i];
                    }
                    if (target === undefined || target === null) {
                        throw new TypeError('Spica: assign: Cannot walk on ' + target + '.');
                    }
                    try {
                        for (var sources_1 = __values(sources), sources_1_1 = sources_1.next(); !sources_1_1.done; sources_1_1 = sources_1.next()) {
                            var source = sources_1_1.value;
                            if (source === undefined || source === null) {
                                continue;
                            }
                            try {
                                for (var _a = __values(Object.keys(Object(source))), _b = _a.next(); !_b.done; _b = _a.next()) {
                                    var key = _b.value;
                                    var desc = Object.getOwnPropertyDescriptor(Object(source), key);
                                    if (desc !== undefined && desc.enumerable) {
                                        void strategy(key, Object(target), Object(source));
                                    }
                                }
                            } catch (e_1_1) {
                                e_1 = { error: e_1_1 };
                            } finally {
                                try {
                                    if (_b && !_b.done && (_c = _a.return))
                                        _c.call(_a);
                                } finally {
                                    if (e_1)
                                        throw e_1.error;
                                }
                            }
                        }
                    } catch (e_2_1) {
                        e_2 = { error: e_2_1 };
                    } finally {
                        try {
                            if (sources_1_1 && !sources_1_1.done && (_d = sources_1.return))
                                _d.call(sources_1);
                        } finally {
                            if (e_2)
                                throw e_2.error;
                        }
                    }
                    return Object(target);
                    var e_2, _d, e_1, _c;
                }
            }
        },
        { './type': 73 }
    ],
    4: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var exception_1 = require('./exception');
            var maybe_1 = require('./monad/maybe');
            var either_1 = require('./monad/either');
            var Cancellation = function () {
                function Cancellation(cancelees) {
                    if (cancelees === void 0) {
                        cancelees = [];
                    }
                    var _this = this;
                    this.done = false;
                    this.listeners = new Set();
                    this.register = function (listener) {
                        if (_this.canceled)
                            return void handler(_this.reason), function () {
                                return void 0;
                            };
                        if (_this.done)
                            return function () {
                                return void 0;
                            };
                        void _this.listeners.add(handler);
                        return function () {
                            return _this.done ? void 0 : void _this.listeners.delete(handler);
                        };
                        function handler(reason) {
                            try {
                                void listener(reason);
                            } catch (reason) {
                                void exception_1.causeAsyncException(reason);
                            }
                        }
                    };
                    this.cancel = function (reason) {
                        if (_this.done)
                            return;
                        _this.done = true;
                        _this.canceled = true;
                        _this.reason = reason;
                        void Object.freeze(_this.listeners);
                        void Object.freeze(_this);
                        void _this.listeners.forEach(function (cb) {
                            return void cb(reason);
                        });
                    };
                    this.close = function () {
                        if (_this.done)
                            return;
                        _this.done = true;
                        void Object.freeze(_this.listeners);
                        void Object.freeze(_this);
                    };
                    this.canceled = false;
                    this.promise = function (val) {
                        return _this.canceled ? new Promise(function (_, reject) {
                            return void reject(_this.reason);
                        }) : Promise.resolve(val);
                    };
                    this.maybe = function (val) {
                        return _this.canceled ? maybe_1.Nothing : maybe_1.Just(val);
                    };
                    this.either = function (val) {
                        return _this.canceled ? either_1.Left(_this.reason) : either_1.Right(val);
                    };
                    void __spread(cancelees).forEach(function (cancellee) {
                        return void cancellee.register(_this.cancel);
                    });
                }
                return Cancellation;
            }();
            exports.Cancellation = Cancellation;
        },
        {
            './exception': 10,
            './monad/either': 16,
            './monad/maybe': 20
        }
    ],
    5: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function compose(target) {
                var sources = [];
                for (var _i = 1; _i < arguments.length; _i++) {
                    sources[_i - 1] = arguments[_i];
                }
                return sources.reduce(function (b, d) {
                    void Object.getOwnPropertyNames(d.prototype).filter(function (p) {
                        return !(p in b.prototype);
                    }).forEach(function (p) {
                        return b.prototype[p] = d.prototype[p];
                    });
                    void Object.getOwnPropertyNames(d).filter(function (p) {
                        return !(p in b);
                    }).forEach(function (p) {
                        return b[p] = d[p];
                    });
                    return b;
                }, target);
            }
            exports.compose = compose;
        },
        {}
    ],
    6: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function concat(target, source) {
                for (var i = 0, len = source.length, offset = target.length; i < len; ++i) {
                    target[i + offset] = source[i];
                }
                return target;
            }
            exports.concat = concat;
        },
        {}
    ],
    7: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            exports.curry = function (f, ctx) {
                return f.length === 0 ? function () {
                    return f.call(ctx);
                } : curry_(f, [], ctx);
            };
            function curry_(f, xs, ctx) {
                return f.length <= xs.length ? f.apply(ctx, xs.slice(0, f.length)) : function () {
                    var ys = [];
                    for (var _i = 0; _i < arguments.length; _i++) {
                        ys[_i] = arguments[_i];
                    }
                    return curry_(f, xs.concat(ys), ctx);
                };
            }
        },
        {}
    ],
    8: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            __export(require('./monad/either'));
        },
        { './monad/either': 16 }
    ],
    9: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function findIndex(a1, as) {
                var isNaN = a1 !== a1;
                for (var i = 0; i < as.length; ++i) {
                    var a2 = as[i];
                    if (isNaN ? a2 !== a2 : a2 === a1)
                        return i;
                }
                return -1;
            }
            exports.findIndex = findIndex;
        },
        {}
    ],
    10: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function causeAsyncException(reason) {
                void new Promise(function (_, reject) {
                    return void reject(reason);
                });
            }
            exports.causeAsyncException = causeAsyncException;
            function stringify(target) {
                try {
                    return target instanceof Error && typeof target.stack === 'string' ? target.stack : target !== void 0 && target !== null && typeof target.toString === 'function' ? target + '' : Object.prototype.toString.call(target);
                } catch (reason) {
                    return stringify(reason);
                }
            }
        },
        {}
    ],
    11: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var curry_1 = require('./curry');
            function flip(f) {
                return curry_1.curry(function (b, a) {
                    return f.length > 1 ? f(a, b) : f(a)(b);
                });
            }
            exports.flip = flip;
        },
        { './curry': 7 }
    ],
    12: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var concat_1 = require('./concat');
            var HNil = function () {
                function HNil() {
                    void this.NIL;
                }
                HNil.prototype.push = function (a) {
                    return new HCons(a, this);
                };
                HNil.prototype.extend = function (f) {
                    return this.push(f());
                };
                HNil.prototype.array = function () {
                    return [];
                };
                return HNil;
            }();
            exports.HNil = HNil;
            var HCons = function () {
                function HCons(head, tail) {
                    this.head = head;
                    this.tail = tail;
                    void this.CONS;
                }
                HCons.prototype.push = function (b) {
                    return new HCons(b, this);
                };
                HCons.prototype.walk = function (f) {
                    void f(this.head);
                    return this.tail;
                };
                HCons.prototype.modify = function (f) {
                    return this.tail.push(f(this.head));
                };
                HCons.prototype.extend = function (f) {
                    return this.push(f(this.head));
                };
                HCons.prototype.compact = function (f) {
                    var _this = this;
                    return this.tail.modify(function (r) {
                        return f(_this.head, r);
                    });
                };
                HCons.prototype.reverse = function () {
                    return this.array().reduce(function (l, e) {
                        return l.push(e);
                    }, new HNil());
                };
                HCons.prototype.tuple = function () {
                    return this.array();
                };
                HCons.prototype.array = function () {
                    return concat_1.concat([this.head], this.tail.array());
                };
                return HCons;
            }();
        },
        { './concat': 6 }
    ],
    13: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            __export(require('./monad/maybe'));
        },
        { './monad/maybe': 20 }
    ],
    14: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var functor_1 = require('./functor');
            var curry_1 = require('../curry');
            var Applicative = function (_super) {
                __extends(Applicative, _super);
                function Applicative() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return Applicative;
            }(functor_1.Functor);
            exports.Applicative = Applicative;
            (function (Applicative) {
                function ap(af, aa) {
                    return aa ? af.bind(function (f) {
                        return aa.fmap(function (a) {
                            return f.length === 0 ? f(a) : curry_1.curry(f)(a);
                        });
                    }) : function (aa) {
                        return ap(af, aa);
                    };
                }
                Applicative.ap = ap;
            }(Applicative = exports.Applicative || (exports.Applicative = {})));
            exports.Applicative = Applicative;
        },
        {
            '../curry': 7,
            './functor': 17
        }
    ],
    15: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var monad_1 = require('./monad');
            var Either = function (_super) {
                __extends(Either, _super);
                function Either(thunk) {
                    var _this = _super.call(this, thunk) || this;
                    void _this.EITHER;
                    return _this;
                }
                Either.prototype.fmap = function (f) {
                    return this.bind(function (b) {
                        return new Right(f(b));
                    });
                };
                Either.prototype.ap = function (b) {
                    return Either.ap(this, b);
                };
                Either.prototype.bind = function (f) {
                    var _this = this;
                    return new Either(function () {
                        var m = _this.evaluate();
                        if (m instanceof Left) {
                            return m;
                        }
                        if (m instanceof Right) {
                            return f(m.extract());
                        }
                        if (m instanceof Either) {
                            return m.bind(f);
                        }
                        throw new TypeError('Spica: Either: Invalid monad value.\n\t' + m);
                    });
                };
                Either.prototype.extract = function (left, right) {
                    return !right ? this.evaluate().extract(left) : this.fmap(right).extract(left);
                };
                return Either;
            }(monad_1.Monad);
            exports.Either = Either;
            (function (Either) {
                function pure(b) {
                    return new Right(b);
                }
                Either.pure = pure;
                Either.Return = pure;
            }(Either = exports.Either || (exports.Either = {})));
            exports.Either = Either;
            var Left = function (_super) {
                __extends(Left, _super);
                function Left(a) {
                    var _this = _super.call(this, throwCallError) || this;
                    _this.a = a;
                    void _this.LEFT;
                    return _this;
                }
                Left.prototype.bind = function (_) {
                    return this;
                };
                Left.prototype.extract = function (left) {
                    if (!left)
                        throw this.a;
                    return left(this.a);
                };
                return Left;
            }(Either);
            exports.Left = Left;
            var Right = function (_super) {
                __extends(Right, _super);
                function Right(b) {
                    var _this = _super.call(this, throwCallError) || this;
                    _this.b = b;
                    void _this.RIGHT;
                    return _this;
                }
                Right.prototype.bind = function (f) {
                    var _this = this;
                    return new Either(function () {
                        return f(_this.extract());
                    });
                };
                Right.prototype.extract = function (_, right) {
                    return !right ? this.b : right(this.b);
                };
                return Right;
            }(Either);
            exports.Right = Right;
            function throwCallError() {
                throw new Error('Spica: Either: Invalid thunk call.');
            }
        },
        { './monad': 21 }
    ],
    16: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var Monad = require('./either.impl');
            var Either;
            (function (Either) {
                Either.fmap = Monad.Either.fmap;
                Either.pure = Monad.Either.pure;
                Either.ap = Monad.Either.ap;
                Either.Return = Monad.Either.Return;
                Either.bind = Monad.Either.bind;
            }(Either = exports.Either || (exports.Either = {})));
            function Left(a) {
                return new Monad.Left(a);
            }
            exports.Left = Left;
            function Right(b) {
                return new Monad.Right(b);
            }
            exports.Right = Right;
        },
        { './either.impl': 15 }
    ],
    17: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var lazy_1 = require('./lazy');
            var Functor = function (_super) {
                __extends(Functor, _super);
                function Functor() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return Functor;
            }(lazy_1.Lazy);
            exports.Functor = Functor;
            (function (Functor) {
                function fmap(m, f) {
                    return f ? m.fmap(f) : function (f) {
                        return m.fmap(f);
                    };
                }
                Functor.fmap = fmap;
            }(Functor = exports.Functor || (exports.Functor = {})));
            exports.Functor = Functor;
        },
        { './lazy': 18 }
    ],
    18: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var Lazy = function () {
                function Lazy(thunk) {
                    this.thunk = thunk;
                }
                Lazy.prototype.evaluate = function () {
                    return this.memory_ = this.memory_ || this.thunk();
                };
                return Lazy;
            }();
            exports.Lazy = Lazy;
        },
        {}
    ],
    19: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var monadplus_1 = require('./monadplus');
            var Maybe = function (_super) {
                __extends(Maybe, _super);
                function Maybe(thunk) {
                    var _this = _super.call(this, thunk) || this;
                    void _this.MAYBE;
                    return _this;
                }
                Maybe.prototype.fmap = function (f) {
                    return this.bind(function (a) {
                        return new Just(f(a));
                    });
                };
                Maybe.prototype.ap = function (a) {
                    return Maybe.ap(this, a);
                };
                Maybe.prototype.bind = function (f) {
                    var _this = this;
                    return new Maybe(function () {
                        var m = _this.evaluate();
                        if (m instanceof Just) {
                            return f(m.extract());
                        }
                        if (m instanceof Nothing) {
                            return m;
                        }
                        if (m instanceof Maybe) {
                            return m.bind(f);
                        }
                        throw new TypeError('Spica: Maybe: Invalid monad value.\n\t' + m);
                    });
                };
                Maybe.prototype.extract = function (nothing, just) {
                    return !just ? this.evaluate().extract(nothing) : this.fmap(just).extract(nothing);
                };
                return Maybe;
            }(monadplus_1.MonadPlus);
            exports.Maybe = Maybe;
            (function (Maybe) {
                function pure(a) {
                    return new Just(a);
                }
                Maybe.pure = pure;
                Maybe.Return = pure;
            }(Maybe = exports.Maybe || (exports.Maybe = {})));
            exports.Maybe = Maybe;
            var Just = function (_super) {
                __extends(Just, _super);
                function Just(a) {
                    var _this = _super.call(this, throwCallError) || this;
                    _this.a = a;
                    void _this.JUST;
                    return _this;
                }
                Just.prototype.bind = function (f) {
                    var _this = this;
                    return new Maybe(function () {
                        return f(_this.extract());
                    });
                };
                Just.prototype.extract = function (_, just) {
                    return !just ? this.a : just(this.a);
                };
                return Just;
            }(Maybe);
            exports.Just = Just;
            var Nothing = function (_super) {
                __extends(Nothing, _super);
                function Nothing() {
                    var _this = _super.call(this, throwCallError) || this;
                    void _this.NOTHING;
                    return _this;
                }
                Nothing.prototype.bind = function (_) {
                    return this;
                };
                Nothing.prototype.extract = function (nothing) {
                    if (!nothing)
                        throw void 0;
                    return nothing();
                };
                return Nothing;
            }(Maybe);
            exports.Nothing = Nothing;
            (function (Maybe) {
                Maybe.mzero = new Nothing();
                function mplus(ml, mr) {
                    return new Maybe(function () {
                        return ml.fmap(function () {
                            return ml;
                        }).extract(function () {
                            return mr;
                        });
                    });
                }
                Maybe.mplus = mplus;
            }(Maybe = exports.Maybe || (exports.Maybe = {})));
            exports.Maybe = Maybe;
            function throwCallError() {
                throw new Error('Spica: Maybe: Invalid thunk call.');
            }
        },
        { './monadplus': 22 }
    ],
    20: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var Monad = require('./maybe.impl');
            var Maybe;
            (function (Maybe) {
                Maybe.fmap = Monad.Maybe.fmap;
                Maybe.pure = Monad.Maybe.pure;
                Maybe.ap = Monad.Maybe.ap;
                Maybe.Return = Monad.Maybe.Return;
                Maybe.bind = Monad.Maybe.bind;
                Maybe.mzero = Monad.Maybe.mzero;
                Maybe.mplus = Monad.Maybe.mplus;
            }(Maybe = exports.Maybe || (exports.Maybe = {})));
            function Just(a) {
                return new Monad.Just(a);
            }
            exports.Just = Just;
            exports.Nothing = Monad.Maybe.mzero;
        },
        { './maybe.impl': 19 }
    ],
    21: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var applicative_1 = require('./applicative');
            var Monad = function (_super) {
                __extends(Monad, _super);
                function Monad() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return Monad;
            }(applicative_1.Applicative);
            exports.Monad = Monad;
            (function (Monad) {
                function bind(m, f) {
                    return f ? m.bind(f) : function (f) {
                        return bind(m, f);
                    };
                }
                Monad.bind = bind;
            }(Monad = exports.Monad || (exports.Monad = {})));
            exports.Monad = Monad;
        },
        { './applicative': 14 }
    ],
    22: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var monad_1 = require('./monad');
            var MonadPlus = function (_super) {
                __extends(MonadPlus, _super);
                function MonadPlus() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return MonadPlus;
            }(monad_1.Monad);
            exports.MonadPlus = MonadPlus;
            (function (MonadPlus) {
            }(MonadPlus = exports.MonadPlus || (exports.MonadPlus = {})));
            exports.MonadPlus = MonadPlus;
        },
        { './monad': 21 }
    ],
    23: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('./sequence/core');
            exports.Sequence = core_1.Sequence;
            var resume_1 = require('./sequence/member/static/resume');
            var from_1 = require('./sequence/member/static/from');
            var cycle_1 = require('./sequence/member/static/cycle');
            var random_1 = require('./sequence/member/static/random');
            var concat_1 = require('./sequence/member/static/concat');
            var zip_1 = require('./sequence/member/static/zip');
            var difference_1 = require('./sequence/member/static/difference');
            var union_1 = require('./sequence/member/static/union');
            var intersect_1 = require('./sequence/member/static/intersect');
            var pure_1 = require('./sequence/member/static/pure');
            var return_1 = require('./sequence/member/static/return');
            var mempty_1 = require('./sequence/member/static/mempty');
            var mconcat_1 = require('./sequence/member/static/mconcat');
            var mappend_1 = require('./sequence/member/static/mappend');
            var mzero_1 = require('./sequence/member/static/mzero');
            var mplus_1 = require('./sequence/member/static/mplus');
            var extract_1 = require('./sequence/member/instance/extract');
            var iterate_1 = require('./sequence/member/instance/iterate');
            var memoize_1 = require('./sequence/member/instance/memoize');
            var reduce_1 = require('./sequence/member/instance/reduce');
            var take_1 = require('./sequence/member/instance/take');
            var drop_1 = require('./sequence/member/instance/drop');
            var takeWhile_1 = require('./sequence/member/instance/takeWhile');
            var dropWhile_1 = require('./sequence/member/instance/dropWhile');
            var takeUntil_1 = require('./sequence/member/instance/takeUntil');
            var dropUntil_1 = require('./sequence/member/instance/dropUntil');
            var sort_1 = require('./sequence/member/instance/sort');
            var fmap_1 = require('./sequence/member/instance/fmap');
            var ap_1 = require('./sequence/member/instance/ap');
            var bind_1 = require('./sequence/member/instance/bind');
            var mapM_1 = require('./sequence/member/instance/mapM');
            var filterM_1 = require('./sequence/member/instance/filterM');
            var map_1 = require('./sequence/member/instance/map');
            var filter_1 = require('./sequence/member/instance/filter');
            var scan_1 = require('./sequence/member/instance/scan');
            var foldr_1 = require('./sequence/member/instance/foldr');
            var group_1 = require('./sequence/member/instance/group');
            var inits_1 = require('./sequence/member/instance/inits');
            var tails_1 = require('./sequence/member/instance/tails');
            var segs_1 = require('./sequence/member/instance/segs');
            var subsequences_1 = require('./sequence/member/instance/subsequences');
            var permutations_1 = require('./sequence/member/instance/permutations');
            var compose_1 = require('../compose');
            void compose_1.compose(core_1.Sequence, resume_1.default, from_1.default, cycle_1.default, random_1.default, concat_1.default, zip_1.default, difference_1.default, union_1.default, intersect_1.default, pure_1.default, return_1.default, mempty_1.default, mconcat_1.default, mappend_1.default, mzero_1.default, mplus_1.default, extract_1.default, iterate_1.default, memoize_1.default, reduce_1.default, take_1.default, drop_1.default, takeWhile_1.default, dropWhile_1.default, takeUntil_1.default, dropUntil_1.default, sort_1.default, fmap_1.default, ap_1.default, bind_1.default, mapM_1.default, filterM_1.default, map_1.default, filter_1.default, scan_1.default, foldr_1.default, group_1.default, inits_1.default, tails_1.default, segs_1.default, subsequences_1.default, permutations_1.default);
        },
        {
            '../compose': 5,
            './sequence/core': 24,
            './sequence/member/instance/ap': 25,
            './sequence/member/instance/bind': 26,
            './sequence/member/instance/drop': 27,
            './sequence/member/instance/dropUntil': 28,
            './sequence/member/instance/dropWhile': 29,
            './sequence/member/instance/extract': 30,
            './sequence/member/instance/filter': 31,
            './sequence/member/instance/filterM': 32,
            './sequence/member/instance/fmap': 33,
            './sequence/member/instance/foldr': 34,
            './sequence/member/instance/group': 35,
            './sequence/member/instance/inits': 36,
            './sequence/member/instance/iterate': 37,
            './sequence/member/instance/map': 38,
            './sequence/member/instance/mapM': 39,
            './sequence/member/instance/memoize': 40,
            './sequence/member/instance/permutations': 41,
            './sequence/member/instance/reduce': 42,
            './sequence/member/instance/scan': 43,
            './sequence/member/instance/segs': 44,
            './sequence/member/instance/sort': 45,
            './sequence/member/instance/subsequences': 46,
            './sequence/member/instance/tails': 47,
            './sequence/member/instance/take': 48,
            './sequence/member/instance/takeUntil': 49,
            './sequence/member/instance/takeWhile': 50,
            './sequence/member/static/concat': 51,
            './sequence/member/static/cycle': 52,
            './sequence/member/static/difference': 53,
            './sequence/member/static/from': 54,
            './sequence/member/static/intersect': 55,
            './sequence/member/static/mappend': 56,
            './sequence/member/static/mconcat': 57,
            './sequence/member/static/mempty': 58,
            './sequence/member/static/mplus': 59,
            './sequence/member/static/mzero': 60,
            './sequence/member/static/pure': 61,
            './sequence/member/static/random': 62,
            './sequence/member/static/resume': 63,
            './sequence/member/static/return': 64,
            './sequence/member/static/union': 65,
            './sequence/member/static/zip': 66
        }
    ],
    24: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var monadplus_1 = require('../monadplus');
            var Sequence = function (_super) {
                __extends(Sequence, _super);
                function Sequence(cons) {
                    var _this = _super.call(this, throwCallError) || this;
                    _this.cons = cons;
                    return _this;
                }
                Sequence.prototype[Symbol.iterator] = function () {
                    var _this = this;
                    var iter = function () {
                        return _this.iterate();
                    };
                    return {
                        next: function () {
                            var thunk = iter();
                            iter = Sequence.Thunk.iterator(thunk);
                            return {
                                done: !Sequence.isIterable(thunk),
                                value: Sequence.Thunk.value(thunk)
                            };
                        }
                    };
                };
                return Sequence;
            }(monadplus_1.MonadPlus);
            exports.Sequence = Sequence;
            (function (Sequence) {
            }(Sequence = exports.Sequence || (exports.Sequence = {})));
            exports.Sequence = Sequence;
            (function (Sequence) {
                var Data;
                (function (Data) {
                    function cons(a, z) {
                        switch (arguments.length) {
                        case 0:
                            return [];
                        case 1:
                            return [a];
                        case 2:
                            return [
                                a,
                                z
                            ];
                        default:
                            throw Sequence.Exception.invalidConsError(arguments);
                        }
                    }
                    Data.cons = cons;
                }(Data = Sequence.Data || (Sequence.Data = {})));
                var Thunk;
                (function (Thunk) {
                    function value(thunk) {
                        return thunk[0];
                    }
                    Thunk.value = value;
                    function iterator(thunk) {
                        return thunk[1];
                    }
                    Thunk.iterator = iterator;
                    function index(thunk) {
                        return thunk[2];
                    }
                    Thunk.index = index;
                }(Thunk = Sequence.Thunk || (Sequence.Thunk = {})));
                var Iterator;
                (function (Iterator) {
                    Iterator.done = function () {
                        return [
                            void 0,
                            Iterator.done,
                            -1
                        ];
                    };
                    function when(thunk, caseDone, caseIterable) {
                        return Sequence.isIterable(thunk) ? caseIterable(thunk, function () {
                            return when(Thunk.iterator(thunk)(), caseDone, caseIterable);
                        }) : caseDone(thunk);
                    }
                    Iterator.when = when;
                }(Iterator = Sequence.Iterator || (Sequence.Iterator = {})));
                function isIterable(thunk) {
                    return Thunk.iterator(thunk) !== Iterator.done;
                }
                Sequence.isIterable = isIterable;
                var Exception;
                (function (Exception) {
                    function invalidConsError(args) {
                        console.error(args, args.length, args[0], args[1]);
                        return new TypeError('Spica: Sequence: Invalid parameters of cons.');
                    }
                    Exception.invalidConsError = invalidConsError;
                    function invalidDataError(data) {
                        console.error(data);
                        return new TypeError('Spica: Sequence: Invalid data.');
                    }
                    Exception.invalidDataError = invalidDataError;
                    function invalidThunkError(thunk) {
                        console.error(thunk);
                        return new TypeError('Spica: Sequence: Invalid thunk.');
                    }
                    Exception.invalidThunkError = invalidThunkError;
                }(Exception = Sequence.Exception || (Sequence.Exception = {})));
            }(Sequence = exports.Sequence || (exports.Sequence = {})));
            exports.Sequence = Sequence;
            function throwCallError() {
                throw new Error('Spica: Sequence: Invalid thunk call.');
            }
        },
        { '../monadplus': 22 }
    ],
    25: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.ap = function (a) {
                    return core_1.Sequence.ap(this, a);
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    26: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.bind = function (f) {
                    return core_1.Sequence.concat(this.fmap(f));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    27: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.drop = function (n) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk, recur) {
                            return core_1.Sequence.Thunk.index(thunk) < n ? recur() : cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    28: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.dropUntil = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk, recur) {
                            return f(core_1.Sequence.Thunk.value(thunk)) ? recur() : cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    29: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.dropWhile = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk, recur) {
                            return f(core_1.Sequence.Thunk.value(thunk)) ? recur() : cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    30: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.extract = function () {
                    var _this = this;
                    var acc = [];
                    var iter = function () {
                        return _this.iterate();
                    };
                    while (true) {
                        var thunk = iter();
                        if (!core_1.Sequence.isIterable(thunk))
                            return acc;
                        void concat_1.concat(acc, [core_1.Sequence.Thunk.value(thunk)]);
                        iter = core_1.Sequence.Thunk.iterator(thunk);
                    }
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    31: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.filter = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk, recur) {
                            return f(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.index(thunk)) ? cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk)) : recur();
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    32: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.filterM = function (f) {
                    var _this = this;
                    return core_1.Sequence.from([0]).bind(function () {
                        var xs = _this.extract();
                        switch (xs.length) {
                        case 0:
                            return core_1.Sequence.from([[]]);
                        default: {
                                var x_1 = xs.shift();
                                return f(x_1).bind(function (b) {
                                    return b ? xs.length === 0 ? core_1.Sequence.from([[x_1]]) : core_1.Sequence.from(xs).filterM(f).fmap(function (ys) {
                                        return concat_1.concat([x_1], ys);
                                    }) : xs.length === 0 ? core_1.Sequence.from([[]]) : core_1.Sequence.from(xs).filterM(f);
                                });
                            }
                        }
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    33: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.fmap = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return core_1.Sequence.Data.cons();
                        }, function (thunk) {
                            return core_1.Sequence.Data.cons(f(core_1.Sequence.Thunk.value(thunk)), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    34: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.foldr = function (f, z) {
                    var _this = this;
                    return new core_1.Sequence(function (iter) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.reduce().iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return core_1.Sequence.Data.cons(z);
                        }, function (thunk) {
                            return core_1.Sequence.Data.cons(f(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.resume(core_1.Sequence.Thunk.iterator(thunk)).foldr(f, z)));
                        });
                    }).bind(function (s) {
                        return s;
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    35: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.group = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return _this.iterate();
                                },
                                []
                            ] : _a, 2), iter = _b[0], acc = _b[1];
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return acc.length === 0 ? cons() : cons(acc);
                        }, function (thunk, recur) {
                            return acc.length === 0 || f(acc[0], core_1.Sequence.Thunk.value(thunk)) ? (concat_1.concat(acc, [core_1.Sequence.Thunk.value(thunk)]), recur()) : cons(acc, [
                                core_1.Sequence.Thunk.iterator(thunk),
                                concat_1.concat([], [core_1.Sequence.Thunk.value(thunk)])
                            ]);
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    36: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.inits = function () {
                    return core_1.Sequence.mappend(core_1.Sequence.from([[]]), this.scan(function (b, a) {
                        return b.concat([a]);
                    }, []).dropWhile(function (as) {
                        return as.length === 0;
                    }));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    37: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.iterate = function () {
                    return this.iterate_();
                };
                default_1.prototype.iterate_ = function (z, i) {
                    var _this = this;
                    if (i === void 0) {
                        i = 0;
                    }
                    var data = this.cons(z, core_1.Sequence.Data.cons);
                    switch (data.length) {
                    case 0:
                        return [
                            void 0,
                            core_1.Sequence.Iterator.done,
                            -1
                        ];
                    case 1:
                        return [
                            data[0],
                            function () {
                                return core_1.Sequence.Iterator.done();
                            },
                            i
                        ];
                    case 2:
                        return [
                            data[0],
                            function () {
                                return _this.iterate_(data[1], i + 1);
                            },
                            i
                        ];
                    default:
                        throw core_1.Sequence.Exception.invalidDataError(data);
                    }
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    38: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.map = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return core_1.Sequence.Data.cons();
                        }, function (thunk) {
                            return core_1.Sequence.Data.cons(f(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.index(thunk)), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    39: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.mapM = function (f) {
                    var _this = this;
                    return core_1.Sequence.from([0]).bind(function () {
                        var xs = _this.extract();
                        switch (xs.length) {
                        case 0:
                            return core_1.Sequence.mempty;
                        default: {
                                var x = xs.shift();
                                return f(x).bind(function (y) {
                                    return xs.length === 0 ? core_1.Sequence.from([[y]]) : core_1.Sequence.from(xs).mapM(f).fmap(function (ys) {
                                        return concat_1.concat([y], ys);
                                    });
                                });
                            }
                        }
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    40: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var memories = new WeakMap();
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.memoize = function () {
                    var _this = this;
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                0,
                                memories.get(_this) || memories.set(_this, new Map()).get(_this)
                            ] : _a, 2), i = _b[0], memo = _b[1];
                        return core_1.Sequence.Iterator.when(memo.get(i) || memo.set(i, i > 0 && memo.has(i - 1) ? core_1.Sequence.Thunk.iterator(memo.get(i - 1))() : _this.iterate()).get(i), function () {
                            return cons();
                        }, function (thunk) {
                            return cons(core_1.Sequence.Thunk.value(thunk), [
                                i + 1,
                                memo
                            ]);
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    41: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.permutations = function () {
                    var _this = this;
                    return core_1.Sequence.from([0]).bind(function () {
                        var xs = _this.extract();
                        return xs.length === 0 ? core_1.Sequence.mempty : core_1.Sequence.from([xs]);
                    }).bind(function (xs) {
                        return core_1.Sequence.mappend(core_1.Sequence.from([xs]), perms(core_1.Sequence.from(xs), core_1.Sequence.mempty));
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
            function perms(ts, is) {
                return core_1.Sequence.Iterator.when(ts.iterate(), function () {
                    return core_1.Sequence.mempty;
                }, function (tt) {
                    return new core_1.Sequence(function (_, cons) {
                        return core_1.Sequence.Iterator.when(tt, function () {
                            return cons();
                        }, function (tt) {
                            var t = core_1.Sequence.Thunk.value(tt);
                            var ts = core_1.Sequence.resume(core_1.Sequence.Thunk.iterator(tt)).memoize();
                            return cons(is.permutations().foldr(function (ys, r) {
                                return interleave(core_1.Sequence.from(ys), r);
                            }, perms(ts, core_1.Sequence.mappend(core_1.Sequence.from([t]), is))));
                            function interleave(xs, r) {
                                return interleave_(function (as) {
                                    return as;
                                }, xs, r)[1];
                            }
                            function interleave_(f, ys, r) {
                                return core_1.Sequence.Iterator.when(ys.iterate(), function () {
                                    return [
                                        ts,
                                        r
                                    ];
                                }, function (yt) {
                                    var y = core_1.Sequence.Thunk.value(yt);
                                    var _a = __read(interleave_(function (as) {
                                            return f(core_1.Sequence.mappend(core_1.Sequence.from([y]), as));
                                        }, core_1.Sequence.resume(core_1.Sequence.Thunk.iterator(yt)), r), 2), us = _a[0], zs = _a[1];
                                    return [
                                        core_1.Sequence.mappend(core_1.Sequence.from([y]), us),
                                        core_1.Sequence.mappend(core_1.Sequence.from([f(core_1.Sequence.mappend(core_1.Sequence.from([t]), core_1.Sequence.mappend(core_1.Sequence.from([y]), us))).extract()]), zs)
                                    ];
                                });
                            }
                        });
                    }).bind(function (xs) {
                        return xs;
                    });
                });
            }
        },
        { '../../core': 24 }
    ],
    42: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.reduce = function () {
                    var _this = this;
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                0,
                                new Map()
                            ] : _a, 2), i = _b[0], memo = _b[1];
                        return core_1.Sequence.Iterator.when(memo.get(i) || memo.set(i, i > 0 && memo.has(i - 1) ? core_1.Sequence.Thunk.iterator(memo.get(i - 1))() : _this.iterate()).get(i), function () {
                            return cons();
                        }, function (thunk) {
                            return cons(core_1.Sequence.Thunk.value(thunk), [
                                i + 1,
                                memo
                            ]);
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    43: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.scan = function (f, z) {
                    var _this = this;
                    return new core_1.Sequence(function (_a) {
                        var _b = __read(_a === void 0 ? [
                                z,
                                function () {
                                    return _this.iterate();
                                },
                                0
                            ] : _a, 3), prev = _b[0], iter = _b[1], i = _b[2];
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return i === 0 ? core_1.Sequence.Data.cons(z) : core_1.Sequence.Data.cons();
                        }, function (thunk) {
                            return core_1.Sequence.Data.cons(prev = f(prev, core_1.Sequence.Thunk.value(thunk)), [
                                prev,
                                core_1.Sequence.Thunk.iterator(thunk),
                                core_1.Sequence.Thunk.index(thunk) + 1
                            ]);
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    44: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.segs = function () {
                    return core_1.Sequence.mappend(this.foldr(function (a, bs) {
                        return bs.take(1).bind(function (b) {
                            return core_1.Sequence.mappend(core_1.Sequence.from([core_1.Sequence.mappend(core_1.Sequence.from([[a]]), core_1.Sequence.from(b).map(function (c) {
                                    return concat_1.concat([a], c);
                                }))]), bs);
                        });
                    }, core_1.Sequence.from([core_1.Sequence.from([])])).bind(function (a) {
                        return a;
                    }), core_1.Sequence.from([[]]));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    45: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.sort = function (cmp) {
                    return core_1.Sequence.from(this.extract().sort(cmp));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    46: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var concat_1 = require('../../../../concat');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.subsequences = function () {
                    var _this = this;
                    return core_1.Sequence.mappend(core_1.Sequence.from([[]]), core_1.Sequence.from([0]).bind(function () {
                        return nonEmptySubsequences(_this);
                    }));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
            function nonEmptySubsequences(xs) {
                return core_1.Sequence.Iterator.when(xs.iterate(), function () {
                    return core_1.Sequence.mempty;
                }, function (xt) {
                    return core_1.Sequence.mappend(core_1.Sequence.from([[core_1.Sequence.Thunk.value(xt)]]), new core_1.Sequence(function (_, cons) {
                        return core_1.Sequence.Iterator.when(xt, function () {
                            return cons();
                        }, function (xt) {
                            return cons(nonEmptySubsequences(core_1.Sequence.resume(core_1.Sequence.Thunk.iterator(xt))).foldr(function (ys, r) {
                                return core_1.Sequence.mappend(core_1.Sequence.mappend(core_1.Sequence.from([ys]), core_1.Sequence.from([concat_1.concat([core_1.Sequence.Thunk.value(xt)], ys)])), r);
                            }, core_1.Sequence.mempty));
                        });
                    }).bind(function (xs) {
                        return xs;
                    }));
                });
            }
        },
        {
            '../../../../concat': 6,
            '../../core': 24
        }
    ],
    47: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.tails = function () {
                    return core_1.Sequence.mappend(core_1.Sequence.from(this.extract().map(function (_, i, as) {
                        return as.slice(i);
                    })), core_1.Sequence.from([[]]));
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    48: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.take = function (n) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(n > 0 ? iter() : core_1.Sequence.Iterator.done(), function () {
                            return cons();
                        }, function (thunk) {
                            return core_1.Sequence.Thunk.index(thunk) + 1 < n ? cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk)) : cons(core_1.Sequence.Thunk.value(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    49: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.takeUntil = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk) {
                            return f(core_1.Sequence.Thunk.value(thunk)) ? cons(core_1.Sequence.Thunk.value(thunk)) : cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    50: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.prototype.takeWhile = function (f) {
                    var _this = this;
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = function () {
                                return _this.iterate();
                            };
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk) {
                            return f(core_1.Sequence.Thunk.value(thunk)) ? cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk)) : cons();
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    51: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.concat = function (as) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return as.iterate();
                                },
                                core_1.Sequence.Iterator.done
                            ] : _a, 2), ai = _b[0], bi = _b[1];
                        return core_1.Sequence.Iterator.when(ai(), function () {
                            return cons();
                        }, function (at, ar) {
                            return bi = bi === core_1.Sequence.Iterator.done ? function () {
                                return core_1.Sequence.Thunk.value(at).iterate();
                            } : bi, core_1.Sequence.Iterator.when(bi(), function () {
                                return bi = core_1.Sequence.Iterator.done, ar();
                            }, function (bt) {
                                return cons(core_1.Sequence.Thunk.value(bt), [
                                    function () {
                                        return at;
                                    },
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    52: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.cycle = function (as) {
                    return new core_1.Sequence(function cycle(_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                as[Symbol.iterator](),
                                0
                            ] : _a, 2), iter = _b[0], i = _b[1];
                        var result = iter.next();
                        return result.done ? cycle([
                            as[Symbol.iterator](),
                            i + 1
                        ], cons) : cons(result.value, [
                            iter,
                            i + 1
                        ]);
                    }).reduce();
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    53: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.difference = function (a, b, cmp) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return a.iterate();
                                },
                                function () {
                                    return b.iterate();
                                }
                            ] : _a, 2), ai = _b[0], bi = _b[1];
                        return core_1.Sequence.Iterator.when(ai(), function () {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons();
                            }, function (bt) {
                                return cons(core_1.Sequence.Thunk.value(bt), [
                                    core_1.Sequence.Iterator.done,
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        }, function (at, ar) {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons(core_1.Sequence.Thunk.value(at), [
                                    core_1.Sequence.Thunk.iterator(at),
                                    core_1.Sequence.Iterator.done
                                ]);
                            }, function (bt) {
                                var ord = cmp(core_1.Sequence.Thunk.value(at), core_1.Sequence.Thunk.value(bt));
                                if (ord < 0)
                                    return cons(core_1.Sequence.Thunk.value(at), [
                                        core_1.Sequence.Thunk.iterator(at),
                                        function () {
                                            return bt;
                                        }
                                    ]);
                                if (ord > 0)
                                    return cons(core_1.Sequence.Thunk.value(bt), [
                                        function () {
                                            return at;
                                        },
                                        core_1.Sequence.Thunk.iterator(bt)
                                    ]);
                                return bi = function () {
                                    return core_1.Sequence.Thunk.iterator(bt)();
                                }, ar();
                            });
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    54: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.from = function (as) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                as[Symbol.iterator](),
                                0
                            ] : _a, 2), iter = _b[0], i = _b[1];
                        var result = iter.next();
                        return result.done ? cons() : cons(result.value, [
                            iter,
                            i + 1
                        ]);
                    }).reduce();
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    55: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.intersect = function (a, b, cmp) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return a.iterate();
                                },
                                function () {
                                    return b.iterate();
                                }
                            ] : _a, 2), ai = _b[0], bi = _b[1];
                        return core_1.Sequence.Iterator.when(ai(), function () {
                            return cons();
                        }, function (at, ar) {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons();
                            }, function (bt, br) {
                                var ord = cmp(core_1.Sequence.Thunk.value(at), core_1.Sequence.Thunk.value(bt));
                                if (ord < 0)
                                    return bi = function () {
                                        return bt;
                                    }, ar();
                                if (ord > 0)
                                    return br();
                                return cons(core_1.Sequence.Thunk.value(at), [
                                    core_1.Sequence.Thunk.iterator(at),
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    56: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.mappend = function (l, r) {
                    return core_1.Sequence.mconcat([
                        l,
                        r
                    ]);
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    57: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.mconcat = function (as) {
                    return __spread(as).reduce(function (a, b) {
                        return mconcat(a, b);
                    }, core_1.Sequence.mempty);
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
            function mconcat(a, b) {
                return new core_1.Sequence(function (_a, cons) {
                    var _b = __read(_a === void 0 ? [
                            function () {
                                return a.iterate();
                            },
                            function () {
                                return b.iterate();
                            }
                        ] : _a, 2), ai = _b[0], bi = _b[1];
                    return core_1.Sequence.Iterator.when(ai(), function () {
                        return core_1.Sequence.Iterator.when(bi(), function () {
                            return cons();
                        }, function (bt) {
                            return cons(core_1.Sequence.Thunk.value(bt), [
                                core_1.Sequence.Iterator.done,
                                core_1.Sequence.Thunk.iterator(bt)
                            ]);
                        });
                    }, function (at) {
                        return cons(core_1.Sequence.Thunk.value(at), [
                            core_1.Sequence.Thunk.iterator(at),
                            bi
                        ]);
                    });
                });
            }
        },
        { '../../core': 24 }
    ],
    58: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.mempty = new core_1.Sequence(function (_, cons) {
                    return cons();
                });
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    59: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.mplus = core_1.Sequence.mappend;
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    60: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.mzero = core_1.Sequence.mempty;
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    61: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.pure = function (a) {
                    return new core_1.Sequence(function (_, cons) {
                        return cons(a);
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    62: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.random = function (p) {
                    if (p === void 0) {
                        p = function () {
                            return Math.random();
                        };
                    }
                    return typeof p === 'function' ? core_1.Sequence.from(new core_1.Sequence(function (_, cons) {
                        return cons(p(), _);
                    })) : this.random().map(function (r) {
                        return p[r * p.length | 0];
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    63: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.resume = function (iterator) {
                    return new core_1.Sequence(function (iter, cons) {
                        if (iter === void 0) {
                            iter = iterator;
                        }
                        return core_1.Sequence.Iterator.when(iter(), function () {
                            return cons();
                        }, function (thunk) {
                            return cons(core_1.Sequence.Thunk.value(thunk), core_1.Sequence.Thunk.iterator(thunk));
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    64: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.Return = function (a) {
                    return new core_1.Sequence(function (_, cons) {
                        return cons(a);
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    65: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.union = function (a, b, cmp) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return a.iterate();
                                },
                                function () {
                                    return b.iterate();
                                }
                            ] : _a, 2), ai = _b[0], bi = _b[1];
                        return core_1.Sequence.Iterator.when(ai(), function () {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons();
                            }, function (bt) {
                                return cons(core_1.Sequence.Thunk.value(bt), [
                                    core_1.Sequence.Iterator.done,
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        }, function (at) {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons(core_1.Sequence.Thunk.value(at), [
                                    core_1.Sequence.Thunk.iterator(at),
                                    core_1.Sequence.Iterator.done
                                ]);
                            }, function (bt) {
                                var ord = cmp(core_1.Sequence.Thunk.value(at), core_1.Sequence.Thunk.value(bt));
                                if (ord < 0)
                                    return cons(core_1.Sequence.Thunk.value(at), [
                                        core_1.Sequence.Thunk.iterator(at),
                                        function () {
                                            return bt;
                                        }
                                    ]);
                                if (ord > 0)
                                    return cons(core_1.Sequence.Thunk.value(bt), [
                                        function () {
                                            return at;
                                        },
                                        core_1.Sequence.Thunk.iterator(bt)
                                    ]);
                                return cons(core_1.Sequence.Thunk.value(at), [
                                    core_1.Sequence.Thunk.iterator(at),
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    66: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var core_1 = require('../../core');
            var default_1 = function (_super) {
                __extends(default_1, _super);
                function default_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                default_1.zip = function (a, b) {
                    return new core_1.Sequence(function (_a, cons) {
                        var _b = __read(_a === void 0 ? [
                                function () {
                                    return a.iterate();
                                },
                                function () {
                                    return b.iterate();
                                }
                            ] : _a, 2), ai = _b[0], bi = _b[1];
                        return core_1.Sequence.Iterator.when(ai(), function () {
                            return cons();
                        }, function (at) {
                            return core_1.Sequence.Iterator.when(bi(), function () {
                                return cons();
                            }, function (bt) {
                                return cons([
                                    core_1.Sequence.Thunk.value(at),
                                    core_1.Sequence.Thunk.value(bt)
                                ], [
                                    core_1.Sequence.Thunk.iterator(at),
                                    core_1.Sequence.Thunk.iterator(bt)
                                ]);
                            });
                        });
                    });
                };
                return default_1;
            }(core_1.Sequence);
            exports.default = default_1;
        },
        { '../../core': 24 }
    ],
    67: [
        function (require, module, exports) {
            'use strict';
            var __values = this && this.__values || function (o) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator], i = 0;
                if (m)
                    return m.call(o);
                return {
                    next: function () {
                        if (o && i >= o.length)
                            o = void 0;
                        return {
                            value: o && o[i++],
                            done: !o
                        };
                    }
                };
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var concat_1 = require('./concat');
            var equal_1 = require('./equal');
            var exception_1 = require('./exception');
            var RegisterItemType;
            (function (RegisterItemType) {
                RegisterItemType.monitor = 'monitor';
                RegisterItemType.subscriber = 'subscriber';
            }(RegisterItemType = exports.RegisterItemType || (exports.RegisterItemType = {})));
            var Observation = function () {
                function Observation() {
                    this.relaySources = new WeakSet();
                    this.node_ = {
                        parent: void 0,
                        children: new Map(),
                        childrenNames: [],
                        items: []
                    };
                }
                Observation.prototype.monitor = function (namespace, listener, _a) {
                    var _this = this;
                    var _b = (_a === void 0 ? {} : _a).once, once = _b === void 0 ? false : _b;
                    void throwTypeErrorIfInvalidListener(listener, namespace);
                    var items = this.seekNode_(namespace).items;
                    if (isRegistered(items, RegisterItemType.monitor, namespace, listener))
                        return function () {
                            return void 0;
                        };
                    void items.push({
                        type: RegisterItemType.monitor,
                        namespace: namespace,
                        listener: listener,
                        options: { once: once }
                    });
                    return function () {
                        return _this.off(namespace, listener, RegisterItemType.monitor);
                    };
                };
                Observation.prototype.on = function (namespace, listener, _a) {
                    var _this = this;
                    var _b = (_a === void 0 ? {} : _a).once, once = _b === void 0 ? false : _b;
                    void throwTypeErrorIfInvalidListener(listener, namespace);
                    var items = this.seekNode_(namespace).items;
                    if (isRegistered(items, RegisterItemType.subscriber, namespace, listener))
                        return function () {
                            return void 0;
                        };
                    void items.push({
                        type: RegisterItemType.subscriber,
                        namespace: namespace,
                        listener: listener,
                        options: { once: once }
                    });
                    return function () {
                        return _this.off(namespace, listener);
                    };
                };
                Observation.prototype.once = function (namespace, listener) {
                    void throwTypeErrorIfInvalidListener(listener, namespace);
                    return this.on(namespace, listener, { once: true });
                };
                Observation.prototype.off = function (namespace, listener, type) {
                    var _this = this;
                    if (type === void 0) {
                        type = RegisterItemType.subscriber;
                    }
                    switch (typeof listener) {
                    case 'function':
                        return void this.seekNode_(namespace).items.some(function (_a, i, items) {
                            var type_ = _a.type, listener_ = _a.listener;
                            if (listener_ !== listener)
                                return false;
                            if (type_ !== type)
                                return false;
                            switch (i) {
                            case 0:
                                return !void items.shift();
                            case items.length - 1:
                                return !void items.pop();
                            default:
                                return !void items.splice(i, 1);
                            }
                        });
                    case 'undefined': {
                            var node_1 = this.seekNode_(namespace);
                            void node_1.childrenNames.slice().forEach(function (name) {
                                void _this.off(namespace.concat([name]));
                                var child = node_1.children.get(name);
                                if (!child)
                                    return;
                                if (child.items.length + child.childrenNames.length > 0)
                                    return;
                                void node_1.children.delete(name);
                                void node_1.childrenNames.splice(equal_1.findIndex(name, node_1.childrenNames), 1);
                            });
                            node_1.items = node_1.items.filter(function (_a) {
                                var type = _a.type;
                                return type === RegisterItemType.monitor;
                            });
                            return;
                        }
                    default:
                        throw throwTypeErrorIfInvalidListener(listener, namespace);
                    }
                };
                Observation.prototype.emit = function (namespace, data, tracker) {
                    void this.drain_(namespace, data, tracker);
                };
                Observation.prototype.reflect = function (namespace, data) {
                    var results = [];
                    void this.emit(namespace, data, function (_, r) {
                        return results = r;
                    });
                    return results;
                };
                Observation.prototype.relay = function (source) {
                    var _this = this;
                    if (this.relaySources.has(source))
                        return function () {
                            return void 0;
                        };
                    void this.relaySources.add(source);
                    var unbind = source.monitor([], function (data, namespace) {
                        return void _this.emit(namespace, data);
                    });
                    return function () {
                        return void _this.relaySources.delete(source), unbind();
                    };
                };
                Observation.prototype.drain_ = function (namespace, data, tracker) {
                    var _this = this;
                    var results = [];
                    void this.refsBelow_(this.seekNode_(namespace)).reduce(function (_, _a) {
                        var type = _a.type, listener = _a.listener, once = _a.options.once;
                        if (type !== RegisterItemType.subscriber)
                            return;
                        if (once) {
                            void _this.off(namespace, listener);
                        }
                        try {
                            var result = listener(data, namespace);
                            if (tracker) {
                                results[results.length] = result;
                            }
                        } catch (reason) {
                            void exception_1.causeAsyncException(reason);
                        }
                    }, void 0);
                    void this.refsAbove_(this.seekNode_(namespace)).reduce(function (_, _a) {
                        var type = _a.type, listener = _a.listener, once = _a.options.once;
                        if (type !== RegisterItemType.monitor)
                            return;
                        if (once) {
                            void _this.off(namespace, listener, RegisterItemType.monitor);
                        }
                        try {
                            void listener(data, namespace);
                        } catch (reason) {
                            void exception_1.causeAsyncException(reason);
                        }
                    }, void 0);
                    if (tracker) {
                        try {
                            void tracker(data, results);
                        } catch (reason) {
                            void exception_1.causeAsyncException(reason);
                        }
                    }
                };
                Observation.prototype.refs = function (namespace) {
                    return this.refsBelow_(this.seekNode_(namespace));
                };
                Observation.prototype.refsAbove_ = function (_a) {
                    var parent = _a.parent, items = _a.items;
                    items = concat_1.concat([], items);
                    while (parent) {
                        items = concat_1.concat(items, parent.items);
                        parent = parent.parent;
                    }
                    return items;
                };
                Observation.prototype.refsBelow_ = function (_a) {
                    var childrenNames = _a.childrenNames, children = _a.children, items = _a.items;
                    items = concat_1.concat([], items);
                    for (var i = 0; i < childrenNames.length; ++i) {
                        var name_1 = childrenNames[i];
                        var below = this.refsBelow_(children.get(name_1));
                        items = concat_1.concat(items, below);
                        if (below.length === 0) {
                            void children.delete(name_1);
                            void childrenNames.splice(equal_1.findIndex(name_1, childrenNames), 1);
                            void --i;
                        }
                    }
                    return items;
                };
                Observation.prototype.seekNode_ = function (namespace) {
                    var node = this.node_;
                    try {
                        for (var namespace_1 = __values(namespace), namespace_1_1 = namespace_1.next(); !namespace_1_1.done; namespace_1_1 = namespace_1.next()) {
                            var name_2 = namespace_1_1.value;
                            var children = node.children;
                            if (!children.has(name_2)) {
                                void node.childrenNames.push(name_2);
                                children.set(name_2, {
                                    parent: node,
                                    children: new Map(),
                                    childrenNames: [],
                                    items: []
                                });
                            }
                            node = children.get(name_2);
                        }
                    } catch (e_1_1) {
                        e_1 = { error: e_1_1 };
                    } finally {
                        try {
                            if (namespace_1_1 && !namespace_1_1.done && (_a = namespace_1.return))
                                _a.call(namespace_1);
                        } finally {
                            if (e_1)
                                throw e_1.error;
                        }
                    }
                    return node;
                    var e_1, _a;
                };
                return Observation;
            }();
            exports.Observation = Observation;
            function isRegistered(items, type, namespace, listener) {
                return items.some(function (_a) {
                    var t = _a.type, n = _a.namespace, l = _a.listener;
                    return t === type && n.length === namespace.length && n.every(function (_, i) {
                        return n[i] === namespace[i];
                    }) && l === listener;
                });
            }
            function throwTypeErrorIfInvalidListener(listener, types) {
                switch (typeof listener) {
                case 'function':
                    return;
                default:
                    throw new TypeError('Spica: Observation: Invalid listener.\n\t' + types + ' ' + listener);
                }
            }
        },
        {
            './concat': 6,
            './equal': 9,
            './exception': 10
        }
    ],
    68: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            __export(require('./monad/sequence'));
        },
        { './monad/sequence': 23 }
    ],
    69: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var zeros = '0'.repeat(15);
            var cnt = 0;
            function sqid(id) {
                if (arguments.length > 0) {
                    if (typeof id !== 'number')
                        throw new TypeError('Spica: sqid: A parameter value must be a number: ' + id);
                    if (id >= 0 === false)
                        throw new TypeError('Spica: sqid: A parameter value must be a positive number: ' + id);
                    if (id % 1 !== 0)
                        throw new TypeError('Spica: sqid: A parameter value must be an integer: ' + id);
                }
                return id === void 0 ? (zeros + ++cnt).slice(-15) : (zeros + id).slice(-15);
            }
            exports.sqid = sqid;
        },
        {}
    ],
    70: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var observation_1 = require('./observation');
            var assign_1 = require('./assign');
            var tick_1 = require('./tick');
            var thenable_1 = require('./thenable');
            var sqid_1 = require('./sqid');
            var exception_1 = require('./exception');
            var Supervisor = function () {
                function Supervisor(opts) {
                    if (opts === void 0) {
                        opts = {};
                    }
                    var _this = this;
                    this.id = sqid_1.sqid();
                    this.settings = {
                        name: '',
                        size: Infinity,
                        timeout: Infinity,
                        destructor: function (_) {
                            return void 0;
                        },
                        scheduler: tick_1.tick,
                        resource: 10
                    };
                    this.events = {
                        init: new observation_1.Observation(),
                        loss: new observation_1.Observation(),
                        exit: new observation_1.Observation()
                    };
                    this.workers = new Map();
                    this.alive = true;
                    this.available = true;
                    this.messages = [];
                    this.deliver = function () {
                        var since = Date.now();
                        var _loop_1 = function (i, len) {
                            if (_this.settings.resource - (Date.now() - since) > 0 === false)
                                return { value: void _this.schedule() };
                            var _a = __read(_this.messages[i], 4), name_1 = _a[0], param = _a[1], callback = _a[2], expiry = _a[3];
                            var result = _this.workers.has(name_1) && Date.now() <= expiry ? _this.workers.get(name_1).call([
                                param,
                                expiry
                            ]) : void 0;
                            if (!result && Date.now() < expiry)
                                return out_i_1 = i, out_len_1 = len, 'continue';
                            i === 0 ? void _this.messages.shift() : void _this.messages.splice(i, 1);
                            void --i;
                            void --len;
                            if (!result) {
                                void _this.events.loss.emit([name_1], [
                                    name_1,
                                    param
                                ]);
                            }
                            if (!result || result instanceof Error) {
                                try {
                                    void callback(void 0, new Error('Spica: Supervisor: A processing has failed.'));
                                } catch (reason) {
                                    void exception_1.causeAsyncException(reason);
                                }
                                return out_i_1 = i, out_len_1 = len, 'continue';
                            }
                            var _b = __read(result, 1), reply = _b[0];
                            if (!thenable_1.isThenable(reply)) {
                                try {
                                    void callback(reply);
                                } catch (reason) {
                                    void exception_1.causeAsyncException(reason);
                                }
                            } else {
                                void Promise.resolve(reply).then(function (reply) {
                                    return _this.available ? void callback(reply) : void callback(void 0, new Error('Spica: Supervisor: A processing has failed.'));
                                }, function () {
                                    return void callback(void 0, new Error('Spica: Supervisor: A processing has failed.'));
                                });
                            }
                            out_i_1 = i;
                            out_len_1 = len;
                        };
                        var out_i_1, out_len_1;
                        for (var i = 0, len = _this.messages.length; _this.available && i < len; ++i) {
                            var state_1 = _loop_1(i, len);
                            i = out_i_1;
                            len = out_len_1;
                            if (typeof state_1 === 'object')
                                return state_1.value;
                        }
                    };
                    if (!this.constructor.hasOwnProperty('instances')) {
                        this.constructor.instances = new Set();
                    }
                    void assign_1.extend(this.settings, opts);
                    this.name = this.settings.name;
                    if (this.constructor === Supervisor)
                        throw new Error('Spica: Supervisor: <' + this.id + '/' + this.name + '>: Cannot instantiate abstract classes.');
                    void this.constructor.instances.add(this);
                    this.scheduler = function () {
                        return void (void 0, _this.settings.scheduler)(_this.deliver);
                    };
                }
                Object.defineProperty(Supervisor, 'count', {
                    get: function () {
                        return this.instances ? this.instances.size : 0;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(Supervisor, 'procs', {
                    get: function () {
                        return this.instances ? __spread(this.instances).reduce(function (cnt, sv) {
                            return cnt + sv.workers.size;
                        }, 0) : 0;
                    },
                    enumerable: true,
                    configurable: true
                });
                Supervisor.prototype.destructor = function (reason) {
                    this.available = false;
                    void this.workers.forEach(function (worker) {
                        return void worker.terminate(reason);
                    });
                    void Object.freeze(this.workers);
                    while (this.messages.length > 0) {
                        var _a = __read(this.messages.shift(), 2), name_2 = _a[0], param = _a[1];
                        void this.events.loss.emit([name_2], [
                            name_2,
                            param
                        ]);
                    }
                    void Object.freeze(this.messages);
                    this.alive = false;
                    void this.constructor.instances.delete(this);
                    void Object.freeze(this);
                    void this.settings.destructor(reason);
                };
                Supervisor.prototype.validate = function () {
                    if (!this.available)
                        throw new Error('Spica: Supervisor: <' + this.id + '/' + this.name + '>: A supervisor is already terminated.');
                };
                Supervisor.prototype.register = function (name, process, state) {
                    var _this = this;
                    void this.validate();
                    if (this.workers.has(name))
                        throw new Error('Spica: Supervisor: <' + this.id + '/' + this.name + '/' + name + '>: Cannot register a process multiply with the same name.');
                    void this.schedule();
                    process = typeof process === 'function' ? {
                        init: function (state) {
                            return state;
                        },
                        call: process,
                        exit: function (_) {
                            return void 0;
                        }
                    } : process;
                    return this.workers.set(name, new Worker(this, name, process, state, function () {
                        return void _this.workers.delete(name);
                    })).get(name).terminate;
                };
                Supervisor.prototype.call = function (name, param, callback, timeout) {
                    var _this = this;
                    if (timeout === void 0) {
                        timeout = this.settings.timeout;
                    }
                    void this.validate();
                    void this.messages.push([
                        name,
                        param,
                        callback,
                        Date.now() + timeout
                    ]);
                    while (this.messages.length > this.settings.size) {
                        var _a = __read(this.messages.shift(), 3), name_3 = _a[0], param_1 = _a[1], callback_1 = _a[2];
                        void this.events.loss.emit([name_3], [
                            name_3,
                            param_1
                        ]);
                        try {
                            void callback_1(void 0, new Error('Spica: Supervisor: A message overflowed.'));
                        } catch (reason) {
                            void exception_1.causeAsyncException(reason);
                        }
                    }
                    void this.schedule();
                    if (timeout <= 0)
                        return;
                    if (timeout === Infinity)
                        return;
                    void setTimeout(function () {
                        return void _this.schedule();
                    }, timeout + 3);
                };
                Supervisor.prototype.cast = function (name, param, timeout) {
                    if (timeout === void 0) {
                        timeout = this.settings.timeout;
                    }
                    void this.validate();
                    var result = this.workers.has(name) ? this.workers.get(name).call([
                        param,
                        timeout
                    ]) : void 0;
                    if (result === void 0) {
                        void this.events.loss.emit([name], [
                            name,
                            param
                        ]);
                    }
                    if (result === void 0 || result instanceof Error)
                        return false;
                    var _a = __read(result, 1), reply = _a[0];
                    if (thenable_1.isThenable(reply)) {
                        void reply.catch(function () {
                            return void 0;
                        });
                    }
                    return true;
                };
                Supervisor.prototype.refs = function (name) {
                    void this.validate();
                    return name === void 0 ? __spread(this.workers.values()).map(convert) : this.workers.has(name) ? [convert(this.workers.get(name))] : [];
                    function convert(worker) {
                        return [
                            worker.name,
                            worker.process,
                            worker.state,
                            worker.terminate
                        ];
                    }
                };
                Supervisor.prototype.kill = function (name, reason) {
                    if (!this.available)
                        return false;
                    return this.workers.has(name) ? this.workers.get(name).terminate(reason) : false;
                };
                Supervisor.prototype.terminate = function (reason) {
                    if (!this.available)
                        return false;
                    void this.destructor(reason);
                    return true;
                };
                Supervisor.prototype.schedule = function () {
                    if (this.messages.length === 0)
                        return;
                    void tick_1.tick(this.scheduler, true);
                };
                return Supervisor;
            }();
            exports.Supervisor = Supervisor;
            var Worker = function () {
                function Worker(sv, name, process, state, destructor_) {
                    var _this = this;
                    this.sv = sv;
                    this.name = name;
                    this.process = process;
                    this.state = state;
                    this.destructor_ = destructor_;
                    this.alive = true;
                    this.available = true;
                    this.called = false;
                    this.call = function (_a) {
                        var _b = __read(_a, 2), param = _b[0], expiry = _b[1];
                        if (!_this.available)
                            return;
                        try {
                            _this.available = false;
                            if (!_this.called) {
                                _this.called = true;
                                void _this.sv.events.init.emit([_this.name], [
                                    _this.name,
                                    _this.process,
                                    _this.state
                                ]);
                                _this.state = _this.process.init(_this.state);
                            }
                            var result_1 = _this.process.call(param, _this.state);
                            if (!thenable_1.isThenable(result_1)) {
                                var _c = __read(result_1, 2), reply = _c[0], state = _c[1];
                                _this.state = state;
                                _this.available = true;
                                return [reply];
                            } else {
                                return [new Promise(function (resolve, reject) {
                                        return void result_1.then(resolve, reject), expiry === Infinity ? void 0 : void setTimeout(function () {
                                            return void reject(new Error());
                                        }, expiry - Date.now());
                                    }).then(function (_a) {
                                        var _b = __read(_a, 2), reply = _b[0], state = _b[1];
                                        return [
                                            reply,
                                            state
                                        ];
                                    }).then(function (_a) {
                                        var _b = __read(_a, 2), reply = _b[0], state = _b[1];
                                        void _this.sv.schedule();
                                        if (!_this.alive)
                                            return Promise.reject(new Error());
                                        _this.state = state;
                                        _this.available = true;
                                        return reply;
                                    }, function (reason) {
                                        void _this.sv.schedule();
                                        void _this.terminate(reason);
                                        throw reason;
                                    })];
                            }
                        } catch (reason) {
                            void _this.terminate(reason);
                            return new Error();
                        }
                    };
                    this.terminate = function (reason) {
                        if (!_this.alive)
                            return false;
                        void _this.destructor(reason);
                        return true;
                    };
                }
                Worker.prototype.destructor = function (reason) {
                    this.alive = false;
                    this.available = false;
                    void Object.freeze(this);
                    void this.destructor_();
                    if (this.called) {
                        try {
                            void this.process.exit(reason, this.state);
                            void this.sv.events.exit.emit([this.name], [
                                this.name,
                                this.process,
                                this.state,
                                reason
                            ]);
                        } catch (reason_) {
                            void this.sv.events.exit.emit([this.name], [
                                this.name,
                                this.process,
                                this.state,
                                reason
                            ]);
                            void this.sv.terminate(reason_);
                        }
                    }
                };
                return Worker;
            }();
        },
        {
            './assign': 3,
            './exception': 10,
            './observation': 67,
            './sqid': 69,
            './thenable': 71,
            './tick': 72
        }
    ],
    71: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function isThenable(target) {
                return !!target && typeof target === 'object' && typeof target.then === 'function';
            }
            exports.isThenable = isThenable;
        },
        {}
    ],
    72: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var exception_1 = require('./exception');
            var queue = [];
            var register = new WeakSet();
            function tick(cb, dedup) {
                if (dedup === void 0) {
                    dedup = false;
                }
                if (dedup) {
                    if (register.has(cb))
                        return;
                    void register.add(cb);
                }
                void queue.push(cb);
                void schedule();
            }
            exports.tick = tick;
            var scheduler = Promise.resolve();
            function schedule() {
                if (queue.length !== 1)
                    return;
                void scheduler.then(run);
            }
            function run() {
                var cbs = flush();
                while (true) {
                    try {
                        while (cbs.length > 0) {
                            void cbs.shift()();
                        }
                    } catch (reason) {
                        void exception_1.causeAsyncException(reason);
                        continue;
                    }
                    return;
                }
            }
            function flush() {
                var cbs = queue;
                queue = [];
                register = new WeakSet();
                return cbs;
            }
        },
        { './exception': 10 }
    ],
    73: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function type(target) {
                var type = Object.prototype.toString.call(target).split(' ').pop().slice(0, -1);
                if (typeof target !== 'object' && target instanceof Object === false || target === null)
                    return type.toLowerCase();
                return type;
            }
            exports.type = type;
        },
        {}
    ],
    74: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            __export(require('./src/export'));
            var export_1 = require('./src/export');
            exports.default = export_1.default;
        },
        { './src/export': 77 }
    ],
    75: [
        function (require, module, exports) {
            'use strict';
            var __assign = this && this.__assign || Object.assign || function (t) {
                for (var s, i = 1, n = arguments.length; i < n; i++) {
                    s = arguments[i];
                    for (var p in s)
                        if (Object.prototype.hasOwnProperty.call(s, p))
                            t[p] = s[p];
                }
                return t;
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var El = function () {
                function El(element_, children_) {
                    var _this = this;
                    this.element_ = element_;
                    this.children_ = children_;
                    this.mode = this.children_ === void 0 ? 'void' : typeof this.children_ === 'string' ? 'text' : Array.isArray(this.children_) ? 'collection' : 'struct';
                    this.structkeys = this.mode === 'struct' ? Object.keys(this.children_) : [];
                    this.tag;
                    switch (this.mode) {
                    case 'void':
                        return;
                    case 'text':
                        void clear();
                        this.children_ = document.createTextNode('');
                        void this.element_.appendChild(this.children_);
                        this.children = children_;
                        return;
                    case 'collection':
                        void clear();
                        if (element_.id) {
                            void children_.forEach(function (_a) {
                                var element = _a.element;
                                return element instanceof HTMLStyleElement && void scope(element);
                            });
                        }
                        this.children_ = [];
                        this.children = children_;
                        return;
                    case 'struct':
                        void clear();
                        if (element_.id) {
                            void Object.keys(children_).map(function (k) {
                                return children_[k];
                            }).forEach(function (_a) {
                                var element = _a.element;
                                return element instanceof HTMLStyleElement && void scope(element);
                            });
                        }
                        this.children_ = this.observe(__assign({}, children_));
                        void this.structkeys.forEach(function (k) {
                            return void _this.element_.appendChild(children_[k].element);
                        });
                        return;
                    }
                    function clear() {
                        while (element_.childNodes.length > 0) {
                            void element_.removeChild(element_.firstChild);
                        }
                    }
                    function scope(style) {
                        if (!element_.id.match(/^[\w\-]+$/))
                            return;
                        style.innerHTML = style.innerHTML.replace(/^\s*\$scope(?!\w)/gm, '#' + element_.id);
                        void __spread(style.querySelectorAll('*')).forEach(function (el) {
                            return void el.remove();
                        });
                    }
                }
                Object.defineProperty(El.prototype, 'element', {
                    get: function () {
                        return this.element_;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(El.prototype, 'children', {
                    get: function () {
                        switch (this.mode) {
                        case 'text':
                            return this.children_.data;
                        default:
                            return this.children_;
                        }
                    },
                    set: function (children) {
                        var _this = this;
                        switch (this.mode) {
                        case 'void':
                            return;
                        case 'text':
                            if (children === this.children_.data)
                                return;
                            this.children_.data = children;
                            return;
                        case 'collection':
                            if (children === this.children_)
                                return;
                            void children.reduce(function (cs, c) {
                                var i = cs.indexOf(c);
                                if (i === -1)
                                    return cs;
                                void cs.splice(i, 1);
                                return cs;
                            }, __spread(this.children_)).forEach(function (child) {
                                return void child.element.remove();
                            });
                            this.children_ = [];
                            void children.forEach(function (child, i) {
                                return _this.children_[i] = child, void _this.element_.appendChild(child.element);
                            });
                            void Object.freeze(this.children_);
                            return;
                        case 'struct':
                            if (children === this.children_)
                                return;
                            void this.structkeys.forEach(function (k) {
                                return _this.children_[k] = children[k];
                            });
                            return;
                        }
                    },
                    enumerable: true,
                    configurable: true
                });
                El.prototype.observe = function (children) {
                    var _this = this;
                    return Object.defineProperties(children, this.structkeys.reduce(function (descs, key) {
                        var current = children[key];
                        descs[key] = {
                            configurable: true,
                            enumerable: true,
                            get: function () {
                                return current;
                            },
                            set: function (newChild) {
                                var oldChild = current;
                                if (newChild === oldChild)
                                    return;
                                current = newChild;
                                void _this.element_.replaceChild(newChild.element, oldChild.element);
                            }
                        };
                        return descs;
                    }, {}));
                };
                return El;
            }();
            exports.El = El;
        },
        {}
    ],
    76: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var builder_1 = require('./builder');
            exports.TypedHTML = [
                'a',
                'applet',
                'area',
                'audio',
                'base',
                'basefont',
                'blockquote',
                'body',
                'br',
                'button',
                'canvas',
                'caption',
                'col',
                'colgroup',
                'data',
                'datalist',
                'del',
                'dir',
                'div',
                'dl',
                'embed',
                'fieldset',
                'font',
                'form',
                'frame',
                'frameset',
                'h1',
                'h2',
                'h3',
                'h4',
                'h5',
                'h6',
                'head',
                'hr',
                'html',
                'iframe',
                'img',
                'input',
                'ins',
                'isindex',
                'label',
                'legend',
                'li',
                'link',
                'listing',
                'map',
                'marquee',
                'menu',
                'meta',
                'meter',
                'nextid',
                'object',
                'ol',
                'optgroup',
                'option',
                'output',
                'p',
                'param',
                'picture',
                'pre',
                'progress',
                'q',
                'script',
                'select',
                'source',
                'span',
                'style',
                'table',
                'tbody',
                'td',
                'template',
                'textarea',
                'tfoot',
                'th',
                'thead',
                'time',
                'title',
                'tr',
                'track',
                'ul',
                'video',
                'x-ms-webview',
                'xmp',
                'abbr',
                'acronym',
                'address',
                'article',
                'aside',
                'b',
                'bdo',
                'big',
                'center',
                'cite',
                'code',
                'dd',
                'dfn',
                'dt',
                'em',
                'figcaption',
                'figure',
                'footer',
                'header',
                'hgroup',
                'i',
                'kbd',
                'keygen',
                'mark',
                'nav',
                'nobr',
                'noframes',
                'noscript',
                'plaintext',
                'rt',
                'ruby',
                's',
                'samp',
                'section',
                'small',
                'strike',
                'strong',
                'sub',
                'sup',
                'tt',
                'u',
                'var',
                'wbr',
                'create',
                'any'
            ].reduce(function (obj, prop) {
                return obj[prop] = prop === 'create' ? function (tag, b, c, d) {
                    if (b === void 0) {
                        b = function () {
                            return document.createElement(tag);
                        };
                    }
                    if (c === void 0) {
                        c = function () {
                            return document.createElement(tag);
                        };
                    }
                    if (d === void 0) {
                        d = function () {
                            return document.createElement(tag);
                        };
                    }
                    return exports.TypedHTML['any'](b, c, d, tag);
                } : function (attrs, children, factory, tag) {
                    if (tag === void 0) {
                        tag = prop;
                    }
                    tag = prop === 'any' ? tag : prop;
                    switch (typeof attrs) {
                    case 'undefined':
                        return new builder_1.El(define(tag, function () {
                            return document.createElement(tag);
                        }), void 0);
                    case 'function':
                        return new builder_1.El(define(tag, attrs), void 0);
                    case 'string':
                        return new builder_1.El(define(tag, children || function () {
                            return document.createElement(tag);
                        }), attrs);
                    case 'object':
                        factory = typeof children === 'function' ? children : factory || function () {
                            return document.createElement(tag);
                        };
                        return Object.keys(attrs).slice(-1).every(function (key) {
                            return key === void 0 || typeof attrs[key] === 'object';
                        }) ? new builder_1.El(define(tag, factory), attrs) : new builder_1.El(define(tag, factory, attrs), children === factory ? void 0 : children);
                    default:
                        throw new TypeError('Invalid arguments: [' + attrs + ', ' + children + ', ' + factory + ']');
                    }
                }, obj;
            }, {});
            function define(tag, factory, attrs) {
                var el = factory();
                if (tag !== el.tagName && tag !== el.tagName.toLowerCase())
                    throw new Error('Tag name must be "' + tag + '" but "' + el.tagName.toLowerCase() + '".');
                if (!attrs)
                    return el;
                return Object.keys(attrs).reduce(function (el, name) {
                    return void el.setAttribute(name, attrs[name] || ''), el;
                }, el);
            }
        },
        { './builder': 75 }
    ],
    77: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            var html_1 = require('./dom/html');
            exports.default = html_1.TypedHTML;
            exports.TypedHTML = html_1.TypedHTML;
            __export(require('./util/dom'));
        },
        {
            './dom/html': 76,
            './util/dom': 78
        }
    ],
    78: [
        function (require, module, exports) {
            'use strict';
            var __assign = this && this.__assign || Object.assign || function (t) {
                for (var s, i = 1, n = arguments.length; i < n; i++) {
                    s = arguments[i];
                    for (var p in s)
                        if (Object.prototype.hasOwnProperty.call(s, p))
                            t[p] = s[p];
                }
                return t;
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var noop_1 = require('./noop');
            exports.currentTargets = new WeakMap();
            function bind(target, type, listener, option) {
                if (option === void 0) {
                    option = false;
                }
                void target.addEventListener(type, handler, adjustEventListenerOptions(option));
                var unbind = function () {
                    return unbind = noop_1.noop, void target.removeEventListener(type, handler, adjustEventListenerOptions(option));
                };
                return function () {
                    return void unbind();
                };
                function handler(ev) {
                    if (typeof option === 'object' && option.passive) {
                        ev.preventDefault = noop_1.noop;
                    }
                    void exports.currentTargets.set(ev, ev.currentTarget);
                    void listener(ev);
                }
            }
            exports.bind = bind;
            function once(target, type, listener, option) {
                if (option === void 0) {
                    option = false;
                }
                var unbind = bind(target, type, function (ev) {
                    void unbind();
                    void listener(ev);
                }, option);
                return function () {
                    return void unbind();
                };
            }
            exports.once = once;
            function delegate(target, selector, type, listener, option) {
                if (option === void 0) {
                    option = {};
                }
                return bind(target instanceof Document ? target.documentElement : target, type, function (ev) {
                    var cx = ev.target.closest(selector);
                    if (!cx)
                        return;
                    void __spread(target.querySelectorAll(selector)).filter(function (el) {
                        return el === cx;
                    }).forEach(function (el) {
                        return void once(el, type, function (ev) {
                            void listener(ev);
                        }, option);
                    });
                }, __assign({}, option, { capture: true }));
            }
            exports.delegate = delegate;
            var supportEventListenerOptions = false;
            try {
                document.createElement('div').addEventListener('test', function () {
                }, {
                    get capture() {
                        return supportEventListenerOptions = true;
                    }
                });
            } catch (e) {
            }
            function adjustEventListenerOptions(option) {
                return supportEventListenerOptions ? option : typeof option === 'boolean' ? option : option.capture;
            }
        },
        { './noop': 79 }
    ],
    79: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function noop() {
                return;
            }
            exports.noop = noop;
        },
        {}
    ],
    80: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var gui_1 = require('./layer/interface/service/gui');
            exports.default = gui_1.GUI;
            var gui_2 = require('./layer/interface/service/gui');
            exports.Pjax = gui_2.GUI;
            var router_1 = require('./lib/router');
            exports.router = router_1.router;
        },
        {
            './layer/interface/service/gui': 114,
            './lib/router': 125
        }
    ],
    81: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            var maybe_1 = require('spica/maybe');
            var either_1 = require('spica/either');
            var config_1 = require('../domain/data/config');
            exports.Config = config_1.Config;
            var scope_1 = require('./config/scope');
            var api_1 = require('../domain/router/api');
            var router_1 = require('../domain/event/router');
            var error_1 = require('./data/error');
            __export(require('./store/path'));
            function route(config, event, state, io) {
                return __awaiter(this, void 0, void 0, function () {
                    return __generator(this, function (_a) {
                        return [
                            2,
                            maybe_1.Just(new router_1.RouterEvent(event).location).bind(function (_a) {
                                var orig = _a.orig, dest = _a.dest;
                                return scope_1.scope(config, {
                                    orig: orig.pathname,
                                    dest: dest.pathname
                                });
                            }).fmap(function (config) {
                                return new api_1.RouterEntity(config, new router_1.RouterEvent(event), new api_1.RouterEntityState(state.process, state.scripts));
                            }).fmap(function (entity) {
                                return api_1.route(entity, io);
                            }).extract(function () {
                                return either_1.Left(new error_1.ApplicationError('Disabled by config.'));
                            })
                        ];
                    });
                });
            }
            exports.route = route;
        },
        {
            '../domain/data/config': 87,
            '../domain/event/router': 89,
            '../domain/router/api': 90,
            './config/scope': 82,
            './data/error': 83,
            './store/path': 84,
            'spica/either': 8,
            'spica/maybe': 13
        }
    ],
    82: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var router_1 = require('../../../lib/router');
            var config_1 = require('../../domain/data/config');
            var sequence_1 = require('spica/sequence');
            var maybe_1 = require('spica/maybe');
            var assign_1 = require('spica/assign');
            function scope(config, path) {
                return sequence_1.Sequence.from(Object.keys(config.scope).sort().reverse()).dropWhile(function (pattern) {
                    return !!!router_1.compare(pattern, path.orig) && !router_1.compare(pattern, path.dest);
                }).take(1).filter(function (pattern) {
                    return !!router_1.compare(pattern, path.orig) && router_1.compare(pattern, path.dest);
                }).map(function (pattern) {
                    return config.scope[pattern];
                }).map(function (option) {
                    return option ? maybe_1.Just(new config_1.Config(assign_1.extend({}, config, option))) : maybe_1.Nothing;
                }).extract().reduce(function (_, m) {
                    return m;
                }, maybe_1.Nothing);
            }
            exports.scope = scope;
        },
        {
            '../../../lib/router': 125,
            '../../domain/data/config': 87,
            'spica/assign': 3,
            'spica/maybe': 13,
            'spica/sequence': 68
        }
    ],
    83: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var error_1 = require('../../../lib/error');
            var ApplicationError = function (_super) {
                __extends(ApplicationError, _super);
                function ApplicationError(msg) {
                    return _super.call(this, 'Application: ' + msg) || this;
                }
                return ApplicationError;
            }(error_1.PjaxError);
            exports.ApplicationError = ApplicationError;
        },
        { '../../../lib/error': 123 }
    ],
    84: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var path_1 = require('../../domain/store/path');
            exports.loadTitle = path_1.loadTitle;
            exports.savePosition = path_1.savePosition;
        },
        { '../../domain/store/path': 107 }
    ],
    85: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var Identifier;
            (function (Identifier) {
            }(Identifier || (Identifier = {})));
            function standardizeUrl(url) {
                return encode(normalize(url));
            }
            exports.standardizeUrl = standardizeUrl;
            function encode(url) {
                return url.trim().replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]?|[\uDC00-\uDFFF]/g, function (str) {
                    return str.length === 2 ? str : '';
                }).replace(/%(?![0-9A-F]{2})|[^%\[\]]+/ig, encodeURI).replace(/\?[^#]+/, function (query) {
                    return '?' + query.slice(1).replace(/%[0-9A-F]{2}|[^=&]/ig, function (str) {
                        return str.length < 3 ? encodeURIComponent(str) : str;
                    });
                }).replace(/%[0-9A-F]{2}/ig, function (str) {
                    return str.toUpperCase();
                }).replace(/#.+/, url.slice(url.indexOf('#')));
            }
            exports._encode = encode;
            var parser = document.createElement('a');
            function normalize(url) {
                parser.href = url || location.href;
                return parser.href.replace(/^([^:/?#]+:\/\/[^/?#]*?):(?:80)?(?=$|[/?#])/, '$1').replace(/^([^:/?#]+:\/\/[^/?#]*)\/?/, '$1/').replace(/%[0-9A-F]{2}/ig, function (str) {
                    return str.toUpperCase();
                }).replace(/#.+/, url.slice(url.indexOf('#')));
            }
        },
        {}
    ],
    86: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var assign_1 = require('spica/assign');
            void saveTitle();
            void savePosition();
            function loadTitle() {
                return window.history.state.title || document.title;
            }
            exports.loadTitle = loadTitle;
            function saveTitle() {
                void window.history.replaceState(assign_1.extend(window.history.state || {}, { title: document.title }), document.title);
            }
            exports.saveTitle = saveTitle;
            function loadPosition() {
                return window.history.state.position || {
                    top: window.pageYOffset,
                    left: window.pageXOffset
                };
            }
            exports.loadPosition = loadPosition;
            function savePosition() {
                void window.history.replaceState(assign_1.extend(window.history.state || {}, {
                    position: {
                        top: window.pageYOffset,
                        left: window.pageXOffset
                    }
                }), document.title);
            }
            exports.savePosition = savePosition;
        },
        { 'spica/assign': 3 }
    ],
    87: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var assign_1 = require('spica/assign');
            var Config = function () {
                function Config(option) {
                    this.areas = ['body'];
                    this.link = 'a:not([target])';
                    this.form = 'form:not([method])';
                    this.replace = '';
                    this.fetch = {
                        timeout: 3000,
                        wait: 0
                    };
                    this.update = {
                        head: 'base, meta, link',
                        css: true,
                        script: true,
                        ignore: '',
                        ignores: {
                            extension: '[href^="chrome-extension://"]',
                            security: '[src*=".scr.kaspersky-labs.com/"]'
                        },
                        reload: '',
                        logger: ''
                    };
                    this.sequence = new Sequence();
                    this.balance = {
                        bounds: [''],
                        weight: 1,
                        random: 0,
                        client: {
                            hosts: [],
                            support: {
                                balance: /msie|trident.+ rv:|chrome|firefox|safari/i,
                                redirect: /msie|trident.+ rv:|chrome|firefox|safari/i
                            },
                            cookie: {
                                balance: 'balanceable',
                                redirect: 'redirectable'
                            }
                        },
                        server: {
                            header: 'X-Ajax-Host',
                            expiry: 3 * 24 * 3600 * 1000
                        }
                    };
                    this.store = { expiry: 3 * 3600 * 1000 };
                    this.progressbar = 'display:none;position:absolute;bottom:0;left:0;width:0;height:2px;background:rgb(40, 105, 255);';
                    this.scope = { '/': {} };
                    void Object.defineProperties(this.update, {
                        ignore: {
                            enumerable: false,
                            set: function (value) {
                                this.ignores['_'] = value;
                            },
                            get: function () {
                                var _this = this;
                                return Object.keys(this.ignores).map(function (i) {
                                    return _this.ignores[i];
                                }).filter(function (s) {
                                    return s.trim().length > 0;
                                }).join(',');
                            }
                        }
                    });
                    void assign_1.extend(this, option);
                    void Object.freeze(this);
                }
                Config.prototype.filter = function (_el) {
                    return true;
                };
                Config.prototype.rewrite = function (_doc, _area, _host) {
                };
                Config.prototype.fallback = function (target, reason) {
                    if (target instanceof HTMLAnchorElement) {
                        return void window.location.assign(target.href);
                    }
                    if (target instanceof HTMLFormElement) {
                        return void window.location.assign(target.action);
                    }
                    if (target instanceof Window) {
                        return void window.location.reload(true);
                    }
                    throw reason;
                };
                return Config;
            }();
            exports.Config = Config;
            var Sequence = function () {
                function Sequence() {
                }
                Sequence.prototype.fetch = function () {
                    return __awaiter(this, void 0, void 0, function () {
                        return __generator(this, function (_a) {
                            return [
                                2,
                                void 0
                            ];
                        });
                    });
                };
                Sequence.prototype.unload = function () {
                    return __awaiter(this, void 0, void 0, function () {
                        return __generator(this, function (_a) {
                            return [
                                2,
                                void 0
                            ];
                        });
                    });
                };
                Sequence.prototype.ready = function () {
                    return __awaiter(this, void 0, void 0, function () {
                        return __generator(this, function (_a) {
                            return [
                                2,
                                void 0
                            ];
                        });
                    });
                };
                Sequence.prototype.load = function () {
                };
                return Sequence;
            }();
            var SequenceData;
            (function (SequenceData_1) {
            }(SequenceData = exports.SequenceData || (exports.SequenceData = {})));
        },
        { 'spica/assign': 3 }
    ],
    88: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var error_1 = require('../../../lib/error');
            var DomainError = function (_super) {
                __extends(DomainError, _super);
                function DomainError(msg) {
                    return _super.call(this, 'Domain: ' + msg) || this;
                }
                return DomainError;
            }(error_1.PjaxError);
            exports.DomainError = DomainError;
        },
        { '../../../lib/error': 123 }
    ],
    89: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var url_1 = require('../../../lib/url');
            var url_2 = require('../../data/model/domain/url');
            var dom_1 = require('../../../lib/dom');
            var error_1 = require('../data/error');
            var typed_dom_1 = require('typed-dom');
            var RouterEvent = function () {
                function RouterEvent(original) {
                    var _this = this;
                    this.original = original;
                    this.source = typed_dom_1.currentTargets.get(this.original);
                    this.type = this.original.type.toLowerCase();
                    this.request = new RouterEventRequest(this.source);
                    this.location = new RouterEventLocation(this.request.url);
                    void Object.freeze(this);
                }
                return RouterEvent;
            }();
            exports.RouterEvent = RouterEvent;
            var RouterEventSource;
            (function (RouterEventSource) {
                RouterEventSource.Anchor = HTMLAnchorElement;
                RouterEventSource.Form = HTMLFormElement;
                RouterEventSource.Window = window.Window;
            }(RouterEventSource = exports.RouterEventSource || (exports.RouterEventSource = {})));
            var RouterEventType;
            (function (RouterEventType) {
                RouterEventType.click = 'click';
                RouterEventType.submit = 'submit';
                RouterEventType.popstate = 'popstate';
            }(RouterEventType = exports.RouterEventType || (exports.RouterEventType = {})));
            var RouterEventMethod;
            (function (RouterEventMethod) {
                RouterEventMethod.GET = 'GET';
                RouterEventMethod.POST = 'POST';
            }(RouterEventMethod = exports.RouterEventMethod || (exports.RouterEventMethod = {})));
            var RouterEventRequest = function () {
                function RouterEventRequest(source) {
                    var _this = this;
                    this.source = source;
                    this.method = function () {
                        if (_this.source instanceof RouterEventSource.Anchor) {
                            return RouterEventMethod.GET;
                        }
                        if (_this.source instanceof RouterEventSource.Form) {
                            return _this.source.method.toUpperCase() === RouterEventMethod.POST ? RouterEventMethod.POST : RouterEventMethod.GET;
                        }
                        if (_this.source instanceof RouterEventSource.Window) {
                            return RouterEventMethod.GET;
                        }
                        throw new TypeError();
                    }();
                    this.url = function () {
                        if (_this.source instanceof RouterEventSource.Anchor) {
                            return url_2.standardizeUrl(_this.source.href);
                        }
                        if (_this.source instanceof RouterEventSource.Form) {
                            return _this.source.method.toUpperCase() === RouterEventMethod.GET ? url_2.standardizeUrl(_this.source.action.split(/[?#]/).shift().concat('?' + dom_1.serialize(_this.source))) : url_2.standardizeUrl(_this.source.action.split(/[?#]/).shift());
                        }
                        if (_this.source instanceof RouterEventSource.Window) {
                            return url_2.standardizeUrl(window.location.href);
                        }
                        throw new TypeError();
                    }();
                    this.data = function () {
                        return _this.source instanceof RouterEventSource.Form && _this.method === RouterEventMethod.POST ? new FormData(_this.source) : null;
                    }();
                    void Object.freeze(this);
                }
                return RouterEventRequest;
            }();
            exports.RouterEventRequest = RouterEventRequest;
            var RouterEventLocation = function () {
                function RouterEventLocation(target) {
                    this.target = target;
                    this.orig = new url_1.URL(url_2.standardizeUrl(window.location.href));
                    this.dest = new url_1.URL(this.target);
                    if (this.orig.origin !== this.dest.origin)
                        throw new error_1.DomainError('Cannot go to the different origin: ' + this.dest.href);
                    void Object.freeze(this);
                }
                return RouterEventLocation;
            }();
            exports.RouterEventLocation = RouterEventLocation;
        },
        {
            '../../../lib/dom': 122,
            '../../../lib/url': 126,
            '../../data/model/domain/url': 85,
            '../data/error': 88,
            'typed-dom': 74
        }
    ],
    90: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var either_1 = require('spica/either');
            var fetch_1 = require('./module/fetch');
            var update_1 = require('./module/update');
            var content_1 = require('./module/update/content');
            var path_1 = require('../store/path');
            var error_1 = require('../data/error');
            var entity_1 = require('./model/eav/entity');
            exports.RouterEntity = entity_1.RouterEntity;
            exports.RouterEntityState = entity_1.RouterEntityState;
            function route(entity, io) {
                return __awaiter(this, void 0, void 0, function () {
                    var _this = this;
                    function match(document, areas) {
                        return content_1.separate({
                            src: document,
                            dst: document
                        }, areas).extract(function () {
                            return false;
                        }, function () {
                            return true;
                        });
                    }
                    return __generator(this, function (_a) {
                        return [
                            2,
                            either_1.Right(void 0).bind(entity.state.process.either).bind(function () {
                                return match(io.document, entity.config.areas) ? either_1.Right(void 0) : either_1.Left(new error_1.DomainError('Failed to match areas.'));
                            }).fmap(function () {
                                return fetch_1.fetch(entity.event.request, entity.config, entity.state.process);
                            }).fmap(function (p) {
                                return __awaiter(_this, void 0, void 0, function () {
                                    return __generator(this, function (_a) {
                                        switch (_a.label) {
                                        case 0:
                                            return [
                                                4,
                                                p
                                            ];
                                        case 1:
                                            return [
                                                2,
                                                _a.sent().fmap(function (_a) {
                                                    var _b = __read(_a, 2), res = _b[0], seq = _b[1];
                                                    return update_1.update(entity, res, seq, {
                                                        document: io.document,
                                                        position: path_1.loadPosition
                                                    });
                                                }).extract(either_1.Left)
                                            ];
                                        }
                                    });
                                });
                            }).extract(either_1.Left)
                        ];
                    });
                });
            }
            exports.route = route;
        },
        {
            '../data/error': 88,
            '../store/path': 107,
            './model/eav/entity': 91,
            './module/fetch': 94,
            './module/update': 96,
            './module/update/content': 98,
            'spica/either': 8
        }
    ],
    91: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var RouterEntity = function () {
                function RouterEntity(config, event, state) {
                    this.config = config;
                    this.event = event;
                    this.state = state;
                    void Object.freeze(this);
                }
                return RouterEntity;
            }();
            exports.RouterEntity = RouterEntity;
            var RouterEntityState = function () {
                function RouterEntityState(process, scripts) {
                    this.process = process;
                    this.scripts = scripts;
                    void Object.freeze(this);
                }
                return RouterEntityState;
            }();
            exports.RouterEntityState = RouterEntityState;
        },
        {}
    ],
    92: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var html_1 = require('../../../../../../lib/html');
            var url_1 = require('../../../../../data/model/domain/url');
            var FetchResult = function () {
                function FetchResult(xhr) {
                    this.xhr = xhr;
                    this.response = new (function () {
                        function class_1(xhr) {
                            var _this = this;
                            this.xhr = xhr;
                            this.url = this.xhr.responseURL ? url_1.standardizeUrl(this.xhr.responseURL) : '';
                            this.header = function (name) {
                                return _this.xhr.getResponseHeader(name);
                            };
                            this.document = this.xhr.responseType === 'document' ? this.xhr.responseXML : html_1.parse(this.xhr.responseText).extract();
                            void Object.freeze(this);
                        }
                        return class_1;
                    }())(this.xhr);
                    void Object.freeze(this);
                }
                return FetchResult;
            }();
            exports.FetchResult = FetchResult;
        },
        {
            '../../../../../../lib/html': 124,
            '../../../../../data/model/domain/url': 85
        }
    ],
    93: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var UpdateSource = function () {
                function UpdateSource(documents) {
                    this.documents = documents;
                    void Object.freeze(this.documents);
                    void Object.freeze(this);
                }
                return UpdateSource;
            }();
            exports.UpdateSource = UpdateSource;
        },
        {}
    ],
    94: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var either_1 = require('spica/either');
            var xhr_1 = require('../module/fetch/xhr');
            var error_1 = require('../../data/error');
            var url_1 = require('../../../../lib/url');
            function fetch(_a, _b, process) {
                var method = _a.method, url = _a.url, data = _a.data;
                var _c = _b.fetch, timeout = _c.timeout, wait = _c.wait, sequence = _b.sequence;
                return __awaiter(this, void 0, void 0, function () {
                    var req, _a, res, seq;
                    return __generator(this, function (_b) {
                        switch (_b.label) {
                        case 0:
                            req = xhr_1.xhr(method, url, data, timeout, process);
                            void window.dispatchEvent(new Event('pjax:fetch'));
                            return [
                                4,
                                Promise.all([
                                    req,
                                    sequence.fetch(void 0, {
                                        host: '',
                                        path: new url_1.URL(url).path,
                                        method: method,
                                        data: data
                                    }),
                                    new Promise(function (resolve) {
                                        return void setTimeout(resolve, wait);
                                    })
                                ])
                            ];
                        case 1:
                            _a = __read.apply(void 0, [
                                _b.sent(),
                                2
                            ]), res = _a[0], seq = _a[1];
                            return [
                                2,
                                res.bind(process.either).bind(function (result) {
                                    return result.response.url === '' || new url_1.URL(result.response.url).origin === new url_1.URL(url).origin ? either_1.Right([
                                        result,
                                        seq
                                    ]) : either_1.Left(new error_1.DomainError('Request is redirected to the different domain url ' + new url_1.URL(result.response.url).href));
                                })
                            ];
                        }
                    });
                });
            }
            exports.fetch = fetch;
        },
        {
            '../../../../lib/url': 126,
            '../../data/error': 88,
            '../module/fetch/xhr': 95,
            'spica/either': 8
        }
    ],
    95: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var sequence_1 = require('spica/sequence');
            var either_1 = require('spica/either');
            var fetch_1 = require('../../model/eav/value/fetch');
            var error_1 = require('../../../data/error');
            var ContentType = 'text/html';
            function xhr(method, url, data, timeout, cancellation) {
                var xhr = new XMLHttpRequest();
                return new Promise(function (resolve) {
                    return void xhr.open(method, url, true), xhr.responseType = /chrome|firefox/i.test(window.navigator.userAgent) && !/edge/i.test(window.navigator.userAgent) ? 'document' : 'text', xhr.timeout = timeout, void xhr.setRequestHeader('X-Pjax', '1'), void xhr.send(data), void xhr.addEventListener('abort', function () {
                        return void resolve(either_1.Left(new error_1.DomainError('Failed to request by abort.')));
                    }), void xhr.addEventListener('error', function () {
                        return void resolve(either_1.Left(new error_1.DomainError('Failed to request by error.')));
                    }), void xhr.addEventListener('timeout', function () {
                        return void resolve(either_1.Left(new error_1.DomainError('Failed to request by timeout.')));
                    }), void xhr.addEventListener('load', function () {
                        return void verify(xhr).extract(function (err) {
                            return void resolve(either_1.Left(err));
                        }, function (xhr) {
                            return void resolve(either_1.Right(new fetch_1.FetchResult(xhr)));
                        });
                    }), void cancellation.register(function () {
                        return void xhr.abort();
                    });
                });
            }
            exports.xhr = xhr;
            function verify(xhr) {
                return either_1.Right(xhr).bind(function (xhr) {
                    return /2..|304/.test('' + xhr.status) ? either_1.Right(xhr) : either_1.Left(new error_1.DomainError('Faild to validate a content type of response.'));
                }).bind(function (xhr) {
                    return match(xhr.getResponseHeader('Content-Type'), ContentType) ? either_1.Right(xhr) : either_1.Left(new error_1.DomainError('Faild to validate a content type of response.'));
                });
            }
            function match(actualContentType, expectedContentType) {
                return sequence_1.Sequence.intersect(sequence_1.Sequence.from(parse(actualContentType || '').sort()), sequence_1.Sequence.from(parse(expectedContentType).sort()), function (a, b) {
                    return a.localeCompare(b);
                }).take(1).extract().length > 0;
                function parse(headerValue) {
                    return headerValue.split(';').map(function (type) {
                        return type.trim();
                    }).filter(function (type) {
                        return type.length > 0;
                    });
                }
            }
            exports.match = match;
        },
        {
            '../../../data/error': 88,
            '../../model/eav/value/fetch': 92,
            'spica/either': 8,
            'spica/sequence': 68
        }
    ],
    96: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var either_1 = require('spica/either');
            var hlist_1 = require('spica/hlist');
            var router_1 = require('../../event/router');
            var update_1 = require('../model/eav/value/update');
            var blur_1 = require('../module/update/blur');
            var url_1 = require('../module/update/url');
            var title_1 = require('../module/update/title');
            var head_1 = require('../module/update/head');
            var content_1 = require('../module/update/content');
            var css_1 = require('../module/update/css');
            var script_1 = require('../module/update/script');
            var focus_1 = require('../module/update/focus');
            var scroll_1 = require('../module/update/scroll');
            var path_1 = require('../../store/path');
            var error_1 = require('../../data/error');
            function update(_a, _b, seq, io) {
                var event = _a.event, config = _a.config, state = _a.state;
                var response = _b.response;
                return __awaiter(this, void 0, void 0, function () {
                    var _this = this;
                    var process, documents;
                    return __generator(this, function (_a) {
                        process = state.process;
                        documents = new update_1.UpdateSource({
                            src: response.document,
                            dst: io.document
                        }).documents;
                        return [
                            2,
                            new hlist_1.HNil().push(process.either(seq)).modify(function (m) {
                                return m.fmap(function (seq) {
                                    return content_1.separate(documents, config.areas).fmap(function (_a) {
                                        var _b = __read(_a, 1), area = _b[0];
                                        return void config.rewrite(documents.src, area, '');
                                    }).extract(function () {
                                        return __awaiter(_this, void 0, void 0, function () {
                                            return __generator(this, function (_a) {
                                                return [
                                                    2,
                                                    either_1.Left(new error_1.DomainError('Failed to separate areas.'))
                                                ];
                                            });
                                        });
                                    }, function () {
                                        return __awaiter(_this, void 0, void 0, function () {
                                            var _a, _b;
                                            return __generator(this, function (_c) {
                                                switch (_c.label) {
                                                case 0:
                                                    void window.dispatchEvent(new Event('pjax:unload'));
                                                    _b = (_a = process).either;
                                                    return [
                                                        4,
                                                        config.sequence.unload(seq, response)
                                                    ];
                                                case 1:
                                                    return [
                                                        2,
                                                        _b.apply(_a, [_c.sent()])
                                                    ];
                                                }
                                            });
                                        });
                                    });
                                });
                            }).modify(function (m) {
                                return m.fmap(function (p) {
                                    return __awaiter(_this, void 0, void 0, function () {
                                        var _this = this;
                                        return __generator(this, function (_a) {
                                            switch (_a.label) {
                                            case 0:
                                                return [
                                                    4,
                                                    p
                                                ];
                                            case 1:
                                                return [
                                                    2,
                                                    _a.sent().fmap(function (seq) {
                                                        return new hlist_1.HNil().extend(function () {
                                                            return __awaiter(_this, void 0, void 0, function () {
                                                                return __generator(this, function (_a) {
                                                                    return [
                                                                        2,
                                                                        (void blur_1.blur(documents.dst), void url_1.url(new router_1.RouterEventLocation(response.url || event.location.dest.href), documents.src.title, event.type, event.source, config.replace), void title_1.title(documents), void path_1.saveTitle(), void head_1.head({
                                                                            src: documents.src.head,
                                                                            dst: documents.dst.head
                                                                        }, config.update.head, config.update.ignore), content_1.content(documents, config.areas).fmap(function (_a) {
                                                                            var _b = __read(_a, 2), as = _b[0], ps = _b[1];
                                                                            return [
                                                                                as,
                                                                                Promise.all(ps)
                                                                            ];
                                                                        }).fmap(process.either).extract(function () {
                                                                            return either_1.Left(new error_1.DomainError('Failed to update areas.'));
                                                                        }))
                                                                    ];
                                                                });
                                                            });
                                                        }).extend(function (p) {
                                                            return __awaiter(_this, void 0, void 0, function () {
                                                                var _this = this;
                                                                return __generator(this, function (_a) {
                                                                    switch (_a.label) {
                                                                    case 0:
                                                                        return [
                                                                            4,
                                                                            p
                                                                        ];
                                                                    case 1:
                                                                        return [
                                                                            2,
                                                                            _a.sent().fmap(function (_a) {
                                                                                var _b = __read(_a, 1), areas = _b[0];
                                                                                return Promise.all(new hlist_1.HNil().extend(function () {
                                                                                    return __awaiter(_this, void 0, void 0, function () {
                                                                                        var _a;
                                                                                        return __generator(this, function (_b) {
                                                                                            switch (_b.label) {
                                                                                            case 0:
                                                                                                config.update.css ? void css_1.css({
                                                                                                    src: documents.src.head,
                                                                                                    dst: documents.dst.head
                                                                                                }, config.update.ignore) : void 0, config.update.css ? void css_1.css({
                                                                                                    src: documents.src.body,
                                                                                                    dst: documents.dst.body
                                                                                                }, config.update.ignore) : void 0, void focus_1.focus(documents.dst), void scroll_1.scroll(event.type, documents.dst, {
                                                                                                    hash: event.location.dest.fragment,
                                                                                                    position: io.position
                                                                                                }), void path_1.savePosition();
                                                                                                if (!config.update.script)
                                                                                                    return [
                                                                                                        3,
                                                                                                        2
                                                                                                    ];
                                                                                                return [
                                                                                                    4,
                                                                                                    script_1.script(documents, state.scripts, config.update, Math.max(config.fetch.timeout * 10, 10 * 1000), process)
                                                                                                ];
                                                                                            case 1:
                                                                                                _a = _b.sent();
                                                                                                return [
                                                                                                    3,
                                                                                                    4
                                                                                                ];
                                                                                            case 2:
                                                                                                return [
                                                                                                    4,
                                                                                                    process.either([
                                                                                                        [],
                                                                                                        Promise.resolve([])
                                                                                                    ])
                                                                                                ];
                                                                                            case 3:
                                                                                                _a = _b.sent();
                                                                                                _b.label = 4;
                                                                                            case 4:
                                                                                                return [
                                                                                                    2,
                                                                                                    _a
                                                                                                ];
                                                                                            }
                                                                                        });
                                                                                    });
                                                                                }).extend(function () {
                                                                                    return __awaiter(_this, void 0, void 0, function () {
                                                                                        var _a, _b;
                                                                                        return __generator(this, function (_c) {
                                                                                            switch (_c.label) {
                                                                                            case 0:
                                                                                                void io.document.dispatchEvent(new Event('pjax:ready'));
                                                                                                _b = (_a = process).either;
                                                                                                return [
                                                                                                    4,
                                                                                                    config.sequence.ready(seq, areas)
                                                                                                ];
                                                                                            case 1:
                                                                                                return [
                                                                                                    2,
                                                                                                    _b.apply(_a, [_c.sent()])
                                                                                                ];
                                                                                            }
                                                                                        });
                                                                                    });
                                                                                }).reverse().tuple()).then(function (_a) {
                                                                                    var _b = __read(_a, 2), m1 = _b[0], m2 = _b[1];
                                                                                    return m1.bind(function (ss) {
                                                                                        return m2.fmap(function (seq) {
                                                                                            return [
                                                                                                ss,
                                                                                                seq
                                                                                            ];
                                                                                        });
                                                                                    });
                                                                                });
                                                                            }).extract(either_1.Left)
                                                                        ];
                                                                    }
                                                                });
                                                            });
                                                        }).reverse().tuple();
                                                    })
                                                ];
                                            }
                                        });
                                    });
                                });
                            }).modify(function (m) {
                                return m.fmap(function (p) {
                                    return __awaiter(_this, void 0, void 0, function () {
                                        var _this = this;
                                        return __generator(this, function (_a) {
                                            switch (_a.label) {
                                            case 0:
                                                return [
                                                    4,
                                                    p
                                                ];
                                            case 1:
                                                return [
                                                    2,
                                                    _a.sent().fmap(function (_a) {
                                                        var _b = __read(_a, 2), p1 = _b[0], p2 = _b[1];
                                                        return p2.then(function (m2) {
                                                            return void p1.then(function (m1) {
                                                                return m1.bind(function (_a) {
                                                                    var _b = __read(_a, 2), cp = _b[1];
                                                                    return m2.fmap(function (_a) {
                                                                        var _b = __read(_a, 2), _c = __read(_b[0], 2), sp = _c[1], seq = _b[1];
                                                                        return __awaiter(_this, void 0, void 0, function () {
                                                                            var events;
                                                                            return __generator(this, function (_a) {
                                                                                switch (_a.label) {
                                                                                case 0:
                                                                                    return [
                                                                                        4,
                                                                                        sp
                                                                                    ];
                                                                                case 1:
                                                                                    _a.sent();
                                                                                    return [
                                                                                        4,
                                                                                        cp
                                                                                    ];
                                                                                case 2:
                                                                                    events = _a.sent();
                                                                                    if (process.canceled)
                                                                                        return [2];
                                                                                    void window.dispatchEvent(new Event('pjax:load'));
                                                                                    void config.sequence.load(seq, events);
                                                                                    return [2];
                                                                                }
                                                                            });
                                                                        });
                                                                    });
                                                                }).extract(function () {
                                                                    return void 0;
                                                                });
                                                            }), m2.fmap(function (_a) {
                                                                var _b = __read(_a, 1), _c = __read(_b[0], 2), ss = _c[0], p = _c[1];
                                                                return [
                                                                    ss,
                                                                    p
                                                                ];
                                                            });
                                                        });
                                                    }).extract(either_1.Left)
                                                ];
                                            }
                                        });
                                    });
                                });
                            }).head.extract(either_1.Left)
                        ];
                    });
                });
            }
            exports.update = update;
        },
        {
            '../../data/error': 88,
            '../../event/router': 89,
            '../../store/path': 107,
            '../model/eav/value/update': 93,
            '../module/update/blur': 97,
            '../module/update/content': 98,
            '../module/update/css': 99,
            '../module/update/focus': 100,
            '../module/update/head': 101,
            '../module/update/script': 102,
            '../module/update/scroll': 103,
            '../module/update/title': 105,
            '../module/update/url': 106,
            'spica/either': 8,
            'spica/hlist': 12
        }
    ],
    97: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function blur(document) {
                if (document !== window.document || document.activeElement === document.body)
                    return;
                void document.activeElement.blur();
                void document.body.focus();
            }
            exports.blur = blur;
        },
        {}
    ],
    98: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var maybe_1 = require('spica/maybe');
            var concat_1 = require('spica/concat');
            var typed_dom_1 = require('typed-dom');
            var dom_1 = require('../../../../../lib/dom');
            var script_1 = require('./script');
            function content(documents, areas, io) {
                if (io === void 0) {
                    io = {
                        replace: function (src, dst) {
                            return void dst.parentNode.replaceChild(src, dst);
                        }
                    };
                }
                return separate(documents, areas).fmap(function (_a) {
                    var _b = __read(_a, 2), areas = _b[1];
                    return [
                        areas.map(function (a) {
                            return a.dst;
                        }).reduce(concat_1.concat, []),
                        areas.map(load).reduce(concat_1.concat, [])
                    ];
                });
                function load(area) {
                    return area.src.map(function (_, i) {
                        return {
                            src: documents.dst.importNode(area.src[i].cloneNode(true), true),
                            dst: area.dst[i]
                        };
                    }).map(function (area) {
                        return void replace(area), dom_1.find(area.src, 'img, iframe, frame').map(wait);
                    }).reduce(concat_1.concat, []);
                    function replace(area) {
                        var unescape = dom_1.find(area.src, 'script').map(script_1.escape).reduce(function (f, g) {
                            return function () {
                                return void f(), void g();
                            };
                        }, function () {
                            return void 0;
                        });
                        void io.replace(area.src, area.dst);
                        void unescape();
                    }
                }
            }
            exports.content = content;
            function separate(documents, areas) {
                return areas.reduce(function (m, area) {
                    return maybe_1.Maybe.mplus(m, sep(documents, area).fmap(function (as) {
                        return [
                            area,
                            as
                        ];
                    }));
                }, maybe_1.Nothing);
                function sep(documents, area) {
                    return split(area).reduce(function (acc, area) {
                        return acc.bind(function (as) {
                            return pair(area).fmap(function (a) {
                                return concat_1.concat(as, [a]);
                            });
                        });
                    }, maybe_1.Just([]));
                    function pair(area) {
                        return maybeValid(cons(area));
                        function maybeValid(area) {
                            return validate(area) ? maybe_1.Just(area) : maybe_1.Nothing;
                            function validate(area) {
                                return area.src.length > 0 && area.src.length === area.dst.length;
                            }
                        }
                        function cons(area) {
                            return {
                                src: dom_1.find(documents.src, area),
                                dst: dom_1.find(documents.dst, area)
                            };
                        }
                    }
                }
            }
            exports.separate = separate;
            function split(area) {
                return (area.match(/(?:[^,\(\[]+|\(.*?\)|\[.*?\])+/g) || []).map(function (a) {
                    return a.trim();
                });
            }
            exports._split = split;
            function wait(el) {
                return Promise.race([
                    new Promise(function (resolve) {
                        return void typed_dom_1.once(el, 'load', resolve);
                    }),
                    new Promise(function (resolve) {
                        return void typed_dom_1.once(el, 'abort', resolve);
                    }),
                    new Promise(function (resolve) {
                        return void typed_dom_1.once(el, 'error', resolve);
                    })
                ]);
            }
            exports._wait = wait;
        },
        {
            '../../../../../lib/dom': 122,
            './script': 102,
            'spica/concat': 6,
            'spica/maybe': 13,
            'typed-dom': 74
        }
    ],
    99: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var dom_1 = require('../../../../../lib/dom');
            var sync_1 = require('./sync');
            function css(scope, ignore) {
                var selector = 'link[rel~="stylesheet"], style';
                return void sync_1.sync(sync_1.pair(dom_1.find(scope.src, selector).filter(function (el) {
                    return !el.matches(ignore.trim() || '_');
                }), dom_1.find(scope.dst, selector).filter(function (el) {
                    return !el.matches(ignore.trim() || '_');
                }), compare), scope.dst);
            }
            exports.css = css;
            function compare(a, b) {
                switch (a.tagName.toLowerCase()) {
                case 'link':
                    return a.href === b.href;
                case 'style':
                    return a.innerHTML.trim() === b.innerHTML.trim();
                default:
                    return false;
                }
            }
        },
        {
            '../../../../../lib/dom': 122,
            './sync': 104
        }
    ],
    100: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var dom_1 = require('../../../../../lib/dom');
            function focus(document) {
                return void dom_1.find(document, 'body, [autofocus]').slice(-1).filter(function (el) {
                    return document === window.document && el !== document.activeElement;
                }).forEach(function (el) {
                    return void el.focus();
                });
            }
            exports.focus = focus;
        },
        { '../../../../../lib/dom': 122 }
    ],
    101: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var sync_1 = require('./sync');
            var dom_1 = require('../../../../../lib/dom');
            function head(scope, selector, ignore) {
                ignore += selector.indexOf('link') > -1 ? ', link[rel~="stylesheet"]' : '';
                return void sync_1.sync(sync_1.pair(dom_1.find(scope.src, selector).filter(function (el) {
                    return !el.matches(ignore.trim() || '_');
                }), dom_1.find(scope.dst, selector).filter(function (el) {
                    return !el.matches(ignore.trim() || '_');
                }), compare), scope.dst);
            }
            exports.head = head;
            function compare(a, b) {
                return a.outerHTML === b.outerHTML;
            }
        },
        {
            '../../../../../lib/dom': 122,
            './sync': 104
        }
    ],
    102: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var either_1 = require('spica/either');
            var dom_1 = require('../../../../../lib/dom');
            var error_1 = require('../../../../../lib/error');
            var url_1 = require('../../../../../lib/url');
            var url_2 = require('../../../../data/model/domain/url');
            function script(documents, skip, selector, timeout, cancellation, io) {
                if (io === void 0) {
                    io = {
                        fetch: fetch,
                        evaluate: evaluate
                    };
                }
                return __awaiter(this, void 0, void 0, function () {
                    function request(scripts) {
                        return scripts.map(function (script) {
                            return io.fetch(script, timeout);
                        });
                    }
                    function run(responses) {
                        return responses.reduce(function (results, m) {
                            return m.bind(function () {
                                return results;
                            });
                        }, responses.reduce(function (results, m) {
                            return results.bind(cancellation.either).bind(function (_a) {
                                var _b = __read(_a, 2), ss = _b[0], ps = _b[1];
                                return m.fmap(function (_a) {
                                    var _b = __read(_a, 2), script = _b[0], code = _b[1];
                                    return io.evaluate(script, code, selector.logger, skip, Promise.all(ps), cancellation);
                                }).bind(function (m) {
                                    return m.extract(function (m) {
                                        return m.fmap(function (s) {
                                            return [
                                                ss.concat([s]),
                                                ps
                                            ];
                                        });
                                    }, function (p) {
                                        return either_1.Right([
                                            ss,
                                            ps.concat([p])
                                        ]);
                                    });
                                });
                            });
                        }, either_1.Right([
                            [],
                            []
                        ]))).fmap(function (_a) {
                            var _b = __read(_a, 2), ss = _b[0], ps = _b[1];
                            return [
                                ss,
                                Promise.all(ps).then(function (ms) {
                                    return ms.reduce(function (acc, m) {
                                        return acc.bind(function (scripts) {
                                            return m.fmap(function (script) {
                                                return scripts.concat([script]);
                                            });
                                        });
                                    }, either_1.Right([])).extract();
                                })
                            ];
                        });
                    }
                    var scripts, _a;
                    return __generator(this, function (_b) {
                        switch (_b.label) {
                        case 0:
                            scripts = dom_1.find(documents.src, 'script').filter(function (el) {
                                return !el.type || /(?:application|text)\/(?:java|ecma)script|module/i.test(el.type);
                            }).filter(function (el) {
                                return !el.matches(selector.ignore.trim() || '_');
                            }).filter(function (el) {
                                return el.hasAttribute('src') ? !skip.has(new url_1.URL(url_2.standardizeUrl(el.src)).href) || el.matches(selector.reload.trim() || '_') : true;
                            });
                            _a = run;
                            return [
                                4,
                                Promise.all(request(scripts))
                            ];
                        case 1:
                            return [
                                2,
                                _a.apply(void 0, [_b.sent()])
                            ];
                        }
                    });
                });
            }
            exports.script = script;
            function fetch(script, timeout) {
                return __awaiter(this, void 0, void 0, function () {
                    var xhr_1;
                    return __generator(this, function (_a) {
                        if (script.hasAttribute('src')) {
                            if (script.type.toLowerCase() === 'module')
                                return [
                                    2,
                                    either_1.Right([
                                        script,
                                        ''
                                    ])
                                ];
                            xhr_1 = new XMLHttpRequest();
                            void xhr_1.open('GET', script.src, true);
                            xhr_1.timeout = timeout;
                            void xhr_1.send();
                            return [
                                2,
                                new Promise(function (resolve) {
                                    return [
                                        'load',
                                        'abort',
                                        'error',
                                        'timeout'
                                    ].forEach(function (type) {
                                        switch (type) {
                                        case 'load':
                                            return void xhr_1.addEventListener(type, function () {
                                                return void resolve(either_1.Right([
                                                    script,
                                                    xhr_1.response
                                                ]));
                                            });
                                        default:
                                            return void xhr_1.addEventListener(type, function () {
                                                return void resolve(either_1.Left(new Error(script.src + ': ' + xhr_1.statusText)));
                                            });
                                        }
                                    });
                                })
                            ];
                        } else {
                            return [
                                2,
                                either_1.Right([
                                    script,
                                    script.text
                                ])
                            ];
                        }
                        return [2];
                    });
                });
            }
            exports._fetch = fetch;
            function evaluate(script, code, logger, skip, wait, cancellation) {
                script = script.ownerDocument === document ? script : document.importNode(script.cloneNode(true), true);
                var logging = !!script.parentElement && script.parentElement.matches(logger.trim() || '_');
                var container = document.querySelector(logging ? script.parentElement.id ? '#' + script.parentElement.id : script.parentElement.tagName : '_') || document.body;
                var unescape = escape(script);
                void container.appendChild(script);
                void unescape();
                !logging && void script.remove();
                var url = new url_1.URL(url_2.standardizeUrl(window.location.href));
                if (script.type.toLowerCase() === 'module') {
                    return either_1.Right(wait.then(function () {
                        return Promise.resolve().then(function () {
                            return require(script.src);
                        });
                    }).then(function () {
                        return void script.dispatchEvent(new Event('load')), either_1.Right(script);
                    }, function (reason) {
                        return void script.dispatchEvent(new Event('error')), either_1.Left(new error_1.FatalError(reason instanceof Error ? reason.message : reason + ''));
                    }));
                } else {
                    if (script.hasAttribute('defer'))
                        return either_1.Right(wait.then(evaluate));
                    if (script.hasAttribute('async'))
                        return either_1.Right(Promise.resolve().then(evaluate));
                    return either_1.Left(evaluate());
                }
                function evaluate() {
                    if (cancellation.canceled)
                        return cancellation.either(script);
                    try {
                        if (new url_1.URL(url_2.standardizeUrl(window.location.href)).path !== url.path)
                            throw new error_1.FatalError('Expired.');
                        if (skip.has(new url_1.URL(url_2.standardizeUrl(window.location.href)).href))
                            throw new error_1.FatalError('Expired.');
                        void (0, eval)(code);
                        script.hasAttribute('src') && void script.dispatchEvent(new Event('load'));
                        return either_1.Right(script);
                    } catch (reason) {
                        script.hasAttribute('src') && void script.dispatchEvent(new Event('error'));
                        return either_1.Left(new error_1.FatalError(reason instanceof Error ? reason.message : reason + ''));
                    }
                }
            }
            exports._evaluate = evaluate;
            function escape(script) {
                var src = script.hasAttribute('src') ? script.getAttribute('src') : null;
                var code = script.text;
                void script.removeAttribute('src');
                script.text = '';
                return function () {
                    return script.text = ' ', script.text = code, typeof src === 'string' ? void script.setAttribute('src', src) : void 0;
                };
            }
            exports.escape = escape;
        },
        {
            '../../../../../lib/dom': 122,
            '../../../../../lib/error': 123,
            '../../../../../lib/url': 126,
            '../../../../data/model/domain/url': 85,
            'spica/either': 8
        }
    ],
    103: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var router_1 = require('../../../event/router');
            function scroll(type, document, env, io) {
                if (io === void 0) {
                    io = {
                        scroll: window.scrollTo,
                        hash: hash
                    };
                }
                switch (type) {
                case router_1.RouterEventType.click:
                    if (io.hash(document, env.hash, io))
                        return;
                    return void scroll({
                        top: 0,
                        left: 0
                    });
                case router_1.RouterEventType.submit:
                    return void scroll({
                        top: 0,
                        left: 0
                    });
                case router_1.RouterEventType.popstate:
                    return void scroll(env.position());
                default:
                    throw new TypeError(type);
                }
                function scroll(_a) {
                    var top = _a.top, left = _a.left;
                    void io.scroll.call(window, left, top);
                }
            }
            exports.scroll = scroll;
            function hash(document, hash, io) {
                if (io === void 0) {
                    io = { scroll: window.scrollTo };
                }
                var index = hash.slice(1);
                if (index.length === 0)
                    return false;
                var el = document.getElementById(index) || document.getElementsByName(index)[0];
                if (!el)
                    return false;
                void io.scroll.call(window, window.pageXOffset, window.pageYOffset + el.getBoundingClientRect().top | 0);
                return true;
            }
            exports._hash = hash;
        },
        { '../../../event/router': 89 }
    ],
    104: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var either_1 = require('spica/either');
            var concat_1 = require('spica/concat');
            function sync(pairs, fallback, io) {
                if (io === void 0) {
                    io = {
                        before: before,
                        remove: remove
                    };
                }
                return void pairs.forEach(function (_a) {
                    var _b = __read(_a, 2), srcs = _b[0], dst = _b[1];
                    return void io.before(parent(dst), srcs.slice(-1).some(function (src) {
                        return !!dst && src.outerHTML === dst.outerHTML;
                    }) ? srcs.slice(0, -1) : srcs, dst), dst && srcs.length === 0 ? void io.remove(dst) : void 0;
                });
                function parent(dst) {
                    return dst ? dst.parentElement : fallback;
                }
            }
            exports.sync = sync;
            function pair(srcs, dsts, compare) {
                var link = bind(srcs, dsts, compare);
                void dsts.filter(function (dst) {
                    return !link.has(dst);
                }).forEach(function (dst) {
                    return void link.set(dst, []);
                });
                return __spread(link).map(function (_a) {
                    var _b = __read(_a, 2), dst = _b[0], srcs = _b[1];
                    return [
                        srcs,
                        dst
                    ];
                });
                function bind(srcs, dsts, compare) {
                    return srcs.reduce(function (link, src) {
                        return dsts.length === 0 ? link.set(null, concat_1.concat(link.get(null) || [], [src])) : dsts.reduce(function (m, dst) {
                            return m.bind(function (link) {
                                return !link.has(dst) && compare(src, dst) ? (void link.set(dst, concat_1.concat(link.get(null) || [], [src])), void link.delete(null), either_1.Left(link)) : either_1.Right(link);
                            });
                        }, either_1.Right(link)).fmap(function (link) {
                            return link.set(null, concat_1.concat(link.get(null) || [], [src]));
                        }).extract(function (link) {
                            return link;
                        });
                    }, new Map());
                }
            }
            exports.pair = pair;
            function before(parent, children, ref) {
                return void children.map(function (child) {
                    return parent.ownerDocument.importNode(child.cloneNode(true), true);
                }).forEach(function (child) {
                    return void parent.insertBefore(child, ref);
                });
            }
            function remove(el) {
                return void el.remove();
            }
        },
        {
            'spica/concat': 6,
            'spica/either': 8
        }
    ],
    105: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            function title(documents) {
                documents.dst.title = documents.src.title;
            }
            exports.title = title;
        },
        {}
    ],
    106: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var router_1 = require('../../../event/router');
            var typed_dom_1 = require('typed-dom');
            void typed_dom_1.bind(document, 'pjax:ready', function () {
                return void window.history.replaceState(window.history.state, window.document.title);
            });
            function url(location, title, type, source, replaceable) {
                switch (true) {
                case isReplaceable(type, source, replaceable):
                    return void window.history.replaceState({}, title, location.dest.href);
                case isRegisterable(type, location):
                    return void window.history.pushState({}, title, location.dest.href);
                default:
                    return void window.history.replaceState(window.history.state, window.document.title);
                }
            }
            exports.url = url;
            function isRegisterable(type, location) {
                if (location.dest.href === location.orig.href)
                    return false;
                switch (type) {
                case router_1.RouterEventType.click:
                case router_1.RouterEventType.submit:
                    return true;
                case router_1.RouterEventType.popstate:
                    return false;
                default:
                    throw new TypeError(type);
                }
            }
            exports._isRegisterable = isRegisterable;
            function isReplaceable(type, source, selector) {
                switch (type) {
                case router_1.RouterEventType.click:
                case router_1.RouterEventType.submit:
                    return source.matches(selector.trim() || '_');
                case router_1.RouterEventType.popstate:
                    return false;
                default:
                    throw new TypeError(type);
                }
            }
            exports._isReplaceable = isReplaceable;
        },
        {
            '../../../event/router': 89,
            'typed-dom': 74
        }
    ],
    107: [
        function (require, module, exports) {
            'use strict';
            function __export(m) {
                for (var p in m)
                    if (!exports.hasOwnProperty(p))
                        exports[p] = m[p];
            }
            Object.defineProperty(exports, '__esModule', { value: true });
            __export(require('../../data/store/state'));
        },
        { '../../data/store/state': 86 }
    ],
    108: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var error_1 = require('../../../lib/error');
            var InterfaceError = function (_super) {
                __extends(InterfaceError, _super);
                function InterfaceError(msg) {
                    return _super.call(this, 'Interface: ' + msg) || this;
                }
                return InterfaceError;
            }(error_1.PjaxError);
            exports.InterfaceError = InterfaceError;
        },
        { '../../../lib/error': 123 }
    ],
    109: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var supervisor_1 = require('spica/supervisor');
            var typed_dom_1 = require('typed-dom');
            var ClickView = function () {
                function ClickView(document, selector, listener) {
                    var _this = this;
                    this.sv = new (function (_super) {
                        __extends(class_1, _super);
                        function class_1() {
                            return _super !== null && _super.apply(this, arguments) || this;
                        }
                        return class_1;
                    }(supervisor_1.Supervisor))();
                    this.close = function () {
                        return void _this.sv.terminate();
                    };
                    void this.sv.register('', function () {
                        return void _this.sv.events.exit.monitor([], typed_dom_1.delegate(document, selector, 'click', function (ev) {
                            if (!(ev.currentTarget instanceof HTMLAnchorElement))
                                return;
                            if (typeof ev.currentTarget.href !== 'string')
                                return;
                            void listener(ev);
                        })), new Promise(function () {
                            return void 0;
                        });
                    }, void 0);
                    void this.sv.cast('', void 0);
                }
                return ClickView;
            }();
            exports.ClickView = ClickView;
        },
        {
            'spica/supervisor': 70,
            'typed-dom': 74
        }
    ],
    110: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var supervisor_1 = require('spica/supervisor');
            var typed_dom_1 = require('typed-dom');
            var url_1 = require('../../../data/model/domain/url');
            var url_2 = require('../../service/state/url');
            var NavigationView = function () {
                function NavigationView(window, listener) {
                    var _this = this;
                    this.sv = new (function (_super) {
                        __extends(class_1, _super);
                        function class_1() {
                            return _super !== null && _super.apply(this, arguments) || this;
                        }
                        return class_1;
                    }(supervisor_1.Supervisor))();
                    this.close = function () {
                        return void _this.sv.terminate();
                    };
                    void this.sv.register('', function () {
                        return void _this.sv.events.exit.monitor([], typed_dom_1.bind(window, 'popstate', function (ev) {
                            if (url_1.standardizeUrl(window.location.href) === url_2.docurl.href)
                                return;
                            void listener(ev);
                        })), new Promise(function () {
                            return void 0;
                        });
                    }, void 0);
                    void this.sv.cast('', void 0);
                }
                return NavigationView;
            }();
            exports.NavigationView = NavigationView;
        },
        {
            '../../../data/model/domain/url': 85,
            '../../service/state/url': 121,
            'spica/supervisor': 70,
            'typed-dom': 74
        }
    ],
    111: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var supervisor_1 = require('spica/supervisor');
            var typed_dom_1 = require('typed-dom');
            var ScrollView = function () {
                function ScrollView(window, listener) {
                    var _this = this;
                    this.sv = new (function (_super) {
                        __extends(class_1, _super);
                        function class_1() {
                            return _super !== null && _super.apply(this, arguments) || this;
                        }
                        return class_1;
                    }(supervisor_1.Supervisor))();
                    this.close = function () {
                        return void _this.sv.terminate();
                    };
                    var timer = 0;
                    void this.sv.register('', function () {
                        return void _this.sv.events.exit.monitor([], typed_dom_1.bind(window, 'scroll', function (ev) {
                            return timer = timer > 0 ? timer : setTimeout(function () {
                                timer = 0;
                                void listener(ev);
                            }, 300);
                        }, { passive: true })), new Promise(function () {
                            return void 0;
                        });
                    }, void 0);
                    void this.sv.cast('', void 0);
                }
                return ScrollView;
            }();
            exports.ScrollView = ScrollView;
        },
        {
            'spica/supervisor': 70,
            'typed-dom': 74
        }
    ],
    112: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var supervisor_1 = require('spica/supervisor');
            var typed_dom_1 = require('typed-dom');
            var SubmitView = function () {
                function SubmitView(document, selector, listener) {
                    var _this = this;
                    this.sv = new (function (_super) {
                        __extends(class_1, _super);
                        function class_1() {
                            return _super !== null && _super.apply(this, arguments) || this;
                        }
                        return class_1;
                    }(supervisor_1.Supervisor))();
                    this.close = function () {
                        return void _this.sv.terminate();
                    };
                    void this.sv.register('', function () {
                        return void _this.sv.events.exit.monitor([], typed_dom_1.delegate(document, selector, 'submit', function (ev) {
                            if (!(ev.currentTarget instanceof HTMLFormElement))
                                return;
                            void listener(ev);
                        })), new Promise(function () {
                            return void 0;
                        });
                    }, void 0);
                    void this.sv.cast('', void 0);
                }
                return SubmitView;
            }();
            exports.SubmitView = SubmitView;
        },
        {
            'spica/supervisor': 70,
            'typed-dom': 74
        }
    ],
    113: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var assign_1 = require('spica/assign');
            var typed_dom_1 = require('typed-dom');
            var api_1 = require('../../application/api');
            var process_1 = require('./state/process');
            var router_1 = require('./router');
            var html_1 = require('../../../lib/html');
            var API = function () {
                function API() {
                }
                API.assign = function (url, option, io) {
                    if (io === void 0) {
                        io = { document: window.document };
                    }
                    return void click(url, function (event) {
                        return void router_1.route(new api_1.Config(option), event, process_1.process, io);
                    });
                };
                API.replace = function (url, option, io) {
                    if (io === void 0) {
                        io = { document: window.document };
                    }
                    return void click(url, function (event) {
                        return void router_1.route(new api_1.Config(assign_1.extend({}, option, { replace: '*' })), event, process_1.process, io);
                    });
                };
                return API;
            }();
            exports.API = API;
            function click(url, callback) {
                var el = document.createElement('a');
                el.href = url;
                void html_1.parse('').extract().body.appendChild(el);
                void typed_dom_1.once(el, 'click', callback);
                void el.click();
            }
        },
        {
            '../../../lib/html': 124,
            '../../application/api': 81,
            './router': 116,
            './state/process': 118,
            'spica/assign': 3,
            'typed-dom': 74
        }
    ],
    114: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var api_1 = require('./api');
            var supervisor_1 = require('spica/supervisor');
            var cancellation_1 = require('spica/cancellation');
            var maybe_1 = require('spica/maybe');
            var api_2 = require('../../application/api');
            var url_1 = require('../../../lib/url');
            var url_2 = require('../../data/model/domain/url');
            var click_1 = require('../module/view/click');
            var submit_1 = require('../module/view/submit');
            var navigation_1 = require('../module/view/navigation');
            var scroll_1 = require('../module/view/scroll');
            var url_3 = require('./state/url');
            require('./state/scroll-restoration');
            var process_1 = require('./state/process');
            var router_1 = require('./router');
            var api_3 = require('../../application/api');
            var view = new (function (_super) {
                __extends(class_1, _super);
                function class_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return class_1;
            }(supervisor_1.Supervisor))();
            var GUI = function (_super) {
                __extends(GUI, _super);
                function GUI(option, io) {
                    if (io === void 0) {
                        io = { document: window.document };
                    }
                    var _this = _super.call(this) || this;
                    _this.option = option;
                    _this.io = io;
                    var config = new api_2.Config(_this.option);
                    void view.kill('');
                    void view.register('', {
                        init: function (s) {
                            return s;
                        },
                        call: function (_, s) {
                            return void s.register(new click_1.ClickView(_this.io.document, config.link, function (event) {
                                return void maybe_1.Just(new url_1.URL(url_2.standardizeUrl(event.currentTarget.href))).bind(function (url) {
                                    return isAccessible(url) && !isHashClick(url) && !isHashChange(url) && !hasModifierKey(event) && config.filter(event.currentTarget) ? maybe_1.Just(0) : maybe_1.Nothing;
                                }).fmap(function () {
                                    return router_1.route(config, event, process_1.process, _this.io);
                                }).extract(url_3.docurl.sync);
                            }).close), void s.register(new submit_1.SubmitView(_this.io.document, config.form, function (event) {
                                return void maybe_1.Just(new url_1.URL(url_2.standardizeUrl(event.currentTarget.action))).bind(function (url) {
                                    return isAccessible(url) ? maybe_1.Just(0) : maybe_1.Nothing;
                                }).fmap(function () {
                                    return router_1.route(config, event, process_1.process, _this.io);
                                }).extract(url_3.docurl.sync);
                            }).close), void s.register(new navigation_1.NavigationView(window, function (event) {
                                return void maybe_1.Just(new url_1.URL(url_2.standardizeUrl(window.location.href))).bind(function (url) {
                                    return isAccessible(url) && !isHashChange(url) ? maybe_1.Just(0) : maybe_1.Nothing;
                                }).fmap(function () {
                                    return router_1.route(config, event, process_1.process, _this.io);
                                }).extract(url_3.docurl.sync);
                            }).close), void s.register(new scroll_1.ScrollView(window, function () {
                                return void maybe_1.Just(new url_1.URL(url_2.standardizeUrl(window.location.href))).fmap(function (url) {
                                    return url.href === url_3.docurl.href ? void api_3.savePosition() : void 0;
                                }).extract();
                            }).close), new Promise(function () {
                                return void 0;
                            });
                        },
                        exit: function (_, s) {
                            return void s.cancel();
                        }
                    }, new cancellation_1.Cancellation());
                    void view.cast('', void 0);
                    return _this;
                }
                GUI.prototype.assign = function (url) {
                    return void api_1.API.assign(url, this.option, this.io);
                };
                GUI.prototype.replace = function (url) {
                    return void api_1.API.replace(url, this.option, this.io);
                };
                return GUI;
            }(api_1.API);
            exports.GUI = GUI;
            function hasModifierKey(event) {
                return event.which > 1 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey;
            }
            function isAccessible(dest) {
                var orig = new url_1.URL(url_3.docurl.href);
                return orig.origin === dest.origin;
            }
            function isHashClick(dest) {
                var orig = new url_1.URL(url_3.docurl.href);
                return orig.origin === dest.origin && orig.path === dest.path && dest.fragment !== '';
            }
            function isHashChange(dest) {
                var orig = new url_1.URL(url_3.docurl.href);
                return orig.origin === dest.origin && orig.path === dest.path && orig.fragment !== dest.fragment;
            }
        },
        {
            '../../../lib/url': 126,
            '../../application/api': 81,
            '../../data/model/domain/url': 85,
            '../module/view/click': 109,
            '../module/view/navigation': 110,
            '../module/view/scroll': 111,
            '../module/view/submit': 112,
            './api': 113,
            './router': 116,
            './state/process': 118,
            './state/scroll-restoration': 120,
            './state/url': 121,
            'spica/cancellation': 4,
            'spica/maybe': 13,
            'spica/supervisor': 70
        }
    ],
    115: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var bar = document.createElement('div');
            void window.addEventListener('pjax:fetch', function () {
                return void document.documentElement.appendChild(bar);
            });
            void window.addEventListener('pjax:fetch', function () {
                return bar.style.width = '5%';
            });
            void window.addEventListener('pjax:unload', function () {
                return bar.style.width = '80%';
            });
            void document.addEventListener('pjax:ready', function () {
                return bar.style.width = '90%';
            });
            void window.addEventListener('pjax:load', function () {
                return bar.style.width = '100%';
            });
            void window.addEventListener('pjax:load', function () {
                return void bar.remove();
            });
            function progressbar(style) {
                void bar.setAttribute('style', style);
            }
            exports.progressbar = progressbar;
        },
        {}
    ],
    116: [
        function (require, module, exports) {
            'use strict';
            var __awaiter = this && this.__awaiter || function (thisArg, _arguments, P, generator) {
                return new (P || (P = Promise))(function (resolve, reject) {
                    function fulfilled(value) {
                        try {
                            step(generator.next(value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function rejected(value) {
                        try {
                            step(generator['throw'](value));
                        } catch (e) {
                            reject(e);
                        }
                    }
                    function step(result) {
                        result.done ? resolve(result.value) : new P(function (resolve) {
                            resolve(result.value);
                        }).then(fulfilled, rejected);
                    }
                    step((generator = generator.apply(thisArg, _arguments || [])).next());
                });
            };
            var __generator = this && this.__generator || function (thisArg, body) {
                var _ = {
                        label: 0,
                        sent: function () {
                            if (t[0] & 1)
                                throw t[1];
                            return t[1];
                        },
                        trys: [],
                        ops: []
                    }, f, y, t, g;
                return g = {
                    next: verb(0),
                    'throw': verb(1),
                    'return': verb(2)
                }, typeof Symbol === 'function' && (g[Symbol.iterator] = function () {
                    return this;
                }), g;
                function verb(n) {
                    return function (v) {
                        return step([
                            n,
                            v
                        ]);
                    };
                }
                function step(op) {
                    if (f)
                        throw new TypeError('Generator is already executing.');
                    while (_)
                        try {
                            if (f = 1, y && (t = y[op[0] & 2 ? 'return' : op[0] ? 'throw' : 'next']) && !(t = t.call(y, op[1])).done)
                                return t;
                            if (y = 0, t)
                                op = [
                                    0,
                                    t.value
                                ];
                            switch (op[0]) {
                            case 0:
                            case 1:
                                t = op;
                                break;
                            case 4:
                                _.label++;
                                return {
                                    value: op[1],
                                    done: false
                                };
                            case 5:
                                _.label++;
                                y = op[1];
                                op = [0];
                                continue;
                            case 7:
                                op = _.ops.pop();
                                _.trys.pop();
                                continue;
                            default:
                                if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) {
                                    _ = 0;
                                    continue;
                                }
                                if (op[0] === 3 && (!t || op[1] > t[0] && op[1] < t[3])) {
                                    _.label = op[1];
                                    break;
                                }
                                if (op[0] === 6 && _.label < t[1]) {
                                    _.label = t[1];
                                    t = op;
                                    break;
                                }
                                if (t && _.label < t[2]) {
                                    _.label = t[2];
                                    _.ops.push(op);
                                    break;
                                }
                                if (t[2])
                                    _.ops.pop();
                                _.trys.pop();
                                continue;
                            }
                            op = body.call(thisArg, _);
                        } catch (e) {
                            op = [
                                6,
                                e
                            ];
                            y = 0;
                        } finally {
                            f = t = 0;
                        }
                    if (op[0] & 5)
                        throw op[1];
                    return {
                        value: op[0] ? op[1] : void 0,
                        done: true
                    };
                }
            };
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var cancellation_1 = require('spica/cancellation');
            var typed_dom_1 = require('typed-dom');
            var api_1 = require('../../application/api');
            var url_1 = require('./state/url');
            var env_1 = require('../service/state/env');
            var progressbar_1 = require('./progressbar');
            var error_1 = require('../data/error');
            var api_2 = require('../../application/api');
            var url_2 = require('../../data/model/domain/url');
            var url_3 = require('../../../lib/url');
            void typed_dom_1.bind(window, 'pjax:unload', function () {
                return window.history.scrollRestoration = 'auto';
            }, true);
            function route(config, event, process, io) {
                return __awaiter(this, void 0, void 0, function () {
                    var _this = this;
                    var cancellation, kill, _a, scripts;
                    return __generator(this, function (_b) {
                        switch (_b.label) {
                        case 0:
                            void event.preventDefault();
                            void process.cast('', new error_1.InterfaceError('Abort.'));
                            cancellation = new cancellation_1.Cancellation();
                            kill = process.register('', function (e) {
                                io.document.title = api_2.loadTitle();
                                throw void cancellation.cancel(e);
                            }, void 0);
                            return [
                                4,
                                env_1.env
                            ];
                        case 1:
                            _a = __read.apply(void 0, [
                                _b.sent(),
                                1
                            ]), scripts = _a[0];
                            window.history.scrollRestoration = 'manual';
                            void progressbar_1.progressbar(config.progressbar);
                            return [
                                2,
                                api_1.route(config, event, {
                                    process: cancellation,
                                    scripts: scripts
                                }, io).then(function (m) {
                                    return m.fmap(function (_a) {
                                        var _b = __read(_a, 2), ss = _b[0], p = _b[1];
                                        return __awaiter(_this, void 0, void 0, function () {
                                            return __generator(this, function (_a) {
                                                switch (_a.label) {
                                                case 0:
                                                    void kill(), void url_1.docurl.sync(), void ss.filter(function (s) {
                                                        return s.hasAttribute('src');
                                                    }).forEach(function (s) {
                                                        return void scripts.add(new url_3.URL(url_2.standardizeUrl(s.src)).href);
                                                    });
                                                    return [
                                                        4,
                                                        p
                                                    ];
                                                case 1:
                                                    return [
                                                        2,
                                                        void _a.sent().filter(function (s) {
                                                            return s.hasAttribute('src');
                                                        }).forEach(function (s) {
                                                            return void scripts.add(new url_3.URL(url_2.standardizeUrl(s.src)).href);
                                                        })
                                                    ];
                                                }
                                            });
                                        });
                                    }).extract();
                                }).catch(function (e) {
                                    return void kill(), window.history.scrollRestoration = 'auto', void url_1.docurl.sync(), !cancellation.canceled || e instanceof Error && e.name === 'FatalError' ? void config.fallback(typed_dom_1.currentTargets.get(event), e instanceof Error ? e : new Error(e)) : void 0;
                                })
                            ];
                        }
                    });
                });
            }
            exports.route = route;
        },
        {
            '../../../lib/url': 126,
            '../../application/api': 81,
            '../../data/model/domain/url': 85,
            '../data/error': 108,
            '../service/state/env': 117,
            './progressbar': 115,
            './state/url': 121,
            'spica/cancellation': 4,
            'typed-dom': 74
        }
    ],
    117: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var script_1 = require('./script');
            exports.env = Promise.all([
                script_1.scripts,
                new Promise(setTimeout)
            ]);
        },
        { './script': 119 }
    ],
    118: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var supervisor_1 = require('spica/supervisor');
            exports.process = new (function (_super) {
                __extends(class_1, _super);
                function class_1() {
                    return _super !== null && _super.apply(this, arguments) || this;
                }
                return class_1;
            }(supervisor_1.Supervisor))();
        },
        { 'spica/supervisor': 70 }
    ],
    119: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var url_1 = require('../../../data/model/domain/url');
            var url_2 = require('../../../../lib/url');
            var dom_1 = require('../../../../lib/dom');
            var typed_dom_1 = require('typed-dom');
            exports.scripts = new Set();
            void typed_dom_1.bind(window, 'pjax:unload', function () {
                return void dom_1.find(document, 'script').filter(function (script) {
                    return script.hasAttribute('src');
                }).forEach(function (script) {
                    return void exports.scripts.add(new url_2.URL(url_1.standardizeUrl(script.src)).href);
                });
            });
        },
        {
            '../../../../lib/dom': 122,
            '../../../../lib/url': 126,
            '../../../data/model/domain/url': 85,
            'typed-dom': 74
        }
    ],
    120: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var typed_dom_1 = require('typed-dom');
            void typed_dom_1.bind(window, 'unload', function () {
                return window.history.scrollRestoration = 'auto';
            }, false);
        },
        { 'typed-dom': 74 }
    ],
    121: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var url_1 = require('../../../data/model/domain/url');
            var typed_dom_1 = require('typed-dom');
            var url = url_1.standardizeUrl(location.href);
            void typed_dom_1.bind(window, 'hashchange', function () {
                return void exports.docurl.sync();
            });
            exports.docurl = new (function () {
                function class_1() {
                    this.sync = function () {
                        url = url_1.standardizeUrl(location.href);
                    };
                }
                Object.defineProperty(class_1.prototype, 'href', {
                    get: function () {
                        return url;
                    },
                    enumerable: true,
                    configurable: true
                });
                return class_1;
            }())();
        },
        {
            '../../../data/model/domain/url': 85,
            'typed-dom': 74
        }
    ],
    122: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            function find(target, selector) {
                return __spread(target.querySelectorAll(selector || '_'));
            }
            exports.find = find;
            function serialize(form) {
                return Array.from(form.elements).filter(function (el) {
                    if (el.disabled)
                        return false;
                    switch (el.nodeName.toLowerCase()) {
                    case 'input':
                        switch (el.type.toLowerCase()) {
                        case 'checkbox':
                        case 'radio':
                            return el.checked;
                        case 'submit':
                        case 'button':
                        case 'image':
                        case 'reset':
                        case 'file':
                            return false;
                        default:
                            return true;
                        }
                    case 'select':
                    case 'textarea':
                        return true;
                    default:
                        return false;
                    }
                }).filter(function (el) {
                    return typeof el.name === 'string' && typeof el.value === 'string';
                }).map(function (el) {
                    return [
                        encodeURIComponent(removeInvalidSurrogatePairs(el.name)),
                        encodeURIComponent(removeInvalidSurrogatePairs(el.value))
                    ].join('=');
                }).join('&');
                function removeInvalidSurrogatePairs(str) {
                    return str.replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]?|[\uDC00-\uDFFF]/g, function (str) {
                        return str.length === 2 ? str : '';
                    });
                }
            }
            exports.serialize = serialize;
        },
        {}
    ],
    123: [
        function (require, module, exports) {
            'use strict';
            var __extends = this && this.__extends || function () {
                var extendStatics = Object.setPrototypeOf || { __proto__: [] } instanceof Array && function (d, b) {
                    d.__proto__ = b;
                } || function (d, b) {
                    for (var p in b)
                        if (b.hasOwnProperty(p))
                            d[p] = b[p];
                };
                return function (d, b) {
                    extendStatics(d, b);
                    function __() {
                        this.constructor = d;
                    }
                    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
                };
            }();
            Object.defineProperty(exports, '__esModule', { value: true });
            var PjaxError = function (_super) {
                __extends(PjaxError, _super);
                function PjaxError(msg) {
                    return _super.call(this, 'Pjax: ' + msg) || this;
                }
                return PjaxError;
            }(Error);
            exports.PjaxError = PjaxError;
            var FatalError = function (_super) {
                __extends(FatalError, _super);
                function FatalError(msg) {
                    var _this = _super.call(this, 'Pjax: Fatal: ' + msg) || this;
                    _this.name = 'FatalError';
                    return _this;
                }
                return FatalError;
            }(PjaxError);
            exports.FatalError = FatalError;
        },
        {}
    ],
    124: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var maybe_1 = require('spica/maybe');
            var either_1 = require('spica/either');
            var dom_1 = require('./dom');
            exports.parse = [
                parseByDoc,
                parseByDOM
            ].reduce(function (m, parser) {
                return m.bind(function () {
                    return test(parser) ? either_1.Left(parser) : m;
                });
            }, either_1.Right(function () {
                return maybe_1.Nothing;
            })).extract(function (parser) {
                return function (html) {
                    return maybe_1.Just(parser(html));
                };
            });
            function parseByDOM(html) {
                var doc = new DOMParser().parseFromString(html, 'text/html');
                void fix(doc);
                return doc;
            }
            function parseByDoc(html) {
                var document = window.document.implementation.createHTMLDocument('');
                var title = dom_1.find(parseHTML(html.slice(0, html.search(/<\/title>/i) + 8)), 'title').reduce(function (title, el) {
                    return el.textContent || title;
                }, '');
                if ('function' === typeof DOMParser) {
                    document.title = title;
                }
                void document.open();
                void document.write(html);
                void document.close();
                if (document.title !== title) {
                    document.title = document.querySelector('title').textContent || '';
                }
                void fix(document);
                return document;
                function parseHTML(html) {
                    var parser = document.createElement('div');
                    parser.innerHTML = html;
                    return parser.firstElementChild ? parser.firstElementChild : parser;
                }
            }
            function fix(doc) {
                return void fixNoscript(doc).forEach(function (_a) {
                    var _b = __read(_a, 2), src = _b[0], fixed = _b[1];
                    return src.textContent = fixed.textContent;
                });
            }
            function fixNoscript(doc) {
                return dom_1.find(doc, 'noscript').filter(function (el) {
                    return el.children.length > 0;
                }).map(function (el) {
                    var clone = el.cloneNode(true);
                    clone.textContent = el.innerHTML;
                    return [
                        el,
                        clone
                    ];
                });
            }
            exports._fixNoscript = fixNoscript;
            function test(parser) {
                try {
                    var html = '\n<html lang="en" class="html">\n  <head>\n    <link href="/">\n    <title>&amp;</title>\n    <noscript><style>/**/</style></noscript>\n  </head>\n  <body>\n    <noscript>noscript</noscript>\n    <a href="/"></a>\n    <script>document.head.remove();</script>\n    <img src="abc">\n  </body>\n</html>\n';
                    var doc = parser(html);
                    switch (false) {
                    case doc.URL && doc.URL.startsWith(window.location.protocol + '//' + window.location.host):
                    case doc.title === '&':
                    case !!doc.querySelector('html.html[lang="en"]'):
                    case !!doc.querySelector('head > link').href:
                    case !!doc.querySelector('body > a').href:
                    case !doc.querySelector('head > noscript > *'):
                    case doc.querySelector('script').innerHTML === 'document.head.remove();':
                    case doc.querySelector('img').src.endsWith('abc'):
                    case doc.querySelector('head > noscript').textContent === '<style>/**/</style>':
                    case doc.querySelector('body > noscript').textContent === 'noscript':
                        throw void 0;
                    }
                    return true;
                } catch (_a) {
                    return false;
                }
            }
        },
        {
            './dom': 122,
            'spica/either': 8,
            'spica/maybe': 13
        }
    ],
    125: [
        function (require, module, exports) {
            'use strict';
            var __read = this && this.__read || function (o, n) {
                var m = typeof Symbol === 'function' && o[Symbol.iterator];
                if (!m)
                    return o;
                var i = m.call(o), r, ar = [], e;
                try {
                    while ((n === void 0 || n-- > 0) && !(r = i.next()).done)
                        ar.push(r.value);
                } catch (error) {
                    e = { error: error };
                } finally {
                    try {
                        if (r && !r.done && (m = i['return']))
                            m.call(i);
                    } finally {
                        if (e)
                            throw e.error;
                    }
                }
                return ar;
            };
            var __spread = this && this.__spread || function () {
                for (var ar = [], i = 0; i < arguments.length; i++)
                    ar = ar.concat(__read(arguments[i]));
                return ar;
            };
            Object.defineProperty(exports, '__esModule', { value: true });
            var url_1 = require('../layer/data/model/domain/url');
            var url_2 = require('./url');
            var sequence_1 = require('spica/sequence');
            var flip_1 = require('spica/flip');
            var maybe_1 = require('spica/maybe');
            function router(config) {
                return function (url) {
                    var _a = new url_2.URL(url_1.standardizeUrl(url)), path = _a.path, pathname = _a.pathname;
                    return sequence_1.Sequence.from(Object.keys(config).sort().reverse()).filter(flip_1.flip(compare)(pathname)).map(function (pattern) {
                        return config[pattern];
                    }).take(1).extract().pop().call(config, path);
                };
            }
            exports.router = router;
            function compare(pattern, path) {
                var regSegment = /\/|[^/]+\/?/g;
                var regTrailingSlash = /\/$/;
                return sequence_1.Sequence.zip(sequence_1.Sequence.from(expand(pattern)), sequence_1.Sequence.cycle([path])).map(function (_a) {
                    var _b = __read(_a, 2), pattern = _b[0], path = _b[1];
                    return [
                        pattern.match(regSegment) || [],
                        pattern.match(regTrailingSlash) ? path.match(regSegment) || [] : path.replace(regTrailingSlash, '').match(regSegment) || []
                    ];
                }).filter(function (_a) {
                    var _b = __read(_a, 2), ps = _b[0], ss = _b[1];
                    return ps.length <= ss.length;
                }).filter(function (_a) {
                    var _b = __read(_a, 2), patterns = _b[0], segments = _b[1];
                    return sequence_1.Sequence.zip(sequence_1.Sequence.from(patterns), sequence_1.Sequence.from(segments)).takeWhile(function (_a) {
                        var _b = __read(_a, 2), p = _b[0], s = _b[1];
                        return match(p, s);
                    }).extract().length === patterns.length;
                }).take(1).extract().length > 0;
            }
            exports.compare = compare;
            function expand(pattern) {
                return sequence_1.Sequence.from((pattern.match(/{.*?}|[^{]*/g) || []).map(function (p) {
                    return p[0] === '{' ? p.slice(1, -1).split(',') : [p];
                })).mapM(sequence_1.Sequence.from).map(function (ps) {
                    return ps.join('');
                }).extract();
            }
            exports.expand = expand;
            function match(pattern, segment) {
                if (pattern.includes('**'))
                    throw new Error('Invalid pattern: ' + pattern);
                return __spread(optimize(pattern)).map(function (p, i, ps) {
                    return p === '*' ? [
                        p,
                        ps.slice(i + 1).join('').split(/[?*]/, 1)[0]
                    ] : [
                        p,
                        ''
                    ];
                }).reduce(function (m, _a) {
                    var _b = __read(_a, 2), p = _b[0], ref = _b[1];
                    return m.bind(function (_a) {
                        var _b = __read(_a), _c = _b[0], r = _c === void 0 ? '' : _c, rs = _b.slice(1);
                        switch (p) {
                        case '?':
                            return r === '' ? maybe_1.Nothing : maybe_1.Just(rs);
                        case '*':
                            var seg = r.concat(rs.join(''));
                            return seg.includes(ref) ? ref === '' ? maybe_1.Just(__spread(seg.slice(seg.search(/\/|$/)))) : maybe_1.Just(__spread(seg.slice(seg.indexOf(ref)))) : maybe_1.Nothing;
                        default:
                            return r === p ? maybe_1.Just(rs) : maybe_1.Nothing;
                        }
                    });
                }, maybe_1.Just(__spread(segment))).bind(function (rest) {
                    return rest.length === 0 ? maybe_1.Just(void 0) : maybe_1.Nothing;
                }).extract(function () {
                    return false;
                }, function () {
                    return true;
                });
                function optimize(pattern) {
                    var pat = pattern.replace(/\*(\?+)\*?/g, '$1*');
                    return pat === pattern ? pat : optimize(pat);
                }
            }
            exports.match = match;
        },
        {
            '../layer/data/model/domain/url': 85,
            './url': 126,
            'spica/flip': 11,
            'spica/maybe': 13,
            'spica/sequence': 68
        }
    ],
    126: [
        function (require, module, exports) {
            'use strict';
            Object.defineProperty(exports, '__esModule', { value: true });
            var URL = function () {
                function URL(url) {
                    this.parser = document.createElement('a');
                    this.URL;
                    this.parser.href = url || location.href;
                    Object.freeze(this);
                }
                Object.defineProperty(URL.prototype, 'href', {
                    get: function () {
                        return this.parser.href;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'origin', {
                    get: function () {
                        return this.protocol + '//' + this.host;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'domain', {
                    get: function () {
                        return this.protocol + '//' + this.hostname;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'scheme', {
                    get: function () {
                        return this.parser.protocol.slice(0, -1);
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'protocol', {
                    get: function () {
                        return this.parser.protocol;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'userinfo', {
                    get: function () {
                        return this.parser.href.match(/[^:/?#]+:\/\/([^/?#]*)@|$/).pop() || '';
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'host', {
                    get: function () {
                        return this.parser.host;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'hostname', {
                    get: function () {
                        return this.parser.hostname;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'port', {
                    get: function () {
                        return this.parser.port;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'path', {
                    get: function () {
                        return '' + this.pathname + this.query;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'pathname', {
                    get: function () {
                        return this.parser.pathname;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'query', {
                    get: function () {
                        return this.parser.search;
                    },
                    enumerable: true,
                    configurable: true
                });
                Object.defineProperty(URL.prototype, 'fragment', {
                    get: function () {
                        return this.parser.hash;
                    },
                    enumerable: true,
                    configurable: true
                });
                return URL;
            }();
            exports.URL = URL;
        },
        {}
    ],
    'pjax-api': [
        function (require, module, exports) {
            arguments[4][74][0].apply(exports, arguments);
        },
        {
            './src/export': 80,
            'dup': 74
        }
    ]
}, {}, [
    1,
    2,
    'pjax-api'
]);

window.Pjax = require('pjax-api').default;
