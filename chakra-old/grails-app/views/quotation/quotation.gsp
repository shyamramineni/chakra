<%@ page import="com.chakra.quotation.Quotation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="layout" content="main">
	<g:set var="entityName" value="${message(code: 'quotation.label', default: 'Quotation')}" />
	<title><g:message code="default.create.label" args="[entityName]" /></title>
	<g:javascript library="jquery" />
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'quotation.css')}" type="text/css">
	<style type="text/css">
	form {
		display:inline;
	}
	form input {
		display:inline
	}
	</style>	
		
</head>
<body>

<g:javascript src="underscore.js" />
<g:javascript src="backbone.js" />
<g:javascript src="customer.js" />
<g:javascript src="quotation_specs.js" />
<g:javascript src="quotation_info.js" />
<g:javascript src="quotation_model_grid.js" />
<g:javascript src="quotation_model_info.js" />
<g:javascript src="util.js" />
<g:javascript src="quotation.js" />

<g:hiddenField id="enquiry" name="enquiry" value="${enquiryInstance?.id}" />
<g:hiddenField id="customer_id" name="customer_id" value="${customerInstance?.id}" />
<g:hiddenField id="quotation_cart_info" name="quotation_cart_info" value="${quotationCartInfo}" />
<g:hiddenField id="quotation_planner_specs" name="quotation_planner_specs" value="${quotationPlannerSpecs}"/>
<g:hiddenField id="quotation_planner_quotinfo" name="quotation_planner_quotinfo" value=""/>
<g:hiddenField id="quotation_planner_modelinfo" name="quotation_planner_modelinfo" value="${quotationPalnnerModelInfo}"/>
<g:hiddenField id="quot_plan_taxation" name="quot_plan_taxation" value="${taxationInstance?.id}"/>
<!-- <input type="hidden" id="quotation_cart_info" value="<json>" />
<input type="hidden" id="quotation_planner_specs" value="specs" />
<input type="hidden" id="quotation_planner_info" value="info" /> -->

<!-- Starting Script Section -->
<input type="hidden" id="customer_search-url" value="/chakrap/customer/customerSearch" />
<input type="hidden" id="customer_add-url" value="/chakrap/customer/addCustomer" />
<input type="hidden" id="specs_submit-url" value="/chakrap/quotation/quotationSpecs" />
<input type="hidden" id="cagedesign_get-url" value="/chakrap/cageDesign/cageDesignType" />
<input type="hidden" id="cagepartspec_get-url" value="/chakrap/cagePartSpecification/cagePartSpecification" />
<input type="hidden" id="modeladd-url" value="/chakrap/quotation/addQuotationModels" />
<input type="hidden" id="mesh_part_update_request-url" value="/chakrap/quotation/editMeshPart" />
<input type="hidden" id="cage_part_update_request-url" value="/chakrap/quotation/editCagePart" />
<input type="hidden" id="chain_link_update_request-url" value="/chakrap/quotation/editChainLink" />
<input type="hidden" id="weld_side_update_request-url" value="/chakrap/quotation/editWeldSide" />
<input type="hidden" id="quotation_cart_info_submit_request-url" value="/chakrap/quotation/quotationCartSubmit" />
<input type="hidden" id="quotation_planner_info_submit_request-url" value="/chakrap/quotationPlanner/quotationPlannerSubmit" />
<input type="hidden" id="quotation_loader_request-url" value="/chakrap/quotation/quotationShow" />
<input type="hidden" id="customer_fetch-url" value="/chakrap/customer/customerFetch" />

<!-- starting script section with groovy code -->

<script type="text/template" id="taxation_options_template">
	<%def taxationList = com.chakra.config.Taxation.list() %>
	<option value="">Select</option>
	<g:each in="${taxationList}" var="taxation">
	<option value="${taxation?.id}">${taxation}</option>
	</g:each>
</script>
<script type="text/template" id="chain_link_items_template">
	<%def linkMeshList = com.chakra.config.LinkMesh.list()%>
	<option value="">Select</option>
	<g:each in="${linkMeshList}" var="linkMesh">
	<option value="${linkMesh?.id}">${linkMesh}</option>
	</g:each>
</script>
<script type="text/template" id="weld_side_items_template">
	<%def sideMeshList = com.chakra.config.SideMesh.list()%>
	<option value="">Select</option>
	<g:each in="${sideMeshList}" var="sideMesh">
	<option value="${sideMesh?.id}">${sideMesh}</option>
	</g:each>
</script>
<!-- copy this -->
<script type="text/template" id="wirebrand_select_options">
	<% def wireBrandList = com.chakra.config.WireBrand.list() %>
	<option value="">Select</option>
	<g:each in="${wireBrandList}" var="wireBrand">
	<option value="${wireBrand?.id}">${wireBrand}</option>
	</g:each>
</script>
<script type="text/template" id="customer_tile_content-initial">
<div class="customer-content-container">
	<table class="customer-content-container-space-divider">
	<tr>
		<td class="customer-content-container-input-area">
			<div>
				<table>
					<tr>
						<td><input type="text" id="companyname-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="custname-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="mobile-input" class="textfield-initial" /></td>
					</tr>
					<tr>
						<td><input type="text" id="address-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="email" id="email-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="phoneno" id="phoneno-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><input type="text" name="fax" id="fax-input" class="textfield-initial" /></td>
					</tr>
					<tr style="display:none;" name="extra">
						<td><textarea name="comments" id="comments-input" class="textfield-initial"></textarea></td>
					</tr>
				</table>
				<input type="button" value="Search" id="search-btn" class="btn-custom" />
				<input type="button" value="Add" id="add-btn" class="btn-custom" /><br />
				<input type="button" value="Add with Additional Fields" id="addwithaddl-btn" class="btn-custom" /><br />
				<span style="text-align:right">
					
					<select id="taxation" style="margin:0px; padding:0px;">
						<g:each in="${taxationList}" var="taxation">
								<option value="${taxation?.id}">${taxation}</option>
						</g:each>
					</select>
				</span>
			</div>
		</td>
		<td class="customer-content-container-results-area">
			<table>
				<tr class="search-table-header">
					<th name="id">&nbsp;</th>
					<th name="compname">Company Name</th>
					<th name="custname">Customer Name</th>
					<th name="mobile">Mobile No</th>
					<th name="address">Address</th>
				</tr>
			</table>
		</td>
	</tr>
	</table>
</div>
</script>
<script type="text/template" id="model_add_dialogue_content">
	<div class="model-add-dialogue-cage-design-select">
    	<%def designTypeList = com.chakra.config.CageDesign.constraints.designType.inList%>
    	<select id="model_add_dialogue_cage_design_type" style="margin:0px;">
			<option value="">Select</option>
			<g:each in="${designTypeList}" var="designType">
			<option value="${designType}">${designType}</option>
			</g:each>
		</select>
        <select id="model_add_dialogue_cage_design" style="margin:0px;"></select><br />
    </div>
	<div class="model-add-dialogue-add-field-box" id="model_add_dialogue_field_box">
		
    </div>
    <span style="display:block" class="model-add-other-elements">
    	<input type="button" id="model_field_add-btn" value="+" />
    </span>
    <span style="display:block" class="model-add-other-elements">
    	<input type="button" id="model_fields_submit-btn" value="Submit" />
        <input type="button" id="model_fields_cancel-btn" value="Cancel" />
    </span>
</script>
<!-- copty this -->
<script type="text/template" id="model_add_dialogue_field_box_content_additional_fields">
<div class="model-add-dialogue-add-field-additional-fields"
	<table>
		<tr>
			<select name="wireBrand" class="">
				<option value="">Select</option>
				<g:each in="${wireBrandList}" var="wireBrand">
				<option value="${wireBrand?.id}">${wireBrand}</option>
				</g:each>	
			</select>
			<td>Length:<input type="text" name="length" /></td>
		</tr>
		<tr>
			<td>Height:<input type="text" name="height" /></td>
			<td>No Of Pieces:<input type="text" name="noOfPieces" /></td>
		</tr>
	</table>
</div>
</script>
<script type="text/template" id="model_add_dialogue_field_box_content">
	<span class="model-add-dialogue-add-field">
		<%def cagePartTypeList = com.chakra.config.CagePartType.list()%>
		<select name="cagePartType">
			<option value="">Select</option>
			<option value="" class="option-cage-header">Cage Parts</option>
			<g:each in="${cagePartTypeList}" var="cagePartType">
				<option value="${cagePartType?.id}" class="option-cage-part">${cagePartType}</option>
			</g:each>
			<option value="MP" class="option-mesh-part">Mesh Part</option>
			<option value="CL" class="option-chain-link">Chain Link</option>
			<option value="WS" class="option-weld-side">Weld Side</option>
		</select>
		<select name="cagePartSpec">
		</select>
	</span>
</script>
<!-- end script section with groovy code -->

<!-- Starting Script Section -->

<script type="text/template">
	<span name="enquiryId">tempenqID</script>
</script>
<script type="text/template" id="quotation_info_tile_content">
<table id="quotation_info_table" class="info_table">
	<tr>
		<td><span class="info_label">Quotation:</span><span class="info_data"><%= '<'+'%= quotation %'+'>' %></span></td>
	
		<td><span class="info_label">Status:</span><span class="info_data"><%= '<'+'%= status %'+'>' %></span></td>
	
		<td><span class="info_label">Created By:</span><span class="info_data"><%= '<'+'%= createdby %'+'>' %></span></td>
	</tr>
	<tr>
		<td><span class="info_label">Created Date:</span><span class="info_data"><%= '<'+'%= createddate %'+'>' %></span></td>
	
		<td><span class="info_label">EnquiryId:</span><span class="info_data"><%= '<'+'%= enquiry %'+'>' %></span></td>
		
		<td><span class="info_label">Taxation:</span><span class="info_data" id="quotinfo_tax_field"><%= '<'+'%= taxation %'+'>' %></span></td>
	</tr>
</table>

</script>
<script type="text/template" id="specs_tile_content-initial">
<table id="quotation_specs_table-initial">
	<tr>
		<td>Cage Length:</td><td><input type="text" id="cage_length" /></td>
	</tr>
	<tr>
		<td>No of Cuttings:</td> <td><input type="text" id="cage_cuttings" /></td>
	</tr>
	<tr>
		<td>No of Sheds:</td> <td><input type="text" id="shed_count" /></td>
	</tr>
	<tr>
		<td>Fulls:</td> <td><input type="text" id="fulls_count" /></td>
	</tr>
	<tr>
		<td>Halfs:</td> <td><input type="text" id="halfs_count" /></td>
	</tr>
	<tr>
		<td>Tiers:</td> <td><input type="text" id="tiers_count" /></td>
	</tr>
	<tr>
		<td><input type="button" id="quotation_specs_submit-btn" value="Submit" /></td>
	</tr>
</table>
</script>

<script type="text/template" id="specs_tile_content-final">
<table id="quotation_specs_table"  class="info_table">
	<tr>
		<td><span class="info_label">Cage Length:</span><span class="info_data"><%= '<'+'%= cageLength %'+'>' %></span></td>
	
		<td><span class="info_label">No of Cuttings:</span><span class="info_data"><%= '<'+'%= noOfCuttingsInShed %'+'>' %></span></td>
	
		<td><span class="info_label">No of Sheds:</span><span class="info_data"><%= '<'+'%= noOfSheds %'+'>' %></span></td>
	</tr>
	<tr>
		<td><span class="info_label">Fulls:</span><span class="info_data"><%= '<'+'%= fulls %'+'>' %></span></td>

	
		<td><span class="info_label">Halfs:</span><span class="info_data"><%= '<'+'%= halfs %'+'>' %></span></td>
	
		<td><span class="info_label">Tiers:</span><span class="info_data"><%= '<'+'%= tiers %'+'>' %></span></td>
	</tr>
</table>
</script>
<script type="text/template" id="customer_tile_content-final">
<div class="customer-content-container">
	<table>
		<tr>
			<td><span class="info_label">Customer Name:</span><span class="info_data"><%= '<'+'%= custname %'+'>' %></span></td>
			<td><span class="info_label">Company Name:</span><span class="info_data"><%= '<'+'%= compname %'+'>' %></span></td>
			<td><span class="info_label">Mobile:</span><span class="info_data"><%= '<'+'%= mobile %'+'>' %></span></td>
		</tr>
	</table>
</div>
</script>
<script type="text/template" id="customer_search_result_entry">
	<tr class="search-result">
		<td name="id"><input type="radio" name="<%= '<'+'%= id %'+'>' %>" /></td>
		<td name="compname"><%= '<'+'%= compname %'+'>' %></td>
		<td name="custname"><%= '<'+'%= custname %'+'>' %></td>
		<td name="mobile"><%= '<'+'%= mobile %'+'>' %></td>
		<td name="address"><%= '<'+'%= address.country %'+'>' %></td>
	</tr>
</script>

<script type="text/template" id="models_grid_template">
<div id="models_grid_container">
	<div class="models-box">
	</div>
	<input type="button" id="model_add-btn" value="Add Another Model" />
</div>

</script>

<script type="text/template" id="model_row_template">
<div class="model-grid-row">
	<div class="model-grid-row-data" name="<%= '<'+'%= id %'+'>' %>">
		<span class="model-grid-row-cage-design"><%= '<'+'%= cageDesign %'+'>' %></span>
		<span class="model-grid-row-bird-count"><%= '<'+'%= noOfBirds %'+'>' %></span>
		<span class="model-grid-row-cost-per-bird"><%= '<'+'%= costPerBird  %'+'>' %></span>
		<span class="model-grid-row-cost"><%= '<'+'%= cost %'+'>' %></span>
		<span class="model-grid-row-tax"><%= '<'+'%= tax %'+'>' %></span>
		<span class="model-grid-row-totalcost"><%= '<'+'%= totalCost %'+'>' %></span>
		<span class="model-grid-row-confirm" style="width:auto;">
		<g:form method="POST" controller="corder" action="create">
			<input type="hidden" class="quot-id" name="quotation.id" />
			<input type="hidden" class="quot-model-id" name="quotationModel.id" />
			<%= '<'+'% if( showConfirmButton ) { %'+'>' %>
				<input type="button" class="model-submit-button" value="Confirm" />
			<%= '<'+'% } %'+'>' %>
		</g:form>
		<g:form method="POST" controller="quotation" action="quotationPdf1">
			<input type="hidden" class="quot-id" name="id" />
			<input type="hidden" class="quot-model-id" name="quotationModel" />
			<input type="button" class="model-print-button" value="P1" />
		</g:form>
		<g:form method="POST" controller="quotation" action="quotationPdf2">
			<input type="hidden" class="quot-id" name="id" />
			<input type="hidden" class="quot-model-id" name="quotationModel" />
			<input type="button" class="model-print-button" value="P2" />
		</g:form>
		<g:form method="POST" controller="quotation" action="quotationPdf3">
			<input type="hidden" class="quot-id" name="id" />
			<input type="hidden" class="quot-model-id" name="quotationModel" />
			<input type="button" class="model-print-button" value="P3" />
		</g:form>
		<g:form method="POST" controller="quotation" action="quotationPdf4">
			<input type="hidden" class="quot-id" name="id" />
			<input type="hidden" class="quot-model-id" name="quotationModel" />
			<input type="button" class="model-print-button" value="P4" />
		</g:form>
		</span>
		<div class="cageparttype-info">
			
		</div>
	</div>
</div>
</script>
<script type="text/template" id="model_row_cageparttype_info">
<div class="cageparttype-info-field">
	<%= '<'+'%= cagePartType %'+'>' %>::<%= '<'+'%= cagePartSpec %'+'>' %>
</div>
</script>
<script type="text/template" id="tab_tile_template">
        <span class="tab-tile" name="<%= '<'+'%= id %'+'>' %>">
                <span class="tab-tile-label"><%= '<'+'%= cageDesign %'+'>' %></span>
        </span>
</script>
<script type="text/template" id="tab_body_template">
	<div class="tab-tile-content" name="<%= '<'+'%= id %'+'>' %>">
		<%= '<'+'% if(modelInfo.meshPartsDetails) { %'+'>' %>
		<div class="collapse-panel" name="meshBlock">
			
		</div>
		<%= '<'+'% } if(modelInfo.cagePartsDetails) { %'+'>' %>
		<div class="collapse-panel" name="cageBlock">
			
		</div>
		<%= '<'+'% } %'+'>' %>
		<%= '<'+'% if(modelInfo.chainLinkDetails) { %'+'>' %>
		<div class="collapse-panel" name="chainLink">
			
		</div>
		<%= '<'+'% } %'+'>' %>
		<%= '<'+'% if(modelInfo.weldSideMeshDetails) { %'+'>' %>
		<div class="collapse-panel" name="weldSide">
			
		</div>
		<%= '<'+'% } %'+'>' %>
	</div>
</script>
<script type="text/template" id="cage_part_contents_template">
		<%= '<'+'% var details = cagePartsDetails; %'+'>' %>
			<select id="cagePartSpecSelect">
					<option value="">All</option>
					<%= '<'+'% for( i in cagePartSpecs ) {	var tmp = "<option value="+i+">"+cagePartSpecs[i].specName+"</option>"; %'+'>' %>
						<%= '<'+'%= tmp %'+'>' %>
					<%= '<'+'% } %'+'>' %>
				</select>
			<div class="collapse-panel-header">
				
				<table class="table table-bordered">
					<tr>
						<th>Cage Design</th>
						<!--<th>Single Box</th>-->
						<!--<th>Double Box</th>-->
						<th>Cost Per Bird</th>
						<th>Total no. of Birds</th>
						<th>Cage Part Cost</th>
					</tr>
					<tr>
						<td class="table-cagedesign"><%= '<'+'%= details.model.cageDesign %'+'>' %></td>
						
						<td><%= '<'+'%= details.model.costPerBird %'+'>' %></td>
						<td><%= '<'+'%= details.model.noOfBirds %'+'>' %></td>
						<td><%= '<'+'%= details.model.cagePartCost %'+'>' %></td>
					</tr>
				</table>
			</div>
			<div class="collapse-panel-body">
				<table class="table table-bordered" id="mesh_model_summary_table">
					<tr>
						<th class="table-sheet-id">Cage Part Id</th>
						<th>Cage Part</th>
						<th>No of Cage Parts</th>
						<th>Price of Each Cage Part</th>
						<th>Cost of Cage Parts</th>
					</tr>
					<%= '<'+'%  _.each(details.parts.rows, function(row) { %'+'>' %>
					<tr class="table-data">
						<td class="table-sheet-id" name="<%= '<'+'%= row.cagePartId %'+'>' %>"><%= '<'+'%= row.cagePartCode %'+'>' %></td>
						<td class="table-cage-part"><%= '<'+'%= row.cagePart %'+'>' %></td>
						<td class="table-data-itemcount"><%= '<'+'%= row.noOfcageParts %'+'>' %></td>
						<td><%= '<'+'%= row.priceOfEachCagePart %'+'>' %></td>
						<td class="table-data-itemprice"><%= '<'+'%= row.costOfCagePart %'+'>' %></td>
					</tr>
					<%= '<'+'% }); %'+'>' %>
					<tr class="table_summary">
						<th colspan="4">Cage Part Tax</th>
						<td><%= '<'+'%= details.parts.cagePartTax %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="4">Net Cage Parts Cost</th>
						<td><%= '<'+'%= details.parts.cagePartCost %'+'>' %></td>
					</tr>
				</table>
			</div>
</script>

<script type="text/template" id="cage_part_spec_contents_template">
		<%= '<'+'% var details = cagePartsDetails; %'+'>' %>
			<select id="cagePartSpecSelect">
					<option value="">All</option>
					<%= '<'+'% for( i in cagePartSpecs ) { var tmp = "<option value="+i+">"+cagePartSpecs[i].specName+"</option>"; %'+'>' %>
						<%= '<'+'%= tmp %'+'>' %>
					<%= '<'+'% } %'+'>' %>
				</select>
			<div class="collapse-panel-header">
				
				<table class="table table-bordered">
					<tr>
						<th>Cage Part Specification</th>
						<th>No Of Birds</th>						
						<th>Cost Per Bird</th>
						<th>Cost</th>
					</tr>
					<tr>
						<td class="table-cagedesign"><%= '<'+'%= details.cagePartSpec.cagePartSpecification %'+'>' %></td>
						<td><%= '<'+'%= details.cagePartSpec.noOfBirds %'+'>' %></td>
						<td><%= '<'+'%= details.cagePartSpec.costPerBird %'+'>' %></td>
						<td><%= '<'+'%= details.cagePartSpec.cagePartSpecCost %'+'>' %></td>						
					</tr>
				</table>
			</div>
			<div class="collapse-panel-body">
				<table class="table table-bordered" id="mesh_model_summary_table">
					<tr>
						<th class="table-sheet-id">Cage Part Id</th>
						<th>Cage Part</th>
						<th>No of Cage Parts</th>
						<th>Price of Each Cage Part</th>
						<th>Cost of Cage Parts</th>
					</tr>
					<%= '<'+'%  _.each(details.cageParts, function(row) { %'+'>' %>
					<tr class="table-data">
						<td class="table-sheet-id" name="<%= '<'+'%= row.cagePartId %'+'>' %>"><%= '<'+'%= row.cagePartCode %'+'>' %></td>
						<td class="table-cage-part"><%= '<'+'%= row.cagePart %'+'>' %></td>
						<td class="table-data-itemcount"><%= '<'+'%= row.noOfcageParts %'+'>' %></td>
						<td><%= '<'+'%= row.priceOfEachCagePart %'+'>' %></td>
						<td class="table-data-itemprice"><%= '<'+'%= row.costOfCagePart %'+'>' %></td>
					</tr>
					<%= '<'+'% }); %'+'>' %>
					<tr class="table_summary">
						<th colspan="4">Net Cage Parts Cost</th>
						<td><%= '<'+'%= details.cagePartSpec.cagePartSpecCost %'+'>' %></td>
					</tr>
				</table>
			</div>
</script>
<script type="text/template" id="mesh_part_contents_template">
		<%= '<'+'% var details = meshPartsDetails %'+'>' %>
			<div class="collapse-panel-header">
				<table class="table table-bordered">
					<tr>
						<th>Cage Design</th>
						<th>Wire Brand</th>
						<th>Single Box</th>
						<th>Double Box</th>
						<th>Cost Per Bird</th>
						<th>Total no. of Birds</th>
						<th>Mesh Cost</th>
					</tr>
					<tr>
						<td class="table-cagedesign"><%= '<'+'%= details.model.cageDesign %'+'>' %></td>
						<td><%= '<'+'%= details.model.wireBrand %'+'>' %></td>
						<td><%= '<'+'%= details.model.singleBox %'+'>' %></td>
						<td><%= '<'+'%= details.model.doubleBox %'+'>' %></td>
						<td><%= '<'+'%= details.model.costPerBird %'+'>' %></td>
						<td><%= '<'+'%= details.model.noOfBirds %'+'>' %></td>
						<td><%= '<'+'%= details.model.meshCost %'+'>' %></td>
					</tr>
				</table>
			</div>
			<div class="collapse-panel-body">
				<table class="table table-bordered" id="mesh_model_summary_table">
					<tr>
						<th class="table-sheet-id">Sheet Id</th>
						<th class="table-sheet-spec">Sheet Specification</th>
						<th class="table-wirebrand">Wirebrand</th>
						<th class="table-part-count">No of mesh Parts</th>
						<th >Cost of mesh Parts</th>
					</tr>
					<%= '<'+'%  _.each(details.parts.rows, function(row) { %'+'>' %>
					<tr class="table-data">
						<td class="table-sheet-id" name="<%= '<'+'%= row.sheetSpecId %'+'>' %>"><%= '<'+'%= row.sheetId %'+'>' %></td>
						<td class="table-sheet-spec"><%= '<'+'%= row.sheetSpecification %'+'>' %></td>
						<td ><%= '<'+'%= row.wireBrand %'+'>' %></td>
						<td class="table-data-itemcount"><%= '<'+'%= row.noOfMeshParts %'+'>' %></td>
						<td class="table-data-itemprice"><%= '<'+'%= row.costOfMeshPart %'+'>' %></td>
					</tr>
					<%= '<'+'% }); %'+'>' %>
					<tr class="table_summary">
						<th colspan="4">Mesh Parts Cost</th>
						<td><%= '<'+'%= details.parts.meshCost %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="4">Mesh Discount@<%= '<'+'%= details.parts.meshDiscountPercent %'+'>' %></th>
						<td><%= '<'+'%= details.parts.meshDiscount %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="4">Mesh Tax</th>
						<td><%= '<'+'%= details.parts.meshTax %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="4">Net Cost of Mesh Parts</th>
						<td><%= '<'+'%= details.parts.netMeshCost %'+'>' %></td>
					</tr>
				</table>
			</div>
</script>
<script type="text/template" id="chain_link_contents_template">
		<%= '<'+'% var details = chainLinkDetails; %'+'>' %>
			<div class="collapse-panel-header">
				<table class="table table-bordered">
					<tr>
						<th>Chain Link Mesh Cost</th>
					</tr>
					<tr>
						<td><%= '<'+'%= details.model.chainLinkCost %'+'>' %></td>
					</tr>
				</table>
			</div>
			<div class="collapse-panel-body">
				<table class="table table-bordered" id="mesh_model_summary_table">
					<tr>
						<th class="table-sheet-id">Link Mesh Id</th>
						<th >Wirebrand</th>
						<th>Length</th>
						<th>Height</th>
						<th>No of Pieces</th>
						<th>Square feet</th>
						<th>Price per Square feet</th>
						<th>Chain Link Item Cost</th>
					</tr>
					<%= '<'+'%  _.each(details.parts.rows, function(row) { %'+'>' %>
					<tr class="table-data" name="<%= '<'+'%= row.chainLinkId %'+'>' %>">
						<td class="table-cl-id" name="<%= '<'+'%= row.linkMeshId %'+'>' %>"><%= '<'+'%= row.linkMesh %'+'>' %></td>
						<td class="table-cl-wirebrand"><%= '<'+'%= row.wireBrand %'+'>' %></td>
						<td class="table-cl-length"><%= '<'+'%= row.length %'+'>' %></td>
						<td class="table-cl-height"><%= '<'+'%= row.height %'+'>' %></td>
						<td class="table-cl-noOfPices"><%= '<'+'%= row.noOfPieces %'+'>' %></td>
						<td><%= '<'+'%= row.squareFeets %'+'>' %></td>
						<td class="table-data-itemcount"><%= '<'+'%= row.pricePerSqFt %'+'>' %></td>
						<td class="table-data-itemprice"><%= '<'+'%= row.chainLinkItemCost %'+'>' %></td>
					</tr>
					<%= '<'+'% }); %'+'>' %>
					<tr class="table_summary">
						<th colspan="7">Chain Link Cost</th>
						<td><%= '<'+'%= details.parts.chainLinkCost %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Chain Link Discount@<%= '<'+'%= details.parts.chainLinkDiscountPercent %'+'>' %></th>
						<td><%= '<'+'%= details.parts.chainLinkDiscount %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Chain Link Tax</th>
						<td><%= '<'+'%= details.parts.chainLinkTax %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Net Cost of Chain Link</th>
						<td><%= '<'+'%= details.parts.netChainLinkCost %'+'>' %></td>
					</tr>    
				</table>
			</div>
</script>
<script type="text/template" id="weld_side_contents_template">
		<%= '<'+'% var details = weldSideMeshDetails; %'+'>' %>
			<div class="collapse-panel-header">
				<table class="table table-bordered">
					<tr>
						<th>Weld Side Mesh Cost</th>
					</tr>
					<tr>
						<td><%= '<'+'%= details.model.weldSideCost %'+'>' %></td>
					</tr>
				</table>
			</div>
			<div class="collapse-panel-body">
				<table class="table table-bordered" id="mesh_model_summary_table">
					<tr>
						<th class="table-sheet-id">Weld Side Id</th>
						<th >Wirebrand</th>
						<th>Length</th>
						<th>Height</th>
						<th>No of Pieces</th>
						<th>Square feet</th>
						<th>Price per Square feet</th>
						<th>Weld Side Item Cost</th>
					</tr>
					<%= '<'+'%  _.each(details.parts.rows, function(row) { %'+'>' %>
					<tr class="table-data" name="<%= '<'+'%= row.weldSideId %'+'>' %>">
						<td class="table-ws-id" name="<%= '<'+'%= row.sideMeshId %'+'>' %>"><%= '<'+'%= row.sideMesh %'+'>' %></td>
						<td class="table-ws-wirebrand"><%= '<'+'%= row.wireBrand %'+'>' %></td>
						<td class="table-ws-length"><%= '<'+'%= row.length %'+'>' %></td>
						<td class="table-ws-height"><%= '<'+'%= row.height %'+'>' %></td>
						<td class="table-ws-noOfPices"><%= '<'+'%= row.noOfPieces %'+'>' %></td>
						<td><%= '<'+'%= row.squareFeets %'+'>' %></td>
						<td class="table-data-itemcount"><%= '<'+'%= row.pricePerSqFt %'+'>' %></td>
						<td class="table-data-itemprice"><%= '<'+'%= row.weldSideItemCost %'+'>' %></td>
					</tr>
					<%= '<'+'% }); %'+'>' %>
					<tr class="table_summary">
						<th colspan="7">Weld Side Mesh Cost</th>
						<td><%= '<'+'%= details.parts.weldSideCost %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Discount@<%= '<'+'%= details.parts.weldSideDiscountPercent %'+'>' %></th>
						<td><%= '<'+'%= details.parts.weldSideDiscount %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Weld Side Tax</th>
						<td><%= '<'+'%= details.parts.weldSideTax %'+'>' %></td>
					</tr>
					<tr class="table_summary">
						<th colspan="7">Net Cost of Weld Side Mesh</th>
						<td><%= '<'+'%= details.parts.netWeldSideCost %'+'>' %></td>
					</tr>    
				</table>
			</div>
</script>
<div id="container">
    <div id="quotation_info_tile" class="quotation-page-tile">
    </div>
    <div id="customer_tile" class="quotation-page-tile">
    </div>
    <div id="quotation_info_tile_init" class="quotation-page-tile">
    </div>
    <div id="models_tile" class="quotation-page-tile">
    </div>
    <div id="models_info_tile" class="quotation-page-tile">
       	<script id="tabbed_panel_content" type="text/template">
    	<div class="models-info-container">
 			<div class="tabs-box-container">
            	<div class="tabs-holder">
                	
                </div>
                <div class="tabs-content-holder">
                	
                </div>
            </div>  
    	</div>
		</script> 
    </div>
</div>

<!-- end of script section --> 

</body>
</html>
