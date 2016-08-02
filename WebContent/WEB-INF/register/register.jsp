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
        			Register Test
        		</h1>
        	</div>
        </header>
        
        <div class="container">
        
	        <br/>
	        
	        <form id="register" name="register" method="POST" onSubmit="return putTogether();">
		        
		        	<div class="control-group">
			       		<label class="control-label" for="type">Type:</label>
				       	<div class="controls">
					         <select id="type" name="type">
					            <option value="">None</option>
					            <option value="chain">Click-through</option>
					            <option value="url">URL</option>
					            <option value="db">DB</option>
					         </select>
				     	</div>
			    	</div>
		        
		        	<label id="machine_label" for="machine" style="display:none">Machine:</label><input id="machine" name="machine" type="text" class="input-block-level" placeholder="Machine" style="display:none">
		        
			        <label id="name_label" for="name" style="display:none">Name:</label><input id="name" name="name" type="text" class="input-block-level" placeholder="Name" style="display:none">
			        
			        <label id="url_label" for="url" style="display:none">URL:</label><input id="url" name="url" type="text" class="input-block-level" placeholder="URL" style="display:none">
			        
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
			        
			        <label id="verify_phrase_label" for="verify_phrase" style="display:none">Verify Phrase:</label><input id="verify_phrase" name="verify_phrase" type="text" class="input-block-level" placeholder="Verify Phrase" style="display:none">
			        
			        <label id="timeout_label" for="timeout" style="display:none">Timeout:</label><input id="timeout" name="timeout" type="text" class="input-block-level" placeholder="Timeout" style="display:none">
			        
			        <br/>
			        <br/>
			        
			        <button class="btn btn-large btn-primary" type="submit">Register</button>
		        
		    </form>
	        
	        <br/>
	        
	        <script type="text/javascript">
	        	$("#type").change(function() {
	        		
	        		$("input").hide();
	        		$("label").hide();
	        		
	        		$(".commandDiv").hide();
	        		$(".commandsTitle").hide();
	        		
	        		if($("#type option:selected").text() != 'None') {
	        			$("#machine").show();
	        			$("#machine_label").show();
		        		
		        		$("#name").show();
		        		$("#name_label").show();
		        		
		        		$("#timeout").show();
		        		$("#timeout_label").show();
	        		}
	        		
	        		if($("#type option:selected").text() == 'URL') {
	        			$("#verify_phrase").show();
	        			$("#verify_phrase_label").show();
	        			
	        			$("#url").attr("placeholder",$("#type :selected").text()).show();
	        			$("#url_label").show();
	        		}
	        		
	 				if($("#type option:selected").text() == 'Click-through') {
	 					$(".commandsTitle").show();
	 					$(".commandDiv").show();
	 					$(".params").show();
	 					//$("#commands").show();
	 					//$("#commands_label").show();
	 				}
	 				
	 				if($("#type option:selected").text() == 'DB') {
	 					$("#url").attr("placeholder",$("#type :selected").text()).show();
	        			$("#url_label").text("Connection String:").show();
	 				}
	        	});
	        	
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
	        		$("#commands").val(commandString);
	        		
	        		return true;
	        	}
	        	
	        	$("#register").bind('submit',function() {
	        		if($("#type :selected").val() == "") {
	        			alert("Please pick a type.");
	        			return false;
	        		}
	        	});
	        </script>
        
        </div>