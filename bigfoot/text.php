<? 
include("bigfoot.inc"); 

note0("<img align=center src=img/bigfoot.jpg>"); // !!! change to alter default image

head("BigFoot demo",            // !!! title
       "Your name",             // !!! name
       "Your organization",     // !!! organization
       "Your email",            // !!! email
       "Your home page",        // !!! home page
       "Year of copyright",     // !!! year of copyright
       "Date of last change",   // !!! date of last change
	   "Extra notes for the header" // !!! notes for header
);
?>

<!-- !!! Header page stuff -->

<h2>Abstract</h2>
<p>Lecture notes are tedious to write.
<ul><li>
... and all that reworking for different formats (web, print outs)
</ul>
<p>Standard tools are tedious to use (one wrong window update in WordPress,Moodle, etc and all your changes are lost).
<p>Better to write simple html in raw text editors
<ul><li>Throwing graphics into a large footnote display space, along side the text.
</ul>
<p>Welcome to BigFoot.

<!-- Important! Leave in the  next line -->
<? neck() ?>

<!-- !!! Start your talk here -->

<h1>Downloads</h1>
<p>
Download <a href="http://unbox.org/dust/tags/bigfoot/1.0/bigfoot.zip">http://unbox.org/dust/tags/bigfoot/1.0/bigfoot.zip</a>
<p>Unzip to a fresh, web-accessible directory
<p>Edit index.html:
<ul>
<li>
Change the title 
</ul>
<p>Edit text.php:
<ul>
<li>Look for the lines with "!!!" and make the change appropriatel
<li>Don't change or move the line <em> neck()</em> (near the top) or <em>toes()</em> on the last line.
</ul>

<h1>New page</h1>


<p>You can include <? $eg1=note("footnotes","on any content"); ?>.

<p>Here's a quick way to include <? img("an image","bigfoot01_001.sized.jpg"); ?>
<p>
The footnotes are <? note("auto-numbers ","<img src=img/bones.jpg>"); ?>  
 for ease of <? note("reference","<img src=img/ray_robillard_bigfoot.jpg>"); ?>.

<h1>Newer newer page</h1>

<p> You can even refer back to past <? ref($eg1); ?> footnotes.

<center> <img style="border: 0;" width=100 src=img/theend.jpg> </center>

<? toes() ?>
