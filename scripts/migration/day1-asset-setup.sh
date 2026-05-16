#!/bin/bash
set -e

echo "🚀 Day 1: Setting up new asset structure..."

# Create new asset directories
mkdir -p grails-app/assets/stylesheets/{modern,legacy,components}
mkdir -p grails-app/assets/javascripts/{modern,legacy,components}
mkdir -p grails-app/assets/images

# Copy images (safe migration)
echo "📁 Copying image assets..."
cp -r chakra-old/web-app/images/* grails-app/assets/images/ 2>/dev/null || true

# Copy CSS files to legacy folder initially
echo "🎨 Copying CSS files..."
cp chakra-old/web-app/css/*.css grails-app/assets/stylesheets/legacy/

# Copy JS files to legacy folder initially  
echo "⚡ Copying JavaScript files..."
cp chakra-old/web-app/js/*.js grails-app/assets/javascripts/legacy/
cp -r chakra-old/web-app/js/prototype grails-app/assets/javascripts/legacy/ 2>/dev/null || true
cp -r chakra-old/web-app/js/quotation_components grails-app/assets/javascripts/legacy/ 2>/dev/null || true

echo "✅ Asset structure created successfully!"
echo "📊 Summary:"
echo "   - Images: $(find grails-app/assets/images -type f | wc -l) files"
echo "   - CSS: $(find grails-app/assets/stylesheets/legacy -name "*.css" | wc -l) files"
echo "   - JavaScript: $(find grails-app/assets/javascripts/legacy -name "*.js" | wc -l) files"