let counter = {contents: 0};

let subscribers = {contents: []};

let request = cb => {
  subscribers.contents = [cb, ...subscribers.contents];
  counter.contents = counter.contents + 1;
  counter.contents;
};

let tick = () => {
  let prevSubscribers = subscribers.contents;
  subscribers.contents = [];
  List.iter(cb => cb(), prevSubscribers);
};

let clearAll = () => subscribers.contents = [];
