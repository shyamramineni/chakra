#!/bin/bash
set -e

echo "📦 Day 3: Updating Asset Pipeline..."

# Update application.css manifest
echo "🎨 Updating application.css manifest..."
cat > grails-app/assets/stylesheets/application.css << 'CSS_EOF'
/*
* This is a manifest file that'll be compiled into application.css
*
* Any CSS file within this directory can be referenced here using a relative path.
*
*= require webjars/dist/css/bootstrap.css
*= require webjars/font/bootstrap-icons.css
*= require modern/main.css
*= require modern/quotation.css
*= require modern/shopping-cart.css
*= require grails.css
*= require_self
*/

/* Application-wide custom styles */
body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}

/* Custom application overrides */
.navbar-brand {
    font-weight: bold;
}

.main-content {
    padding-top: 2rem;
    padding-bottom: 2rem;
}

/* Loading spinner styling */
#spinner {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 9999;
}

.spinner-border-custom {
    width: 3rem;
    height: 3rem;
    border-width: 0.3em;
}
CSS_EOF

# Update application.js manifest
echo "⚡ Updating application.js manifest..."
cat > grails-app/assets/javascripts/application.js << 'JS_EOF'
// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
//= require webjars/dist/jquery.js
//= require webjars/dist/js/bootstrap.bundle.js
//= require modern/compatibility-layer.js
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
JS_EOF

# Create compatibility layer for legacy JavaScript
echo "🔄 Creating compatibility layer..."
cat > grails-app/assets/javascripts/modern/compatibility-layer.js << 'JS_EOF'
/* Compatibility layer for legacy JavaScript */

// Prototype.js to jQuery compatibility
if (typeof Prototype !== 'undefined') {
    console.warn('Prototype.js detected - using compatibility mode');
}

// Legacy Ajax spinner compatibility
if (typeof Ajax !== 'undefined' && Ajax.Responders) {
    Ajax.Responders.register({
        onCreate: function() {
            $('#spinner').removeClass('d-none').addClass('d-flex');
        },
        onComplete: function() {
            if (Ajax.activeRequestCount === 0) {
                $('#spinner').removeClass('d-flex').addClass('d-none');
            }
        }
    });
} else {
    // Modern jQuery AJAX handling
    $(document).ajaxStart(function() {
        $('#spinner').removeClass('d-none').addClass('d-flex');
    }).ajaxStop(function() {
        $('#spinner').removeClass('d-flex').addClass('d-none');
    });
}

// Legacy Effect compatibility
if (typeof Effect === 'undefined') {
    window.Effect = {
        Appear: function(element, options) {
            $('#' + element).fadeIn(options?.duration ? options.duration * 1000 : 500);
        },
        Fade: function(element, options) {
            $('#' + element).fadeOut(options?.duration ? options.duration * 1000 : 500);
        }
    };
}

// Console compatibility for older browsers
if (typeof console === 'undefined') {
    window.console = {
        log: function() {},
        warn: function() {},
        error: function() {}
    };
}
JS_EOF

echo "✅ Asset pipeline configuration complete!"
echo "📊 Summary:"
echo "   - Updated application.css manifest"
echo "   - Updated application.js manifest"
echo "   - Created compatibility layer"
echo "   - Bootstrap 5 + modern assets configured"