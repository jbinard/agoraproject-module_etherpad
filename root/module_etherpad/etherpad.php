<?php
////	INIT
require "commun.inc.php";
require_once PATH_INC."header.inc.php";

////	INFOS + DROIT ACCES
$etherpad_tmp = objet_infos($objet["etherpad"], $_GET["id_etherpad"]);
$etherpad_nom = addslashes($etherpad_tmp['nom']);
$droit_acces = droit_acces_controler($objet["etherpad"], $etherpad_tmp, 1);

echo "<script type=\"text/javascript\">
    resize_iframe_popup(800,665);
    document.title = document.title + ' - $etherpad_nom';
    jQuery(document).ready(function() {
        jQuery('#ePad').pad({'host': '{$etherpad_url}', 'padId':'{$etherpad_tmp["id_serveur"]}', 'baseUrl': '/p/', 'showChat': true, 'userName': '{$_SESSION["user"]["prenom"]} {$_SESSION["user"]["nom"]}','showControls': true,'showLineNumbers': true});
    });
    </script>";
?>

<script type="text/javascript" src="etherpad.js"></script>
<style type="text/css">
#ePad {background-color: #FFFFFF}

#epframeePad {
  height:   100%;
  left:     0px;
  position: absolute;
  top:      0px;
  width:    100%;
}

</style>

<div id="ePad"></div>

<?php
require PATH_INC."footer.inc.php";
?>
