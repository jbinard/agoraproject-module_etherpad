<?php
////	INIT
require "commun.inc.php";
require_once PATH_INC."header.inc.php";
if(@$_REQUEST["id_etherpad"]>0)		{ $etherpad_tmp = objet_infos($objet["etherpad"],$_REQUEST["id_etherpad"]);  droit_acces_controler($objet["etherpad"], $etherpad_tmp, 1.5); }
else							{ $etherpad_tmp = array("id_dossier"=> $_REQUEST["id_dossier"], "nom"=>""); }

function id_serveur ($length = 8){
    $password = "";
    $possible = "2346789bcdfghjkmnpqrtvwxyzBCDFGHJKLMNPQRTVWXYZ";
    $maxlength = strlen($possible);
    if ($length > $maxlength) {
      $length = $maxlength;
    }
    $i = 0; 
    while ($i < $length) { 
      $char = substr($possible, mt_rand(0, $maxlength-1), 1);
      if (!strstr($password, $char)) { 
        $password .= $char;
        $i++;
      }
    }
    return $password;
}

////	VALIDATION DU FORMULAIRE
////
if(isset($_POST["id_etherpad"]))
{
	////	MODIF / AJOUT
	$id_serveur = id_serveur();
	$corps_sql = " nom=".db_format($_POST["nom"]).", id_serveur=".db_format($id_serveur).", raccourci=".db_format(@$_POST["raccourci"],"bool")." "; 
	if($_POST["id_etherpad"] > 0){
		db_query("UPDATE gt_etherpad SET nom=".db_format($_POST["nom"]).", raccourci=".db_format(@$_POST["raccourci"],"bool")." WHERE id_etherpad=".db_format($_POST["id_etherpad"]));
		add_logs("modif", $objet["etherpad"], $_POST["id_etherpad"]);
	}
	else{
		try {
  			$instance->createPad($id_serveur,'');

			db_query("INSERT INTO gt_etherpad SET id_dossier=".db_format($_POST["id_dossier"]).", date_crea='".db_insert_date()."', id_utilisateur='".$_SESSION["user"]["id_utilisateur"]."', invite=".db_format(@$_POST["invite"]).", ".$corps_sql);
		$_POST["id_etherpad"] = db_last_id();

		} catch (Exception $e) {
  			echo "\n\ncreate Pad Failed with message ". $e->getMessage();
		}
	}

	////	AFFECTATION DES DROITS D'ACCÈS  +  AJOUT FICHIERS JOINTS
	affecter_droits_acces($objet["etherpad"],$_POST["id_etherpad"]);
	ajouter_fichiers_joint($objet["etherpad"],$_POST["id_etherpad"]);

	////	ENVOI DE NOTIFICATION PAR MAIL
	if(isset($_POST["notification"]))
	{
		$liste_id_destinataires = users_affectes($objet["etherpad"], $_POST["id_etherpad"]);
		$objet_mail = $trad["ETHERPAD_mail_nouveau_etherpad_cree"]." ".$_SESSION["user"]["nom"]." ".$_SESSION["user"]["prenom"];
		$contenu_mail = "Un nouveau pad a &eacute;t&eacute; cr&eacute;&eacute; : ".$_POST["nom"];
		envoi_mail($liste_id_destinataires, $objet_mail, magicquotes_strip($contenu_mail), array("notif"=>true));
	}

	////	FERMETURE DU POPUP
	reload_close();
}
?>

<style type="text/css">  body {  background-image:url('<?php echo PATH_TPL; ?>module_etherpad/fond_popup.png');  }  </style>
<script type="text/javascript">
////	Redimensionne
resize_iframe_popup(650,<?php echo ($etherpad_tmp["id_dossier"]==1)?"500":"300"; ?>);

////	CONTROLE VALIDATION FINALE
function controle_formulaire()
{
	// Il doit y avoir un nom
	if(get_value("nom").length==0){
		alert("<?php echo $trad["ETHERPAD_specifier_nom"]; ?>");
		return false;
	}
	// Controle le nombre de groupes et d'utilisateurs
	if(Controle_Menu_Objet()==false)	return false;
}
</script>


<form action="<?php echo php_self(); ?>" method="post" enctype="multipart/form-data" OnSubmit="return controle_formulaire();" style="padding:10px;font-weight:bold;">

	<?php
	////	NOM
	echo "<fieldset>";
		echo $trad["ETHERPAD_nom"]." <input type=\"text\" name=\"nom\" id=\"nom\" value=\"".$etherpad_tmp["nom"]."\" style=\"width:400px\" /><br><br>";
	echo "</fieldset>";

	////	DROITS D'ACCES ET OPTIONS
	$cfg_menu_edit = array("objet"=>$objet["etherpad"], "id_objet"=>@$etherpad_tmp["id_etherpad"]);
	require_once PATH_INC."element_menu_edit.inc.php";
	?>

	<div style="text-align:right;margin-top:20px;">
		<input type="hidden" name="id_etherpad" value="<?php echo @$etherpad_tmp["id_etherpad"]; ?>" />
		<input type="hidden" name="id_dossier" value="<?php echo $etherpad_tmp["id_dossier"]; ?>" />
		<input type="submit" value="<?php echo $trad["valider"]; ?>" class="button_big" />
	</div>

</form>


<?php require PATH_INC."footer.inc.php"; ?>
