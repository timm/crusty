<?
$noteTxt ="";
$n=0;
function toes() {
 echo "</div>";
 notes();
 echo "</body>";
}


function head($title, $author, $organization, $email, $url, $year, $date,$thanks) {
echo <<<EEOTT
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd"> 
<HTML> 
  <HEAD> 
     <link rel="stylesheet" media="screen" type="text/css" href="img/screen.css" /> 
     <link rel="stylesheet" media="print" type="text/css" href="img/print.css" /> 
     <TITLE>$title </title> 
</HEAD>
<body>
<div class=header>



<p>        <em><font size="0"><a target="_top" href="index.html">display</a> | <a target="_top" href="text.php">print</a></em></font></p>
<H1 >$title</h1>

<p>
&copy; $year <a href="$url">$author</a><br>
$organization<br>
<a target="_top" href="$url">$url</a><br>
<a href="mailto:$email">$email</a><br>
$date




<p>         
<a target="_top" rel="license" 
href="http://creativecommons.org/licenses/by-sa/3.0/">
<img 
  alt="Creative Commons License"   align=right style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png"/></a>
This work is licensed under a
<a rel="license" target="_top" 
href="http://creativecommons.org/licenses/by-sa/3.0/">
Creative Commons Attribution-Share Alike 3.0  License</a>.

$thanks
<hr>
EEOTT;
}
function neck() {
	 echo "</div><div class=body>";
}
function note0($note) {
   global $noteTxt;
   global $n;
   $noteTxt .=  "<li><a name=\"0\">\n" . $note . "\n";
   return $n;
}
function ref($ref ) {
	    echo "[<a target=rhs href=\"#$ref\">$ref</a>]";
}

function img($str, $img) {
	 return note($str,"<img src=img/$img>");
}
function note($str, $note) {
   global $n;
   global $noteTxt;
   $n++;
   echo "<span class=it>$str</span> <a target=rhs href=\"#$n\">[$n]</a>";
   $noteTxt .=  "<li><a name=\"". $n . "\">\n" . $note . "\n";
   return $n;
}
function notes() {
 global  $noteTxt;
 echo "<div class=refs>\n<h1>Notes</h1><ol>\n" . $noteTxt ."\n</ol></div>";
}

function aa( $txt ) {
	 echo "asdadasd " . $txt;
}
?>
