<?php
////	INITIALISATION
////
$version_module = "1.1";
$version_agora = "2.16.4";
$nom_module ="etherpad";
define("IS_MAIN_PAGE",true);
require "commun.inc.php";
require PATH_INC."header_menu.inc.php";
require_once PATH_INC."header.inc.php";


//// Vérification admin
if ($_SESSION['user']['admin_general'] == 1)
{
  //// Test la présence du module messagerie
  $test = 0;
  $test_module = db_tableau("SELECT * FROM gt_module");
  foreach ($test_module as $module)
  {
	if ($module["nom"] == $nom_module)
	{$test = 1;}
  }

  if ($test == 1)
  {
  	
?>
	<script type="text/javascript">
	/* Installation du module */
  	var answer1 = confirm("Utilisez-vous le module Version ?");
  	if (answer1)
  	{
	<?php
	$resultat=mysql_query("select 1 from gt_versions_modules");
	if($resultat!=false)
	{
		//// effacement de la version du module si existant
		mysql_query("
    	DELETE FROM gt_versions_modules WHERE nom_module='$nom_module';");

		//// Ajout de la version du module
		mysql_query ("
		INSERT INTO gt_versions_modules (nom_module, version_module, version_agora) VALUES ('$nom_module', '$version_module', '$version_agora');
	");
		?>
		alert("Installation terminée.\n\n Supprimez le fichier install.php");
		<?php
	}
	else
	{
		?>
		alert("Le module Version n'est pas installé. \nInstallez le module Version et relancez le fichier install.php");
		<?php
	}

	

	?>
	window.location.replace('index.php');
  	}
	else 
	{window.location.replace('index.php');}
</script>
<?php 
}
  
}
else 
{redir('index.php');}
?>
