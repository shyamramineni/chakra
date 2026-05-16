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
