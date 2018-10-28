!# /bin/bash

YARNADDLIST = $(
bootstrap-datepicker
bootstrap-daterangepicker
inputmask
sweet-alert
bootstrap-tagsinput
bootstrap-touchspin
twitter-bootstrap-wizard
bootstrap3-wysihtml5-npm
chart.js
chartist
colorpicker
countdown
counterup
custombox
d3
datatables
dropzone
footable
fullcalendar
gmaps
ion-rangelsider
isotope
jquery-circliful
datatables
jquery-knob
multiselect
jquery-sparkline
jquery-ui
jquery-validation
ember-cli-easypiechart
jquery.steps
jstree
magnific-popup
masonry
matches-selector
mocha
moment
nestable
notifications
notifyjs
nvd3
parsleyjs
peity
raphael
requirejs
RWD-Table-Patterns
select2
jquery.simple-text-rotator
spinner
summernote
switchery
tablesaw
bootstrap-tagsinput-qs
editable
tinymce
toggles
waypoints
X-editable)

YARNCOUNT=$(echo "$YARNADDLIST" wc -l)

YARNPKG=$(echo "$YARNADDLIST" | tr '\n' ' ')

echo "Installing [$YARNCOUNT] yarn/npm packages \n" 

#yarn add $YARNPKG
