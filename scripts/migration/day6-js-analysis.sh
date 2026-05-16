#!/bin/bash

echo "📊 Day 6: Analyzing JavaScript for modernization..."

# Analyze JavaScript dependencies
echo "🔍 Analyzing JavaScript dependencies..."
find grails-app/assets/javascripts/legacy -name "*.js" -exec grep -l "Prototype\|Effect\|Ajax" {} \; > temp/prototype-dependencies.txt 2>/dev/null || touch temp/prototype-dependencies.txt
find grails-app/assets/javascripts/legacy -name "*.js" -exec grep -l "Backbone\|underscore" {} \; > temp/backbone-dependencies.txt 2>/dev/null || touch temp/backbone-dependencies.txt
find grails-app/assets/javascripts/legacy -name "*.js" -exec grep -l "jQuery\|$" {} \; > temp/jquery-compatible.txt 2>/dev/null || touch temp/jquery-compatible.txt

# Analyze function patterns
echo "🔍 Analyzing function patterns..."
grep -r "function.*{" grails-app/assets/javascripts/legacy/ > temp/function-patterns.txt 2>/dev/null || touch temp/function-patterns.txt
grep -r "var.*=" grails-app/assets/javascripts/legacy/ > temp/variable-patterns.txt 2>/dev/null || touch temp/variable-patterns.txt
grep -r "\.observe\|\.on\|addEventListener" grails-app/assets/javascripts/legacy/ > temp/event-patterns.txt 2>/dev/null || touch temp/event-patterns.txt

# Create modernization priority list
cat > temp/modernization-priority.txt << 'PRIORITY_EOF'
HIGH PRIORITY (Business Critical):
1. quotation.js - Core quotation functionality
2. shopping_cart.js - Shopping cart system  
3. customer.js - Customer management

MEDIUM PRIORITY (Enhanced Features):
4. quotation_components/* - Quotation sub-modules
5. util.js - Utility functions

LOW PRIORITY (Legacy Dependencies):
6. prototype/* - Replace with modern alternatives
7. backbone.js, underscore.js - Consider removal

ANALYSIS RESULTS:
PRIORITY_EOF

echo "📊 Dependency Analysis Results:" >> temp/modernization-priority.txt
echo "- Prototype.js dependencies: $(cat temp/prototype-dependencies.txt | wc -l) files" >> temp/modernization-priority.txt
echo "- Backbone.js dependencies: $(cat temp/backbone-dependencies.txt | wc -l) files" >> temp/modernization-priority.txt
echo "- jQuery compatible files: $(cat temp/jquery-compatible.txt | wc -l) files" >> temp/modernization-priority.txt
echo "" >> temp/modernization-priority.txt

echo "📊 Function Pattern Analysis:" >> temp/modernization-priority.txt
echo "- Function definitions found: $(cat temp/function-patterns.txt | wc -l) occurrences" >> temp/modernization-priority.txt
echo "- Variable declarations: $(cat temp/variable-patterns.txt | wc -l) occurrences" >> temp/modernization-priority.txt
echo "- Event handlers: $(cat temp/event-patterns.txt | wc -l) occurrences" >> temp/modernization-priority.txt

echo ""
echo "📊 JavaScript analysis complete!"
echo "📄 Results saved to temp/modernization-priority.txt"
echo ""
echo "🎯 Week 2 Strategy:"
echo "   Day 7-8: Modernize quotation.js and core business logic"
echo "   Day 9: Modernize shopping_cart.js system"
echo "   Day 10: Final integration and testing"
echo ""
cat temp/modernization-priority.txt