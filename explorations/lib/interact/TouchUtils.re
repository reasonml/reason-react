open Touch.Types;

let rec isTracked = (touch, tracksTouchIds) =>
  switch (tracksTouchIds) {
  | [] => false
  | [id] => touch.privateTouchData.identifier === id
  | [id, ...tl] =>
    touch.privateTouchData.identifier === id || isTracked(touch, tl)
  };

/***
 * Fast paths the common cases.
 */
let rec removeTouchIds = (touchIds, id) =>
  switch (touchIds) {
  | [] => []
  | [oneId] when oneId === id => []
  /* Case of exactly two. */
  | [oneId, ...[twoId] as tl] =>
    if (oneId === id) {
      tl;
    } else if (twoId === id) {
      [oneId];
    } else {
      touchIds;
    }
  | [hdId, ...tl] =>
    if (hdId === id) {
      tl;
    } else {
      [hdId, ...removeTouchIds(tl, id)];
    }
  };

/***
 * Fast passes the most common cases of categorization.
 */
let rec classifyTouches =
        ((beg, move, endd, cancel) as cur, touches, tracksTouchIds) =>
  switch (cur, touches) {
  | (_, []) => cur
  | (_, [{stage: Still}, ...tl]) =>
    classifyTouches(cur, tl, tracksTouchIds)
  /* These cases avoid allocating a new list when there's only one *total* changed touch */
  | (([], _, _, _), [{stage: Began} as touch]) =>
    if (isTracked(touch, tracksTouchIds)) {
      (touches, move, endd, cancel);
    } else {
      cur;
    }
  | ((_, [], _, _), [{stage: Moved} as touch]) =>
    if (isTracked(touch, tracksTouchIds)) {
      (beg, touches, endd, cancel);
    } else {
      cur;
    }
  | ((_, _, [], _), [{stage: Ended} as touch]) =>
    if (isTracked(touch, tracksTouchIds)) {
      (beg, move, touches, cancel);
    } else {
      cur;
    }
  | ((_, _, _, []), [{stage: Cancelled} as touch]) =>
    if (isTracked(touch, tracksTouchIds)) {
      (beg, move, endd, touches);
    } else {
      cur;
    }
  /* These cases handle multiple touches. */
  | (_, [{stage: Began} as touch, ...tl]) =>
    let next =
      if (isTracked(touch, tracksTouchIds)) {
        ([touch, ...beg], move, endd, cancel);
      } else {
        cur;
      };
    classifyTouches(next, tl, tracksTouchIds);
  | (_, [{stage: Moved} as touch, ...tl]) =>
    let next =
      if (isTracked(touch, tracksTouchIds)) {
        (beg, [touch, ...move], endd, cancel);
      } else {
        cur;
      };
    classifyTouches(next, tl, tracksTouchIds);
  | (_, [{stage: Ended} as touch, ...tl]) =>
    let next =
      if (isTracked(touch, tracksTouchIds)) {
        (beg, move, [touch, ...endd], cancel);
      } else {
        cur;
      };
    classifyTouches(next, tl, tracksTouchIds);
  | (_, [{stage: Cancelled} as touch, ...tl]) =>
    let next =
      if (isTracked(touch, tracksTouchIds)) {
        (beg, move, endd, [touch, ...cancel]);
      } else {
        cur;
      };
    classifyTouches(next, tl, tracksTouchIds);
  };
