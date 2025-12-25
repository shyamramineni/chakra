

class BootStrap {

    def init = { servletContext ->
		
		System.setProperty("xr.load.configure-features", "true")
		
	}
	 def destroy = {
    }
}
