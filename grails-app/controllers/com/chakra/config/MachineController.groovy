package com.chakra.config

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class MachineController {

    MachineService machineService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond machineService.list(params), model:[machineCount: machineService.count()]
    }

    def show(Long id) {
        respond machineService.get(id)
    }

    def create() {
        respond new Machine(params)
    }

    def save(Machine machine) {
        if (machine == null) {
            notFound()
            return
        }

        try {
            machineService.save(machine)
        } catch (ValidationException e) {
            respond machine.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'machine.label', default: 'Machine'), machine.id])
                redirect machine
            }
            '*' { respond machine, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond machineService.get(id)
    }

    def update(Machine machine) {
        if (machine == null) {
            notFound()
            return
        }

        try {
            machineService.save(machine)
        } catch (ValidationException e) {
            respond machine.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'machine.label', default: 'Machine'), machine.id])
                redirect machine
            }
            '*'{ respond machine, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        machineService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'machine.label', default: 'Machine'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'machine.label', default: 'Machine'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
