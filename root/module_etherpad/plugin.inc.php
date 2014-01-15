<?php
////	PAD
$liste_etherpads = db_tableau("SELECT DISTINCT * FROM gt_etherpad WHERE ".sql_affichage_objets_arbo($objet["etherpad"])." ".sql_selection_plugins($objet["etherpad"])."  ORDER BY date_crea desc");
foreach($liste_etherpads as $etherpad_tmp)
{
	$opener = ($cfg_plugin["mode"]=="recherche") ? ".opener" : "";
	$resultat_tmp = array("type"=>"elem", "module_path"=>$cfg_plugin["module_path"]);
	$resultat_tmp["lien_js_icone"] = "window".$opener.".location.replace('".ROOT_PATH.$cfg_plugin["module_path"]."/index.php?id_dossier=".$etherpad_tmp["id_dossier"]."');";
	$resultat_tmp["lien_js_libelle"] = "popup('".ROOT_PATH.$cfg_plugin["module_path"]."/etherpad.php?id_etherpad=".$etherpad_tmp["id_etherpad"]."','etherpad".$etherpad_tmp["id_etherpad"]."');";
	$resultat_tmp["libelle"] = "<span ".infobulle(chemin($objet["etherpad_dossier"],$etherpad_tmp["id_dossier"],"url_virtuelle")."<br>".$trad["auteur"]." ".auteur($etherpad_tmp["id_utilisateur"],$etherpad_tmp["invite"])).">".$etherpad_tmp["nom"]."</span>";
	$cfg_plugin["resultats"][] = $resultat_tmp;
}
////	DOSSIERS
$liste_dossiers	= db_tableau("SELECT * FROM gt_etherpad_dossier WHERE 1 ".sql_affichage($objet["etherpad_dossier"])." ".sql_selection_plugins($objet["etherpad_dossier"])."  ORDER BY date_crea desc");
foreach($liste_dossiers as $dossier_tmp)
{
	$resultat_tmp = array("type"=>"dossier", "module_path"=>$cfg_plugin["module_path"]);
	$resultat_tmp["etherpad_js_icone"] = "window.location.replace('".ROOT_PATH.$cfg_plugin["module_path"]."/index.php?id_dossier=".$dossier_tmp["id_dossier"]."');";
	$resultat_tmp["etherpad_js_libelle"] = $resultat_tmp["etherpad_js_icone"];
	$resultat_tmp["libelle"] = $dossier_tmp["nom"];
	$cfg_plugin["resultats"][] = $resultat_tmp;
}
?>
