<?php
////	INIT
@define("MODULE_NOM","etherpad");
@define("MODULE_PATH","module_etherpad");
require_once "../includes/global.inc.php";
include "etherpad-lite-client.php";

$etherpad_url = '';
$etherpad_api_key = '';

$instance = new EtherpadLiteClient($etherpad_api_key,$etherpad_url.'/api');

$objet["etherpad_dossier"]	= array("type_objet"=>"etherpad_dossier", "cle_id_objet"=>"id_dossier", "type_contenu"=>"etherpad", "cle_id_contenu"=>"id_etherpad", "table_objet"=>"gt_etherpad_dossier");
$objet["etherpad"]			= array("type_objet"=>"etherpad", "cle_id_objet"=>"id_etherpad", "type_conteneur"=>"etherpad_dossier", "cle_id_conteneur"=>"id_dossier", "table_objet"=>"gt_etherpad");
$objet["etherpad_dossier"]["champs_recherche"]	= array("nom","description");
$objet["etherpad"]["champs_recherche"]			= array("nom");
$objet["etherpad"]["tri"]		= array("date_crea@@desc","date_crea@@asc","date_modif@@desc","date_modif@@asc","id_utilisateur@@asc","id_utilisateur@@desc","nom@@asc","nom@@desc");
patch_dossier_racine($objet["etherpad_dossier"]);


////	SUPPRESSION D'UN PAD
////
function suppr_etherpad($id_etherpad)
{
	global $objet;
	global $instance;
	if(droit_acces($objet["etherpad"],$id_etherpad) >= 2)
	{	
		$etherpad_infos = objet_infos($objet["etherpad"],$id_etherpad);

		try {
  			$instance->deletePad($etherpad_infos["id_serveur"]);
			suppr_objet($objet["etherpad"], $id_etherpad);
		} catch (Exception $e) {
  			// the pad doesn't exist?
  			echo "\n\ndelete Pad Failed with message ". $e->getMessage();
		}
	}

}


////	SUPPRESSION D'UN DOSSIER
////
function suppr_etherpad_dossier($id_dossier)
{
	global $objet;
	if(droit_acces($objet["etherpad_dossier"],$id_dossier)==3 && $id_dossier>1)
	{
		// on créé la liste des dossiers & on supprime chaque dossier
		$liste_dossiers_suppr = arborescence($objet["etherpad_dossier"], $id_dossier, "tous");
		foreach($liste_dossiers_suppr as $dossier_tmp)
		{
			// On supprime chaque pad du dossier puis le dossier en question
			$liste_etherpads = db_tableau("SELECT * FROM gt_etherpad WHERE id_dossier='".$dossier_tmp["id_dossier"]."'");
			foreach($liste_etherpads as $infos_etherpad)	{ suppr_etherpad($infos_etherpad["id_etherpad"]); }
			suppr_objet($objet["etherpad_dossier"], $dossier_tmp["id_dossier"]);
		}
	}
}


////	DEPLACEMENT D'UN PAD
////
function deplacer_etherpad($id_etherpad, $id_dossier_destination)
{
	global $objet;
	////	Accès en écriture au pad et au dossier de destination
	if(droit_acces($objet["etherpad"],$id_etherpad)>=2  &&  droit_acces($objet["etherpad_dossier"],$id_dossier_destination)>=2)
	{
		////	Si on deplace à la racine, on donne les droits d'accès de l'ancien dossier
		racine_copie_droits_acces($objet["etherpad"], $id_etherpad, $objet["etherpad_dossier"], $id_dossier_destination);
		////	On déplace le pad
		db_query("UPDATE gt_etherpad SET id_dossier=".db_format($id_dossier_destination)." WHERE id_etherpad=".db_format($id_etherpad));
	}
}


////	DEPLACEMENT D'UN DOSSIER
////
function deplacer_etherpad_dossier($id_dossier, $id_dossier_destination)
{
	global $objet;
	////	Accès total au dossier en question  &  accès en écriture au dossier destination  &  controle du déplacement du dossier
	if(droit_acces($objet["etherpad_dossier"],$id_dossier)==3  &&  droit_acces($objet["etherpad_dossier"],$id_dossier_destination)>=2  &&  controle_deplacement_dossier($objet["etherpad_dossier"],$id_dossier,$id_dossier_destination)==1) {
		db_query("UPDATE gt_etherpad_dossier SET id_dossier_parent=".db_format($id_dossier_destination)." WHERE id_dossier=".db_format($id_dossier));
	}
}
?>
