/* Modern Customer Management System */

class ModernCustomerManager {
    constructor() {
        this.selectedCustomer = null;
        this.searchCache = new Map();
        this.searchTimeout = null;
        this.init();
    }
    
    init() {
        this.setupEventHandlers();
        this.initializeCustomerSearch();
    }
    
    setupEventHandlers() {
        // Customer search with debouncing
        $(document).on('input', '#customer-search', (e) => {
            clearTimeout(this.searchTimeout);
            this.searchTimeout = setTimeout(() => {
                this.performSearch($(e.target).val());
            }, 300);
        });
        
        // Customer selection
        $(document).on('click', '.customer-select-btn', (e) => {
            e.preventDefault();
            const customerId = $(e.currentTarget).data('customer-id');
            this.selectCustomer(customerId);
        });
        
        // Customer form submission
        $(document).on('submit', '#customer-form', (e) => {
            this.handleFormSubmission(e);
        });
        
        // Customer modal events
        $(document).on('click', '.customer-edit-btn', (e) => {
            const customerId = $(e.currentTarget).data('customer-id');
            this.showEditModal(customerId);
        });
        
        // Customer details view
        $(document).on('click', '.customer-details-btn', (e) => {
            const customerId = $(e.currentTarget).data('customer-id');
            this.showCustomerDetails(customerId);
        });
    }
    
    initializeCustomerSearch() {
        // Initialize autocomplete if available
        if (typeof $.fn.autocomplete !== 'undefined') {
            $('#customer-search').autocomplete({
                source: (request, response) => {
                    this.getCustomerSuggestions(request.term, response);
                },
                minLength: 2,
                select: (event, ui) => {
                    this.selectCustomer(ui.item.value);
                }
            });
        }
    }
    
    performSearch(searchTerm) {
        if (!searchTerm || searchTerm.length < 2) {
            this.clearSearchResults();
            return;
        }
        
        // Check cache first
        if (this.searchCache.has(searchTerm)) {
            this.displaySearchResults(this.searchCache.get(searchTerm));
            return;
        }
        
        // Show loading state
        this.showSearchLoading();
        
        $.ajax({
            url: '/customer/search',
            type: 'GET',
            data: { q: searchTerm },
            dataType: 'json',
            success: (response) => {
                this.hideSearchLoading();
                if (response.success && response.data) {
                    this.searchCache.set(searchTerm, response.data);
                    this.displaySearchResults(response.data);
                } else {
                    this.showNoResults();
                }
            },
            error: (xhr, status, error) => {
                this.hideSearchLoading();
                console.error('Customer search failed:', error);
                this.showSearchError('Search failed. Please try again.');
            }
        });
    }
    
    getCustomerSuggestions(term, callback) {
        if (this.searchCache.has(term)) {
            const results = this.searchCache.get(term);
            callback(this.formatSuggestions(results));
            return;
        }
        
        $.ajax({
            url: '/customer/suggestions',
            type: 'GET',
            data: { term: term },
            dataType: 'json',
            success: (response) => {
                if (response.success && response.data) {
                    callback(this.formatSuggestions(response.data));
                } else {
                    callback([]);
                }
            },
            error: () => {
                callback([]);
            }
        });
    }
    
    formatSuggestions(customers) {
        return customers.map(customer => ({
            label: `${customer.customerName} - ${customer.companyName}`,
            value: customer.id,
            customer: customer
        }));
    }
    
    displaySearchResults(customers) {
        const container = $('#customer-search-results');
        if (!container.length) return;
        
        if (!customers || customers.length === 0) {
            this.showNoResults();
            return;
        }
        
        let html = '<div class="list-group">';
        customers.forEach(customer => {
            html += `
                <div class="list-group-item list-group-item-action customer-search-item" data-customer-id="${customer.id}">
                    <div class="d-flex w-100 justify-content-between">
                        <div>
                            <h6 class="mb-1">${customer.customerName}</h6>
                            <p class="mb-1 text-muted">${customer.companyName}</p>
                            <small class="text-muted">${customer.email || ''}</small>
                        </div>
                        <div>
                            <button class="btn btn-sm btn-primary customer-select-btn" data-customer-id="${customer.id}">
                                Select
                            </button>
                        </div>
                    </div>
                </div>
            `;
        });
        html += '</div>';
        
        container.html(html);
        container.show();
    }
    
    clearSearchResults() {
        $('#customer-search-results').hide().empty();
    }
    
    showNoResults() {
        const container = $('#customer-search-results');
        container.html(`
            <div class="alert alert-info">
                <i class="bi bi-info-circle"></i>
                No customers found matching your search criteria.
                <a href="/customer/create" class="alert-link">Create new customer</a>
            </div>
        `).show();
    }
    
    showSearchLoading() {
        const container = $('#customer-search-results');
        container.html(`
            <div class="d-flex justify-content-center p-3">
                <div class="spinner-border spinner-border-sm" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                <span class="ms-2">Searching customers...</span>
            </div>
        `).show();
    }
    
    hideSearchLoading() {
        // Loading will be replaced by results or error message
    }
    
    showSearchError(message) {
        const container = $('#customer-search-results');
        container.html(`
            <div class="alert alert-danger">
                <i class="bi bi-exclamation-triangle"></i>
                ${message}
            </div>
        `).show();
    }
    
    selectCustomer(customerId) {
        this.showLoadingSpinner();
        
        $.ajax({
            url: `/customer/${customerId}`,
            type: 'GET',
            dataType: 'json',
            success: (response) => {
                this.hideLoadingSpinner();
                if (response.success && response.data) {
                    this.selectedCustomer = response.data;
                    this.displaySelectedCustomer(response.data);
                    this.triggerCustomerSelectedEvent(response.data);
                } else {
                    this.showErrorMessage('Failed to load customer details');
                }
            },
            error: (xhr, status, error) => {
                this.hideLoadingSpinner();
                console.error('Failed to load customer:', error);
                this.showErrorMessage('Failed to load customer. Please try again.');
            }
        });
    }
    
    displaySelectedCustomer(customer) {
        const container = $('#selected-customer-display');
        if (!container.length) return;
        
        const html = `
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h6 class="mb-0">Selected Customer</h6>
                    <div>
                        <button class="btn btn-sm btn-outline-primary customer-details-btn" data-customer-id="${customer.id}">
                            View Details
                        </button>
                        <button class="btn btn-sm btn-outline-secondary customer-edit-btn" data-customer-id="${customer.id}">
                            Edit
                        </button>
                        <button class="btn btn-sm btn-outline-danger" onclick="modernCustomer.clearSelection()">
                            Clear
                        </button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>Name:</strong> ${customer.customerName}<br>
                            <strong>Company:</strong> ${customer.companyName}<br>
                            <strong>ID:</strong> ${customer.customerId || customer.id}
                        </div>
                        <div class="col-md-6">
                            <strong>Mobile:</strong> ${customer.mobileNumber || 'N/A'}<br>
                            <strong>Email:</strong> ${customer.email || 'N/A'}<br>
                            <strong>Phone:</strong> ${customer.phoneNumber || 'N/A'}
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        container.html(html);
        this.clearSearchResults();
    }
    
    triggerCustomerSelectedEvent(customer) {
        // Trigger event for quotation system and other components
        $(document).trigger('customer-selected', [customer]);
        
        // Legacy compatibility
        if (window.quotationEventHandlers && window.quotationEventHandlers.customerSelected) {
            window.quotationEventHandlers.customerSelected(customer);
        }
        
        this.showSuccessMessage(`Customer ${customer.customerName} selected successfully`);
    }
    
    clearSelection() {
        this.selectedCustomer = null;
        $('#selected-customer-display').empty();
        $('#customer-search').val('');
        this.clearSearchResults();
        
        $(document).trigger('customer-cleared');
        this.showSuccessMessage('Customer selection cleared');
    }
    
    showEditModal(customerId) {
        this.showLoadingSpinner();
        
        $.ajax({
            url: `/customer/edit/${customerId}`,
            type: 'GET',
            dataType: 'json',
            success: (response) => {
                this.hideLoadingSpinner();
                if (response.success && response.data) {
                    this.createEditModal(response.data);
                } else {
                    this.showErrorMessage('Failed to load customer for editing');
                }
            },
            error: () => {
                this.hideLoadingSpinner();
                this.showErrorMessage('Failed to load customer edit form');
            }
        });
    }
    
    createEditModal(customer) {
        const modalHtml = `
            <div class="modal fade" id="customerEditModal" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-person-gear"></i>
                                Edit Customer - ${customer.customerName}
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="customer-edit-form" class="needs-validation" novalidate>
                                <input type="hidden" name="id" value="${customer.id}">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Customer Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="customerName" value="${customer.customerName}" required>
                                            <div class="invalid-feedback">Please enter customer name.</div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Company Name <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="companyName" value="${customer.companyName}" required>
                                            <div class="invalid-feedback">Please enter company name.</div>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Mobile Number <span class="text-danger">*</span></label>
                                            <input type="tel" class="form-control" name="mobileNumber" value="${customer.mobileNumber}" required>
                                            <div class="invalid-feedback">Please enter mobile number.</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input type="email" class="form-control" name="email" value="${customer.email || ''}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Phone Number</label>
                                            <input type="tel" class="form-control" name="phoneNumber" value="${customer.phoneNumber || ''}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Fax</label>
                                            <input type="tel" class="form-control" name="fax" value="${customer.fax || ''}">
                                        </div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Address</label>
                                    <textarea class="form-control" name="address" rows="3">${customer.address || ''}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Comments</label>
                                    <textarea class="form-control" name="comments" rows="2">${customer.comments || ''}</textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="save-customer-changes">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        // Remove existing modal
        $('#customerEditModal').remove();
        $('body').append(modalHtml);
        
        const modal = new bootstrap.Modal(document.getElementById('customerEditModal'));
        modal.show();
        
        // Handle save
        $('#save-customer-changes').on('click', () => {
            this.saveCustomerChanges();
        });
        
        // Form validation
        $('#customer-edit-form input, #customer-edit-form textarea').on('input', function() {
            if (this.checkValidity()) {
                $(this).removeClass('is-invalid').addClass('is-valid');
            } else {
                $(this).removeClass('is-valid').addClass('is-invalid');
            }
        });
    }
    
    saveCustomerChanges() {
        const form = document.getElementById('customer-edit-form');
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }
        
        const formData = new FormData(form);
        const customerData = {};
        for (let [key, value] of formData.entries()) {
            customerData[key] = value;
        }
        
        this.showLoadingSpinner();
        
        $.ajax({
            url: `/customer/update/${customerData.id}`,
            type: 'POST',
            data: customerData,
            dataType: 'json',
            success: (response) => {
                this.hideLoadingSpinner();
                if (response.success) {
                    $('#customerEditModal').modal('hide');
                    this.showSuccessMessage('Customer updated successfully');
                    
                    // Refresh customer display if this is the selected customer
                    if (this.selectedCustomer && this.selectedCustomer.id == customerData.id) {
                        this.selectCustomer(customerData.id);
                    }
                } else {
                    this.showErrorMessage(response.message || 'Failed to update customer');
                }
            },
            error: () => {
                this.hideLoadingSpinner();
                this.showErrorMessage('Failed to save customer changes');
            }
        });
    }
    
    showCustomerDetails(customerId) {
        window.open(`/customer/show/${customerId}`, '_blank');
    }
    
    handleFormSubmission(e) {
        e.preventDefault();
        
        const form = e.target;
        if (!form.checkValidity()) {
            e.stopPropagation();
            form.classList.add('was-validated');
            return;
        }
        
        const formData = new FormData(form);
        const customerData = {};
        for (let [key, value] of formData.entries()) {
            customerData[key] = value;
        }
        
        this.showLoadingSpinner();
        
        $.ajax({
            url: form.action || '/customer/save',
            type: 'POST',
            data: customerData,
            dataType: 'json',
            success: (response) => {
                this.hideLoadingSpinner();
                if (response.success) {
                    this.showSuccessMessage('Customer saved successfully');
                    
                    if (response.data && response.data.redirect) {
                        window.location.href = response.data.redirect;
                    } else {
                        form.reset();
                        form.classList.remove('was-validated');
                    }
                } else {
                    this.showErrorMessage(response.message || 'Failed to save customer');
                }
            },
            error: () => {
                this.hideLoadingSpinner();
                this.showErrorMessage('Failed to save customer');
            }
        });
    }
    
    showLoadingSpinner() {
        $('#spinner').removeClass('d-none').addClass('d-flex');
    }
    
    hideLoadingSpinner() {
        $('#spinner').removeClass('d-flex').addClass('d-none');
    }
    
    showSuccessMessage(message) {
        this.showMessage(message, 'success');
    }
    
    showErrorMessage(message) {
        this.showMessage(message, 'danger');
    }
    
    showMessage(message, type) {
        $('.alert').remove();
        
        const alertHtml = `
            <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                <i class="bi bi-${type === 'success' ? 'check-circle' : 'exclamation-triangle'}"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        `;
        $('.main-content').prepend(alertHtml);
        
        if (type === 'success') {
            setTimeout(() => {
                $('.alert-success').alert('close');
            }, 5000);
        }
    }
    
    // Public API
    getSelectedCustomer() {
        return this.selectedCustomer;
    }
    
    setSelectedCustomer(customer) {
        this.selectedCustomer = customer;
        this.displaySelectedCustomer(customer);
    }
}

// Initialize customer manager when document is ready
$(document).ready(() => {
    window.modernCustomer = new ModernCustomerManager();
    
    // Legacy compatibility object
    window.customer = {
        selected: null,
        
        select: (customerId) => window.modernCustomer.selectCustomer(customerId),
        getSelected: () => window.modernCustomer.getSelectedCustomer(),
        clear: () => window.modernCustomer.clearSelection(),
        search: (term) => window.modernCustomer.performSearch(term)
    };
});