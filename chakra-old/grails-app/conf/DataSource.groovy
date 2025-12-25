dataSource {
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = ""
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.provider_class = 'net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/chakra"
			username = "root"
			password = ""
			//logSql = true
        }
    }
    test {
        dataSource {
           // dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/chakra"
			username = "root"
			password = ""
			//logSql = true
        }
    }
    production {
        dataSource {
            //dbCreate = "update" // one of 'create', 'create-drop','update'
            url = "jdbc:mysql://localhost:3306/chakra"
			username = "root"
			password = ""
			//logSql = true
        }
    }
}