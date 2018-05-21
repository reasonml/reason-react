Lots of people have asked about reason-react compiled to native (Reason Native React Native or RNRN 😎), here's a rough outline of dependencies that have to fall into place.

# Prerequisites
status: in progress

The main thing here is getting a package manager + build toolchain that make cross-compilation a breeze. @jordwalke and some others are working on this right now, and it's called [esy](https://github.com/esy/esy).

Time remaining before it's usable: 2-8 months? :P [TODO put in a better estimate about timeline]

# Potential direction #1
status: not started

Use existing react-native infrastructure, and make a reason-react implementation that talks the same protocol as react-native currently uses.

Benefits: we can re-use all the flex-box, native view bindings, etc. that react-native already has.
Downsides: that might come with some cruft as well.

# Potential direction #2
status: started (repo [here](https://github.com/briskml/brisk))

Create a new implementation of React that's especially for Reason + Native
- based off of [ReactMini](https://github.com/reasonml/reason-react/tree/master/ReactMini)
- also using code from [Reason Flex](https://github.com/jordwalke/flex)
- currently prototyped with bindings for iOS
- hasn't started into the Android side yet

Benefits: very tight implementation, light weight
Downsides: have to do new bindings to Android, iOS APIs

