<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <header class="jumbotron subhead">
        	<div class="container">
        		<h1>
        			Edit Test
        		</h1>
        	</div>
        </header>
        
        <div class="container">
        
        	<br/>
	        
	        <a id="delete" href="#">Delete Test</a>
	        
	        <br/>
	        <br/>
	        
	        <form id="edit" name="edit" method="POST" onSubmit="return putTogether();">
		        	<input id="id" name="id" type="hidden">
		        
		        	<input id="type" name="type" type="hidden">
		        
		        	<label for="machine">Machine:</label><input id="machine" name="machine" type="text" class="input-block-level" placeholder="Machine">
		        
			        <label for="name">Name:</label><input id="name" name="name" type="text" class="input-block-level" placeholder="Name">
			        
			        <!-- options for click-through -->	
			        <label class="commandsTitle" style="display:none">Commands:</label>
			        		    
			        <div class="commandDiv" style="display:none">
			        	<div class="control-group" style="display:inline-block;width:220px;">
					       	<div class="controls">
						         <select name="choosenCommand" class="choosenCommand" onChange="updateCommand(this);">
						            <option value="open">open</option>
						            <option value="click">click</option>     
						            <option value="type">type</option>
						            <option value="verify">verify</option>
						         </select>
					     	</div>
			    		</div>
			        
				 		<input name="parameters" type="text" class="params input-block-level" placeholder="Parameters" onChange="updateCommand(this);" style="width:575px;" />
				    	
				    	<button class="addCommand btn" type="button" name="addCommand" onClick="addCommandClick(this);" style="vertical-align:top;">Add</button>
			        
			        	<button class="removeCommand btn" type="button" name="removeCommand" onClick="removeCommandClick(this);" style="vertical-align:top;">Remove</button>
			        	
			        	<input name="commandString" class="commandString" type="hidden" value="" /> 
			        	
			        </div>
			        
			        <input id="commands" name="commands" type="hidden" value="" />
			        
			        <label id="url_label" for="url">URL:</label><input id="url" name="url" type="text" class="input-block-level" placeholder="">
			        
			        <label id="verify_phrase_label" for="verify_phrase">Verify Phrase:</label><input id="verify_phrase" name="verify_phrase" type="text" class="input-block-level" placeholder="Verify Phrase">
			        
			        <label for="timeout">Timeout:</label><input id="timeout" name="timeout" type="text" class="input-block-level" placeholder="Timeout">
			        
			        <br/>
			        <br/>
			        
			        <button class="btn btn-large btn-primary" type="submit">Update</button>
		        
		    </form>
	        
	        <br/>
	        
	        <script type="text/javascript">
	        	var testInfo = ${testInfo};
	        	$('#id').val(testInfo.TEST_ID);
	        	$('#type').val(testInfo.TYPE);
	        	$('#machine').val(testInfo.MACHINE);
	        	$('#name').val(testInfo.NAME);
	        	$('#url').val(testInfo.URL);
	        	$('#verify_phrase').val(testInfo.VERIFY_PHRASE);
	        	$('#timeout').val(testInfo.TIMEOUT);
	        	
	        	$("#url").attr("placeholder",testInfo.TYPE.toUpperCase());
	        	if(testInfo.TYPE.toUpperCase() == 'DB') {
	        		$("#url_label").text("Connection String:");
	        		$('#verify_phrase_label').hide();
	        		$('#verify_phrase').hide();
	        	} else if(testInfo.TYPE.toUpperCase() == 'CHAIN') {
	        		$("#url_label").hide();
	        		$("#url").hide();
	        		$('#verify_phrase_label').hide();
	        		$('#verify_phrase').hide();
	        		
	        		$(".commandsTitle").show();
 					$(".commandDiv").show();
 					$(".params").show();
 					
 					var commands = testInfo.URL.split(";");
 					for(var i = 0; i < commands.length; i++) { 			
 						var check = trim(commands[i]);
 						
 						if(check == "") {
 							continue;
 						}
 						
 						var command = trim(commands[i]).split(" ");
 						
 						$parent = $($(".commandDiv").get($(".commandDiv").length-1));
 						$params = $parent.find(".params");
 		        		$command = $parent.find(".choosenCommand");
 						
 		        		$command.val(command[0]);
 		        		
 		        		var paramString = "";
 		        		
 						for(var j = 1; j < command.length; j++) {
 							paramString += command[j]+" ";
 						}
 						
 						$params.val(paramString);
 						
 						$NewLine = $(".commandDiv").eq(0).clone();
 		        		$NewLine.children("input").val("");
 		        		
 		        		$NewLine.insertAfter($parent);
 		        		
 		        		updateCommand($parent.find(".addCommand"));
 					}
 					
 					if($(".commandDiv").length > 1) {
 						$($(".commandDiv").get($(".commandDiv").length-1)).remove();	
	        		}
	        	} else if(testInfo.TYPE.toUpperCase() == 'URL') {
	        		$("#url_label").text("URL:");
	        	}
	        	
	        	$('#delete').attr("href","delete?id="+testInfo.TEST_ID);
	        	
	        	
	        	
	        	
	        	
	        	
	        	
	        	
	        	
	        	//functions
	        	function addCommandClick(element) {
	        		$NewLine = $(".commandDiv").eq(0).clone();
	        		$NewLine.children("input").val("");
	        		
	        		$NewLine.insertAfter($(element).parent());
	        	}
	        	
	        	function removeCommandClick(element) {
	        		if($(".commandDiv").length > 1) {
	        			$(element).parent().remove();	
	        		}
	        	}
	        	
	        	function updateCommand(element) {
	        		$parent = $(element).parent();
	        		$commandString = $parent.find(".commandString");
	        		$params = $parent.find(".params");
	        		$command = $parent.find(".choosenCommand");
	        		
	        		$commandString.val($command.val()+" "+$params.val());
	        	}
	        	
	        	function putTogether() {
	        		var commandString = "";
	        		$(".commandDiv").find(".commandString").each(function(index, element) {
	        			commandString += element.value+"; ";
	        		});
	        		$("#url").val(commandString);
	        		
	        		return true;
	        	}
	        	
	        	function trim(str) {
	                return str.replace(/^\s+|\s+$/g,"");
	       		}
	        </script>
        
        </div>