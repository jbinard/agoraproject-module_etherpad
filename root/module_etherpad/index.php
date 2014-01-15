<?php
////	INIT
define("IS_MAIN_PAGE",true);
require "commun.inc.php";
require PATH_INC."header_menu.inc.php";
init_id_dossier();
elements_width_height_type_affichage("medium","63px","bloc");
$droit_acces_dossier = droit_acces_controler($objet["etherpad_dossier"], $_GET["id_dossier"], 1);
?>


<table id="contenu_principal_table"><tr>
	<td id="menu_gauche_block_td">
		<div id="menu_gauche_block_flottant">
			<div class="menu_gauche_block content">
				<?php
				////	MENU D'ARBORESCENCE
				$cfg_menu_arbo = array("objet"=>$objet["etherpad_dossier"], "id_objet"=>$_GET["id_dossier"], "ajouter_dossier"=>true, "droit_acces_dossier"=>$droit_acces_dossier);
				require_once PATH_INC."menu_arborescence.inc.php";
				?>
			</div>
			<div class="menu_gauche_block content">
				<?php
				////	AJOUTER PAD
				if($droit_acces_dossier>=1.5)	echo "<div class='menu_gauche_ligne lien' onclick=\"edit_iframe_popup('etherpad_edit.php?id_dossier=".$_GET["id_dossier"]."');\"><div class='menu_gauche_img'><img src=\"".PATH_TPL."divers/ajouter.png\" /></div><div class='menu_gauche_txt'>".$trad["ETHERPAD_ajouter_etherpad"]."</div></div><hr />";
				////	MENU ELEMENTS
				$cfg_menu_elements = array("objet"=>$objet["etherpad"], "objet_dossier"=>$objet["etherpad_dossier"], "id_objet_dossier"=>$_GET["id_dossier"], "droit_acces_dossier"=>$droit_acces_dossier);
				require PATH_INC."elements_menu_selection.inc.php";
				////	MENU D'AFFICHAGE  &  DE TRI  &  CONTENU DU DOSSIER
				echo menu_type_affichage();
				echo menu_tri($objet["etherpad"]["tri"]);
				echo contenu_dossier($objet["etherpad_dossier"],$_GET["id_dossier"]);
				?>
			</div>
		</div>
	</td>
	<td>
		<?php
		////	MENU CHEMIN + OBJETS_DOSSIERS
		////
		echo menu_chemin($objet["etherpad_dossier"], $_GET["id_dossier"]);
		$cfg_dossiers = array("objet"=>$objet["etherpad_dossier"], "id_objet"=>$_GET["id_dossier"]);
		require_once PATH_INC."dossiers.inc.php";

		////	LISTE DES PADS
		////
		$liste_etherpads = db_tableau("SELECT * FROM gt_etherpad WHERE id_dossier='".intval($_GET["id_dossier"])."' ".sql_affichage($objet["etherpad"],$_GET["id_dossier"])." ".tri_sql($objet["etherpad"]["tri"]));
		foreach($liste_etherpads as $etherpad_tmp)
		{
			////	INFOS / MODIF / SUPPR
			$cfg_menu_elem = array("objet"=>$objet["etherpad"], "objet_infos"=>$etherpad_tmp);
			$etherpad_tmp["droit_acces"] = ($_GET["id_dossier"]>1)  ?  $droit_acces_dossier  :  droit_acces($objet["etherpad"],$etherpad_tmp);
			if($etherpad_tmp["droit_acces"]>=2)	{
				$cfg_menu_elem["modif"] = "etherpad_edit.php?id_etherpad=".$etherpad_tmp["id_etherpad"];
				$cfg_menu_elem["deplacer"] = PATH_DIVERS."deplacer.php?module_path=".MODULE_PATH."&type_objet_dossier=etherpad_dossier&id_dossier_parent=".$_GET["id_dossier"]."&SelectedElems[etherpad]=".$etherpad_tmp["id_etherpad"];
				$cfg_menu_elem["suppr"] = "elements_suppr.php?id_etherpad=".$etherpad_tmp["id_etherpad"]."&id_dossier_retour=".$_GET["id_dossier"];
			}
			////	PAD / LIBELLE
			$lien_etherpad = "onclick=\"popup('etherpad.php?id_etherpad=".$etherpad_tmp["id_etherpad"]."','aff_etherpad".$etherpad_tmp["id_etherpad"]."');\"";

			////	DIV SELECTIONNABLE + OPTIONS
			$cfg_menu_elem["id_div_element"] = div_element($objet["etherpad"], $etherpad_tmp["id_etherpad"]);
			require PATH_INC."element_menu_contextuel.inc.php";
			////	AFFICHAGE BLOCK
			if($_REQUEST["type_affichage"]=="bloc")
			{
				echo "<div class='div_elem_contenu' style='background-image:url(".PATH_TPL."module_etherpad/fond_element.png);'>";
					echo "<table class='table_nospace' cellpadding='0' cellspacing='0' style='width:100%;height:".$height_element.";'><tr>";
						echo "<td style='vertical-align:middle'>";
							echo "<div style='font-size:12px;text-align:center;' class='lien' ".$lien_etherpad.">".$etherpad_tmp["nom"]."</div>";
						echo "</td>";
					echo "</tr></table>";
				echo "</div>";
			}
			////	AFFICHAGE LISTE
			else
			{
				echo "<div class='div_elem_contenu' >";
					echo "<table class='div_elem_table'><tr>";
					echo "<td class='div_elem_td'><span class='lien' ".$lien_etherpad.">".$etherpad_tmp["nom"]."</span></td>";
					echo "<td class='div_elem_td div_elem_td_right'>".$cfg_menu_elem["auteur_tmp"]." <img src=\"".PATH_TPL."divers/separateur.gif\" /> ".temps($etherpad_tmp["date_crea"],"date")."</td>";
					echo "</tr></table>";
				echo "</div>";
			}
			echo "</div>";
		}
		////	AUCUN PAD
		if(@$cpt_div_element<1)  echo "<div class='div_elem_aucun'>".$trad["ETHERPAD_aucun_etherpad"]."</div>";
		?>
	</td>
</tr></table>


<?php require PATH_INC."footer.inc.php"; ?>
