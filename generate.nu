# make sure to have roboto serif on your system before you generate these xoxo
# https://fonts.google.com/specimen/Roboto+Serif


let alphabet = "abcdefghijklmnopqrstuvwxyz0123456789!?@#:;[]{}-=_+%^()/.:,"
let special = {
   "&": "&amp;", 
   "<": "&lt;", 
   ">": "&gt;", 
   "$": "&#36;", 
   "£": "&#163;"
}

let colours = [
    { name: "ectoplasm", light: "#b3f1a5", dark: "#204a20", dark-text: "#153515" },
    { name: "plum", light: "#c49ef4", dark: "#300d5d", dark-text: "#1c0438" },
    { name: "weezer", light: "#99cee3", dark: "#193e56", dark-text: "#0d2736" },
    { name: "yellow", light: "#f4e37e", dark: "#563f18", dark-text: "#3a2709" },
    { name: "orange", light: "#eeaf98", dark: "#612411", dark-text: "#371407" },
    { name: "red", light: "#eda3ab", dark: "#7b1a1d", dark-text: "#3e0a0e" },
    { name: "bubblegum", light: "#eca3cd", dark: "#5d143a", dark-text: "#380923" },
    { name: "grey", light: "#c7c6c8", dark: "#1f1d20", dark-text: "#171517" },
    { name: "brown", light: "#daa97c", dark: "#40240c", dark-text: "#2a1805" },
]

let svg = {|bg, text, letter| $"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>

<svg
   width=\"56\"
   height=\"56\"
   viewBox=\"0 0 14.816666 14.816667\"
   version=\"1.1\"
   id=\"svg1\"
   sodipodi:docname=\"drawing.svg\"
   xmlns:inkscape=\"http://www.inkscape.org/namespaces/inkscape\"
   xmlns:sodipodi=\"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd\"
   xmlns=\"http://www.w3.org/2000/svg\"
   xmlns:svg=\"http://www.w3.org/2000/svg\">
  <sodipodi:namedview
     id=\"namedview1\"
     pagecolor=\"#ffffff\"
     bordercolor=\"#000000\"
     borderopacity=\"0.25\"
     inkscape:showpageshadow=\"2\"
     inkscape:pageopacity=\"0.0\"
     inkscape:pagecheckerboard=\"0\"
     inkscape:deskcolor=\"#d1d1d1\"
     inkscape:document-units=\"px\"
     inkscape:clip-to-page=\"true\"
     inkscape:zoom=\"8.1134749\"
     inkscape:cx=\"19.781906\"
     inkscape:cy=\"40.364949\"
     inkscape:window-width=\"1920\"
     inkscape:window-height=\"1011\"
     inkscape:window-x=\"0\"
     inkscape:window-y=\"0\"
     inkscape:window-maximized=\"1\"
     inkscape:current-layer=\"layer1\" />
  <defs
     id=\"defs1\" />
  <g
     inkscape:label=\"Layer 1\"
     inkscape:groupmode=\"layer\"
     id=\"layer1\">
    <rect
       style=\"fill:($bg);fill-opacity:1;stroke-width:0.0494769\"
       id=\"rect1\"
       width=\"14.816667\"
       height=\"14.816667\"
       x=\"0\"
       y=\"0\" />
    <text
       xml:space=\"preserve\"
       style=\"font-style:italic;line-height:1;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:11.1124px;font-family:'Roboto Serif';-inkscape-font-specification:'Roboto Serif, @GRAD=100,opsz=40,wdth=150';font-variant-ligatures:normal;font-variant-caps:normal;font-variant-numeric:normal;font-variant-east-asian:normal;font-variation-settings:'GRAD' 100, 'opsz' 40, 'wdth' 150;fill:($text);stroke-width:0.926033;fill-opacity:1\"
       x=\"50%\"
       y=\"50%\"
       text-anchor=\"middle\"
       alignment-baseline=\"central\"
       dominant-baseline=\"central\"
       line-height=\"0\"
       id=\"text1\">($letter)</text>
  </g>
</svg>"}

let doot_it = {|path, bg, fg, char|
   let thing = do $svg $bg $fg $char
   print $"dooting ($path)"

   $thing | inkscape -w 1024 -h 1024 --pipe -o $path
}

$colours | each {|colour|
   mkdir $colour.name

   # dark on light
   $alphabet | split chars | each {|char|
      let file = $"($colour.name)/($char | url encode -a).png"
      do $doot_it $file $colour.light $colour.dark-text $char
   }

   # light on dark
   $alphabet | split chars | each {|char|
      let file = $"($colour.name)/($char | url encode -a)-dark.png"
      do $doot_it $file $colour.dark $colour.light $char
   }

   $special | transpose key value | each {|pair|
      let file = $"($colour.name)/($pair.key | url encode -a).png"

      do $doot_it $file $colour.light $colour.dark-text $pair.value
   }

   $special | transpose key value | each {|pair|
      let file = $"($colour.name)/($pair.key | url encode -a)-dark.png"

      do $doot_it $file $colour.dark $colour.light $pair.value
   }
}