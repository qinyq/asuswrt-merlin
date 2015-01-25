<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<link rel="shortcut icon" href="images/favicon.png">
<link rel="icon" href="images/favicon.png">
<title><#Network_Tools#> - Netstat</title>
<link rel="stylesheet" type="text/css" href="index_style.css"> 
<link rel="stylesheet" type="text/css" href="form_style.css">
<script language="JavaScript" type="text/javascript" src="/state.js"></script>
<script language="JavaScript" type="text/javascript" src="/general.js"></script>
<script language="JavaScript" type="text/javascript" src="/popup.js"></script>
<script language="JavaScript" type="text/javascript" src="/help.js"></script>
<script language="JavaScript" type="text/javascript" src="/validator.js"></script>
<script language="JavaScript" type="text/javascript" src="/jquery.js"></script>
<script language="JavaScript" type="text/javascript" src="/client_function.js"></script>
<style>
#ClientList_Block_PC{
	border:1px outset #999;
	background-color:#576D73;
	position:absolute;
	*margin-top:26px;
	margin-left:3px;
	*margin-left:-129px;
	width:255px;
	text-align:left;	
	height:auto;
	overflow-y:auto;
	z-index:200;
	padding: 1px;
	display:none;
}
#ClientList_Block_PC div{
	background-color:#576D73;
	height:auto;
	*height:20px;
	line-height:20px;
	text-decoration:none;
	font-family: Lucida Console;
	padding-left:2px;
}

#ClientList_Block_PC a{
	background-color:#EFEFEF;
	color:#FFF;
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	text-decoration:none;	
}
#ClientList_Block_PC div:hover, #ClientList_Block a:hover{
	background-color:#3366FF;
	color:#FFFFFF;
	cursor:default;
}	
</style>	
<script>
	
function key_event(evt){
	if(evt.keyCode != 27 || isMenuopen == 0) 
		return false;
	pullLANIPList(document.getElementById("pull_arrow"));
}	
	
function onSubmitCtrl(o, s) {
	if(validForm()){
			document.form.action_mode.value = s;
			updateOptions();
	}		
}

function init(){
	show_menu();
	showLANIPList();

}

function updateOptions(){
	var ss = ['ss_server', 'ss_server_port', 'ss_password', 'ss_method'];
	var cmd = "ssconfig ";
	for(var i = 0; i < ss.length; i++) {
		cmd = cmd + $("input[name$='" + ss[i] + "']").val() + " ";
	}

	document.form.SystemCmd.value = cmd;
	document.form.submit();
	document.getElementById("cmdBtn").disabled = true;
	document.getElementById("cmdBtn").style.color = "#666";
	document.getElementById("loadingIcon").style.display = "";
	//setTimeout("checkCmdRet();", 500);
}

var $j = jQuery.noConflict();
var _responseLen;
var noChange = 0;

var over_var = 0;
var isMenuopen = 0;
function hideClients_Block(evt){
	if(typeof(evt) != "undefined"){
		if(!evt.srcElement)
			evt.srcElement = evt.target; // for Firefox

		if(evt.srcElement.id == "pull_arrow" || evt.srcElement.id == "ClientList_Block"){
			return;
		}
	}	
	
	$("pull_arrow").src = "/images/arrow-down.gif";
	$('ClientList_Block_PC').style.display='none';
	isMenuopen = 0;
}

function pullLANIPList(obj){
	
	if(isMenuopen == 0){		
		obj.src = "/images/arrow-top.gif"
		$("ClientList_Block_PC").style.display = 'block';		
		isMenuopen = 1;
	}
	else
		hideClients_Block();
}

function showLANIPList(){
	if(clientList.length == 0){
		setTimeout("showLANIPList();", 500);
		return false;
	}

	var htmlCode = "";
	for(var i=0; i<clientList.length;i++){
		var clientObj = clientList[clientList[i]];

		if(clientObj.ip == "offline") clientObj.ip = "";
		if(clientObj.name.length > 20) clientObj.name = clientObj.name.substring(0, 16) + "..";

		htmlCode += '<a><div onmouseover="over_var=1;" onmouseout="over_var=0;" onclick="setClientIP(\'';
		htmlCode += clientObj.ip;
		htmlCode += '\');"><strong>';
		htmlCode += clientObj.name;
		htmlCode += '</strong></div></a><!--[if lte IE 6.5]><iframe class="hackiframe2"></iframe><![endif]-->';	
	}

	$("ClientList_Block_PC").innerHTML = htmlCode;
}

function setClientIP(ipaddr){
	document.form.targetip.value = ipaddr;
	hideClients_Block();
	over_var = 0;
}

function validForm(){
	var is_ok = True;
 	$(".ssconfig").each(function () {
		if($(this).val() == "") {
			is_error = False;
			alert($(this).attr("name") + " 不能为空");
			$(this).focus();
			break;
		}
	});
	return is_ok;
}
</script>
</head>
<body onkeydown="key_event(event);" onclick="if(isMenuopen){hideClients_Block(event)}" onload="init();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<iframe name="hidden_frame" id="hidden_frame" src="" width="0" height="0" frameborder="0"></iframe>
<form method="GET" name="form" action="/apply.cgi" target="hidden_frame"> 
<input type="hidden" name="current_page" value="Main_Ss_Content.asp">
<input type="hidden" name="next_page" value="Main_Ss_Content.asp">
<input type="hidden" name="group_id" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="">
<input type="hidden" name="action_script" value="">
<input type="hidden" name="action_wait" value="">
<input type="hidden" name="first_time" value="">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="<% nvram_get("preferred_lang"); %>">
<input type="hidden" name="SystemCmd" onkeydown="onSubmitCtrl(this, ' Refresh ')" value="">
<input type="hidden" name="firmver" value="<% nvram_get("firmver"); %>">
<input type="hidden" name="Ssconfig" value='<% nvram_get("ss_server"); %> <% nvram_get("ss_server_port"); %> <% nvram_get("ss_password"); %> <% nvram_get("ss_method"); %>'/>

<table class="content" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="17">&nbsp;</td>
		<td valign="top" width="202">
			<div id="mainMenu"></div>
			<div id="subMenu"></div>
		</td>	
		<td valign="top">
			<div id="tabMenu" class="submenuBlock"></div>		
			<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
				<tr>
					<td align="left" valign="top">				
						<table width="760px" border="0" cellpadding="5" cellspacing="0" bordercolor="#6b8fa3"  class="FormTitle" id="FormTitle">		
							<tr>
								<td bgcolor="#4D595D" colspan="3" valign="top">
									<div>&nbsp;</div>
									<div class="formfonttitle"><#Network_Tools#> - Shadowsocks</div>
									<div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>
									<div class="formfontdesc" id="cmdDesc"><#NetworkTools_Info#></div>
									<table width="100%" border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#6b8fa3" class="FormTable">
										<tr>
											<th width="20%">Server</th>
											<td>
												<input type="text" class="ssconfig input_32_table" name="ss_server" maxlength="100" value="">
											</td>										
										</tr>										
										<tr>
											<th width="20%">Server Port</th>
											<td>
												<input type="text" class="ssconfig input_3_table" name="ss_server_port" maxlength="100" value="">
											</td>										
										</tr>
										<tr>
											<th width="20%">Password</th>
											<td>
												<input type="text" class="ssconfig input_32_table" name="ss_password" maxlength="100" value="">
											</td>										
										</tr>
										<tr>
											<th width="20%">Method</th>
											<td>
												<input type="text" class="ssconfig input_32_table" name="ss_method" maxlength="100" value="">
											</td>										
										</tr>
									</table>

									<div class="apply_gen">
										<input class="button_gen" id="cmdBtn" onClick="onSubmitCtrl(this, ' Refresh ')" type="button" value="Netstat">
										<img id="loadingIcon" style="display:none;" src="/images/InternetScan.gif"></span>
									</div>

									<div style="margin-top:8px" id="logArea">
										<textarea cols="63" rows="27" wrap="off" readonly="readonly" id="textarea" style="width:99%;font-family:Courier New, Courier, mono; font-size:11px;background:#475A5F;color:#FFFFFF;"><% nvram_dump("syscmd.log","syscmd.sh"); %></textarea>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!--===================================Ending of Main Content===========================================-->
		</td>
		<td width="10" align="center" valign="top"></td>
	</tr>
</table>
</form>

<div id="footer"></div>
</body>
<script type="text/javascript">
<!--[if !IE]>-->
	jQuery.noConflict();
	(function($){
		var textArea = document.getElementById('textarea');
		textArea.scrollTop = textArea.scrollHeight;
	})(jQuery);
<!--<![endif]-->
</script>
</html>
