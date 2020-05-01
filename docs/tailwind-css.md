---
title: Styling: Tailwind CSS
---

[Tailwind CSS](https://tailwindcss.com) is a new CSS framework that is rapidly
growing in popularity. It's completely customizable and lightweight, making it
a perfect companion to React. If you're not familiar with Tailwind, we recommend
checking out [their docs](https://tailwindcss.com/#what-is-tailwind) for
a gentle introduction before moving forward.

## Setting up Tailwind

Now let's see how we can use Tailwind within ReasonReact and start building an
app!

First, you'll need to create a new ReasonReact project -- we recommend [this
template](https://github.com/bodhish/create-reason-react-tailwind) (select the
`tailwind-starter` option) which has Tailwind set up out of the box. Once you've
installed the dependencies with `yarn install` or `npm install`, you should be
ready to go.

Let's see an example of a React component using Tailwind:

```reason
[@react.component]
let make = () =>
  <div className="h-screen flex justify-center items-center">
    <div className="max-w-sm rounded overflow-hidden shadow-lg p-4">
      <img className="w-full" src=logo alt="Sunset in the mountains" />
      <div className="px-6 py-4">
        <div className="font-bold text-xl mb-2"> {React.string("Tailwind")} </div>
        <p className="text-gray-700 text-base">
          {React.string("A reason react starter with tailwind")}
        </p>
      </div>
   </div>
  </div>;
```

which gives us the following UI:

<img src="/reason-react/img/tailwind-example.png">

## tailwind-ppx

Often times when you're writing with Tailwind and ReasonReact, you may find
yourself wondering why the UI isn't working like it should, only to find out you
had a typo in a class name. For example,

```reason
<div className="flex flex-ro">
  ...
</div>
```

Wouldn't it be nice to get some validation _while_ you're writing the Tailwind
classes? Better yet, how about preventing your code from even compiling if the
classes aren't correct? Well, enter
[`tailwind-ppx`](https://github.com/dylanirlbeck/tailwind-ppx): a compile-time
validator for Tailwind CSS. Using this PPX, you can get immediate compiler
errors if you happen to misspell class names, along with a nice suggestion of
what you may have meant to write!

```reason
<div className=[%tw "flex flex-ro"]> /* ERROR: Class name not found: flex-ro. Did you mean flex-row? */
  ...
</div>
```

Moreover, in a large codebase where components may have many class names, you
may find yourself duplicating some class names. `tailwind-ppx` solves this
issue, too!

```reason
<div className=[%tw "flex flex-row mt-2 pb-3 flex"]> /* ERROR: Duplicate class name: flex */
  ...
</div>
```

Wrapping the class names in a PPX allows for some powerful integrations with
Tailwind in addition to validation. For more information, check out
`tailwind-ppx`'s [other features](https://github.com/dylanirlbeck/tailwind-ppx#features)
