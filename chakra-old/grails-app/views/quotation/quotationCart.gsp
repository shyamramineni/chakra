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
	<g:javascript src="json2.js" />
	<g:javascript src="shopping_cart.js" />	
		<g:form action="shoppingCart" name="shoppingCart" onsubmit="submit_shopping_cart_click(event)">
			<div class="container-fluid">
				<div class="row-fluid item_selection_container">
					<div class="span4 box_holder">
        				<div class="item_tree_box well">
        					<ul class="item_tree">
			                	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" /><a href="#">MESH</a>
			                    	<ul>
			                    		<g:each in="${com.chakra.config.CageDesign.constraints.designType.inList}" var="designType">
			                        	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" /><a href="#">${designType}</a>
			                            	<ul>
			                            		<% def cageDesignList = com.chakra.config.CageDesign.findAllByDesignTypeAndIsCustom(designType,false) %>
		                                		<g:each in="${cageDesignList}" var="cageDesign" status="i">
		                                		
			                                	<li class="final_item" name="mesh_item_tree"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" />
			                                    	<a class="final_item_label">${cageDesign}</a>
			                                    	<span class="data_field" name="id">${cageDesign?.id}</span>
			                                    		<%def wireBrandList = com.chakra.config.WireBrand.findAll() %>
	                                                    <span class="data_field" id="wirebrand_options">
															<g:each in="${wireBrandList}" var="wireBrand">
															<option value="${wireBrand?.id}">${wireBrand}</option>
															</g:each>
														</span>
			                                    		<%--<g:each in="${sheetSpecList}" var="sheetSpec" status="j">
		                                    			<span class="data_field" name="mesh_item">
		                                                    <span class="data_field" name="id">${sheetSpec?.sheetSpecification?.sheetSpecId}</span>
		                                                    <span class="data_field" name="name">${sheetSpec?.sheetSpecification}</span>
		                                                    <span class="data_field" name="desc">this is from tree 1</span>
		                                                    
		                                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
		                                                    <span class="data_field" name="price">4</span>
		                                                </span>
		                                                </g:each>
			                                        --%><ul>
			                                        	<li class="final_item" name="mesh_item_tree"><a class="final_item_label">${cageDesign?.childCageDesign[i]}</a>
			                                    			<span class="data_field" name="id">${cageDesign?.childCageDesign[i]?.id}</span>
			                                                <%--<g:each in="${sheetSpecList}" var="sheetSpec" status="j">
			                                                <span class="data_field" name="mesh_item">
			                                                    <span class="data_field" name="id">${sheetSpec?.sheetSpecification?.sheetSpecId}</span>
			                                                    <span class="data_field" name="name">${sheetSpec?.sheetSpecification}</span>
			                                                    <span class="data_field" name="desc">this is from tree 1</span>
			                                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
			                                                    <span class="data_field" name="price">4</span>
			                                                </span>	
			                                                </g:each>		                                                
			                                    		--%></li>			                                            
			                                        </ul>
			                                    </li>
			                                    </g:each>
			                                </ul>
			                            </li>
			                            </g:each>
			                        </ul>
			                    </li>
			                    <li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" /><a href="#">CAGE</a>
			                    	<ul>
			                    		<g:each in="${com.chakra.config.CagePartType.list()}" var="cagePartType">
			                        	<li class="item_group"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" /><a href="#">${cagePartType}</a>
			                            	<ul>
			                            		<% def cagePartSpecificationList = com.chakra.config.CagePartSpecification.findAllByCagePartType(cagePartType) %>
		                                		<g:each in="${cagePartSpecificationList}" var="cagePartSpecification" status="i">
			                                	<li class="final_item" name="cage_item_tree"><img src="${resource(dir: 'images', file: 'icon_Tree_ExpandAll.jpg')}" class="group_state_icon" />
			                                		
			                                    	<a class="final_item_label">${cagePartSpecification}</a>
			                                    	<span class="data_field" name="id">${cagePartSpecification?.id}</span>
			                                    	<%--<g:each in="${cagePartTypeList}" var="cagePart" status="j">
			                                    	<span class="data_field" name="cage_item">
					                                	<span class="data_field" name="id">${cagePart?.id}</span>
					                                    <span class="data_field" name="name">${cagePart?.cagePart}</span>
					                                    <span class="data_field" name="desc">aksjdna smdasdka kjasda skdjba</span>
					                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
					                                    <% def cagePartPriceList = com.chakra.config.CagePartPrice.findByCagePart(cagePart?.cagePart) %>
		                                                <g:each in="${cagePartPriceList}" var="cagePartPrice" status="k">
					                                    <span class="data_field" name="price">${cagePartPrice?.price}</span>
					                                    </g:each>
					                                </span>
					                                </g:each>
			                                    --%></li>
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
			                <input type="button" id="remove_item_button" class="select_button_style btn" value="<%= '<'%>" />
			            </div>
			        </div>
			        <div class="span2 box_holder">
			        	<div class="selected_item_box well">
							
			            </div>
			        </div>
				</div>
				<h5>Mesh Items:</h5>
			    <div class="row-fluid mesh_item_selection_container">
			        <div class="span8">
			        	<div id="add_to_cart_grid" class="well mesh_item_selection_box">
			            	<div class="header_bar">
			                	<span class="header_pid">Product ID</span>
			                    <span class="header_pname">Product Name</span>
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
    
                <div id="add_to_cart_grid_field_popup">
                	<img class="element_icon" src="" />
                    <div class="element_data">
                    	<span style="font-weight:bold">Name: </span><span class="element_name"></span>
                        <br />
                        <span style="font-weight:bold">Description: </span><span class="element_desc"></span>
                    </div>
                </div>
			    <div class="row-fluid mesh_item_selection_container">
			    	<div class="span8">
			    	
			        	<div id="shopping_cart_summary" class="well mesh_item_selection_box">
			            	<div class="summary_header_bar">
		                	<span class="summary_header_pid">Product ID</span>
		                    <span class="summary_header_pname">Product Name</span>
		                    <span class="summary_header_pdesc">Product Description</span>
		                    <span class="summary_header_pic">Picture</span>
		                    <span class="summary_header_quantity">Quantity</span>
		                    <span class="summary_header_price">Price</span>
		                    <span class="summary_header_total">Total</span>
		                    <span class="summary_header_extra_box">&nbsp;</span>		                    
		                </div>
			                <div class="item_entry_box">
			                    <table class="item_entry_table">
			                        
			                    </table>
			                    <img src="${resource(dir: 'images', file: 'close.png')}" id="summary_row_delete_icon"/>
			                    
			                </div>
			                <%def taxationList = com.chakra.config.Taxation.list() %>
			                <span id="taxation_options">
								<select name= "taxation">
									<g:each in="${taxationList}" var="taxation">
										<option value="${taxation?.id}">${taxation}</option>
									</g:each>
								</select>									
							</span>
			            </div>
			        </div>
			    </div>
			    
			    <g:hiddenField id="mesh_items_field" name="sheetQuantity"  value="" />
			    <g:hiddenField id="cage_parts_field" name="cageQuantity"  value="" />
			    
			    <input type="submit" id="submit_shopping_cart" style="clear:left; display:block;" value="submit" />
			</div>						    
		</g:form>		
	</body>
</html>