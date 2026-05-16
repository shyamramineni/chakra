#!/bin/bash
set -e

echo "🎨 Day 2: Converting Bootstrap 2 to Bootstrap 5..."

# Create Bootstrap 5 CSS conversion map
cat > temp/bootstrap-conversion-map.js << 'JS_EOF'
const conversionMap = {
  // Layout classes
  'hero-unit': 'bg-primary text-white p-5 mb-4',
  'row-fluid': 'row',
  'span1': 'col-1', 'span2': 'col-2', 'span3': 'col-3',
  'span4': 'col-4', 'span5': 'col-5', 'span6': 'col-6',
  'span7': 'col-7', 'span8': 'col-8', 'span9': 'col-9',
  'span10': 'col-10', 'span11': 'col-11', 'span12': 'col-12',
  
  // Button classes
  'btn-large': 'btn-lg',
  'btn-small': 'btn-sm',
  'btn-mini': 'btn-sm',
  'btn-block': 'd-grid gap-2',
  
  // Form classes
  'control-group': 'mb-3',
  'control-label': 'form-label',
  'controls': '',
  'help-inline': 'form-text',
  'help-block': 'form-text',
  'input-prepend': 'input-group',
  'input-append': 'input-group',
  'add-on': 'input-group-text',
  
  // Navigation
  'nav-pills': 'nav nav-pills',
  'nav-tabs': 'nav nav-tabs',
  
  // Utilities
  'pull-left': 'float-start',
  'pull-right': 'float-end',
  'muted': 'text-muted',
  'text-error': 'text-danger',
  'text-warning': 'text-warning',
  'text-success': 'text-success',
  'text-info': 'text-info'
};

module.exports = conversionMap;
JS_EOF

# Create modernized main CSS
echo "🎨 Creating modernized main.css..."
cat > grails-app/assets/stylesheets/modern/main.css << 'CSS_EOF'
/* Modern Main CSS - Bootstrap 5 Compatible */

/* Preserve existing layout patterns */
#grailsLogo {
    padding: 4px;
}

#loginblock {
    padding-top: 80px;
    float: right;
}

/* Modern form styling */
.form-label {
    font-weight: bold;
    margin-bottom: 0.5rem;
}

.form-label:after {
    content: ": ";
}

/* Enhanced fieldset styling */
fieldset legend {
    background: #CCA383;
    padding: 6px 12px;
    font-weight: bold;
    border-radius: 4px;
}

/* Responsive navigation */
.nav {
    margin-bottom: 1rem;
}

.searchbox { 
    width: 100%;
    max-width: 300px;
}

/* Modern table styling */
.table th {
    background-color: #f8f9fa;
    font-weight: bold;
}

/* Modern button enhancements */
.btn-group .btn {
    margin-right: 0.25rem;
}

.btn-group .btn:last-child {
    margin-right: 0;
}

/* Print styles */
@media print {
    .no-print {
        display: none;
    }
}
CSS_EOF

echo "🎨 Creating modernized quotation.css..."
cat > grails-app/assets/stylesheets/modern/quotation.css << 'CSS_EOF'
/* Modern Quotation CSS - Bootstrap 5 Compatible */

.quotation-container {
    max-width: 1200px;
    margin: 0 auto;
}

/* Modern tile design */
.quotation-page-tile {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 0.375rem;
    margin-bottom: 1rem;
    padding: 1rem;
    box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
}

.quotation-page-tile-loaded {
    min-height: 45px;
}

/* Customer content styling */
.customer-content-container {
    padding: 1rem;
    background-color: #ffffff;
    border-radius: 0.375rem;
    border: 1px solid #dee2e6;
}

.customer-content-container table {
    width: 100%;
    margin-bottom: 0;
}

.customer-content-container-input-area {
    border-right: 1px solid #dee2e6;
    padding-right: 1rem;
}

.customer-content-container-results-area {
    display: table-cell;
    vertical-align: top;
    overflow-y: auto;
    max-height: 400px;
}

/* Modern form field styling */
.textfield-initial {
    color: #6c757d;
}

.textfield_error {
    background-color: #f8d7da !important;
    border-color: #dc3545 !important;
}

/* Responsive design */
@media (max-width: 768px) {
    .customer-content-container-input-area {
        border-right: none;
        border-bottom: 1px solid #dee2e6;
        margin-bottom: 1rem;
        padding-bottom: 1rem;
    }
    
    .customer-content-container-results-area {
        display: block;
    }
}
CSS_EOF

echo "🛒 Creating modernized shopping-cart.css..."
cat > grails-app/assets/stylesheets/modern/shopping-cart.css << 'CSS_EOF'
/* Modern Shopping Cart CSS - Bootstrap 5 Compatible */

.item-selection-container {
    min-height: 300px;
    margin: 2rem 0;
}

.item-tree-box {
    position: relative;
    height: 100%;
    background-color: #ffffff;
    border: 1px solid #dee2e6;
    border-radius: 0.375rem;
}

.button-box {
    padding: 2rem;
    text-align: center;
    background-color: #f8f9fa;
}

.select-button-style {
    width: 100%;
    max-width: 200px;
    margin: 0 auto 0.75rem auto;
    display: block;
}

.item-tree {
    height: 100%;
    overflow-y: auto;
    list-style: none;
    padding: 0;
    margin: 0;
}

.item-tree li {
    list-style: none;
    padding: 0.25rem 0.5rem;
}

.group-state-icon {
    margin-right: 0.5rem;
    cursor: pointer;
}

.final-item-label {
    cursor: pointer;
    color: #0d6efd;
    text-decoration: none;
}

.final-item-label:hover {
    background-color: #e7f3ff;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
    color: #0a58ca;
}

.final-item-selected-label {
    background-color: #0d6efd;
    color: #ffffff !important;
    padding: 0.25rem 0.5rem;
    border-radius: 0.25rem;
}

/* Modern grid styling */
.mesh-item-selection-container {
    margin: 2rem 0;
}

.header-bar {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 0.375rem 0.375rem 0 0;
}

.header-bar span {
    float: left;
    padding: 0.75rem 0.5rem;
    border-right: 1px solid #dee2e6;
    font-weight: bold;
}

.item-entry-box {
    border: 1px solid #dee2e6;
    border-top: none;
    border-radius: 0 0 0.375rem 0.375rem;
    max-height: 400px;
    overflow-y: auto;
}

.mesh-item-selection-entry {
    cursor: pointer;
    transition: background-color 0.15s ease-in-out;
}

.mesh-item-selection-entry:hover {
    background-color: #f8f9fa;
}

.mesh-item-selection-entry-edit-mode {
    background-color: #e7f3ff !important;
}

.mesh-item-pic {
    width: 50px;
    height: 50px;
    object-fit: cover;
    border-radius: 0.25rem;
}

/* Modern popup styling */
.row-edit-popup, .summary-edit-popup {
    position: absolute;
    background-color: #ffffff;
    border: 1px solid #dee2e6;
    border-radius: 0.375rem;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    padding: 1.5rem;
    z-index: 1050;
}

/* Responsive design for shopping cart */
@media (max-width: 768px) {
    .header-bar span {
        float: none;
        display: block;
        border-right: none;
        border-bottom: 1px solid #dee2e6;
    }
    
    .item-entry-box table {
        font-size: 0.875rem;
    }
}
CSS_EOF

echo "✅ Bootstrap 5 CSS migration complete!"
echo "📊 Summary:"
echo "   - Created modern/main.css"
echo "   - Created modern/quotation.css"
echo "   - Created modern/shopping-cart.css"
echo "   - Bootstrap 2 → Bootstrap 5 conversion ready"