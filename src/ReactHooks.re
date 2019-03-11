let useEffect = generator => React.useEffect0(generator);

let useEffect1 = (generator, key) =>
  React.useEffect1(() => generator(key), [|key|]);

let useEffect2 = (generator, k0, k1) =>
  React.useEffect2(() => generator(k0, k1), (k0, k1));

let useEffect3 = (generator, k0, k1, k2) =>
  React.useEffect3(() => generator(k0, k1, k2), (k0, k1, k2));

let useEffect4 = (generator, k0, k1, k2, k3) =>
  React.useEffect4(() => generator(k0, k1, k2, k3), (k0, k1, k2, k3));

let useMemo = generator => React.useMemo0(generator);

let useMemo1 = (generator: 'a => 't, ctx0: 'a) =>
  React.useMemo1(() => generator(ctx0), [|ctx0|]);

let useMemo2 = (generator, ctx0, ctx1) =>
  React.useMemo2(() => generator(ctx0, ctx1), (ctx0, ctx1));

let useMemo3 = (generator, ctx0, ctx1, ctx2) =>
  React.useMemo3(
    () => generator(ctx0, ctx1, ctx2),
    (ctx0, ctx1, ctx2),
  );

let useMemo4 = (generator, ctx0, ctx1, ctx2, ctx3) =>
  React.useMemo4(
    () => generator(ctx0, ctx1, ctx2, ctx3),
    (ctx0, ctx1, ctx2, ctx3),
  );

let useMemo5 = (generator, ctx0, ctx1, ctx2, ctx3, ctx4) =>
  React.useMemo5(
    () => generator(ctx0, ctx1, ctx2, ctx3, ctx4),
    (ctx0, ctx1, ctx2, ctx3, ctx4),
  );

let useMemo6 = (generator, ctx0, ctx1, ctx2, ctx3, ctx4, ctx5) =>
  React.useMemo6(
    () => generator(ctx0, ctx1, ctx2, ctx3, ctx4, ctx5),
    (ctx0, ctx1, ctx2, ctx3, ctx4, ctx5),
  );