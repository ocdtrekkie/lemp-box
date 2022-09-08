<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>Warning!</title><style>
	  a { color: gray; }
      @media (prefers-color-scheme: dark) { body { color: #efefef; background-color: #000000; } }
      @media (prefers-color-scheme: light) { body { color: #111111; background-color: #efefef; } }
</style></head>
<body><h1>This app is a Footgun!</h1>
<p>Several crimes against the Sandstorm platform were committed in the design and development of this app. This app does not follow the good design practices of Sandstorm apps, and the Sandstorm project will not support or ensure continued operation of this app. By using this app, you understand that it compromises some of the security benefits of operating within the Sandstorm environment, and have taken appropriate precautions.</p>
<p>This app is largely intended to allow you to host a legacy codebase on Sandstorm. We recommend not storing any sensitive data in a Footgun. We also recommend having a good backup of your Footgun. We do <i>not</i> recommend using a Footgun with <a href="https://github.com/sandstorm-io/sandstorm/wiki/Standalone-Grains" target="_blank">Standalone Grains</a>, but you could, if you acknowledge it is <i>also</i> unsupported, not recommended, and may compromise some of the security benefits of Sandstorm.</p>
<h2>How to use PHP Footgun</h2>
<ul>
<li>Create a grain and download the backup.</li>
<li>Copy the directory of the web application to the /data/www folder inside the zip file.</li>
<li>Copy the database backup as import.sql in the /data/sql folder inside the zip file. (Database name "app", user "root", password "root")</li>
<li>Restore the grain backup to your server and rename the grain title to be explanatory.</li>
</ul>
<h2>PHP/MySQL Support</h2>
<ul>
<li>PHP Version: <?php echo phpversion(); ?></li>
<li>MySQL Version: <?php echo mysqli_get_server_info(mysqli_connect("localhost","root","root","app")); ?></li>
</ul></body></html>