type interactionDetectorId = int;

let uuid = {contents: 0};

let createInteractionDetectorId = () => {
  uuid.contents = uuid.contents + 1;
  uuid.contents;
};

let eq = (id1, id2) => id1 === id2;
