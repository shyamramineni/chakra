// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
//= require webjars/dist/jquery.js
//= require webjars/dist/js/bootstrap.bundle.js
//= require modern/compatibility-layer.js
//= require modern/quotation-modern.js
//= require modern/customer-modern.js
//= require modern/shopping-cart-modern.js
//= require_self

// Application-wide JavaScript
$(document).ready(function() {
    // Modern spinner implementation
    $(document).ajaxStart(function() {
        $('#spinner').removeClass('d-none').addClass('d-flex');
    }).ajaxStop(function() {
        $('#spinner').removeClass('d-flex').addClass('d-none');
    });
    
    // Bootstrap 5 tooltip initialization
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Bootstrap 5 popover initialization
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl);
    });
});
