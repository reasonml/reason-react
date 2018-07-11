let rec mapi3_ = (f, iSoFar, revSoFar, listA, listB, listC) =>
  switch (listA, listB, listC) {
  | ([hda, ...tla], [hdb, ...tlb], [hdc, ...tlc]) =>
    mapi3_(
      f,
      iSoFar + 1,
      [f(iSoFar, hda, hdb, hdc), ...revSoFar],
      tla,
      tlb,
      tlc,
    )
  | ([], [], []) => List.rev(revSoFar)
  | _ =>
    raise(
      Invalid_argument("Length changing sequences aren't supported yet."),
    )
  };

let mapi3 = (f, listA, listB, listC) =>
  mapi3_(f, 0, [], listA, listB, listC);

let rec splitList_ = (revCount, revSoFar, splitAt, lst) =>
  switch (lst) {
  | [] =>
    raise(
      Invalid_argument(
        "Empty list cannot be split at " ++ string_of_int(splitAt),
      ),
    )
  | [hd, ...tl] =>
    revCount === splitAt ?
      (List.rev(revSoFar), hd, tl) :
      splitList_(revCount + 1, [hd, ...revSoFar], splitAt, tl)
  };

let splitList = (splitAt, lst) => splitList_(0, [], splitAt, lst);
