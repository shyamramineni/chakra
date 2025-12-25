<!doctype html>
<html>
    <head>
        <meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Shopping Cart')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<g:javascript library="jquery" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'shopping_cart.css')}" type="text/css">
	</head>
	<body>
	<g:javascript src="shopping_cart.js" /> 
	
	<g:form action="shoppingCart" name="shoppingCart">
		<div class="container-fluid">
			<div class="row-fluid item_selection_container">
				<div class="span4 box_holder">
	        		<div class="item_tree_box well">
					  	<ul class="item_tree">
					  		
		                	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" /><a href="#">MESH</a>
		                    
		                    	<ul>
		                    		<g:each in="${com.chakra.config.CageDesign.constraints.designType.inList}" var="designType">
		                        	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" /><a href="#">${designType}</a>
		                        	
		                            	<ul>
		                            		<% def cageDesignList = com.chakra.config.CageDesign.findAllByDesignTypeAndIsCustom(designType,false) %>
		                                	<g:each in="${cageDesignList}" var="cageDesign" status="i">
		                                	<% def sheetSpecList = com.chakra.config.CageDesignSheetSpecFormula.findAllByCageDesign(cageDesign) %>
		                                	<li class="final_item"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" />
		                                    	
		                                    	<a class="final_item_label">${cageDesign}</a>
		                                    	
		                                    	<span class="data_field" name="id">${cageDesign?.id}</span>
		                                    	<g:each in="${sheetSpecList}" var="sheetSpec" status="j">
		                                    		<span class="data_field" name="mesh_item">
					                                	<span class="data_field" name="id">${sheetSpec?.sheetSpecification?.sheetSpecId}</span>
					                                    <span class="data_field" name="name">${sheetSpec?.sheetSpecification}</span>
					                                    <span class="data_field" name="desc"></span>
					                                    <span class="data_field" name="pic_url"><img src="${resource(dir: 'images', file: 'sample_pic.jpg')}" /></span>
					                                    <span class="data_field" name="price"></span>
					                                </span>
					                            </g:each>
		                                        <ul>
		                                        	<li class="custom_item"><a class="custom_item_label">${cageDesign?.childCageDesign[i]}</a>
		                                    			<span class="data_field" name="id">${cageDesign?.childCageDesign[i]?.id}</span>
		                                    		</li>
		                                    	</ul>
		                                    </li>
		                                    </g:each>
		                                </ul>
		                            </li>
		                            </g:each>
		                            
		                        </ul>
		                    </li>
		                   
		                    <li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" /><a href="#">CAGE</a>
		                    
		                    	<ul>
		                    		<g:each in="${com.chakra.config.CagePartType.list()}" var="cagePartType">
		                        	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" /><a href="#">${cagePartType}</a>
		                        	
		                            	<ul>
		                            		<% def cagePartSpecificationList = com.chakra.config.CagePartSpecification.findAllByCagePartType(cagePartType) %>
		                                	<g:each in="${cagePartSpecificationList}" var="cagePartSpecification" status="i">
		                                	
		                                	<li class="final_item"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" />
		                                    	<% def cagePartTypeList = com.chakra.config.CagePartSpecFormula.findAllByCagePartSpecification(cagePartSpecification) %>
		                                    	<a class="final_item_label">${cagePartSpecification}</a>
		                                    	<span class="data_field" name="id">${cagePartSpecification?.id}</span>
		                                    	<g:each in="${cagePartTypeList}" var="cagePart" status="j">
		                                    		<span class="data_field" name="mesh_item">
					                                	<span class="data_field" name="id">${cagePart?.id}</span>
					                                    <span class="data_field" name="name">${cagePart?.cagePart}</span>
					                                    <span class="data_field" name="desc"></span>
					                                    <span class="data_field" name="pic_url"><img src="${resource(dir: 'images', file: 'sample_pic.jpg')}" /></span>
					                                    <% def cagePartPriceList = com.chakra.config.CagePartPrice.findByCagePart(cagePart?.cagePart) %>
		                                                <g:each in="${cagePartPriceList}" var="cagePartPrice" status="k">
					                                    <span class="data_field" name="price">${cagePartPrice?.price}</span>
					                                    </g:each>
					                                </span>
					                            </g:each>
		                                                                        	
		                                    </li>
		                                    </g:each>
		                                </ul>
		                            </li>
		                            </g:each>
		                            
		                        </ul>
		                    </li>
		                    
		                </ul>
		                         
					  </div>					  
			    </div>
			    <div class="span2 box_holder">
					<div class="button_box">
	            		<input type="button" id="add_item_button" class="select_button_style btn" value=">" />
	                	<input type="button" id="remove_item_button" class="select_button_style btn" value="" />
	            	</div>
			    </div>
			    <div class="span2 box_holder">
        		<div class="selected_item_box well">
				
            	</div>
        		</div>
			</div>
			<h4>Cart Items:</h4>
			
		    <div class="row-fluid mesh_item_selection_container">
		        <div class="span8">
		        	<div id="add_to_cart_grid" class="well mesh_item_selection_box">
		            	<div class="header_bar">
		                	<span class="header_pid">SheetSpec ID</span>
		                    <span class="header_pname">SheetSpec Name</span>
		                    <span class="header_pdesc">Product Description</span>
		                    <span class="header_pic">Picture</span>
		                    <span class="header_quantity">Quantity</span>
		                    <span class="header_price">Price</span>
		                    <span class="header_extra_box">&nbsp;</span>
		                </div>
		                <div class="item_entry_box">
		                    <table class="item_entry_table">
		                    
		                    </table>
		                    <div id="row_edit_popup">
		                        <input type="button" id="row_edit_cancel" value="Cancel"  />
		                        <input type="button" id="row_edit_ok" value="Ok" style="margin-left:10px;" />
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		    <input type="button" id="add_to_cart_button" style="clear:left; display:block;" value="Add to cart" /> 
		    <div class="row-fluid mesh_item_selection_container">
		    	<div class="span8">
		        	<div id="shopping_cart_summary" class="well mesh_item_selection_box">
		            	<div class="header_bar">
		                	<span class="header_pid">SheetSpec ID</span>
		                    <span class="header_pname">SheetSpec Name</span>
		                    <span class="header_pdesc">Product Description</span>
		                    <span class="header_pic">Picture</span>
		                    <span class="header_quantity">Quantity</span>
		                    <span class="header_price">Price</span>
		                    <span class="header_extra_box">&nbsp;</span>
		                </div>
		                <div class="item_entry_box">
		                    <table class="item_entry_table">
		                        
		                    </table>
		                    <div id="summary_edit_popup">
		                        <input type="button" id="summary_edit_cancel" value="Cancel"  />
		                        <input type="button" id="summary_edit_ok" value="Ok" style="margin-left:10px;" />
		                    </div>
							<%--<img src="close.png" id="summary_row_delete_icon" />--%>
							<img src="${resource(dir: 'images', file: 'close.png')}" id="summary_row_delete_icon"/>
		                </div>
		            </div>
		        </div>
		    </div>   
		</div>	    
	</g:form>		   
	
	
	</body>
</html>