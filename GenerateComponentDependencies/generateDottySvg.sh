# simple script to scan .re file and generate comp.dot and comp.svg with component dependencies.
# Nodes are components: either capitalized .re files or <components ...> appearing in jsx.
# Edges are jsx uses.
# Nodes are color-coded:
#  1) Reason Orange means a Reason component never called from javascript.
#  2) Blue means a Reason component callable from javascript.
#  3) Reason Grey means a Reason component wrapping a javascript one.
#  4) Pink means a javascript component used by Reason.

dir=src
files=$dir/*.re
addBlue=( awk -F ":" '{print $1 " [color=blue]"}' )
addReasonGrey=( awk -F ":" '{print $1 " [color=\"#8F8F8F\"]"}' )
addReasonOrange=( awk -F ":" '{print $1 " [color=\"#DD4B39\"]"}' )
capitalize=( awk '{print toupper(substr($0,1,1)) substr($0,2) }' )
componentJSX="<[A-Z][a-zA-Z0-9]*"
lightGrey="\"#F6F4F4\""
reasonGrey="\"#8F8F8F\""
removeSrcReJsx=( sed -e 's/src\///g' -e 's/\.re//g' -e 's/<//g' )

# on macOS, use brew install grep to make ggrep available
# ggrep shows the file name on each match, while the system grep does not
if ! [ -x "$(command -v ggrep)" ]; then
  export GREP=grep
else
  export GREP=ggrep
fi

# detect pattern file.re ... <Component ...>
# and generate File -> Component
$GREP -H -o $componentJSX $files \
 | awk -F ":" '{print $1 " -> " $2 }' \
 | "${removeSrcReJsx[@]}" \
 | "${capitalize[@]}" \
 | sort -u \
 >edges.txt

# for each file.re generate a node "File" of color Reason orange
find $dir -name "*.re" \
 | "${removeSrcReJsx[@]}" \
 | "${capitalize[@]}" \
 | "${addReasonOrange[@]}" \
 >nodes.txt

# if file.re containing wrapJsForReason, make color Reason grey
$GREP -o "wrapJsForReason" $files \
 | sort -u \
 | "${removeSrcReJsx[@]}" \
 | "${capitalize[@]}" \
 | "${addReasonGrey[@]}" \
 >>nodes.txt

# if file.re containing wrapReasonForJs, make color blue
$GREP -o "wrapReasonForJs" $files \
 | sort -u \
 | "${removeSrcReJsx[@]}" \
 | "${capitalize[@]}" \
 | "${addBlue[@]}" \
 >>nodes.txt

echo "digraph {" > comp.dot
# background color is light grey
echo "graph [rankdir=LR bgcolor=$lightGrey]" >> comp.dot
# edge color is Reason grey
echo "edge [color=$reasonGrey]" >> comp.dot
# default node color is pink
echo "node [style=filled color=pink fontcolor=white]" >> comp.dot
cat nodes.txt edges.txt >> comp.dot
echo "}" >> comp.dot

dot -Tsvg -o comp.svg comp.dot
sed -i -e 's/Times,serif/montserrat, sans-serif/g' comp.svg
