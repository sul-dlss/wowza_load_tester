Simple client side ruby script and server side html to get some performance stats on starting streaming files on Wowza server.

The script load_tester.rb opens a list of URLs and tests how long it takes from clicking on the
video play button until the video actually starts playing. This is done with some super basic client
side JavaScript. It would be better to make the load_tester.rb script do this on its own, maybe
using PhantomJS' evaluate() method (currently Selenium is used).

Before running load_tester.rb, you need to put the HTML files on a web server, together with the
wowzaevent.js JavaScript file. You'll also need to add Bootstrap CSS and the VideoJS related
JavaScript files to the web server directory in which the HTML is stored. See the <script> and
<link> tags in the web pages.
