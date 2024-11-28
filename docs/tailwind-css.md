---
title: Styling: Tailwind CSS
---

[Tailwind CSS](https://tailwindcss.com) is a CSS framework that is rapidly
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
