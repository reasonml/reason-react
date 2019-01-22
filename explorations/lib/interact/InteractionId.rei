/***
 * Made opaque to prevent forming assumptions on datatype.
 */
type interactionDetectorId;

let createInteractionDetectorId: unit => interactionDetectorId;

let eq: (interactionDetectorId, interactionDetectorId) => bool;
