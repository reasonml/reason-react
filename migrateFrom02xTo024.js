'use strict';

const fs = require('fs');

if (process.argv.length <= 2) {
  console.error('You need to pass a list of the files you\'d like to migrate, like so: `node migrateFrom02xTo024.js src/*.re`');
  process.exit(1);
}
const filesToMigrate = process.argv.slice(2);
console.log(`\u{1b}[36m
***
Starting ReasonReact 0.2.x -> 0.2.4 migration!

Note that this is just a dumb script that only converts the easily automatable stuff. It's _not_ comprehensive.

Even though this is a mass codemod, we recommend you to convert a single/a few files at time. This imposes less cognitive burden.

Things to do after the codemod:

- Check the new \`reduce\` callsites, put the right action there, and **handle them in \`reducer\`**.
- Check the ReasonReact.SilentUpdate/self.update warnings in this script at the bottom, if any.

Full migration guide: https://github.com/reasonml/reason-react/blob/master/HISTORY.md#024
***
\u{1b}[39m`)

function transform(content) {
  const statefulComponentR = /let (\w+) *=(\n*) *(ReasonReact\.)?statefulComponent/;
  const statefulComponentMatch = content.match(statefulComponentR);
  if (statefulComponentMatch) {
    const componentBindingName = statefulComponentMatch[1];
    const componentSpreadR = new RegExp(' *\\{\\n?\\s*\\.\\.\\.' + componentBindingName + ',', 'g');

    const componentSpreadMatch = content.match(componentSpreadR);
    if (componentSpreadMatch) {
      const reducerR = /(reducer,|reducer: )/;
      const reducerMatch = content.match(reducerR);

      if (reducerMatch) {
        // weird, already have the reducer mention in the file. The codemod's idempotent, so skip for now...
      } else {
        const leadingSpacesCount = componentSpreadMatch[0].length - componentSpreadMatch[0].trimLeft().length;
        const leadingSpaces = ' '.repeat(leadingSpacesCount + 2);
        content = content
          .replace(componentSpreadR, `${componentSpreadMatch[0]}\n${leadingSpaces}reducer: fun action state =>\n${leadingSpaces}  switch action {\n${leadingSpaces}  | YourActionHere => ReasonReact.Update {...state, bla: blabla}\n${leadingSpaces}  },`)
          .replace(statefulComponentR, `type action =\n  | YourActionHere  \n  | AnotherActionHere;\n\n${statefulComponentMatch[0].replace('statefulComponent', 'reducerComponent')}`)
          .replace(/(self|oldSelf|newSelf)\.ReasonReact\.update/g, '$1.ReasonReact.reduce (fun _ => YourActionHereThenPleaseRemoveTheCallbackThatComesAfterward)')
          .replace(/(self|oldSelf|newSelf)\.update/g, '$1.reduce (fun _ => YourActionHereThenPleaseRemoveTheCallbackThatComesAfterward)')
          .replace(/(self|oldSelf|newSelf)\.ReasonReact\.enqueue/g, '$1.ReasonReact.reduce (fun _ => YourActionHereThenPleaseRemoveTheCallbackThatComesAfterward)')
          .replace(/(self|oldSelf|newSelf)\.enqueue/g, '$1.reduce (fun _ => YourActionHereThenPleaseRemoveTheCallbackThatComesAfterward)')
          .replace(/\{ReasonReact.(update|enqueue)\}/g, `{ReasonReact.reduce}`)
          .replace(/\{ReasonReact.(update|enqueue),(.+?)\}/g, `{ReasonReact.reduce,$1}`)
          .replace(/\{ReasonReact\.(.+? *)(update|enqueue)\}/g, `{ReasonReact.$1reduce}`)
          .replace(/(render|didMount|willUnmount|willReceiveProps): *fun *\{(ReasonReact\.)?(.+? *)(update|enqueue)\} *=>/g, `$1: fun {$3reduce} =>`)
          .replace(/(render|didMount|willUnmount|willReceiveProps): *fun *\{(ReasonReact\.)?(update|enqueue)(.+? *)\} *=>/g, `$1: fun {reduce$4} =>`)
      }
    }
  }

  const silentUpdateR = /SilentUpdate/;
  const silentUpdateMatch = content.match(silentUpdateR);

  const updateR = /[\s\.]update[\s\.]/;
  const updateMatch = content.match(updateR);

  const enqueueR = /[\s\.]enqueue[\s\.]/;
  const enqueueMatch = content.match(enqueueR);

  return [silentUpdateMatch != null, updateMatch != null, enqueueMatch != null, content];
}

let filesWithSilentUpdate = [];
let filesWithSelfUpdate = [];
let filesWithSelfEnqueue = [];
// entry point
function migrate(files) {
  files.forEach((file) => {
    let content;
    try {
      content = fs.readFileSync(file, {encoding: 'utf-8'});
    } catch (e) {
      console.error(`\u{1b}[31mProblem reading ${file}: ${e.message}\u{1b}[39m`);
      process.exit(1);
    }

    const result = transform(content);
    const hasSilentUpdate = result[0];
    const hasSelfUpdate = result[1];
    const hasSelfEnqueue = result[2];
    const newContent = result[3];

    if (newContent !== content) {
      console.log('Found a file that has things to migrate: ' + file);
      fs.writeFileSync(file, newContent, {encoding: 'utf-8'});
    }
    if (hasSilentUpdate) {
      filesWithSilentUpdate.push(file);
    }
    if (hasSelfUpdate) {
      filesWithSelfUpdate.push(file);
    }
    if (hasSelfEnqueue) {
      filesWithSelfEnqueue.push(file);
    }
  });

  if (filesWithSilentUpdate.length !== 0) {
      console.log(`\u{1b}[36m
The follow files have \`SilentUpdate\`:
\u{1b}[39m`);
      console.log(filesWithSilentUpdate.map(f => '- ' + f).join('\n'));
      console.log(`\u{1b}[36m
In most cases this isn\'t what you want. Please change it to ref cells on state: https://reasonml.github.io/reason-react/#reason-react-component-creation-instance-variables
\u{1b}[39m`);
  }
  if (filesWithSelfUpdate.length !== 0) {
      console.log(`\u{1b}[36m
The follow files mention \`update\`. We aren't sure whether they refer to \`self.update\`, so we didn't touch them. If they are, please replace them with \`reduce\`:
\u{1b}[39m`);
      console.log(filesWithSelfUpdate.map(f => '- ' + f).join('\n'));
  }
  if (filesWithSelfEnqueue.length !== 0) {
      console.log(`\u{1b}[36m
The follow files mention \`enqueue\`. We aren't sure whether they refer to \`self.enqueue\`, so we didn't touch them. If they are, please replace them with \`reduce\`:
\u{1b}[39m`);
      console.log(filesWithSelfEnqueue.map(f => '- ' + f).join('\n'));
  }

}

migrate(filesToMigrate);
