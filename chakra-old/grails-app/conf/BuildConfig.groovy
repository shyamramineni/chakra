grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // uncomment to disable ehcache
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins
        grailsPlugins()
        grailsHome()
        grailsCentral()
        mavenCentral()

        // uncomment these to enable remote dependency resolution from public Maven repositories
        //mavenCentral()
        //mavenLocal()
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }
    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.

         runtime 'mysql:mysql-connector-java:5.1.16'
		 //compile ":quartz:1.0-RC5"
		 runtime 'org.springframework:org.springframework.test:3.0.3.RELEASE'
		 runtime 'org.imgscalr:imgscalr-lib:4.2'
		 //runtime('com.lowagie:itext:2.1.5')
		 //runtime('org.hibernate:hibernate-core:3.6.10.Final')
		 //runtime('commons-collections:commons-collections:3.2.1')
		 //compile 'org.imgscalr:imgscalr-lib:4.1'
		 
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.7.1"
        runtime ":resources:1.1.5"
		runtime ":quartz:1.0-RC2"
		runtime ":twitter-bootstrap:2.0.2.25"
		compile ":spring-security-core:1.2.7.3"
		//compile ":rendering:0.4.3"
		//compile ":export:1.5"
		//runtime(':rendering:0.4.3') { excludes 'itext' }
		//runtime(':hibernate:2.0.0'){ excludes 'hibernate-core' }
		//compile(':quartz:1.0-RC2'){ excludes 'commons-collections' }

        build ":tomcat:$grailsVersion"	
		
		
    }
}

/*grails.war.resources = { stagingDir, args ->
	println "Removing itext-2.1.0.jar from WEB-INF/lib/"
	delete(file: "${stagingDir}/WEB-INF/lib/iTextAsian-2.1.5.jar")
	delete(file: "${stagingDir}/WEB-INF/lib/itext-2.1.5.jar")
	delete(file: "${stagingDir}/WEB-INF/lib/itext-rtf-2.1.5.jar")
}*/
