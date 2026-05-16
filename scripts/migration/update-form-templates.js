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
