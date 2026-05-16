#!/bin/bash
set -e

echo "📄 Day 4: Updating GSP templates..."

# Update main layout template
echo "🎨 Updating main layout template..."
cat > grails-app/views/layouts/main.gsp << 'GSP_EOF'
<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Chakra Manufacturing"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:stylesheet src="application.css"/>
    <g:layoutHead/>
</head>
<body>
    <!-- Modern Bootstrap 5 Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${createLink(uri: '/')}">
                <asset:image src="logo.jpg" alt="Chakra" class="d-inline-block align-text-top" style="height: 30px;"/>
                Chakra Manufacturing
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="customerDropdown" role="button" data-bs-toggle="dropdown">
                            Customers
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="customer" action="list" class="dropdown-item">List Customers</g:link></li>
                            <li><g:link controller="customer" action="create" class="dropdown-item">Add Customer</g:link></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="enquiryDropdown" role="button" data-bs-toggle="dropdown">
                            Enquiries
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="enquiry" action="list" class="dropdown-item">List Enquiries</g:link></li>
                            <li><g:link controller="enquiry" action="create" class="dropdown-item">New Enquiry</g:link></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="quotationDropdown" role="button" data-bs-toggle="dropdown">
                            Quotations
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="quotation" action="list" class="dropdown-item">List Quotations</g:link></li>
                            <li><g:link controller="quotation" action="create" class="dropdown-item">New Quotation</g:link></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="orderDropdown" role="button" data-bs-toggle="dropdown">
                            Orders
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="corder" action="list" class="dropdown-item">List Orders</g:link></li>
                            <li><g:link controller="corder" action="create" class="dropdown-item">New Order</g:link></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="productionDropdown" role="button" data-bs-toggle="dropdown">
                            Production
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="productionReporting" action="list" class="dropdown-item">Production Reports</g:link></li>
                            <li><g:link controller="stock" action="list" class="dropdown-item">Stock Management</g:link></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container-fluid main-content">
        <!-- Flash Messages -->
        <g:if test="${flash.message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                ${flash.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </g:if>
        <g:if test="${flash.error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${flash.error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </g:if>

        <!-- Page Content -->
        <g:layoutBody/>
    </div>

    <!-- Loading Spinner -->
    <div id="spinner" class="d-none justify-content-center align-items-center position-fixed w-100 h-100" style="top: 0; left: 0; background-color: rgba(0,0,0,0.1); z-index: 9999;">
        <div class="spinner-border spinner-border-custom text-primary" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>

    <asset:javascript src="application.js"/>
    <g:layoutJavaScript/>
</body>
</html>
GSP_EOF

echo "📋 Creating form template converter script..."
cat > scripts/migration/update-form-templates.js << 'JS_EOF'
const fs = require('fs');
const path = require('path');

const formReplacements = {
    // Bootstrap 2 to Bootstrap 5 form classes
    'control-group': 'mb-3',
    'control-label': 'form-label',
    'controls': '',
    'help-inline': 'form-text',
    'help-block': 'form-text',
    'input-prepend': 'input-group',
    'input-append': 'input-group',
    'add-on': 'input-group-text',
    'uneditable-input': 'form-control-plaintext',
    
    // Button classes
    'btn btn-primary': 'btn btn-primary',
    'btn btn-secondary': 'btn btn-outline-secondary',
    'btn btn-success': 'btn btn-success',
    'btn btn-danger': 'btn btn-danger',
    'btn btn-warning': 'btn btn-warning',
    'btn btn-info': 'btn btn-info'
};

function updateFormTemplate(filePath) {
    let content = fs.readFileSync(filePath, 'utf8');
    let hasChanges = false;
    
    // Update form field structure
    content = content.replace(
        /<div class="control-group">\s*<label[^>]*class="control-label"[^>]*>([^<]+)<\/label>\s*<div class="controls">\s*(<[^>]+>)\s*<\/div>\s*<\/div>/g,
        '<div class="mb-3">\n    <label class="form-label">$1</label>\n    $2\n</div>'
    );
    
    // Apply class replacements
    Object.entries(formReplacements).forEach(([oldClass, newClass]) => {
        const regex = new RegExp(oldClass.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), 'g');
        const newContent = content.replace(regex, newClass);
        if (newContent !== content) {
            hasChanges = true;
            content = newContent;
        }
    });
    
    if (hasChanges) {
        fs.writeFileSync(filePath, content);
        console.log(`✅ Updated form template: ${filePath}`);
        return true;
    }
    return false;
}

// Process all GSP files with forms
function processDirectory(dir) {
    let updatedCount = 0;
    try {
        const files = fs.readdirSync(dir);
        files.forEach(file => {
            const filePath = path.join(dir, file);
            const stat = fs.statSync(filePath);
            
            if (stat.isDirectory()) {
                updatedCount += processDirectory(filePath);
            } else if (file.endsWith('.gsp') && (
                file.includes('_form') || 
                file.includes('create') || 
                file.includes('edit') ||
                file.includes('show')
            )) {
                if (updateFormTemplate(filePath)) {
                    updatedCount++;
                }
            }
        });
    } catch (err) {
        // Ignore directories that don't exist or can't be read
    }
    return updatedCount;
}

const updatedCount = processDirectory('grails-app/views');
console.log(`🎉 Form template updates complete! Updated ${updatedCount} files.`);
JS_EOF

# Check if Node.js is available and run the converter
if command -v node &> /dev/null; then
    echo "🔄 Running form template converter..."
    node scripts/migration/update-form-templates.js
else
    echo "⚠️  Node.js not available, skipping form template conversion"
    echo "   Manual conversion may be needed for optimal results"
fi

echo "✅ GSP template updates complete!"
echo "📊 Summary:"
echo "   - Updated main layout with Bootstrap 5 navigation"
echo "   - Added modern responsive design"
echo "   - Updated flash message styling"
echo "   - Added modern loading spinner"
if command -v node &> /dev/null; then
    echo "   - Form templates automatically converted"
else
    echo "   - Form templates ready for manual conversion"
fi