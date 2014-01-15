<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet[
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:mod="modx-1.2.5.xsd">
	<xsl:output method="html" omit-xml-declaration="no" indent="yes" />
	<xsl:variable name="title" select="mod:mod/mod:header/mod:title" />
	<xsl:variable name="version">
		<xsl:for-each select="mod:mod/mod:header/mod:mod-version">
			<xsl:value-of select="current()" />
		</xsl:for-each>
	</xsl:variable>

	<xsl:template match="mod:mod">
		<html xmlns="http://www.w3.org/1999/xhtml">
		<head>
		<meta http-equiv="Content-Language" content="fr" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<style type="text/css">

/* General markup styles
––––––––––––––––––––––––––––––*/
* {
	/* Reset browsers default margin, padding and font sizes */
	margin:0;
	padding:0;
	font-size:100%;
}

/*.rtl * {
	text-align:right;
	direction: rtl;
}*/

body, div, p, th, td, li, dd {
	font-size:x-small;
	voice-family:"\"}\"";
	voice-family:inherit;
	font-size:100%;
}

html>body, html>div, html>p, html>th, html>td, html>li, html>dd {
	font-size:small
}

html {
	color:#536482;
	background:#ffffff;
	/* Always show a scrollbar for short pages - stops the jump when the scrollbar appears. non-ie browsers */
	height:100%;
	margin-bottom:1px;
}

body {
	font-family:"Lucida Grande", Verdana, Helvetica, Arial, sans-serif;
	color:#536482;
	background:#ffffff;
	font-size:82.5%;	/* This sets the default font size to be equivalent to 10px */
	margin:10px 15px;
}

img {
	border:0;
}

h1 {
	font-family:"Trebuchet MS", Helvetica, sans-serif;
	font-size:1.70em;
	font-weight:normal;
	color:#333333;
}

h2, caption {
	font-family:"Trebuchet MS", Helvetica, sans-serif;
	font-size:1.40em;
	font-weight:normal;
	color:#115098;
	text-align:left;
	margin-top:25px;
}

.rtl h2, .rtl caption {
	text-align:right;
}

h3, h4, h5 {
	font-family:"Trebuchet MS", Helvetica, sans-serif;
	font-size:1.20em;
	text-decoration:none;
	line-height:1.20em;
	margin-top:10px;
}

p {
	margin-bottom:0.7em;
	line-height:1.40em;
	font-size:1.0em;
}

ul {
	list-style:disc;
	margin:0 0 1em 2em;
}

.rtl ul {
	margin:0 2em 1em 0;
}

hr {
	border:0 none;
	border-top:1px dashed #999999;
	margin-bottom:5px;
	padding-bottom:5px;
	height:1px;
}

.small {
	font-size:0.85em;
}

/* General links  */
a:link, a:visited {
	color:#105289;
	text-decoration:none;
}

a:link:hover {
	color:#BC2A4D;
	text-decoration:underline;
}

a:active {
	color:#368AD2;
	text-decoration:none;
}

/* Main blocks
––––––––––––––––––––––––––––––––––––––––*/
#wrap {
	padding:0 0 15px 0;
	min-width:615px;
}

#page-header {
	clear:both;
	text-align:right;
	background:url(data:image/gif;base64,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) top left no-repeat;
	height:69px;
	font-size:0.85em;
	margin-bottom:10px;
}

.rtl #page-header {
	text-align:left;
	background:top right no-repeat;
}

#page-header h1 {
	color:#767676;
	font-family:"Trebuchet MS",Helvetica,sans-serif;
	font-size:1.70em;
	padding-top:10px;
}

#page-header p {
	font-size:1.00em;
}

#page-body {
	clear:both;
	min-width:700px;
}

#page-footer {
	clear:both;
	font-size:0.75em;
	text-align:center;
}

#content {
	padding:0 10px 10px 10px;
	position:relative;
}

#content h1 {
	color:#115098;
	line-height:1.2em;
	margin-bottom:0;
}

#main {
	width:100%;
	margin:0;
	min-height:350px;
}

.rtl #main {
	float:right;
	margin:0;
}

* html #main {
	height:350px;
}

/* Main Panel
–––––––––––––––––––––––––––––––––––––––– */
#acp {
	margin:4px 0;
	padding:3px 1px;
	min-width:550px;
	background-color:#FFFFFF;
	border:1px #999999 solid;
}

.panel {
	background:#F3F3F3 url(data:image/gif;base64,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) repeat-x top;
	padding:0;
}

span.corners-top, span.corners-bottom, span.corners-top span, span.corners-bottom span {
	font-size:1px;
	line-height:1px;
	display:block;
	height:5px;
	background-repeat:no-repeat;
}

span.corners-top, span.corners-bottom {
	background-image:url(data:image/gif;base64,R0lGODlhiBMMAMQSAP///5mZmfPz89vX0cvIw9zc3PX19bKysqmopvb29pqamvn5+Z2dnLy6t62sqp+fnqCgn/T09P///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAABIALAAAAACIEwwAAAX/4DAQDhScaKqubOu+cCzPdG3feK7vfO//wKBwSCwaj8ikcslsOp/QqHRKrVqv2Kx2y+16v+CweEwum8/otHrNbrvf8Lh8Tq/b7/i8fs/v+/+AgYKDhIWGh4hSAw0HBREAkJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v8PG7BAoCAAkCEvr7/P3+/wADChxIsKDBgwgTKlzIsKHDhxAjSpxIsaLFixgzatzIsaPHjyBDihxJsqTJkyhT/6pcybKly5cwY8qcSbOmzZs4c+rcybOnz59AgwodSrSo0aNIkypdyrSp06dQo0qdSrWq1atYs2rdShJBAQBcw4odS7as2bNo06pdy7at27dw48qdS7eu3bt48+rdy7ev37+AAwseTLiw4cOIizJYYCCx48eQI0ueTLmy5cuYM2vezLmz58+gQ4seTbq06dOoU6teHToAgHysY8ueTbu27du4c+vezbu379/AgwsfTry48ePIkyuX4Br28ufQo0ufTr269evYs2vfzr279+/gw4sfT7704sbl06tfz769+/fw48ufT7++/fv48+vfzx+vV7D9BSjggAQWaOCBCCao4JmCDDbo4IMQRijhdfTYg8+EGGao4YYcdujhhyCGKOKIJJZo4oko5rVIIwbI4+KLMMYo44w01mjjjTjmqOOOPPbo449ABinkkEQWaeSRSCap5JJMNunkk1BGKeWUVFaZjQgkPJDIllx26eWXYIYp5phklmnmmWimqeaabLbp5ptwxinnnHTWaeedeOap55589unnn4AGKigcIQAAOw==);
}

span.corners-top span, span.corners-bottom span {
	background-image:url(data:image/gif;base64,R0lGODlhBgAMAMQWAP///9vX0fPz85mZmdzc3Jqamtvb28vIw7y6t62sqsvIxPX19bKysqmop/T09Pb29pycnJ+fnp2dnKCgn/n5+fr6+v///wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAEAABYALAAAAAAGAAwAAAUs4DAlRxAADsEggfAAQqFYNGA0tLVQUi4AAx8w56hAcraGCyYDLFSsQYRkCgEAOw==);
}

span.corners-top {
	background-position:0 0;
	margin:-4px -2px 0;
}

span.corners-top span {
	background-position:100% 0;
}

span.corners-bottom {
	background-position:0 100%;
	margin:0 -2px -4px;
	clear:both;
}

span.corners-bottom span {
	background-position:100% 100%;
}

/* General form styles
––––––––––––––––––––––––––––––––––––––––*/
fieldset {
	margin:25px 0;
	padding:1px 0;
	border-top:1px solid #D7D7D7;
	border-right:1px solid #CCCCCC;
	border-bottom:1px solid #CCCCCC;
	border-left:1px solid #D7D7D7;
	background-color:#FFFFFF;
	position:relative;
}

.rtl fieldset {
	border-top:1px solid #D7D7D7;
	border-right:1px solid #D7D7D7;
	border-bottom:1px solid #CCCCCC;
	border-left:1px solid #CCCCCC;
}

* html fieldset {
	padding:0 10px 5px 10px;
}

fieldset p {
	font-size:1.0em;
}

legend {
	padding:1px 5px;
	font-family:Tahoma,arial,Verdana,Sans-serif;
	font-size:1.06em;
	font-weight:bold;
	color:#115098;
	margin-top:-.4em;
	position:relative;
/*	text-transform:capitalize;*/
	line-height:1.00em;
	top:0;
	vertical-align:middle;
}

/* Hide from macIE \*/
legend { top:-1.2em; }
/* end */

* html legend {
	margin-bottom:-10px;
	margin-left:-7px;
}

/* Holly hack, .rtl comes after html */
* html .rtl legend {
	margin:0;
	margin-right:-7px;
}

optgroup, select {
	font-family: Verdana, Helvetica, Arial, sans-serif;
	font-size: 0.85em;
	font-weight: normal;
	font-style: normal;
	cursor: pointer;
	vertical-align: middle;
	width: auto;
}

optgroup {
	font-size: 1.00em;
	font-weight: bold;
}

option {
	padding:0 1em 0 0;
}

.rtl option {
	padding:0 0 0 1em;
}

fieldset.nobg {
	margin:15px 0 0 0;
	padding:0;
	border:none;
	background-color:transparent;
}

/* MOD-ABOUT STUFFS ~smithy_dll */

.mod-about {
	background-color:#CADCEB;
	/*width:100%;*/
}

.mod-about span.corners-top, .mod-about span.corners-bottom, .mod-about span.corners-top span, .mod-about span.corners-bottom span {
	font-size:1px;
	line-height:1px;
	display:block;
	height:5px;
	background-repeat:no-repeat;
}

.mod-about span.corners-top, .mod-about span.corners-bottom {
background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAMCAYAAABBV8wuAAAABGdBTUEAANbY1E9YMgAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAABVSURBVHjaYviPAD+BeDIQ2wMxGwNU8AkQGwAxAwwzQFXqIgvCJCajC8IkbLBJMIItYmD4xYAGmBhwAJCEMS6JcKxa8DkX5kFdbBKwIJkADRIGgAADAGtyotIvyqGpAAAAAElFTkSuQmCC);
}

.mod-about span.corners-top span, .mod-about span.corners-bottom span {	background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAYAAAAMCAYAAABBV8wuAAAABGdBTUEAANbY1E9YMgAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAABbSURBVHjaYvr//z8bENsD8WQg/vkfChjQsAEQPwFJMDGgggtA7AnEv9AlQOAyEM/CJgECK3FJnMIlwYZLQheXRDg2CV0gzmTCIrgd2Q4bIJ4AxGeAWBokABBgAE4XMoXm9S+UAAAAAElFTkSuQmCC);
}

.mod-about span.corners-top {
	background-position:0 0;
	margin:0 0;
}

.mod-about span.corners-top span {
	background-position:100% 0;
}

.mod-about span.corners-bottom {
	background-position:0 100%;
	margin:0 0;
	clear:both;
}

.mod-about span.corners-bottom span {
	background-position:100% 100%;
}

.mod-about-padding { padding: 0 8px; }
.mod-about { margin:7px 4px 10px 4px; }
.mod-about dt { font-weight:bold; padding-right:4px; }
.rtl .mod-about dt { padding-left: 4px; }
.mod-about dl { margin:0 8px; }
.mod-about div { margin:3px 8px;}
/*div.inner .mod-about dl { margin:0; }*/
/*.nopadding { margin:0; }*/

.mod-history {font-size:82.5%; } /* Mod histories can get pretty long, so I'm making that font a bit smaller */
#language { width:130px; }
#modDisclaimer .mod-about, #other-notes.mod-about { background-color:#EECCCC; }
#other-notes.mod-about strong.red { color:#DD3333; }
span.key { font-size:12px; line-height:14px; padding-bottom:2px; width:20px; border:outset 2px #999999; background-color:#EEEECC; display:block; float:left; text-align:center; margin-right:5px; }
.mod-edit { background-color:#D6E6F6; border:solid 1px #336699; margin:10px 0; padding:0 10px; }
.mod-inlineedit { background-color:#DDEEFF; border:solid 1px #6699CC; margin:10px 0; padding:0 10px; }

dl.author-info dd { margin-left:112px; margin-bottom:8px; }
.rtl dl.author-info dd { margin-left:112px; margin-bottom:8px; }
ol#file-copy, ol#file-delete { padding:5px; margin-left:20px; margin-right:20px; margin-bottom:10px; }
ol#file-copy li, ol#file-delete li { margin-left:30px; margin-right:30px; vertical-align:top;}
ol#file-copy span, ol#file-delete span { font-weight:bold; }
ol#file-copy dt, ol#file-delete dt {margin-right:5px; float:none !important }
ol#file-copy dl, ol#file-delete dl {width:100%}
h2#lang-fca, h2#lang-edts, h2#lang-diy, h2#lang-sql, h2#lang-installer-h2, h2#lang-del-head { margin-left:5px; }

/* Code block */
div.codebox {
	padding:3px;
	background-color:#FFFFFF;
	border:1px solid #d8d8d8;
	font-size:1em;
}

div.codebox div.codeHead {
	text-transform:uppercase;
	border-bottom:1px solid #CCCCCC;
	margin-bottom:3px;
	font-size:0.8em;
	font-weight:bold;
	display:block;
}

div.codebox div.codeHead a.codeSelect {
	padding-left:5px;
}

blockquote div.codebox {
	margin-left:0;
}

div.codebox pre {
	/* Also see tweaks.css */
	width:100%;
	overflow-x:scroll;
	display:block;
	height:auto;
	max-height:200px;
	/*white-space:normal;*/
	padding-top:5px;
	font:0.9em Monaco, "Andale Mono","Courier New", Courier, mono;
	line-height:1.3em;
	color:#606060;
	margin:2px 0;
}

/*.rtl div.codePre pre {
	text-align: left !important;
	direction: ltr !important;
}*/

dt {
	float: left;
	width:auto;
}

.rtl dt {
	float: right !important;
	text-align: right;
	width:auto;
}

dd { color:#666666; }
dd + dd { padding-top: 5px; }

dt span { padding: 0 5px 0 0; }
.rtl dt span { padding: 0 0 0 5px; }

div.endMOD { padding:0 5px; }

#history_toggle_link {
	display:block;
}
.edit_toggle_link {
	display:block;
	text-align:right;
	margin-bottom:2px;
}
		</style>
		<title>Cyrakuse.fr &#187; <xsl:value-of select="$title" /></title>
		<script type="text/javascript">
			var i = 0;

			/* passed from xslt */
			<xsl:for-each select="mod:header">
				<xsl:for-each select="mod:author-group">
					var authors_ll = [];
					<xsl:for-each select="mod:author">
						authors_ll.push('<xsl:value-of select="generate-id()"/>');
					</xsl:for-each>
				</xsl:for-each>

				var mhes_ll = [];
				var mhcls_ll = [];
				<xsl:for-each select="mod:history/mod:entry">
					mhes_ll.push('<xsl:value-of select="generate-id()"/>');
					<xsl:if test="count(mod:changelog) > 1">
						mhcls_ll.push('<xsl:value-of select="generate-id()"/>');
					</xsl:if>
				</xsl:for-each>

				var link_ll = [];
				<xsl:for-each select="mod:link-group/mod:link">
					link_ll.push('<xsl:value-of select="generate-id()"/>');
				</xsl:for-each>
			</xsl:for-each>

			var opens_ll = [];
			<xsl:for-each select="mod:action-group/mod:open">
				opens_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			var codes_ll = [];
			<xsl:for-each select="mod:action-group/mod:sql">
				codes_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			var edits_ll = [];
			<xsl:for-each select="mod:action-group/mod:open/mod:edit">
				edits_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			var finds_ll = [];
			var removes_ll = [];
			var regex_ll = [];
			var ifinds_ll = [];
			var iremoves_ll = [];
			var iregex_ll = [];
			var addafters_ll = [];
			var iaddafters_ll = [];
			var addbefores_ll = [];
			var iaddbefores_ll = [];
			var replacewiths_ll = [];
			var ireplacewiths_ll = [];
			var increments_ll = [];
			var iincrements_ll = [];
			var comments_ll = [];
			<xsl:for-each select="mod:action-group/mod:open/mod:edit">
				<xsl:for-each select="mod:find">
					finds_ll.push('<xsl:value-of select="generate-id()"/>');
				</xsl:for-each>
				<xsl:for-each select="mod:remove">
					removes_ll.push('<xsl:value-of select="generate-id()"/>');
				</xsl:for-each>
				<xsl:if test="count(mod:comment) > 0">
					comments_ll.push('<xsl:value-of select="generate-id()"/>');
				</xsl:if>
				<xsl:for-each select="mod:find|mod:action">
					codes_ll.push('<xsl:value-of select="generate-id()"/>');
					<xsl:if test="name() = 'action'">
						<xsl:if test="@type = 'after-add'">
							addafters_ll.push('<xsl:value-of select="generate-id()"/>');
						</xsl:if>
						<xsl:if test="@type = 'before-add'">
							addbefores_ll.push('<xsl:value-of select="generate-id()"/>');
						</xsl:if>
						<xsl:if test="@type = 'replace-with'">
							replacewiths_ll.push('<xsl:value-of select="generate-id()"/>');
						</xsl:if>
						<xsl:if test="@type = 'operation'">
							increments_ll.push('<xsl:value-of select="generate-id()"/>');
						</xsl:if>
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="mod:inline-edit">
					<xsl:for-each select="mod:inline-find">
						ifinds_ll.push('<xsl:value-of select="generate-id()"/>');
						<xsl:if test="@type = 'regex'">
							iregex_ll.push('<xsl:value-of select="generate-id()"/>');
						</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="mod:inline-remove">
						iremoves_ll.push('<xsl:value-of select="generate-id()"/>');
					</xsl:for-each>
					<xsl:for-each select="mod:inline-find|mod:inline-action">
						codes_ll.push('<xsl:value-of select="generate-id()"/>');
						<xsl:if test="name() = 'inline-action'">
							<xsl:if test="@type = 'after-add'">
								iaddafters_ll.push('<xsl:value-of select="generate-id()"/>');
							</xsl:if>
							<xsl:if test="@type = 'before-add'">
								iaddbefores_ll.push('<xsl:value-of select="generate-id()"/>');
							</xsl:if>
							<xsl:if test="@type = 'replace-with'">
								ireplacewiths_ll.push('<xsl:value-of select="generate-id()"/>');
							</xsl:if>
							<xsl:if test="@type = 'operation'">
								iincrements_ll.push('<xsl:value-of select="generate-id()"/>');
							</xsl:if>
						</xsl:if>
					</xsl:for-each>
				</xsl:for-each>
			</xsl:for-each>

			 <xsl:for-each select="mod:action-group/mod:diy-instructions">
				codes_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			var copies_ll = [];
			<xsl:for-each select="mod:action-group/mod:copy/mod:file">
				copies_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			var delete_ll = [];
			<xsl:for-each select="mod:action-group/mod:delete/mod:file">
				delete_ll.push('<xsl:value-of select="generate-id()"/>');
			</xsl:for-each>

			<xsl:text disable-output-escaping="yes">
<![CDATA[
document.onkeydown = mod_do_keypress;


var box = codes_ll;

var arrClasCnt = [
	['a-'	, authors_ll		],
	['c-'	, copies_ll			],
	['del-'	, delete_ll			],
	['cm-'	, comments_ll		],
	['opn'	, opens_ll			],
	['cde-'	, codes_ll			],
	['edt-'	, edits_ll			],
	['fnd'	, finds_ll			],
	['fnd'	, removes_ll			],
	['regex', regex_ll			],
	['rplw'	, replacewiths_ll	],
	['aft'	, addafters_ll		],
	['bef'	, addbefores_ll		],
	['inc'	, increments_ll		],
	['ifnd'	, ifinds_ll			],
	['ifnd'	, iremoves_ll			],
	['regex', iregex_ll			],
	['irplw', ireplacewiths_ll	],
	['iaft'	, iaddafters_ll		],
	['ibef'	, iaddbefores_ll	],
	['iinc'	, iincrements_ll	],
	['mhe'	, mhes_ll			],
	['link', link_ll]
];

function startup()
{
	sql_dropdown();
	change_dbms();
	document.getElementById('lang-selector').style.display = "block";
	init_mod_history();
}


/*****************
* AJAX Functions *
*****************/
var $xmlhttp = http_object();
var $finished = 0;
var $send_queue = [];
var $running = false;
var $divname;
var $newform;
var $newurl;
var $output;

function http_object()
{
	if (window.XMLHttpRequest)
	{
		return new XMLHttpRequest();
	}
	else if (window.ActiveXObject)
	{
		return new ActiveXObject("Microsoft.XMLHTTP");
	}
}

function send($action, $url, $form, $div, $clear)
{
	$newform = $form;
	$newurl = $url;

	$send_queue.push("handle_send($newurl, $newform)");

	if (!$running)
	{
		run_ajax();
	}
	return;
}

function run_ajax()
{
	$running = true;
	for ($i = 0; $i < $send_queue.length; $i++)
	{
		if ($xmlhttp.readyState == 4 || $xmlhttp.readyState == 0)
		{
			eval($send_queue[$i]);
		}
		else
		{
			$xmlhttp.onreadystatechange = check_state;
		}
	}
}

function check_state()
{
	if ($xmlhttp.readyState == 4 || $xmlhtt.readyState == 0)
	{
		eval($send_queue[$finished]);
	}
	else
	{
		$xmlhttp.onreadystatechange = check_state;
	}
}

function handle_send($url, $f)
{
	if ($xmlhttp.readyState == 4 || $xmlhttp.readyState == 0)
	{
		$param = '';

		try
		{
			netscape.security.PrivilegeManager.enablePrivilege("UniversalBrowserRead");
			$allowed = true;
		}
		catch (e)
		{}

		try
		{
			$xmlhttp.open('POST', $url, true);
			$xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			$xmlhttp.onreadystatechange = handle_return;
			$xmlhttp.send($param);
		}
		catch (e)
		{
			$divname = document.getElementById('language');
			var loadingItem = document.createElement('option');
			$divname.appendChild(loadingItem);
			loadingItem.innerHTML = 'Unavailable';
			$divname.remove(0);
			$divname.disabled = true;
		}
	}
	return;
}

function handle_return()
{
	if ($xmlhttp.readyState == 4)
	{
		ajax_output($xmlhttp.responseText);

		$finished++;

		if ($send_queue[$finished])
		{
			check_state();
		}
		else
		{
			$send_queue = [];
			$finished = 0;
			$running = false;
		}
	}
	return;
}
/*********************
* END AJAX Functions *
*********************/

function ajax_output($response)
{
	switch ($output)
	{
		case 'load_language':
			var texts = $response.replace("\r\n", "\n").split("\n");
			applyLanguage(texts);
		break;

		case 'load_languages':
			languages = $response.replace("\r", "").split("\n");

			var i, l, s = 0;
			for (i in languages)
			{
				languages[i] = languages[i].replace("\r", "");
				languages[i] = languages[i].split("=");

				var langItem = document.createElement('option');
				$divname.appendChild(langItem);
				langItem.value = languages[i][0];
				var iso = languages[i][0].split('-');
				langItem.innerHTML = languages[i][1];
				if (iso.length == 2)
				{
					langItem.innerHTML += ' [' + iso[1].toUpperCase() + ']';
				}
				if (languages[i][0] == currentLanguage)
				{
					$divname.selectedIndex = s;
					$divname.text = languages[i][1];
				}
				s++;
			}

			$divname.focus();
			$divname.onchange =
			function()
			{
				changeLanguage(this.value.replace(" ", ""));
			};
			$divname.remove(0);
		break;
	}
}

function in_array(array, value, position)
{
	for (var i = 0; i < array.length; i++)
	{
		// Matches identical (===), not just similar (==).
		if (array[i] === value)
		{
			return (position ? i : true);
		}
	}
	return false;
};

function set_dir(direction)
{
	direction = (direction == 'rtl') ? 'rtl' : 'ltr';
	document.body.style.direction=direction;

	var ie = /*@cc_on!@*/false;
	var dts = document.getElementsByTagName('dt');
	var uls = document.getElementsByTagName('ul');
	var h2s = document.getElementsByTagName('h2');
	var mod_dt = document.getElementsByName('left4px');
	var author_dd = document.getElementsByName('author-dd');
	var ltr_spec = document.getElementsByName('ltr-spec');
	var rtl_spec = document.getElementsByName('rtl-spec');

	var rtl_float = (ie) ? 'styleFloat' : 'cssFloat';

	if(direction == 'rtl')
	{
		for(j = 0; j < dts.length; j++)
		{
			if(ie)
			{
				dts[j].style.styleFloat='right';
			}
			else
			{
				dts[j].style.cssFloat='right';
			}
		}
		for(j = 0; j < h2s.length; j++)
		{
			h2s[j].style.textAlign='right';
		}
		for(j = 0; j < uls.length; j++)
		{
			uls[j].style.margin='0 2em 1em 0';
		}
		for(j = 0; j < ltr_spec.length; j++)
		{
			ltr_spec[j].style.display='none';
		}
		for(j = 0; j < rtl_spec.length; j++)
		{
			rtl_spec[j].style.display='inherit';
		}
		for(j = 0; j < author_dd.length; j++)
		{
			author_dd[j].style.marginRight='115px';
		}
		for(j = 0; j < mod_dt.length; j++)
		{
			mod_dt[j].style.paddingRight='0';
			mod_dt[j].style.paddingLeft='4px';
		}
	}
	else
	{
		for(j = 0; j < dts.length; j++)
		{
			if(ie)
			{
				dts[j].style.styleFloat='left';
			}
			else
			{
				dts[j].style.cssFloat='left';
			}
		}
		for(j = 0; j < h2s.length; j++)
		{
			h2s[j].style.textAlign='left';
		}
		for(j = 0; j < uls.length; j++)
		{
			uls[j].style.margin='0 0 1em 2em';
		}
		for(j = 0; j < ltr_spec.length; j++)
		{
			ltr_spec[j].style.display='inherit';
		}
		for(j = 0; j < rtl_spec.length; j++)
		{
			rtl_spec[j].style.display='none';
		}
		for(j = 0; j < author_dd.length; j++)
		{
			author_dd[j].style.marginleft='112px';
		}
		for(j = 0; j < mod_dt.length; j++)
		{
			mod_dt[j].style.paddingRight='4px';
			mod_dt[j].style.paddingLeft='0';
		}
	}
}

function select_code(a)
{
	// Get ID of code block
	var e = a.parentNode.parentNode.getElementsByTagName('PRE')[0];
	select_text(e.id);
}

var selectedElement = -1;
var boxes = box.length;
var pre_count = 0;

function select_text(id)
{
	var o = document.getElementById(id);
	if(!o)
	{
		return;
	}

	// Not IE
	if (window.getSelection)
	{
		var s = window.getSelection();
		// Safari
		if (s.setBaseAndExtent)
		{
			s.setBaseAndExtent(o, 0, o, o.innerText.length - 1);
		}
		// Firefox and Opera
		else
		{
			var r = document.createRange();
			r.selectNodeContents(o);
			s.removeAllRanges();
			s.addRange(r);
		}
	}
	// Some older browsers
	else if (document.getSelection)
	{
		var s = document.getSelection();
		var r = document.createRange();
		r.selectNodeContents(o);
		s.removeAllRanges();
		s.addRange(r);
	}
	// IE
	else if (document.selection)
	{
		var r = document.body.createTextRange();
		r.moveToElementText(o);
		r.select();
	}

	for(x = 0; x < box.length; x++)
	{
		if (box[x] == id)
		{
			selectedElement = x;
			break;
		}
	}
	return o;
}

/**
* Determines if an object is hidden. If a class is specified, checking will stop when that class is encountered.
*/
function is_hidden(o, className)
{
	o = typeof(o) == 'String' ? document.getElementById(o) : o;
	while (o)
	{
		if (o.style && o.style.display == 'none')
		{
			return true;
		}
		o = (o.parentNode && !(className && o.className == className)) ? o.parentNode : null;
	}
	return false;
}

function findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
	{
		curtop += obj.y;
	}
	return curtop;
}

function selectBox()
{
	obj = select_text(box[selectedElement]);
	window.scrollTo(0, findPosY(obj) - 100);
}

function selectNextBox()
{
	// Find the next box that is not hidden
	for (var i = 0; i < boxes; i++)
	{
		selectedElement = (selectedElement + 1 >= boxes) ? 0 : selectedElement + 1;
		if (!is_hidden(document.getElementById(box[selectedElement]), 'mod-edit-contents'))
		{
			break;
		}
	}
	selectBox();
}

function selectPrevBox()
{
	// Find the previos box that is not hidden
	for (var i = 0; i < boxes; i++)
	{
		selectedElement = (selectedElement - 1 < 0) ? boxes - 1 : selectedElement - 1;
		if (!is_hidden(document.getElementById(box[selectedElement]), 'mod-edit-contents'))
		{
			break;
		}
	}
	selectBox();
}

function selectFirstBox()
{
	// Find the first box that is not hidden
	for (selectedElement = 0; selectedElement < boxes; selectedElement++)
	{
		if (!is_hidden(document.getElementById(box[selectedElement]), 'mod-edit-contents'))
		{
			break;
		}
	}
	selectBox();
}

function mod_do_keypress(e)
{
	var key = (window.event && !window.event.ctrlKey) ? window.event.keyCode : ((e && !e.ctrlKey) ? e.which : null);

	switch (key)
	{
		case 88:	// X
		case 187:	// plus (+)
		case 190:	// period/greater-than (.>)
			selectNextBox();
			return false;
		break;

		case 87:	// W
		case 189:	// minus (-)
		case 188:	// comma/less-than (,<)
			selectPrevBox();
			return false;
		break;

		case 83:	// S
		case 37:
			selectFirstBox();
			return false;
		break;
	}
	return true; // true allows browser to take care of any further key press combinations such as (ctrl|cmd) + c
}



/**
 * Load the sql dropdown with all the database types supported by this MODX file
*/
function sql_dropdown()
{
	var $ie = /*@cc_on!@*/false;
	var $dbms_element = document.getElementById('dbms');
	var $dbms_selector = document.getElementById('dbms-selector');
	if (!$dbms_element || !$dbms_selector)
	{
		return;
	}

/*	if($ie)
	{
		$dbms_selector.style.display = 'none';
		return;
	}
*/
	$type = [
		'mysql',
		'mysql_41',
		'mysql_40',
		'firebird',
		'mssql',
		'oracle',
		'postgres',
		'sqllite'
	];
	$options = [];
	$ie_options = [];
	$ie_count = 0;
	$tags = document.getElementsByTagName('dbms');

	// Show the dbms of type we have selected, hide all others except for non dbms specific
	for ($i = 0; $i < $tags.length; $i++)
	{
		if (!($dbms = $tags[$i].attributes['type'].nodeValue))
		{
			continue;
		}
		if (($position = in_array($type, $dbms, true)) !== false)
		{
			$options[$position] = '<option value=' + $dbms + '>' + $dbms + '</option>';
			if($ie)
			{
				if(!in_array($ie_options, $dbms, false))
				{
					$ie_options[$ie_count++] = $dbms;
				}
			}
		}
	}

	if ($options.length > 0)
	{
		$selects = '';

		// sort options and output in the correct order
		for ($i = 0; $i < $type.length; $i++)
		{
			if ($options[$i])
			{
				$selects += $options[$i];
			}
		}
		$dbms_element.innerHTML=$selects;

		if($ie)
		{
			for($i in $ie_options)
			{
				$ie_option = document.createElement('option');
				$ie_option.text = $ie_options[$i];
				$ie_option.value = $ie_options[$i];
				$dbms_element.add($ie_option);
			}
		}
	}
	else
	{
		$dbms_selector.style.display = 'none';
	}
}
						//-->]]>
					</xsl:text>
/**
* Toggle the visibility of certain sections.
*/
var toggle_strings = {
	'show' : (enStrings.match(/^|\n(?:edt-show=)([^\n]*)\n|$/))[1],
	'hide' : (enStrings.match(/^|\n(?:edt-hide=)([^\n]*)\n|$/))[1]
}
function init_mod_history()
{
<xsl:if test="count(mod:header/mod:history/mod:entry) > 1">
	document.getElementById('mod_history_content').style.display = 'none';
	document.getElementById('history_toggle_area').style.display = '';
	document.getElementById('history_toggle_link').innerHTML = toggle_strings['show'];
</xsl:if>
}

function toggle_display(o, n)
{
	var v = o.rel == 'hide';
	n.style.display = n.style.display == '' ? 'none' : '';
	o.rel = v ? 'show' : 'hide';
	o.innerHTML = toggle_strings[o.rel];
	if (o.id.indexOf('lang-edt-') == 0)
	{
		o.style.textAlign = v ? 'left' : 'right';
	}
	return false;
}

function toggle_history(o)
{
	return toggle_display(o, document.getElementById("mod_history_content"));
}

function toggle_edit(o)
{
	var s = o.previousSibling;
	while (s.nodeType != 1)
	{
		s = s.previousSibling;
	}
	return toggle_display(o, s);
}
				</script>
		</head>
		<body onload="startup()">
		<div id="debug"></div>
		<div id="wrap">
			<div id="page-header">
				<h1><span id="lang-h1">Instructions d'installation pour</span> '<xsl:value-of select="$title" />' <span id="lang-V">version</span>&nbsp;<xsl:value-of select="$version" /></h1>
				
			</div>
			<div id="page-body">
				<div id="acp">
					<div class="panel"><span class="corners-top"><span></span></span>
						<div id="content">
							<div id="main">
								<xsl:for-each select="mod:header">
									<xsl:call-template name="give-header"></xsl:call-template>
								</xsl:for-each>

								<div class="permissions" id="Fieldset1">
									<xsl:for-each select="mod:action-group">
										<xsl:call-template name="give-actions"></xsl:call-template>
									</xsl:for-each>
									<hr style="margin-bottom:0;" />
									<div class="endMOD">
										<h2 id="lang-eom">Sauvegarder tous les fichiers. Fin de l'installation.</h2>
										<p id="lang-eomt">Vous avez terminé l'installation de ce module. Transférez tous les fichiers modifiés sur votre Agora. Si l'installation s'avérait mauvaise, restaurez tout simplement les fichiers sauvegardés précédemment.</p>
									</div>
								</div>
							</div>
						</div>
					<span class="corners-bottom"><span></span></span></div>
				</div>
			</div>
			
		</div>
		</body>
		</html>
	</xsl:template>

	<xsl:template name="give-header">
		<fieldset>
			<legend id="lang-atm">A propos de ce module</legend>
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
				<dl>
					<dt id="lang-t" name="left4px">Nom du module :</dt>
					<dd>
						<xsl:if test="count(mod:title) > 1">
							<dl id="title" class="nopadding">
								<xsl:for-each select="mod:title">
									<dt><xsl:value-of select="@lang" /></dt>
									<dd style='white-space:pre;' lang="{@lang}">
										<p><xsl:value-of select="current()" /></p>
									</dd>
								</xsl:for-each>
							</dl>
						</xsl:if>
						<xsl:if test="count(mod:title) = 1">
							<p lang="{@lang}" style='white-space:pre;'><xsl:value-of select="mod:title" /></p>
						</xsl:if>
					</dd>
					<dt id="lang-d" name="left4px">Description :</dt>
					<dd>
						<xsl:if test="count(mod:description) > 1">
							<dl id="description" class="nopadding">
								<xsl:for-each select="mod:description">
									<dt><xsl:value-of select="@lang" /></dt>
									<dd lang="{@lang}">
										<p>
											<xsl:call-template name="add-line-breaks">
												<xsl:with-param name="string"><xsl:value-of select="current()" /></xsl:with-param>
											</xsl:call-template>
										</p>
									</dd>
								</xsl:for-each>
							</dl>
						</xsl:if>
						<xsl:if test="count(mod:description) = 1">
							<p lang="{@lang}">
								<xsl:call-template name="add-line-breaks">
									<xsl:with-param name="string"><xsl:value-of select="mod:description" /></xsl:with-param>
								</xsl:call-template>
							</p>
						</xsl:if>
					</dd>
					<dt id="lang-aV" name="left4px">Version du module :</dt>
					<dd class="mod-about">
						<p>
							<xsl:for-each select="mod:mod-version">
								<xsl:value-of select="$version" />
							</xsl:for-each>
						</p>
					</dd>
					<dt id="lang-aV" name="left4px">Version d'Agora nécessaire :</dt>
					<dd class="mod-about">
						<p>
							<xsl:value-of select="mod:installation/mod:target-version" />
						</p>
					</dd>
					<xsl:for-each select="mod:installation">
						<xsl:call-template name="give-installation"></xsl:call-template>
					</xsl:for-each>
					<xsl:if test="mod:author-notes != 'N/A' and mod:author-notes != 'n/a' and mod:author-notes != ''">
						<dt id="lang-ant" name="left4px">Notes de l'auteur :</dt>
						<dd>
							<xsl:if test="count(mod:author-notes) > 1">
								<dl id="author-notes" class="nopadding">
									<xsl:for-each select="mod:author-notes">
										<dt><xsl:value-of select="@lang" /></dt>
										<dd lang="{@lang}">
											<p>
												<xsl:call-template name="add-line-breaks">
													<xsl:with-param name="string"><xsl:value-of select="current()" /></xsl:with-param>
												</xsl:call-template>
											</p>
										</dd>
									</xsl:for-each>
								</dl>
							</xsl:if>
							<xsl:if test="count(mod:author-notes) = 1">
								<p lang="{@lang}">
									<xsl:call-template name="add-line-breaks">
										<xsl:with-param name="string"><xsl:value-of select="mod:author-notes" /></xsl:with-param>
									</xsl:call-template>
								</p>
							</xsl:if>
						</dd>
					</xsl:if>
				</dl>
				<span class="corners-bottom"><span></span></span>
			</div>
		</fieldset>
		<fieldset>
			<xsl:for-each select="mod:author-group">
				<xsl:if test="count(mod:author) > 1">
					<legend id="lang-aus">Auteurs</legend>
				</xsl:if>
				<xsl:if test="count(mod:author) = 1">
					<legend id="lang-au">Auteur</legend>
				</xsl:if>
				<xsl:call-template name="give-authors"></xsl:call-template>
			</xsl:for-each>
		</fieldset>
		<xsl:if test="count(../mod:action-group/mod:open) > 0">
			<h3 id="lang-fte">Fichiers à modifier</h3>
			<xsl:for-each select="../mod:action-group">
				<xsl:call-template name="give-files-to-edit"></xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<h3 id="lang-icf">Fichiers inclus</h3>
		<xsl:if test="count(../mod:action-group/mod:copy/mod:file) = 0">
			<p id="lang-icfn">Aucun fichier inclu avec ce module.</p>
		</xsl:if>
		<xsl:for-each select="../mod:action-group">
			<xsl:call-template name="give-files-included"></xsl:call-template>
		</xsl:for-each>
		

		<ul class="link-group" id="link-group">
			<xsl:for-each select="mod:link-group/mod:link">
				<li lang="{@lang}">
					<span class="link-group-lang"><xsl:value-of select="@lang" />&nbsp;</span>
					<strong>
						<xsl:if test="@type = 'contrib'">
							<span id="lang-link-c[{generate-id()}]">Contribution </span>:
						</xsl:if>
						<xsl:if test="@type = 'dependency'">
							<span id="lang-link-d[{generate-id()}]">Dépendance </span>:
						</xsl:if>
						<xsl:if test="@type = 'language'">
							<span id="lang-link-l[{generate-id()}]">Langue </span>:
						</xsl:if>
						<xsl:if test="@type = 'parent'">
							<span id="lang-link-p[{generate-id()}]">Parent </span>:
						</xsl:if>
						<xsl:if test="@type = 'template'">
							<span id="lang-link-te[{generate-id()}]">Template </span>:
						</xsl:if>
						<xsl:if test="@type = 'template-lang'">
							<span id="lang-link-tl[{generate-id()}]">Template lang </span>:
						</xsl:if>
						<xsl:if test="@type = 'text'">
							<span id="lang-link-txt[{generate-id()}]">Text file </span>:
						</xsl:if>
						<xsl:if test="@type = 'uninstall'">
							<span id="lang-link-un[{generate-id()}]">Uninstall instructions </span>:
						</xsl:if>
					</strong>
					&nbsp;<a href="{@href}"><xsl:value-of select="current()" /></a>
				</li>
			</xsl:for-each>
		</ul>
		<hr />
		<div id="modDisclaimer">
			<h3><span id="lang-dcl">Avertissement</span>&nbsp;<span id="lang-ont">et autres informations</span></h3>
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
				<div class="mod-about-padding">
					<p><span id="lang-dclt">Pour des raisons de sécurité, veuillez consulter <a href="http://www.cyrakuse.fr">http://www.cyrakuse.fr</a> afin d'obtenir la dernière version de ce module. Le téléchargement de ce module à partir d'autres sites peut entraîner l'intrusion de code malicieux dans votre Agora. C'est pourquoi Cyrakuse.fr n'offrira aucun support concernant les modules qui ne proviennent pas de notre base de données de modules, située sur <a href="http://www.cyrakuse.fr">http://www.cyrakuse.fr</a></span></p>
					<p><span id="lang-ontt1">Avant d'ajouter ce module à votre Agora, vous devriez effectuer une sauvegarde de tous les fichiers concernés par ce module.</span></p>
					<p><span id="lang-ontt2">Ce module a été conçu pour Agora</span><xsl:text> </xsl:text><xsl:value-of select="mod:installation/mod:target-version" /><xsl:text> </xsl:text>&nbsp;<span id="lang-ontt3">et peut ne pas fonctionner correctement sur d'autres versions de Agora. Les modules pour Agora ne fonctionnent <strong>que</strong> sur la version pour laquelle ils ont été conçus.</span></p>
					<xsl:for-each select="./mod:mod-version">
						<xsl:if test="substring-before(current(), '.') = 0">
							<p><strong class="red"><span id="lang-onttq">Ce module est actuellement en développement. Il est déconseillé de l'installer sur un Agora en production.</span></strong></p>
						</xsl:if>
					</xsl:for-each>
				</div>
				<span class="corners-bottom"><span></span></span>
			</div>
		</div>
		<div>
			<h3><span id="lang-lic">Licence</span>&nbsp;<span id="lang-isp">et support technique</span></h3>
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
				<div class="mod-about-padding">
					<p><span id="lang-lict">Ce module est soumis à la licence suivante :</span></p>
					<p style='white-space:pre;'><a href="license.txt"><xsl:value-of select="mod:license" /></a></p>
					<p><span id="lang-ispt">Tout support technique pour ce module peut être obtenu sur <a href="http://www.cyrakuse.fr">http://www.cyrakuse.fr</a></span></p>
				</div>
				<span class="corners-bottom"><span></span></span>
			</div>
			<xsl:for-each select="mod:history">
				<xsl:call-template name="give-mod-history"></xsl:call-template>
			</xsl:for-each>
		</div>
	</xsl:template>

	<xsl:template name="give-authors">
		<xsl:for-each select="mod:author">
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
					<dl class="author-info">
						<dt id="lang-a-un[{generate-id()}]" name="left4px">Nom d'utilisateur :</dt>

						<xsl:variable name="authorname" select="mod:username" />
						<xsl:for-each select="mod:username">
							<xsl:choose>
								<xsl:when test="@cyrakuse = 'no' or @cyrakuse = 'No' or @cyrakuse = 'NO'">
									<dd name="author-dd"><span dir="ltr"><xsl:value-of select="$authorname" /></span></dd>
								</xsl:when>

								<xsl:otherwise>
									<xsl:variable name="authorurl">
										<xsl:call-template name="validate-username">
											<xsl:with-param name="string-in" select="string($authorname)"/>
										</xsl:call-template>
									</xsl:variable>

									<xsl:variable name="browserEngine" select="system-property('xsl:vendor')" />
									<xsl:choose>
										<xsl:when test="$browserEngine='Opera'">
											<xsl:variable name="operaurl">
												<xsl:call-template name="validate-opera">
													<xsl:with-param name="string-in" select="string($authorurl)"/>
												</xsl:call-template>
											</xsl:variable>
											<dd name="author-dd"><a dir="ltr" href="http://www.cyrakuse.fr/memberlist.php?mode=viewprofile&amp;un={$operaurl}"><xsl:value-of select="$authorname" /></a></dd>
										</xsl:when>
										<xsl:otherwise>
											<dd name="author-dd"><a dir="ltr" href="http://www.cyrakuse.fr/memberlist.php?mode=viewprofile&amp;un={$authorurl}"><xsl:value-of select="$authorname" /></a></dd>
										</xsl:otherwise>

									</xsl:choose>
								</xsl:otherwise>

							</xsl:choose>
						</xsl:for-each>
						<xsl:if test="mod:email != 'N/A' and mod:email != 'n/a' and mod:email != ''">
							<dt id="lang-a-e[{generate-id()}]">Email :</dt>
							<dd name="author-dd"><a href="mailto:{mod:email}"><xsl:value-of select="mod:email" /></a></dd>
						</xsl:if>
						<xsl:if test="mod:realname != 'N/A' and mod:realname != 'n/a' and mod:realname != ''">
							<dt id="lang-a-n[{generate-id()}]">Nom :</dt>
							<dd name="author-dd"><xsl:value-of select="mod:realname" /></dd>
						</xsl:if>
						<xsl:if test="mod:homepage != 'N/A' and mod:homepage != 'n/a' and mod:homepage!=''">
							<dt id="lang-a-h[{generate-id()}]">Site web :</dt>
							<dd name="author-dd"><a href="{mod:homepage}" dir="ltr"><xsl:value-of select="mod:homepage" /></a></dd>
						</xsl:if>
						<xsl:if test="count(mod:contributions-group) > 0">
							<dt id="lang-a-c[{generate-id()}]">Contributions:</dt>
							<xsl:for-each select="mod:contributions-group/mod:contributions">
								<dd name="author-dd">

									<span name="rtl-spec" style="display: none">
										<xsl:if test="@status = 'past' and @from != 'N/A' and @from != 'n/a' and @from!=''">
											<xsl:if test="@to != 'N/A' and @to != 'n/a' and @to!=''">
											<span id="lang-a-c-f[{generate-id()}]">Du</span>:&nbsp;<xsl:value-of select="@from" />&nbsp;<span id="lang-a-c-t[{generate-id()}]]">au</span>:&nbsp;<xsl:value-of select="@to" />
											</xsl:if>
										</xsl:if>
										<xsl:if test="@status = 'current' and @from != 'N/A' and @from != 'n/a' and @from!=''">
											<span id="lang-a-c-s[{generate-id()}]]">Depuis</span>:&nbsp;<xsl:value-of select="@from" />
										</xsl:if>
										&nbsp;<strong style="text-transform: capitalize;"><xsl:value-of select="@position" /></strong>
									</span>

									<span name="ltr-spec">
										<strong style="text-transform: capitalize;"><xsl:value-of select="@position" /></strong>&nbsp;
										<xsl:if test="@status = 'past' and @from != 'N/A' and @from != 'n/a' and @from!=''">
											<xsl:if test="@to != 'N/A' and @to != 'n/a' and @to!=''">
											(<span id="lang-a-c-f[{generate-id()}]]">Du</span>:&nbsp;<xsl:value-of select="@from" />&nbsp;<span id="lang-a-c-t[{generate-id()}]]">au</span>:&nbsp;<xsl:value-of select="@to" />)
											</xsl:if>
										</xsl:if>
										<xsl:if test="@status = 'current' and @from != 'N/A' and @from != 'n/a' and @from!=''">
											(<span id="lang-a-c-s[{generate-id()}]]">Depuis</span>:&nbsp;<xsl:value-of select="@from" />)
										</xsl:if>
									</span>

								</dd>
							</xsl:for-each>
						</xsl:if>
					</dl>
				<span class="corners-bottom"><span></span></span>
			</div>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="give-installation">
		<dt id="lang-il" name="left4px">Difficulté d'installation :</dt>
		<dd class="mod-about">
			<div class="inner">
				<xsl:if test="mod:level='facile'">
					<p id="lang-ile">Facile</p>
				</xsl:if>
				<xsl:if test="mod:level='moyen'">
					<p id="lang-ili">Moyen</p>
				</xsl:if>
				<xsl:if test="mod:level='difficile'">
					<p id="lang-ila">Difficile</p>
				</xsl:if>
			</div>
		</dd>
		<dt id="lang-it" name="left4px">Temps requis pour l'installation :</dt>
		<dd class="mod-about">
			<div class="inner">
				<p>~<xsl:value-of select="floor(mod:time div 60)" />&nbsp;<span id="lang-mint">minutes</span></p>
			</div>
		</dd>
	</xsl:template>

	<xsl:template name="give-mod-history">
		<xsl:if test="count(mod:entry) > 0">
			<fieldset>
			<legend id="lang-mh">Historique du module</legend>
			<div class="mod-about" id="history_toggle_area" style="display:none;">
				<span class="corners-top"><span></span></span>
				<div class="mod-about-padding">
					<a href="#" id="history_toggle_link" rel="show" onclick="return toggle_history(this);"></a>
				</div>
				<span class="corners-bottom"><span></span></span>
			</div>
			<div id="mod_history_content">
			<xsl:for-each select="mod:entry">
				<xsl:call-template name="give-history-entry"></xsl:call-template>
			</xsl:for-each>
			</div>
			</fieldset>
		</xsl:if>
	</xsl:template>

	<xsl:template name="give-history-entry">
		<div class="mod-about">
			<span class="corners-top"><span></span></span>
			<dl class="mod-history">
				<dt>
					<p><strong><xsl:value-of select="substring(mod:date,1,10)" />&nbsp;<span id="lang-mhe-v[{generate-id()}]">- Version</span>
						<xsl:for-each select="mod:rev-version">
							<xsl:value-of select="current()" />
						</xsl:for-each>
						</strong></p>
				</dt>
				<dd><br clear="all" />
					<xsl:if test="count(mod:changelog) > 1">
						<dl id="mhcl[{generate-id()}]">
							<xsl:for-each select="mod:changelog">
								<xsl:call-template name="give-history-entry-changelog"></xsl:call-template>
							</xsl:for-each>
						</dl>
					</xsl:if>
					<xsl:if test="count(mod:changelog) = 1">
						<xsl:for-each select="mod:changelog">
							<xsl:call-template name="give-history-entry-changelog-single"></xsl:call-template>
						</xsl:for-each>
					</xsl:if>
				</dd>
			</dl>
			<span class="corners-bottom"><span></span></span>
		</div>
	</xsl:template>

	<xsl:template name="give-history-entry-changelog">
		<dt><xsl:value-of select="@lang" /></dt>
		<dd lang="{@lang}">
			<ul>
				<xsl:for-each select="mod:change">
					<li>
						<p><xsl:value-of select="current()" /></p>
					</li>
				</xsl:for-each>
			</ul>
		</dd>
	</xsl:template>

	<xsl:template name="give-history-entry-changelog-single">
		<ul>
			<xsl:for-each select="mod:change">
				<li>
					<p><xsl:value-of select="current()" /></p>
				</li>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template name="give-files-to-edit">
		<ul>
			<xsl:for-each select="mod:open">
				<xsl:call-template name="give-file"></xsl:call-template>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template name="give-files-included">
		<ul>
			<xsl:for-each select="mod:copy">
				<xsl:call-template name="give-file-copy"></xsl:call-template>
			</xsl:for-each>
		</ul>
	</xsl:template>

	<xsl:template name="give-file">
		<li><a href="#{@src}"><xsl:value-of select="@src" /></a><xsl:if test="position()!=last()">,</xsl:if></li>
	</xsl:template>

	<xsl:template name="give-file-copy">
		<xsl:for-each select="mod:file">
			<li><xsl:value-of select="@from" />
				<xsl:if test="position()!=last()">,
				</xsl:if>
			</li>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="give-actions">
	  <xsl:if test="count(mod:sql) > 0 or count(mod:copy) > 0 or count(mod:open) > 0">
	  <hr />
    </xsl:if>
		<xsl:if test="count(mod:sql) > 0">
			
			<h2 id="lang-sql">SQL</h2>
			<div id="sql" class="mod-about">
				<span class="corners-top"><span></span></span>
					<xsl:for-each select="mod:sql">
						<xsl:call-template name="give-sql"></xsl:call-template>
					</xsl:for-each>
				<span class="corners-bottom"><span></span></span>
			</div>
		</xsl:if>
		<xsl:if test="count(mod:copy) > 0">
			<xsl:for-each select="mod:copy">
				<xsl:call-template name="give-filez"></xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="count(mod:delete) > 0">
			<xsl:for-each select="mod:delete">
				<xsl:call-template name="away-filez"></xsl:call-template>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="count(mod:open) > 0">
			<h2 id="lang-edts">Modifications</h2>
			<p><span class="key">s</span><span class="key">w</span><span class="key">x</span><span id="lang-edtt">Utilisez votre clavier afin de naviguer entre les différentes boîtes de code. Vous pouvez également appuyer sur la touche '<em>s</em>' de votre clavier afin de vous rendre directement à la première boîte de code.</span></p>
			<div id="edits">
				<div class="inner">
					<xsl:for-each select="mod:open">
						<xsl:call-template name="give-fileo"></xsl:call-template>
					</xsl:for-each>
				</div>
			</div>
		</xsl:if>
		<xsl:if test="count(mod:php-installer) > 0">
			<h2 id="lang-installer-h2">Fichier d'installation PHP</h2>
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
					<div class="mod-about-padding">
						<p>
							<span id="lang-installer-exp1">Un fichier d'installation PHP doit être exécuté afin de terminer l'installation.</span>
							<br />
							<span id="lang-installer-exp2">Pour l'exécuter, veuillez diriger votre navigateur. Par exemple :</span><span dir="ltr"> http://mon_agora.com/<xsl:value-of select="mod:php-installer" /></span>
						</p>
						<div class="content">
							<div class="codebox">
								<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
								<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="mod:php-installer" /></pre></div>
							</div>
						</div>
					</div>
				<span class="corners-bottom"><span></span></span>
			</div>
		</xsl:if>
		<xsl:call-template name="give-manual" />
	</xsl:template>

	<xsl:template name="give-sql">
		<dbms type="{@dbms}">
			<div class="content" name="{@dbms}">
				<xsl:if test="@dbms != ''">
					<xsl:value-of select="@dbms" />:
				</xsl:if>
				<div class="codebox">
					<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
					<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
				</div>
			</div>
		</dbms>
	</xsl:template>

	<xsl:template name="give-manual">
		<xsl:if test="count(mod:diy-instructions)">
			<h2 id="lang-diy">Instructions à effectuer manuellement</h2>
			<div class="mod-about">
				<span class="corners-top"><span></span></span>
					<div class="mod-about-padding">
					<p><span id="lang-diyt">Ce sont les instructions manuelles qui ne peuvent pas être réalisées automatiquement. Vous devriez suivre ces instructions avec attention.</span></p>
					</div>
					<div id="diy">
						<xsl:for-each select="mod:diy-instructions">
							<div lang="{@lang}" style="margin:0;">
								<div class="content">
									<div class="codebox">
										<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
										<div class="codePre"><pre id="{generate-id()}"><xsl:value-of select="current()" /></pre></div>
									</div>
								</div>
							</div>
						</xsl:for-each>
					</div>
				<span class="corners-bottom"><span></span></span>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="give-fileo">
		<div class="mod-about">
			<span class="corners-top"><span></span></span>
			<div class="editFile">
				<h3><span id="lang-opn[{generate-id()}]">Ouvrir :</span>&nbsp;<a name="{@src}"><xsl:value-of select="@src" /></a></h3>
				<xsl:for-each select="mod:edit">
					<div class="mod-edit">
						<div class="mod-edit-contents">
						<xsl:if test="count(mod:comment) > 0">
							<div class="mod-comment" style="margin:0;">
								<h4 id="lang-cm-cmt[{generate-id()}]">Commentaires</h4>
								<dl id="mod-comment[{generate-id()}]">
									<xsl:for-each select="mod:comment">
										<dt><span>
											<xsl:if test="count(../mod:comment) > 1">
												<xsl:value-of select="@lang" />
											</xsl:if>
											</span></dt>
										<dd lang="{@lang}"><xsl:value-of select="current()" /></dd>
									</xsl:for-each>
								</dl>
							</div>
						</xsl:if>
						<xsl:for-each select="mod:find|mod:remove|mod:action|mod:inline-edit">
							<xsl:if test="name() = 'find'">
								<h4 id="lang-fnd[{generate-id()}]">Trouver</h4>
								<p><span id="lang-fndt[{generate-id()}]"><strong>Note :</strong> ceci peut ne correspondre qu'à un résultat partiel et non à la ligne entière.</span>
									<xsl:if test="@type = 'regex'">
										<br /><em id="lang-regex[{generate-id()}]">This find contains an advanced feature known as regular expressions.</em>
									</xsl:if>
								</p>
								<div class="codebox">
									<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
									<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
								</div>
							</xsl:if>
							<xsl:if test="name() = 'remove'">
								<h4 id="lang-remove[{generate-id()}]" style="color: #FF0FFF;">Trouver et effacer</h4>
								<p><span id="lang-removet[{generate-id()}]"><strong>Note :</strong>  Trouver et effacez ce code.</span></p>
								<div class="codebox">
									<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
									<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
								</div>
							</xsl:if>
							<xsl:if test="name() = 'action'">
								<xsl:if test="@type = 'after-add'">
									<h4 id="lang-aft[{generate-id()}]" style="color: #009933;">Ajouter après</h4>
									<p><span id="lang-aftt[{generate-id()}]"><strong>Note :</strong> ajoutez ces lignes sur une nouvelle ligne vierge et après les lignes que vous aviez à trouver précédemment.</span></p>
								</xsl:if>
								<xsl:if test="@type = 'before-add'">
									<h4 id="lang-bef[{generate-id()}]" style="color: #AC1987;">Ajouter avant</h4>
									<p><span id="lang-beft[{generate-id()}]"><strong>Note :</strong> ajoutez ces lignes sur une nouvelle ligne vierge et avant les lignes que vous aviez à trouver précédemment.</span></p>
								</xsl:if>
								<xsl:if test="@type = 'replace-with'">
									<h4 id="lang-rplw[{generate-id()}]" style="color: #AE1616;">Remplacer par</h4>
									<p><span id="lang-rplwt[{generate-id()}]"><strong>Note :</strong> remplacez les lignes que vous aviez à trouver précédemment par les lignes suivantes.</span></p>
								</xsl:if>
								<xsl:if test="@type = 'operation'">
									<h4 id="lang-inc[{generate-id()}]" style="color: #333333;">Operation</h4>
									<p><span id="lang-inct[{generate-id()}]"><strong>Tip:</strong> This allows you to alter integers.</span></p>
								</xsl:if>
								<div class="codebox">
									<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
									<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
								</div>
							</xsl:if>
							<xsl:if test="name() = 'inline-edit'">
								<div class="mod-inlineedit">
									<xsl:for-each select="mod:inline-find|mod:inline-remove|mod:inline-action|mod:inline-comment">
										<xsl:if test="name() = 'inline-find'">
											<h5 id="lang-ifnd[{generate-id()}]">Dans la ligne, trouver</h5>
											<p><span id="lang-ifndt[{generate-id()}]"><strong>Note :</strong> ceci correspond à un résultat partiel de la ligne dans laquelle il faut effectuer les opérations.</span>
												<xsl:if test="@type = 'regex'">
													<br /><em id="lang-regex[{generate-id()}]">This find contains an advanced feature known as regular expressions.</em>
												</xsl:if>
											</p>
											<div class="codebox">
												<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
												<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
											</div>
										</xsl:if>
										<xsl:if test="name() = 'inline-remove'">
											<h5 id="lang-iremove[{generate-id()}]" style="color: #FF0FFF;">Dans la ligne, trouver et effacer</h5>
											<p><span id="lang-iremovet[{generate-id()}]"><strong>Note :</strong> Trouvez ce code dans la ligne et effacez-le.</span></p>
											<div class="codebox">
												<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
												<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
											</div>
										</xsl:if>
										<xsl:if test="name() = 'inline-action'">
											<xsl:if test="@type = 'after-add'">
												<h5 id="lang-iaft[{generate-id()}]" style="color: #009933;">Dans la ligne, ajouter après</h5>
												<p><span id="lang-iaftt[{generate-id()}]"></span></p>
											</xsl:if>
											<xsl:if test="@type = 'before-add'">
												<h5 id="lang-ibef[{generate-id()}]" style="color: #AC1987;">Dans la ligne, ajouter avant</h5>
												<p><span id="lang-ibeft[{generate-id()}]"></span></p>
											</xsl:if>
											<xsl:if test="@type = 'replace-with'">
												<h5 id="lang-irplw[{generate-id()}]" style="color: #AE1616;">Dans la ligne, remplacer par</h5>
												<p><span id="lang-irplwt[{generate-id()}]"></span></p>
											</xsl:if>
											<xsl:if test="@type = 'operation'">
												<h5 id="lang-iinc[{generate-id()}]" style="color: #333333;">In-line Operation</h5>
												<p><span id="lang-iinct[{generate-id()}]"><strong>Tip:</strong> This allows you to alter integers.</span></p>
											</xsl:if>
											<div class="codebox">
												<div class="codeHead"><span id="lang-cde-c[{generate-id()}]">Code :</span><a href="#" onclick="select_code(this); return false;" class="codeSelect"><span id="lang-cde-sa[{generate-id()}]">Sélectionner tout</span></a></div>
												<div class="codePre"><pre id="{generate-id()}" dir="ltr"><xsl:value-of select="current()" /></pre></div>
											</div>
										</xsl:if>
										<xsl:if test="name() = 'inline-comment'">
											<dl id="comment[{generate-id()}]">
												<dt><span id="lang-cm-cmt[{generate-id()}]">Commentaires</span>&nbsp;<span><xsl:value-of select="@lang" /></span></dt>
												<dd lang="{@lang}"><xsl:value-of select="current()" /></dd>
											</dl>
										</xsl:if>
									</xsl:for-each>
								</div>
							</xsl:if>
						</xsl:for-each>
						</div>
						<a href="#" id="lang-edt-hide[{generate-id()}]" class="edit_toggle_link" rel="hide" onclick="return toggle_edit(this);">&lt;&lt;&nbsp;Cacher</a>
					</div>
				</xsl:for-each>
			</div>
			<span class="corners-bottom"><span></span></span>
		</div>
	</xsl:template>

	<xsl:template name="give-filez">
		<h2 id="lang-fca">Transfert de fichiers</h2>
		<ol id="file-copy">
			<xsl:for-each select="mod:file">
				<li>
					<dl>
						<dt><span id="lang-c-copy[{generate-id()}]">Transfert FTP de :</span>&nbsp;<xsl:value-of select="@from" /></dt>
						<dd><span id="lang-c-to[{generate-id()}]">sur :</span>&nbsp;<xsl:value-of select="@to" /></dd>
					</dl>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>

	<xsl:template name="away-filez">
		<xsl:choose>
			<xsl:when test="count(mod:file) > 1">
				<h2 id="lang-del-heads">Effacement de fichier</h2>
			</xsl:when>
			<xsl:otherwise>
				<h2 id="lang-del-head">Supprimer</h2>
			</xsl:otherwise>
		</xsl:choose>
		<ol id="file-delete">
			<xsl:for-each select="mod:file">
				<li>
					<dl>
						<dt><span id="lang-del-file[{generate-id()}]">Supprimer:</span>&nbsp;<xsl:value-of select="@name" /></dt>
					</dl>
				</li>
			</xsl:for-each>
		</ol>
	</xsl:template>

	<!-- add-line-breaks borrowed from http://www.stylusstudio.com/xsllist/200103/post40180.html -->
	<xsl:template name="add-line-breaks">
		<xsl:param name="string" select="." />
		<xsl:choose>
			<xsl:when test="contains($string, '&#xA;')">
				<xsl:value-of select="substring-before($string, '&#xA;')" /><br />
				<xsl:call-template name="add-line-breaks"><xsl:with-param name="string" select="substring-after($string, '&#xA;')" /></xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$string" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- replace function borrowed from http://www.dpawson.co.uk/xsl/sect2/replace.html#d9701e43 -->
	<xsl:template name="replaceCharsInString">
		<xsl:param name="stringIn"/>
		<xsl:param name="charsIn"/>
		<xsl:param name="charsOut"/>
		<xsl:choose>
			<xsl:when test="contains($stringIn,$charsIn)">
				<xsl:value-of select="concat(substring-before($stringIn,$charsIn),$charsOut)"/>
				<xsl:call-template name="replaceCharsInString">
					<xsl:with-param name="stringIn" select="substring-after($stringIn,$charsIn)"/>
					<xsl:with-param name="charsIn" select="$charsIn"/>
					<xsl:with-param name="charsOut" select="$charsOut"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$stringIn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Replace some chars -->
	<xsl:template name="validate-username">
		<xsl:param name="string-in"/>

		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">

		<xsl:call-template name="replaceCharsInString">
			<xsl:with-param name="stringIn" select="string($string-in)"/>
			<xsl:with-param name="charsIn" select="'#'"/>
			<xsl:with-param name="charsOut" select="'%23'"/>
		</xsl:call-template>

		</xsl:with-param><xsl:with-param name="charsIn" select="'&amp;'"/><xsl:with-param name="charsOut" select="'%26'"/></xsl:call-template> <!-- & -->
		</xsl:with-param><xsl:with-param name="charsIn" select="'+'"/><xsl:with-param name="charsOut" select="'%2B'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="' '"/><xsl:with-param name="charsOut" select="'%20'"/></xsl:call-template> <!-- space -->
	</xsl:template>

	<!-- This is only needed for Opera support, hiding it here at the bottom. -->
	<xsl:template name="validate-opera">
		<xsl:param name="string-in"/>

		<!-- This doesn't follow any coding guidelines. But is easier to read this way -->
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">
		<xsl:call-template name="replaceCharsInString"><xsl:with-param name="stringIn">

		<xsl:call-template name="replaceCharsInString">
			<xsl:with-param name="stringIn" select="string($string-in)"/>
			<xsl:with-param name="charsIn" select="'é'"/>
			<xsl:with-param name="charsOut" select="'%C3%A9'"/>
		</xsl:call-template>

		</xsl:with-param><xsl:with-param name="charsIn" select="'ÿ'"/><xsl:with-param name="charsOut" select="'%C3%BF'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'þ'"/><xsl:with-param name="charsOut" select="'%C3%BE'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ý'"/><xsl:with-param name="charsOut" select="'%C3%BD'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ü'"/><xsl:with-param name="charsOut" select="'%C3%BC'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'û'"/><xsl:with-param name="charsOut" select="'%C3%BB'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ú'"/><xsl:with-param name="charsOut" select="'%C3%BA'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ù'"/><xsl:with-param name="charsOut" select="'%C3%B9'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ø'"/><xsl:with-param name="charsOut" select="'%C3%B8'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'÷'"/><xsl:with-param name="charsOut" select="'%C3%B7'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ö'"/><xsl:with-param name="charsOut" select="'%C3%B6'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'õ'"/><xsl:with-param name="charsOut" select="'%C3%B5'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ô'"/><xsl:with-param name="charsOut" select="'%C3%B4'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ó'"/><xsl:with-param name="charsOut" select="'%C3%B3'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ò'"/><xsl:with-param name="charsOut" select="'%C3%B2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ñ'"/><xsl:with-param name="charsOut" select="'%C3%B1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ð'"/><xsl:with-param name="charsOut" select="'%C3%B0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ï'"/><xsl:with-param name="charsOut" select="'%C3%AF'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'î'"/><xsl:with-param name="charsOut" select="'%C3%AE'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'í'"/><xsl:with-param name="charsOut" select="'%C3%AD'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ì'"/><xsl:with-param name="charsOut" select="'%C3%AC'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ë'"/><xsl:with-param name="charsOut" select="'%C3%AB'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ê'"/><xsl:with-param name="charsOut" select="'%C3%AA'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'é'"/><xsl:with-param name="charsOut" select="'%C3%A9'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'è'"/><xsl:with-param name="charsOut" select="'%C3%A8'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ç'"/><xsl:with-param name="charsOut" select="'%C3%A7'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'æ'"/><xsl:with-param name="charsOut" select="'%C3%A6'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'å'"/><xsl:with-param name="charsOut" select="'%C3%A5'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ä'"/><xsl:with-param name="charsOut" select="'%C3%A4'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ã'"/><xsl:with-param name="charsOut" select="'%C3%A3'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'â'"/><xsl:with-param name="charsOut" select="'%C3%A2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'á'"/><xsl:with-param name="charsOut" select="'%C3%A1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'à'"/><xsl:with-param name="charsOut" select="'%C3%A0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ß'"/><xsl:with-param name="charsOut" select="'%C3%9F'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Þ'"/><xsl:with-param name="charsOut" select="'%C3%9E'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ý'"/><xsl:with-param name="charsOut" select="'%C3%9D'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ü'"/><xsl:with-param name="charsOut" select="'%C3%9C'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Û'"/><xsl:with-param name="charsOut" select="'%C3%9B'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ú'"/><xsl:with-param name="charsOut" select="'%C3%9A'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ù'"/><xsl:with-param name="charsOut" select="'%C3%99'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ø'"/><xsl:with-param name="charsOut" select="'%C3%98'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'×'"/><xsl:with-param name="charsOut" select="'%C3%97'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ö'"/><xsl:with-param name="charsOut" select="'%C3%96'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Õ'"/><xsl:with-param name="charsOut" select="'%C3%95'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ô'"/><xsl:with-param name="charsOut" select="'%C3%94'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ó'"/><xsl:with-param name="charsOut" select="'%C3%93'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ò'"/><xsl:with-param name="charsOut" select="'%C3%92'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ñ'"/><xsl:with-param name="charsOut" select="'%C3%91'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ð'"/><xsl:with-param name="charsOut" select="'%C3%90'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ï'"/><xsl:with-param name="charsOut" select="'%C3%8F'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Î'"/><xsl:with-param name="charsOut" select="'%C3%8E'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Í'"/><xsl:with-param name="charsOut" select="'%C3%8D'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ì'"/><xsl:with-param name="charsOut" select="'%C3%8C'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ë'"/><xsl:with-param name="charsOut" select="'%C3%8B'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ê'"/><xsl:with-param name="charsOut" select="'%C3%8A'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'É'"/><xsl:with-param name="charsOut" select="'%C3%89'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'È'"/><xsl:with-param name="charsOut" select="'%C3%88'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ç'"/><xsl:with-param name="charsOut" select="'%C3%87'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Æ'"/><xsl:with-param name="charsOut" select="'%C3%86'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Å'"/><xsl:with-param name="charsOut" select="'%C3%85'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ä'"/><xsl:with-param name="charsOut" select="'%C3%84'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ã'"/><xsl:with-param name="charsOut" select="'%C3%83'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Â'"/><xsl:with-param name="charsOut" select="'%C3%82'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Á'"/><xsl:with-param name="charsOut" select="'%C3%81'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'À'"/><xsl:with-param name="charsOut" select="'%C3%80'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¿'"/><xsl:with-param name="charsOut" select="'%C2%BF'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¾'"/><xsl:with-param name="charsOut" select="'%C2%BE'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'½'"/><xsl:with-param name="charsOut" select="'%C2%BD'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¼'"/><xsl:with-param name="charsOut" select="'%C2%BC'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'»'"/><xsl:with-param name="charsOut" select="'%C2%BB'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'º'"/><xsl:with-param name="charsOut" select="'%C2%BA'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¹'"/><xsl:with-param name="charsOut" select="'%C2%B9'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¸'"/><xsl:with-param name="charsOut" select="'%C2%B8'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'·'"/><xsl:with-param name="charsOut" select="'%C2%B7'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¶'"/><xsl:with-param name="charsOut" select="'%C2%B6'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'µ'"/><xsl:with-param name="charsOut" select="'%C2%B5'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'´'"/><xsl:with-param name="charsOut" select="'%C2%B4'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'³'"/><xsl:with-param name="charsOut" select="'%C2%B3'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'²'"/><xsl:with-param name="charsOut" select="'%C2%B2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'±'"/><xsl:with-param name="charsOut" select="'%C2%B1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'°'"/><xsl:with-param name="charsOut" select="'%C2%B0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¯'"/><xsl:with-param name="charsOut" select="'%C2%AF'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'®'"/><xsl:with-param name="charsOut" select="'%C2%AE'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¬'"/><xsl:with-param name="charsOut" select="'%C2%AC'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'«'"/><xsl:with-param name="charsOut" select="'%C2%AB'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ª'"/><xsl:with-param name="charsOut" select="'%C2%AA'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'©'"/><xsl:with-param name="charsOut" select="'%C2%A9'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¨'"/><xsl:with-param name="charsOut" select="'%C2%A8'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'§'"/><xsl:with-param name="charsOut" select="'%C2%A7'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¦'"/><xsl:with-param name="charsOut" select="'%C2%A6'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¥'"/><xsl:with-param name="charsOut" select="'%C2%A5'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¤'"/><xsl:with-param name="charsOut" select="'%C2%A4'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'£'"/><xsl:with-param name="charsOut" select="'%C2%A3'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¢'"/><xsl:with-param name="charsOut" select="'%C2%A2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'¡'"/><xsl:with-param name="charsOut" select="'%C2%A1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ÿ'"/><xsl:with-param name="charsOut" select="'%C5%B8'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ž'"/><xsl:with-param name="charsOut" select="'%C5%BE'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'œ'"/><xsl:with-param name="charsOut" select="'%C5%93'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'›'"/><xsl:with-param name="charsOut" select="'%E2%80%BA'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'š'"/><xsl:with-param name="charsOut" select="'%C5%A1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'™'"/><xsl:with-param name="charsOut" select="'%E2%84%A2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'˜'"/><xsl:with-param name="charsOut" select="'%CB%9C'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'—'"/><xsl:with-param name="charsOut" select="'%E2%80%94'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'–'"/><xsl:with-param name="charsOut" select="'%E2%80%93'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'•'"/><xsl:with-param name="charsOut" select="'%E2%80%A2'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'”'"/><xsl:with-param name="charsOut" select="'%E2%80%9D'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'“'"/><xsl:with-param name="charsOut" select="'%E2%80%9C'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'’'"/><xsl:with-param name="charsOut" select="'%E2%80%99'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'‘'"/><xsl:with-param name="charsOut" select="'%E2%80%98'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Ž'"/><xsl:with-param name="charsOut" select="'%C5%BD'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Œ'"/><xsl:with-param name="charsOut" select="'%C5%92'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'‹'"/><xsl:with-param name="charsOut" select="'%E2%80%B9'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'Š'"/><xsl:with-param name="charsOut" select="'%C5%A0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'‰'"/><xsl:with-param name="charsOut" select="'%E2%80%B0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ˆ'"/><xsl:with-param name="charsOut" select="'%CB%86'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'‡'"/><xsl:with-param name="charsOut" select="'%E2%80%A1'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'†'"/><xsl:with-param name="charsOut" select="'%E2%80%A0'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'…'"/><xsl:with-param name="charsOut" select="'%E2%80%A6'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'„'"/><xsl:with-param name="charsOut" select="'%E2%80%9E'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'ƒ'"/><xsl:with-param name="charsOut" select="'%C6%92'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'‚'"/><xsl:with-param name="charsOut" select="'%E2%80%9A'"/></xsl:call-template>
		</xsl:with-param><xsl:with-param name="charsIn" select="'€'"/><xsl:with-param name="charsOut" select="'%E2%82%AC'"/></xsl:call-template>
	</xsl:template>

</xsl:stylesheet>