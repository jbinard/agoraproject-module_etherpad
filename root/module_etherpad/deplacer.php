<?php
////	INIT
require "commun.inc.php";

////	ON DEPLACE PLUSIEURS ELEMENTS
foreach(SelectedElemsArray("etherpad") as $id_etherpad)				{ deplacer_etherpad($id_etherpad, $_POST["id_dossier"]); }
foreach(SelectedElemsArray("etherpad_dossier") as $id_dossier)	{ deplacer_etherpad_dossier($id_dossier, $_POST["id_dossier"]); }

////		DECONNEXION À LA BDD & FERMETURE DU POPUP
reload_close();
?>
