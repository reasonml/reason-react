open Types;

/**
 * Geometric data structures and operations.
 * https://www.bignerdranch.com/blog/rectangles-part-1/
 */
let nullRect = {
  origin: {
    x: infinity,
    y: infinity,
  },
  size: {
    width: 0.0,
    height: 0.0,
  },
};

let zeroPoint = {x: 0.0, y: 0.0};

let rectOffset = (rect, dx, dy) => {
  size: {
    width: rect.size.width,
    height: rect.size.height,
  },
  origin: {
    x: rect.origin.x +. dx,
    y: rect.origin.y +. dy,
  },
};

let rectIsNull = rect =>
  rect === nullRect
  || compare(rect.size.width, 0.0) === 0
  && compare(rect.size.height, 0.0) === 0
  && compare(rect.origin.x, infinity) === 0
  && compare(rect.origin.y, infinity) === 0;

let rectIsNullPoints = (x, y, width, height) =>
  compare(width, 0.0) === 0
  && compare(height, 0.0) === 0
  && compare(x, infinity) === 0
  && compare(y, infinity) === 0;

let rectIsEmpty = rect =>
  rect === nullRect
  || compare(rect.size.width, 0.0) === 0
  || compare(rect.size.height, 0.0) === 0;

/*
 * Assume that width/height are positive, and x0 = rect.x and x1 = rect.x +
 * rect.width. (Implying x1 > x0).
 *
 * - Intersection exists iff all of the following hold:
 *
 * 1. Both rectangles are not null
 *
 * 2. (m.x1 > n.x0 || n.x1 > m.x0)
 *     Greater of two x0's must reside in the other rect's x range.
 *
 * 3. (m.y1 > n.y0 || n.y1 > m.y0)
 *     Greater of two y0's must reside in the other rect's y range.
 *
 *
 * If an intersection is not null, then the intersection is given by:
 *
 *    { x: xb, y: yb, width: xc -. xb, height: yc -. yb }
 *
 * Where xa, xb, xc, xd is the sorting of m.x0, m.x1, n.x0, n.x1.
 *
 *
 * Intersection (not subset):
 * -----------------------------
 *
 *    { x: xb, y: yb, width: xc -. xb, height: yc -. yb }
 *
 *          x0             x1
 *    ya y0 +---------------+
 *          |               |
 *          |      x0       |        x1
 *    yb    |   y0 +--------|---------+
 *          |      |        |         |
 *          |      |        |         |
 *          |      |        |         |
 *    yc y1 +---------------+         |
 *                 |                  |
 *                 |                  |
 *    yd        y1 +------------------+
 *
 *          xa     xb      xc        xd
 *
 *
 * Intersection (proper subset):
 * -----------------------------
 *
 *    { x: xb, y: yb, width: xc -. xb, height: yc -. yb }
 *
 *
 *          x0                  x1
 *    ya y0 +--------------------+
 *          |                    |
 *          |      x0    x1      |
 *    yb    |   y0 +------+      |
 *          |      |      |      |
 *          |      |      |      |
 *    yc    |   y1 +----- +      |
 *          |                    |
 *    yd y1 +--------------------+
 *
 *          xa     xb     xc    xd
 *
 * No intesection:
 * ---------------
 *
 *          xa  xb xc       xd
 *          x0  x1
 *    ya y0 +---+
 *          | m |
 *          |   |
 *          |   |
 *    yb y1 +---+  x0       x1
 *    yc        y0 +---------+
 *                 |    n    |
 *    yd        y1 +---------+
 *
 *
 */
let rectIntersectsWith = (m, n) => {
  let mNotNull = ! rectIsNull(m);
  let nNotNull = ! rectIsNull(n);
  let m_x0 = m.origin.x;
  let m_x1 = m.origin.x +. m.size.width;
  let m_y0 = m.origin.y;
  let m_y1 = m.origin.y +. m.size.height;
  let n_x0 = n.origin.x;
  let n_x1 = n.origin.x +. n.size.width;
  let n_y0 = n.origin.y;
  let n_y1 = n.origin.y +. n.size.height;
  let mRightInsideN = m_x1 > n_x0 && m_x1 <= n_x1;
  let nRightInsideM = n_x1 > m_x0 && n_x1 <= m_x1;
  let mBottomInsideN = m_y1 > n_y0 && m_y1 <= n_y1;
  let nBottomInsideM = n_y1 > m_y0 && n_y1 <= m_y1;
  mNotNull
  && nNotNull
  && (mRightInsideN || nRightInsideM)
  && (mBottomInsideN || nBottomInsideM);
};

/*
 * It's not clear how this should handle null rectangles.
 */
let rectIntersectsWithSlop = (s, m, n) => {
  let mNotNull = ! rectIsNull(m);
  let nNotNull = ! rectIsNull(n);
  let m_x0 = m.origin.x;
  let m_x1 = m.origin.x +. m.size.width;
  let m_y0 = m.origin.y;
  let m_y1 = m.origin.y +. m.size.height;
  let n_x0 = n.origin.x;
  let n_x1 = n.origin.x +. n.size.width;
  let n_y0 = n.origin.y;
  let n_y1 = n.origin.y +. n.size.height;
  /* mNotNull && nNotNull && (m_x1 +. s > n_x0 || n_x1 +. s > m_x0) && (m_y1 +. s > n_y0 || n_y1 +. s > m_y0); */
  let mRightInsideN = m_x1 +. s > n_x0 && m_x1 <= n_x1 +. s;
  let nRightInsideM = n_x1 +. s > m_x0 && n_x1 <= m_x1 +. s;
  let mBottomInsideN = m_y1 +. s > n_y0 && m_y1 <= n_y1 +. s;
  let nBottomInsideM = n_y1 +. s > m_y0 && n_y1 <= m_y1 +. s;
  mNotNull
  && nNotNull
  && (mRightInsideN || nRightInsideM)
  && (mBottomInsideN || nBottomInsideM);
};

/*
 * Optimized for cases when `n` tends to be embedded within `m`, more often
 * than `m` tends to be embedded within `n`.
 */
let rec rectIntersectionValues = (mx, my, mWidth, mHeight, n) => {
  let mNotNull = ! rectIsNullPoints(mx, my, mWidth, mHeight);
  let nNotNull =
    ! rectIsNullPoints(n.origin.x, n.origin.y, n.size.width, n.size.height);
  let m_x0 = mx;
  let m_x1 = mx +. mWidth;
  let m_y0 = my;
  let m_y1 = my +. mHeight;
  let n_x0 = n.origin.x;
  let n_x1 = n.origin.x +. n.size.width;
  let n_y0 = n.origin.y;
  let n_y1 = n.origin.y +. n.size.height;
  let mRightInsideN = m_x1 > n_x0 && m_x1 <= n_x1;
  let nRightInsideM = n_x1 > m_x0 && n_x1 <= m_x1;
  let mBottomInsideN = m_y1 > n_y0 && m_y1 <= n_y1;
  let nBottomInsideM = n_y1 > m_y0 && n_y1 <= m_y1;
  if (mNotNull
      && nNotNull
      && (mRightInsideN || nRightInsideM)
      && (mBottomInsideN || nBottomInsideM)) {
    if (m_x0 >= n_x0 && m_y0 >= n_y0 && m_x1 <= n_x1 && m_y1 <= n_y1) {
      {
        origin: {
          x: mx,
          y: my,
        },
        size: {
          height: mHeight,
          width: mWidth,
        },
      };
    } else if
      /* This is why this function is optimized for cases when `n` is embedded
       * inside of `m`. We can simply return `n`. */
      (n_x0 >= m_x0 && n_y0 >= m_y0 && n_x1 <= m_x1 && n_y1 <= m_y1) {
      n;
    } else {
      /* When one is not embedded in another (which was the common case). */
      let (xa, xb, xc, xd) = sortFour(m_x0, m_x1, n_x0, n_x1);
      let (ya, yb, yc, yd) = sortFour(m_y0, m_y1, n_y0, n_y1);
      {
        origin: {
          x: xb,
          y: yb,
        },
        size: {
          width: xc -. xb,
          height: yc -. yb,
        },
      };
    };
  } else {
    nullRect;
  };
}
and rectIntersection = (m, n) =>
  rectIntersectionValues(
    m.origin.x,
    m.origin.y,
    m.size.width,
    m.size.height,
    n,
  )
and sortFour = (q, r, s, t) => {
  let (l1, l2) = q > r ? (r, q) : (q, r);
  let (r1, r2) = s > t ? (t, s) : (s, t);
  if (l2 <= r1) {
    (l1, l2, r1, r2);
  } else if (r2 <= l1) {
    (r1, r2, l1, l2);
  } else if (l1 <= r1 && l2 <= r2) {
    (l1, r1, l2, r2);
  } else if (l1 <= r1 && r2 <= l2) {
    (l1, r1, r2, l2);
  } else if (r1 <= l1 && r2 <= l2) {
    (r1, l1, r2, l2);
  } else if (r1 <= l1 && l2 <= r2) {
    (r1, l1, l2, r2);
  } else {
    raise(Invalid_argument("Error in implementation of sortFour"));
  };
};

module Print = {
  let rect = (r: rect) =>
    "{origin: {x:"
    ++ string_of_float(r.origin.x)
    ++ ", y:"
    ++ string_of_float(r.origin.y)
    ++ "}, "
    ++ " size: {width: "
    ++ string_of_float(r.size.width)
    ++ ", height: "
    ++ string_of_float(r.size.height)
    ++ "}";
  let point = (r: point) =>
    "{x:" ++ string_of_float(r.x) ++ ", y:" ++ string_of_float(r.y) ++ "}";
};
