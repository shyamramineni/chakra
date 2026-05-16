/* Modern Quotation Management System */

class ModernQuotationManager {
    constructor() {
        this.customer = null;
        this.customerId = null;
        this.specs = null;
        this.enquiryId = null;
        this.sourcePage = null;
        this.temp = {};
        this.popup = null;
        this.specsTile = null;
        this.modelInfo = null;
        
        this.init();
    }
    
    init() {
        // Initialize event handlers
        this.setupEventHandlers();
        
        // Check for legacy quotation object and migrate
        if (window.quotation) {
            this.migrateLegacyData();
        }
        
        // Initialize source page detection
        this.detectSourcePage();
    }
    
    detectSourcePage() {
        // Detect source page from URL or page elements
        const url = window.location.href;
        if (url.includes('enquiry')) {
            this.sourcePage = 'Enquiry';
        } else if (url.includes('quotationPlanner')) {
            this.sourcePage = 'QuotationPlanner';
        } else {
            this.sourcePage = 'Default';
        }
    }
    
    setupEventHandlers() {
        // Modern event delegation
        $(document).on('customer-selected', (event, data) => {
            this.handleCustomerSelected(data);
        });
        
        $(document).on('quotation-specs-submit', (event, specs) => {
            this.handleQuotationSpecsSubmit(specs);
        });
        
        $(document).on('click', '.model-add-btn', () => {
            this.handleModelAddBtnClick();
        });
        
        $(document).on('click', '.model-row', (event) => {
            const modelId = $(event.currentTarget).data('model-id');
            this.handleModelRowClick(modelId);
        });
        
        // Customer selection from dropdown or autocomplete
        $(document).on('change', '#customer-select', (event) => {
            const customerId = $(event.target).val();
            if (customerId) {
                this.loadCustomerData(customerId);
            }
        });
    }
    
    loadCustomerData(customerId) {
        const customerData = {
            id: customerId,
            // Fetch customer data from server or existing data
        };
        
        this.handleCustomerSelected(customerData);
    }
    
    handleCustomerSelected(data) {
        this.customer = data;
        this.customerId = data.id;
        
        console.log('Customer selected:', this.customer);
        
        // Show success message
        this.showSuccessMessage(`Customer ${data.customerName || data.id} selected successfully`);
        
        if (this.sourcePage === "Enquiry") {
            this.createQuotationSpecsTile();
        } else if (this.sourcePage === "QuotationPlanner") {
            this.handleQuotationPlannerSubmit();
        } else {
            this.handleQuotationCartSubmit();
        }
    }
    
    handleQuotationSpecsSubmit(specs) {
        this.specs = specs;
        this.specs.customerId = this.customerId;
        this.specs.enquiryId = this.enquiryId;
        
        const requestData = {
            requestType: "QuotationSubmitRequest",
            requestData: JSON.stringify(this.specs)
        };
        
        this.sendServerRequest(
            $("#specs_submit-url").val() || '/quotation/submitSpecs',
            requestData,
            this.serverResponseHandler.bind(this)
        );
    }
    
    handleQuotationPlannerSubmit() {
        const req = {};
        req.customerId = this.customerId;
        req.quotSpecs = this.getQuotationSpecs();
        req.quotInfo = this.getQuotationInfo();
        req.modelInfo = this.getModelInfo();
        
        const requestData = {
            requestType: "QuotationPlannerInfoSubmitRequest",
            requestData: JSON.stringify(req)
        };
        
        this.sendServerRequest(
            $("#quotation_planner_info_submit_request-url").val() || '/quotation/plannerSubmit',
            requestData,
            this.serverResponseHandler.bind(this)
        );
    }
    
    handleQuotationCartSubmit() {
        const quotCartInfo = this.getQuotationCartInfo();
        quotCartInfo.customerId = this.customerId;
        
        const requestData = {
            requestType: "QuotationCartInfoSubmitRequest",
            requestData: JSON.stringify(quotCartInfo)
        };
        
        this.sendServerRequest(
            $("#quotation_cart_info_submit_request-url").val() || '/quotation/cartSubmit',
            requestData,
            this.serverResponseHandler.bind(this)
        );
    }
    
    handleModelAddBtnClick() {
        // Create modern Bootstrap 5 modal instead of popup
        const modalHtml = `
            <div class="modal fade" id="modelAddModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add Model</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div id="model-add-form-container">
                                <form id="model-add-form" class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Model Name</label>
                                        <input type="text" class="form-control" name="modelName" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Model Type</label>
                                        <select class="form-select" name="modelType" required>
                                            <option value="">Select Type</option>
                                            <option value="cage">Cage Model</option>
                                            <option value="mesh">Mesh Model</option>
                                            <option value="chainlink">Chain Link Model</option>
                                            <option value="weldside">Weld Side Model</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Description</label>
                                        <textarea class="form-control" name="description" rows="3"></textarea>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="model-add-submit">Add Model</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Remove existing modal if present
        $('#modelAddModal').remove();
        $('body').append(modalHtml);
        
        const modal = new bootstrap.Modal(document.getElementById('modelAddModal'));
        modal.show();
        
        // Handle modal events
        $('#model-add-submit').on('click', () => {
            this.handleModelAddSubmit();
        });
        
        $('#modelAddModal').on('hidden.bs.modal', () => {
            $('#modelAddModal').remove();
        });
    }
    
    handleModelAddSubmit() {
        const form = document.getElementById('model-add-form');
        const formData = new FormData(form);
        const modelData = {};
        
        for (let [key, value] of formData.entries()) {
            modelData[key] = value;
        }
        
        // Validate form data
        if (!modelData.modelName || !modelData.modelType) {
            this.showErrorMessage('Please fill in all required fields');
            return;
        }
        
        // Submit model data
        this.sendServerRequest(
            '/quotation/addModel',
            { modelData: JSON.stringify(modelData) },
            (response) => {
                if (response.success) {
                    this.showSuccessMessage('Model added successfully');
                    $('#modelAddModal').modal('hide');
                    this.refreshModelList();
                } else {
                    this.showErrorMessage(response.message || 'Failed to add model');
                }
            }
        );
    }
    
    handleModelRowClick(modelId) {
        console.log("Model ID selected:", modelId);
        
        // Highlight selected model row
        $('.model-row').removeClass('table-active');
        $(`.model-row[data-model-id="${modelId}"]`).addClass('table-active');
        
        if (this.modelInfo) {
            this.modelInfo.selectModel(modelId);
        }
        
        // Trigger model selection event
        $(document).trigger('model-selected', [modelId]);
    }
    
    sendServerRequest(url, data, callback) {
        // Show loading state
        this.showLoadingSpinner();
        
        $.ajax({
            url: url,
            type: 'POST',
            data: data,
            dataType: 'json',
            timeout: 30000,
            success: (response) => {
                this.hideLoadingSpinner();
                if (callback) callback(response);
            },
            error: (xhr, status, error) => {
                this.hideLoadingSpinner();
                console.error('Server request failed:', error);
                this.showErrorMessage('Request failed. Please check your connection and try again.');
            }
        });
    }
    
    serverResponseHandler(response) {
        console.log('Server response:', response);
        
        if (response.success) {
            this.showSuccessMessage(response.message || 'Operation completed successfully');
            
            // Handle specific response actions
            if (response.action) {
                this.handleResponseAction(response.action, response.data);
            }
        } else {
            this.showErrorMessage(response.message || 'Operation failed');
        }
    }
    
    handleResponseAction(action, data) {
        switch (action) {
            case 'redirect':
                window.location.href = data.url;
                break;
            case 'refresh':
                location.reload();
                break;
            case 'updateView':
                this.updateView(data);
                break;
            default:
                console.log('Unknown action:', action);
        }
    }
    
    updateView(data) {
        if (data.targetElement && data.content) {
            $(data.targetElement).html(data.content);
        }
    }
    
    showSuccessMessage(message) {
        this.showMessage(message, 'success');
    }
    
    showErrorMessage(message) {
        this.showMessage(message, 'danger');
    }
    
    showMessage(message, type) {
        // Remove existing alerts
        $('.alert').remove();
        
        const alertHtml = `
            <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                <i class="bi bi-${type === 'success' ? 'check-circle' : 'exclamation-triangle'}"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `;
        $('.main-content').prepend(alertHtml);
        
        // Auto-dismiss after 5 seconds for success messages
        if (type === 'success') {
            setTimeout(() => {
                $('.alert-success').alert('close');
            }, 5000);
        }
    }
    
    showLoadingSpinner() {
        $('#spinner').removeClass('d-none').addClass('d-flex');
    }
    
    hideLoadingSpinner() {
        $('#spinner').removeClass('d-flex').addClass('d-none');
    }
    
    createQuotationSpecsTile() {
        const container = $("#quotation_info_tile_init");
        if (container.length) {
            this.specsTile = new ModernQuotationSpecsTile(container[0]);
        }
    }
    
    getQuotationSpecs() {
        try {
            return $.parseJSON($("#quotation_planner_specs").val() || '{}');
        } catch (e) {
            console.warn('Invalid quotation specs JSON');
            return {};
        }
    }
    
    getQuotationInfo() {
        try {
            return $.parseJSON($("#quotation_planner_quotinfo").val() || '{}');
        } catch (e) {
            console.warn('Invalid quotation info JSON');
            return {};
        }
    }
    
    getModelInfo() {
        try {
            return $.parseJSON($("#quotation_planner_modelinfo").val() || '{}');
        } catch (e) {
            console.warn('Invalid model info JSON');
            return {};
        }
    }
    
    getQuotationCartInfo() {
        try {
            return $.parseJSON($("#quotation_cart_info").val() || '{}');
        } catch (e) {
            console.warn('Invalid cart info JSON');
            return {};
        }
    }
    
    refreshModelList() {
        // Refresh the model list display
        const modelListContainer = $('#model-list-container');
        if (modelListContainer.length) {
            this.sendServerRequest(
                '/quotation/getModelList',
                {},
                (response) => {
                    if (response.success && response.data) {
                        modelListContainer.html(response.data.html);
                    }
                }
            );
        }
    }
    
    migrateLegacyData() {
        // Migrate data from legacy quotation object
        const legacy = window.quotation;
        if (legacy) {
            this.customer = legacy.customer || null;
            this.customerId = legacy.customerId || null;
            this.specs = legacy.specs || null;
            this.enquiryId = legacy.enquiryId || null;
            this.sourcePage = legacy.sourcePage || null;
            this.temp = legacy.temp || {};
            
            console.log('Legacy quotation data migrated');
        }
    }
    
    // Public API methods for backward compatibility
    setCustomer(customer) {
        this.handleCustomerSelected(customer);
    }
    
    getCustomer() {
        return this.customer;
    }
    
    setSpecs(specs) {
        this.specs = specs;
    }
    
    getSpecs() {
        return this.specs;
    }
}

class ModernQuotationSpecsTile {
    constructor(container) {
        this.container = container;
        this.init();
    }
    
    init() {
        this.render();
        this.setupEvents();
    }
    
    render() {
        const html = `
            <div class="quotation-specs-tile card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-clipboard-data"></i>
                        Quotation Specifications
                    </h5>
                </div>
                <div class="card-body">
                    <form id="quotation-specs-form" class="needs-validation" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Cage Length <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="cageLength" step="0.01" min="0" required>
                                    <div class="invalid-feedback">Please enter a valid cage length.</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Fulls</label>
                                    <input type="number" class="form-control" name="fulls" min="0">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Halfs</label>
                                    <input type="number" class="form-control" name="halfs" min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tiers <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="tiers" min="1" required>
                                    <div class="invalid-feedback">Please enter number of tiers.</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">No of Cuttings in Shed</label>
                                    <input type="number" class="form-control" name="noOfCuttingsInShed" min="0">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">No of Sheds</label>
                                    <input type="number" class="form-control" name="noOfSheds" min="1">
                                </div>
                            </div>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="bi bi-calculator"></i>
                                Submit Specifications
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        `;
        
        $(this.container).html(html);
    }
    
    setupEvents() {
        $('#quotation-specs-form').on('submit', (e) => {
            e.preventDefault();
            
            const form = e.target;
            if (!form.checkValidity()) {
                e.stopPropagation();
                form.classList.add('was-validated');
                return;
            }
            
            const formData = this.getFormData();
            $(document).trigger('quotation-specs-submit', [formData]);
        });
        
        // Real-time validation
        $('#quotation-specs-form input').on('input', function() {
            if (this.checkValidity()) {
                $(this).removeClass('is-invalid').addClass('is-valid');
            } else {
                $(this).removeClass('is-valid').addClass('is-invalid');
            }
        });
    }
    
    getFormData() {
        const form = $('#quotation-specs-form')[0];
        const formData = new FormData(form);
        const data = {};
        
        for (let [key, value] of formData.entries()) {
            data[key] = value;
        }
        
        return data;
    }
}

// Initialize modern quotation manager when document is ready
$(document).ready(() => {
    window.modernQuotation = new ModernQuotationManager();
    
    // Maintain backward compatibility with legacy code
    window.quotationEventHandlers = {
        customerSelected: (data) => window.modernQuotation.handleCustomerSelected(data),
        quotationSpecsSubmitClick: (specs) => window.modernQuotation.handleQuotationSpecsSubmit(specs),
        modelAddbtnClickHandler: () => window.modernQuotation.handleModelAddBtnClick(),
        modelRowClickHandler: (modelId) => window.modernQuotation.handleModelRowClick(modelId)
    };
    
    // Legacy global quotation object for compatibility
    window.quotation = {
        customer: null,
        customerId: null,
        specs: null,
        enquiryId: null,
        sourcePage: null,
        temp: {},
        
        // Proxy methods to modern implementation
        setCustomer: (customer) => window.modernQuotation.setCustomer(customer),
        getCustomer: () => window.modernQuotation.getCustomer(),
        setSpecs: (specs) => window.modernQuotation.setSpecs(specs),
        getSpecs: () => window.modernQuotation.getSpecs()
    };
});