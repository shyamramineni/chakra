# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Grails 7.0.4 web application for a manufacturing business that handles enquiries, quotations, orders, and production management for cage parts, chain links, mesh parts, and weld sides. The application manages customers, production reporting, stock management, and pricing calculations.

## Development Commands

### Running the Application
```bash
./grailsw run-app           # Start development server
./grailsw -Dgrails.env=production run-app  # Run in production mode
```

### Build Commands
```bash
./grailsw compile           # Compile the application
./grailsw war              # Build WAR file for deployment
./grailsw clean            # Clean build artifacts
```

### Database Commands
```bash
./grailsw dbm-update       # Update database schema
./grailsw console          # Start Grails console for interactive development
```

### Testing
```bash
./grailsw test-app         # Run all tests
./grailsw test-app --unit  # Run unit tests only
./grailsw test-app --integration  # Run integration tests only
```

## Database Configuration

The application uses MySQL for development (database: `chakra`) and H2 for production/testing. Database configuration is in `grails-app/conf/application.yml`:
- Development: MySQL on localhost:3306
- Test: H2 in-memory database
- Production: H2 file database

## Core Architecture

### Domain Model Structure
The application follows a domain-driven design organized by business areas:

- **config/**: Product configurations (CagePart, CageDesign, LinkMesh, etc.)
- **customer/**: Customer management
- **enquiry/**: Customer enquiries and assignment workflow
- **order/**: Order management (Corder) with parts tracking
- **quotation/**: Quote generation for different product types
- **production/**: Manufacturing reporting and tracking
- **stock/**: Inventory management
- **security/**: User authentication and authorization
- **rawmaterial/**: Wire receipt tracking

### Controller Architecture
Controllers mirror the domain structure under `grails-app/controllers/com/chakra/`. Each domain area has corresponding controllers that follow standard Grails CRUD operations.

### Service Layer
Business logic is encapsulated in services under `grails-app/services/com/chakra/`. Key services include:
- **FormulaService**: Pricing and calculation logic
- **ProductionService**: Manufacturing workflow management
- **NotificationService**: User notifications

### View Technology
The application uses Grails GSP (Groovy Server Pages) for views with Bootstrap for styling.

## Key Business Workflows

1. **Enquiry → Quotation → Order**: Customer enquiries are assigned to sales reps, converted to quotations, then to orders
2. **Production Reporting**: Track manufacturing progress for cage parts, chain links, mesh parts
3. **Stock Management**: Inventory tracking with automatic stock orders
4. **Pricing Calculations**: Formula-based pricing for different product configurations

## Database Schema Migration

The application includes migration support. Use `./grailsw dbm-update` to apply schema changes during development.

## Asset Pipeline

Static assets are managed through the Asset Pipeline plugin with Bootstrap integration. Relevant files are in `grails-app/assets/`.