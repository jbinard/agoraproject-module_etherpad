<?php
////	INIT
require "commun.inc.php";

////	SUPPRESSION DE DOSSIER / PAD / ELEMENTS
if(isset($_GET["id_dossier"]))		{ suppr_etherpad_dossier($_GET["id_dossier"]); }
elseif(isset($_GET["id_etherpad"]))		{ suppr_etherpad($_GET["id_etherpad"]); }
elseif(isset($_GET["SelectedElems"]))
{
	foreach(SelectedElemsArray("etherpad") as $id_etherpad)				{ suppr_etherpad($id_etherpad); }
	foreach(SelectedElemsArray("etherpad_dossier") as $id_etherpad)	{ suppr_etherpad_dossier($id_dossier); }
}

////	Redirection
redir("index.php?id_dossier=".$_GET["id_dossier_retour"]);
?>
