/* Modern Shopping Cart System */

class ModernShoppingCart {
    constructor() {
        this.items = [];
        this.summary = [];
        this.currentSelectedElement = null;
        this.currentActiveEditEntry = null;
        this.superidTracker = [];
        this.editMode = false;
        
        this.init();
    }
    
    init() {
        this.setupEventHandlers();
        this.migrateLegacyData();
        this.initializeTreeView();
    }
    
    setupEventHandlers() {
        // Tree navigation events
        $(document).on('click', '.group-state-toggle', this.handleGroupStateToggle.bind(this));
        $(document).on('click', '.final-item-label', this.handleItemSelection.bind(this));
        
        // Cart operations
        $(document).on('click', '.add-to-cart-btn', this.handleAddToCart.bind(this));
        $(document).on('click', '.remove-from-cart-btn', this.handleRemoveFromCart.bind(this));
        $(document).on('click', '.edit-cart-item-btn', this.handleEditCartItem.bind(this));
        $(document).on('click', '.clear-cart-btn', this.handleClearCart.bind(this));
        
        // Quantity input changes
        $(document).on('change', '.cart-item-quantity', this.handleQuantityChange.bind(this));
        $(document).on('change', '.cart-item-price', this.handlePriceChange.bind(this));
        
        // Selection buttons
        $(document).on('click', '.select-button-style', this.handleSelectionButton.bind(this));
        
        // Mesh item selection grid
        $(document).on('click', '.mesh-item-selection-entry', this.handleMeshItemClick.bind(this));
        $(document).on('dblclick', '.mesh-item-selection-entry', this.handleMeshItemDoubleClick.bind(this));
        
        // Form submissions
        $(document).on('submit', '#cart-checkout-form', this.handleCheckoutSubmit.bind(this));
        
        // Real-time calculations
        $(document).on('input', '.row-input-field', this.handleInputChange.bind(this));
    }
    
    initializeTreeView() {
        // Initialize collapsible tree structure
        $('.item-tree .group-item').each((index, element) => {
            const $element = $(element);
            const $img = $element.find('.group-state-icon').first();
            
            if ($img.length) {
                // Set initial state
                $img.attr('data-state', 'closed');
                $element.find('ul').first().hide();
            }
        });
    }
    
    handleGroupStateToggle(event) {
        event.preventDefault();
        const $element = $(event.currentTarget);
        const $img = $element.find('.group-state-icon').first();
        const $childList = $element.find('ul').first();
        
        if ($img.attr('data-state') === 'closed') {
            // Expand
            const imgSrc = $img.attr('src');
            $img.attr('src', imgSrc.replace('ExpandAll', 'CollapseAll'));
            $img.attr('data-state', 'open');
            $childList.slideDown('fast');
        } else {
            // Collapse
            const imgSrc = $img.attr('src');
            $img.attr('src', imgSrc.replace('CollapseAll', 'ExpandAll'));
            $img.attr('data-state', 'closed');
            $childList.slideUp('fast');
        }
    }
    
    handleItemSelection(event) {
        event.preventDefault();
        const $target = $(event.currentTarget);
        const itemData = this.extractItemData($target);
        
        // Remove previous selection highlighting
        $('.final-item-selected-label').removeClass('final-item-selected-label').addClass('final-item-label');
        
        // Add selection highlighting
        $target.removeClass('final-item-label').addClass('final-item-selected-label');
        
        // Store current selection
        this.currentSelectedElement = itemData;
        
        // Update selection display
        this.updateSelectionDisplay(itemData);
        
        // Trigger selection event
        $(document).trigger('item-selected', [itemData]);
        
        console.log('Item selected:', itemData);
    }
    
    updateSelectionDisplay(itemData) {
        const container = $('#selected-item-display');
        if (!container.length) return;
        
        const html = `
            <div class="card">
                <div class="card-header">
                    <h6 class="mb-0">Selected Item</h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-8">
                            <strong>Name:</strong> ${itemData.name}<br>
                            <strong>ID:</strong> ${itemData.id}<br>
                            <strong>Price:</strong> $${itemData.price?.toFixed(2) || '0.00'}
                        </div>
                        <div class="col-4 text-end">
                            <div class="mb-2">
                                <label class="form-label form-label-sm">Quantity:</label>
                                <input type="number" class="form-control form-control-sm" id="item-quantity" min="1" value="1">
                            </div>
                            <button class="btn btn-primary btn-sm add-to-cart-btn w-100">
                                <i class="bi bi-cart-plus"></i> Add to Cart
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        container.html(html);
    }
    
    handleSelectionButton(event) {
        const $button = $(event.currentTarget);
        const action = $button.data('action');
        
        switch (action) {
            case 'add-selected':
                this.addSelectedToCart();
                break;
            case 'clear-selection':
                this.clearSelection();
                break;
            case 'show-cart':
                this.showCartModal();
                break;
            default:
                console.log('Unknown selection button action:', action);
        }
    }
    
    addSelectedToCart() {
        if (!this.currentSelectedElement) {
            this.showErrorMessage('Please select an item first');
            return;
        }
        
        this.handleAddToCart();
    }
    
    clearSelection() {
        this.currentSelectedElement = null;
        $('.final-item-selected-label').removeClass('final-item-selected-label').addClass('final-item-label');
        $('#selected-item-display').empty();
        $('#item-quantity').val(1);
    }
    
    handleAddToCart(event) {
        if (event) event.preventDefault();
        
        if (!this.currentSelectedElement) {
            this.showErrorMessage('Please select an item first');
            return;
        }
        
        const quantity = parseInt($('#item-quantity').val()) || 1;
        if (quantity <= 0) {
            this.showErrorMessage('Please enter a valid quantity');
            return;
        }
        
        const cartItem = {
            ...this.currentSelectedElement,
            quantity: quantity,
            id: this.generateCartItemId(),
            addedAt: new Date(),
            total: (this.currentSelectedElement.price || 0) * quantity
        };
        
        // Check if item already exists in cart
        const existingIndex = this.items.findIndex(item => 
            item.originalId === cartItem.originalId && item.name === cartItem.name
        );
        
        if (existingIndex !== -1) {
            // Update existing item quantity
            this.items[existingIndex].quantity += quantity;
            this.items[existingIndex].total = this.items[existingIndex].price * this.items[existingIndex].quantity;
            this.showSuccessMessage(`Updated quantity for ${cartItem.name}`);
        } else {
            // Add new item
            this.items.push(cartItem);
            this.showSuccessMessage(`${cartItem.name} added to cart`);
        }
        
        this.updateCartDisplay();
        this.updateSummary();
        this.clearSelection();
    }
    
    handleRemoveFromCart(event) {
        event.preventDefault();
        const itemId = $(event.currentTarget).data('item-id');
        
        const removedItem = this.items.find(item => item.id === itemId);
        this.items = this.items.filter(item => item.id !== itemId);
        
        this.updateCartDisplay();
        this.updateSummary();
        
        if (removedItem) {
            this.showSuccessMessage(`${removedItem.name} removed from cart`);
        }
    }
    
    handleEditCartItem(event) {
        event.preventDefault();
        const itemId = $(event.currentTarget).data('item-id');
        const item = this.items.find(item => item.id === itemId);
        
        if (!item) return;
        
        this.showEditModal(item);
    }
    
    handleClearCart(event) {
        if (event) event.preventDefault();
        
        if (this.items.length === 0) {
            this.showErrorMessage('Cart is already empty');
            return;
        }
        
        // Show confirmation modal
        const confirmModal = `
            <div class="modal fade" id="clearCartModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Clear Cart</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure you want to clear all items from the cart?</p>
                            <p class="text-muted">This action cannot be undone.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-danger" id="confirm-clear-cart">Clear Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        $('#clearCartModal').remove();
        $('body').append(confirmModal);
        const modal = new bootstrap.Modal(document.getElementById('clearCartModal'));
        modal.show();
        
        $('#confirm-clear-cart').on('click', () => {
            this.clearCart();
            modal.hide();
        });
    }
    
    clearCart() {
        const itemCount = this.items.length;
        this.items = [];
        this.summary = [];
        this.updateCartDisplay();
        this.updateSummary();
        this.showSuccessMessage(`Cleared ${itemCount} items from cart`);
    }
    
    handleQuantityChange(event) {
        const $input = $(event.target);
        const itemId = $input.closest('tr').data('item-id');
        const newQuantity = parseInt($input.val()) || 1;
        
        const item = this.items.find(item => item.id === itemId);
        if (item) {
            item.quantity = newQuantity;
            item.total = item.price * newQuantity;
            this.updateCartDisplay();
            this.updateSummary();
        }
    }
    
    handlePriceChange(event) {
        const $input = $(event.target);
        const itemId = $input.closest('tr').data('item-id');
        const newPrice = parseFloat($input.val()) || 0;
        
        const item = this.items.find(item => item.id === itemId);
        if (item) {
            item.price = newPrice;
            item.total = item.price * item.quantity;
            this.updateCartDisplay();
            this.updateSummary();
        }
    }
    
    handleMeshItemClick(event) {
        const $row = $(event.currentTarget);
        const itemData = this.extractMeshItemData($row);
        
        // Toggle selection
        if ($row.hasClass('mesh-item-selection-entry-edit-mode')) {
            $row.removeClass('mesh-item-selection-entry-edit-mode');
            this.currentSelectedElement = null;
        } else {
            $('.mesh-item-selection-entry').removeClass('mesh-item-selection-entry-edit-mode');
            $row.addClass('mesh-item-selection-entry-edit-mode');
            this.currentSelectedElement = itemData;
        }
    }
    
    handleMeshItemDoubleClick(event) {
        this.handleMeshItemClick(event);
        if (this.currentSelectedElement) {
            this.handleAddToCart();
        }
    }
    
    handleInputChange(event) {
        const $input = $(event.target);
        const value = $input.val();
        
        // Real-time validation
        if ($input.attr('type') === 'number') {
            const numValue = parseFloat(value);
            if (isNaN(numValue) || numValue < 0) {
                $input.addClass('is-invalid');
            } else {
                $input.removeClass('is-invalid');
            }
        }
        
        // Trigger calculations if needed
        this.recalculateIfNeeded();
    }
    
    recalculateIfNeeded() {
        // Debounce recalculation
        clearTimeout(this.recalcTimeout);
        this.recalcTimeout = setTimeout(() => {
            this.updateSummary();
        }, 300);
    }
    
    updateCartDisplay() {
        const cartContainer = $('#shopping-cart-items');
        if (!cartContainer.length) return;
        
        let html = '';
        
        if (this.items.length === 0) {
            html = `
                <div class="alert alert-info text-center">
                    <i class="bi bi-cart-x fs-1"></i>
                    <h5 class="mt-2">Your cart is empty</h5>
                    <p class="text-muted">Add items from the selection area to get started.</p>
                </div>
            `;
        } else {
            html = `
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">Shopping Cart (${this.items.length} items)</h5>
                    <button class="btn btn-outline-danger btn-sm clear-cart-btn">
                        <i class="bi bi-trash"></i> Clear Cart
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Item</th>
                                <th>Quantity</th>
                                <th>Price</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;
            
            this.items.forEach(item => {
                const total = (item.quantity * item.price).toFixed(2);
                html += `
                    <tr data-item-id="${item.id}">
                        <td>
                            <div class="d-flex align-items-center">
                                ${item.image ? `<img src="${item.image}" class="mesh-item-pic me-2" alt="${item.name}">` : ''}
                                <div>
                                    <div class="fw-bold">${item.name}</div>
                                    <small class="text-muted">${item.description || ''}</small>
                                </div>
                            </div>
                        </td>
                        <td>
                            <input type="number" class="form-control form-control-sm cart-item-quantity" 
                                   value="${item.quantity}" min="1" style="width: 80px;">
                        </td>
                        <td>
                            <div class="input-group input-group-sm">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control cart-item-price" 
                                       value="${item.price.toFixed(2)}" step="0.01" min="0" style="width: 100px;">
                            </div>
                        </td>
                        <td>
                            <strong>$${total}</strong>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <button class="btn btn-outline-primary edit-cart-item-btn" data-item-id="${item.id}" title="Edit">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-outline-danger remove-from-cart-btn" data-item-id="${item.id}" title="Remove">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
            });
            
            html += '</tbody></table></div>';
        }
        
        cartContainer.html(html);
        this.updateCartBadge();
    }
    
    updateCartBadge() {
        const badge = $('.cart-item-count');
        const totalItems = this.items.reduce((sum, item) => sum + item.quantity, 0);
        
        badge.text(totalItems);
        if (totalItems > 0) {
            badge.show();
        } else {
            badge.hide();
        }
    }
    
    updateSummary() {
        const subtotal = this.items.reduce((sum, item) => sum + (item.quantity * item.price), 0);
        const taxRate = 0.1; // 10% tax
        const tax = subtotal * taxRate;
        const total = subtotal + tax;
        
        const summaryHtml = `
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">
                        <i class="bi bi-receipt"></i>
                        Order Summary
                    </h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Subtotal (${this.items.length} items):</span>
                        <span>$${subtotal.toFixed(2)}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Tax (${(taxRate * 100)}%):</span>
                        <span>$${tax.toFixed(2)}</span>
                    </div>
                    <hr>
                    <div class="d-flex justify-content-between fw-bold fs-5">
                        <span>Total:</span>
                        <span class="text-primary">$${total.toFixed(2)}</span>
                    </div>
                </div>
                <div class="card-footer">
                    <button class="btn btn-success w-100" ${this.items.length === 0 ? 'disabled' : ''} 
                            onclick="modernShoppingCart.proceedToCheckout()">
                        <i class="bi bi-credit-card"></i>
                        Proceed to Checkout
                    </button>
                </div>
            </div>
        `;
        
        $('#cart-summary').html(summaryHtml);
        
        // Update summary object for legacy compatibility
        this.summary = {
            subtotal: subtotal,
            tax: tax,
            total: total,
            itemCount: this.items.length
        };
    }
    
    showEditModal(item) {
        const modalHtml = `
            <div class="modal fade" id="editCartItemModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Cart Item</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form id="edit-cart-item-form" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label class="form-label">Item Name</label>
                                    <input type="text" class="form-control" value="${item.name}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Quantity <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="edit-quantity" value="${item.quantity}" min="1" required>
                                    <div class="invalid-feedback">Please enter a valid quantity.</div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Price <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" class="form-control" id="edit-price" value="${item.price}" step="0.01" min="0" required>
                                        <div class="invalid-feedback">Please enter a valid price.</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" id="edit-description" rows="2">${item.description || ''}</textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="button" class="btn btn-primary" id="save-cart-item-changes" data-item-id="${item.id}">Save Changes</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        $('#editCartItemModal').remove();
        $('body').append(modalHtml);
        const modal = new bootstrap.Modal(document.getElementById('editCartItemModal'));
        modal.show();
        
        // Form validation
        $('#edit-cart-item-form input').on('input', function() {
            if (this.checkValidity()) {
                $(this).removeClass('is-invalid').addClass('is-valid');
            } else {
                $(this).removeClass('is-valid').addClass('is-invalid');
            }
        });
        
        $('#save-cart-item-changes').on('click', () => {
            this.saveCartItemChanges(item.id);
        });
    }
    
    saveCartItemChanges(itemId) {
        const form = document.getElementById('edit-cart-item-form');
        if (!form.checkValidity()) {
            form.classList.add('was-validated');
            return;
        }
        
        const quantity = parseInt($('#edit-quantity').val());
        const price = parseFloat($('#edit-price').val());
        const description = $('#edit-description').val();
        
        const itemIndex = this.items.findIndex(item => item.id === itemId);
        if (itemIndex !== -1) {
            this.items[itemIndex].quantity = quantity;
            this.items[itemIndex].price = price;
            this.items[itemIndex].description = description;
            this.items[itemIndex].total = quantity * price;
            
            this.updateCartDisplay();
            this.updateSummary();
            $('#editCartItemModal').modal('hide');
            this.showSuccessMessage('Item updated successfully');
        }
    }
    
    showCartModal() {
        const modalHtml = `
            <div class="modal fade" id="shoppingCartModal" tabindex="-1">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="bi bi-cart"></i>
                                Shopping Cart
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-8">
                                    <div id="modal-cart-items"></div>
                                </div>
                                <div class="col-4">
                                    <div id="modal-cart-summary"></div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Continue Shopping</button>
                            <button type="button" class="btn btn-success" onclick="modernShoppingCart.proceedToCheckout()">
                                Proceed to Checkout
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        `;
        
        $('#shoppingCartModal').remove();
        $('body').append(modalHtml);
        
        // Copy current cart content to modal
        $('#modal-cart-items').html($('#shopping-cart-items').html());
        $('#modal-cart-summary').html($('#cart-summary').html());
        
        const modal = new bootstrap.Modal(document.getElementById('shoppingCartModal'));
        modal.show();
    }
    
    proceedToCheckout() {
        if (this.items.length === 0) {
            this.showErrorMessage('Cart is empty. Please add items before checkout.');
            return;
        }
        
        // Prepare checkout data
        const checkoutData = {
            items: this.items,
            summary: this.summary,
            timestamp: new Date().toISOString()
        };
        
        // Submit to checkout
        this.submitCheckout(checkoutData);
    }
    
    submitCheckout(data) {
        this.showLoadingSpinner();
        
        $.ajax({
            url: '/cart/checkout',
            type: 'POST',
            data: { cartData: JSON.stringify(data) },
            dataType: 'json',
            success: (response) => {
                this.hideLoadingSpinner();
                if (response.success) {
                    if (response.data && response.data.redirectUrl) {
                        window.location.href = response.data.redirectUrl;
                    } else {
                        this.showSuccessMessage('Checkout completed successfully');
                        this.clearCart();
                    }
                } else {
                    this.showErrorMessage(response.message || 'Checkout failed');
                }
            },
            error: () => {
                this.hideLoadingSpinner();
                this.showErrorMessage('Checkout failed. Please try again.');
            }
        });
    }
    
    handleCheckoutSubmit(event) {
        event.preventDefault();
        this.proceedToCheckout();
    }
    
    extractItemData($element) {
        return {
            id: $element.data('item-id') || this.generateItemId(),
            originalId: $element.data('original-id') || $element.data('item-id'),
            name: $element.text().trim() || $element.data('name') || 'Unknown Item',
            price: parseFloat($element.data('price')) || 0,
            description: $element.data('description') || '',
            category: $element.data('category') || '',
            image: $element.data('image') || null
        };
    }
    
    extractMeshItemData($row) {
        const cells = $row.find('td');
        return {
            id: $row.data('item-id') || this.generateItemId(),
            originalId: $row.data('original-id'),
            name: cells.eq(1).text().trim() || 'Mesh Item',
            description: cells.eq(2).text().trim() || '',
            price: parseFloat(cells.eq(4).text().replace(/[^0-9.]/g, '')) || 0,
            image: cells.find('img').attr('src') || null,
            quantity: 1
        };
    }
    
    generateCartItemId() {
        return 'cart_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
    }
    
    generateItemId() {
        return 'item_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
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
    
    migrateLegacyData() {
        // Migrate data from legacy shopping cart variables
        if (window.element_mesh_items && window.element_mesh_items.length) {
            console.log('Migrating legacy mesh items');
            this.items = window.element_mesh_items.map((item, index) => ({
                id: 'legacy_' + index,
                originalId: item.id || index,
                name: item.name || `Legacy Item ${index + 1}`,
                price: item.price || 0,
                quantity: item.quantity || 1,
                description: item.description || '',
                migrated: true
            }));
            this.updateCartDisplay();
            this.updateSummary();
        }
        
        if (window.shopping_cart_summary && window.shopping_cart_summary.length) {
            console.log('Migrating legacy cart summary');
            this.summary = window.shopping_cart_summary;
        }
        
        if (window.superid_tracker && window.superid_tracker.length) {
            this.superidTracker = window.superid_tracker;
        }
    }
    
    // Public API methods
    getCartData() {
        return {
            items: this.items,
            summary: this.summary,
            total: this.items.reduce((sum, item) => sum + (item.quantity * item.price), 0),
            itemCount: this.items.length
        };
    }
    
    getItems() {
        return this.items;
    }
    
    getSummary() {
        return this.summary;
    }
    
    addItem(item) {
        this.items.push({
            ...item,
            id: this.generateCartItemId(),
            addedAt: new Date()
        });
        this.updateCartDisplay();
        this.updateSummary();
    }
    
    removeItem(itemId) {
        this.items = this.items.filter(item => item.id !== itemId);
        this.updateCartDisplay();
        this.updateSummary();
    }
    
    updateItem(itemId, updates) {
        const itemIndex = this.items.findIndex(item => item.id === itemId);
        if (itemIndex !== -1) {
            Object.assign(this.items[itemIndex], updates);
            this.updateCartDisplay();
            this.updateSummary();
        }
    }
    
    // Legacy compatibility methods
    group_state_toggle(element) {
        $(element).trigger('click');
    }
    
    add_to_cart(item) {
        this.addItem(item);
    }
    
    remove_from_cart(itemId) {
        this.removeItem(itemId);
    }
}

// Initialize modern shopping cart when document is ready
$(document).ready(() => {
    window.modernShoppingCart = new ModernShoppingCart();
    
    // Maintain backward compatibility with legacy function names
    window.group_state_toggle = (element) => {
        window.modernShoppingCart.group_state_toggle(element);
    };
    
    // Legacy global variables for compatibility
    window.element_mesh_items = window.modernShoppingCart.items;
    window.shopping_cart_summary = window.modernShoppingCart.summary;
    window.superid_tracker = window.modernShoppingCart.superidTracker;
    
    // Legacy global functions
    window.add_item_to_cart = (item) => window.modernShoppingCart.addItem(item);
    window.remove_item_from_cart = (itemId) => window.modernShoppingCart.removeItem(itemId);
    window.clear_shopping_cart = () => window.modernShoppingCart.clearCart();
    window.get_cart_total = () => window.modernShoppingCart.getSummary().total;
});