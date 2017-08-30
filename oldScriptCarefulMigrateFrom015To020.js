// You know technically we could have just published some random sed scripts or
// indicated in the migration guide how to make these very trivial changes, but
// we've decided to give you a migration script (windows-friendly too!) anyway
// because that's how much we care and appreciate you for using ReasonReact.

'use strict';

const fs = require('fs');

if (process.argv.length <= 2) {
  console.error('You need to pass a list of the files you\'d like to migrate, like so: `node oldScriptCarefulMigrateFrom015To020.js src/*.re`');
  process.exit(1);
}
var filesToMigrate = process.argv.slice(2);
console.log(`\u{1b}[36m
***
Starting ReasonReact 0.1.5 -> 0.2.0 migration!
Note that this is just a dumb script that only converts the easily automatable stuff. It's not comprehensive and might leave you with easy-to-manually-fix type errors.
***
\u{1b}[39m`)

function transform(content) {
  return content
    // render + lifecyles in the form of let didMount state self => ...
    .replace(/let (render|didMount|willUnmount|willReceiveProps) (_\w*|\(\)) (.+) =>/g, `let $1 $3 =>`)
    .replace(/let (render|didMount|willUnmount|willReceiveProps) state _\w* =>/g, `let $1 {ReasonReact.state} =>`)
    .replace(/let (render|didMount|willUnmount|willReceiveProps) state self =>/g, `let $1 ({ReasonReact.state} as self) =>`)
    .replace(/let (render|didMount|willUnmount|willReceiveProps) state \{(.+)\} =>/g, `let $1 {ReasonReact.state, $2} =>`)

    // render + lifecyles
    .replace(/(render|didMount|willUnmount|willReceiveProps): fun (_\w*|\(\)) (.+) =>/g, `$1: fun $3 =>`)
    .replace(/(render|didMount|willUnmount|willReceiveProps): fun state _\w* =>/g, `$1: fun {state} =>`)
    .replace(/(render|didMount|willUnmount|willReceiveProps): fun state self =>/g, `$1: fun ({state} as self) =>`)
    .replace(/(render|didMount|willUnmount|willReceiveProps): fun state \{(.+)\} =>/g, `$1: fun {state, $2} =>`)

    // handlers
    .replace(/let (\w+) (.+) (_\w*|\(\)) _self =>/g, `let $1 $2 _self =>`)
    .replace(/let (\w+) (.+) (_\w*|\(\)) self =>/g, `let $1 $2 self =>`)
    .replace(/let (\w+) (.+) state _\w* =>/g, `let $1 $2 {ReasonReact.state} =>`)
    .replace(/let (\w+) (.+) state self =>/g, `let $1 $2 ({ReasonReact.state} as self) =>`)
    .replace(/let (\w+) (.+) state \{(.+)\} =>/g, `let $1 $2 {ReasonReact.state, $3} =>`)

    // particular lifecycle events
    .replace(/let (didUpdate|willUpdate|shouldUpdate) previousState::(_\w*|\(\)) \w+State::(_\w*|\(\)) (\w+) =>/g, `let $1 $4 =>`)
    .replace(/let (didUpdate|willUpdate|shouldUpdate) previousState::(_\w*|\(\)) ::(\w+State) \w+ =>/g, `let $1 {ReasonReact.newSelf} =>`)
    .replace(/let (didUpdate|willUpdate|shouldUpdate) ::(previousState) \w+State::(_\w*|\(\)) \w+ =>/g, `let $1 {ReasonReact.oldSelf} =>`)
    .replace(/let (didUpdate|willUpdate|shouldUpdate) ::(previousState) ::(\w+State) \w+ =>/g, `let $1 {ReasonReact.oldSelf, newSelf} =>`)

    .replace(/(didUpdate|willUpdate|shouldUpdate): fun previousState::(_\w*|\(\)) \w+State::(_\w*|\(\)) (\w+) =>/g, `$1: fun $4 =>`)
    .replace(/(didUpdate|willUpdate|shouldUpdate): fun previousState::(_\w*|\(\)) ::(\w+State) \w+ =>/g, `$1: fun {newSelf} =>`)
    .replace(/(didUpdate|willUpdate|shouldUpdate): fun ::(previousState) \w+State::(_\w*|\(\)) \w+ =>/g, `$1: fun {oldSelf} =>`)
    .replace(/(didUpdate|willUpdate|shouldUpdate): fun ::(previousState) ::(\w+State) \w+ =>/g, `$1: fun {oldSelf, newSelf} =>`)
}

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
    const newContent = transform(content);
    if (newContent !== content) {
      console.log('Found a file that has things to migrate: ' + file);
      fs.writeFileSync(file, newContent, {encoding: 'utf-8'});
    }
  });
}

migrate(filesToMigrate);
