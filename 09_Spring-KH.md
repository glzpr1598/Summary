# MVC 프로젝트 세팅

## pom.xml

java-version : 1.8
프로젝트 Properties - Project Facets - Java 버전 1.8
springframwork-version : 4.3.14.RELEASE

라이브러리 추가

```xml
    <!-- 사설저장소 -->
    <repositories>
        <repository>
            <id>codelds</id>
            <url>http://code.lds.org/nexus/content/groups/main-repo</url>
        </repository>
    </repositories>

    <dependencies>
        
        <!-- ... -->

        <!-- Oracle JDBC Driver -->
        <!-- version뒤에 .0 지움 -->
        <dependency>
            <groupId>com.oracle</groupId>
            <artifactId>ojdbc14</artifactId>
            <version>10.2.0.3</version>
        </dependency>

        <!-- Spring JDBC -->
        <!-- version 수정 -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>${org.springframework-version}</version>
        </dependency>

        <!-- MyBatis -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.4.5</version>
        </dependency>

        <!-- MyBatis Spring -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>1.3.1</version>
        </dependency>
        
        <!-- Commons DBCP -->
        <dependency>
            <groupId>commons-dbcp</groupId>
            <artifactId>commons-dbcp</artifactId>
            <version>1.4</version>
        </dependency>
        
        <!-- Log4Jdbc Remix -->
        <dependency>
            <groupId>org.lazyluke</groupId>
            <artifactId>log4jdbc-remix</artifactId>
            <version>0.2.7</version>
        </dependency>

    </dependencies>
```

## web.xml

```xml
    <!-- 한글깨짐 방지 -->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>
```



## servlet-context.xml

```xml
	<!-- scan할 패키지 추가 -->
	<context:component-scan base-package="com.spring.service" />
	
	<!-- MyBatis 설정 import -->
	<beans:import resource="classpath:config/mybatis.xml" />
```



## resources/config/mybatis.xml

Spring Bean Configuration File로 생성
Namespaces : bean, context, util

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
		http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-4.3.xsd">

	<!-- DB 접속 정보 설정 import -->
	<import resource="classpath:config/dataSource.xml" />
	
	<!-- MyBatis 설정 -->
	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
	    <property name="dataSource" ref="dataSource"/>
	    <property name="mapperLocations" value="classpath:com/spring/dao/*mapper.xml"/>
	    <property name="configLocation" value="classpath:/config/mybatis-config.xml"/>
	</bean>
	
	<!-- template 설정(XML과 Java를 연결) -->
	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
	    <constructor-arg index="0" ref="sqlSessionFactory"/>
	</bean>

</beans>
```



## resources/config/dataSource.xml

Spring Bean Configuration File로 생성
Namespaces : bean

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<!-- DB 접속 정보 설정 -->
	<bean name="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
	    <property name="driverClassName" value="net.sf.log4jdbc.DriverSpy"/>
	    <property name="url" value="jdbc:log4jdbc:oracle:thin:@localhost:1521:xe"/>
	    <property name="username" value="사용자명"/>
	    <property name="password" value="비밀번호"/>
	</bean>

</beans>
```



## resources/config/mybatis-config.xml

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<environments default="development">
		<environment id="development">
			<transactionManager type="JDBC"></transactionManager>
			<dataSource type="POOLED">
				<property name="poolMaximumActiveConnections" value="10"/>
				<property name="poolMaximumIdleConnections" value="10"/>
				<property name="poolMaximumCheckoutTime" value="20000"/>
				<property name="poolTimeToWait" value="10000"/>
			</dataSource>
		</environment>
	</environments>
</configuration>
```

- transactionManager type="JDBC | MANAGED" : 트랜잭션 자동 처리를 JDBC | MyBatis 에게 맡긴다.
- dataSource type="POOLED | UNPOOLED" : Pool 사용 여부
- poolMaximumActiveConnections : 최대 활성화 커넥션 수
- poolMaximumIdleConnections : 최대 대기 커넥션 수
- poolMaximumCheckoutTime (ms) : 커넥션 요청 후 획득까지 기다리는 시간
- poolTimeToWait (ms) : 커넥션 획득을 기다리는 시간



## log4j.xml

```xml
	<!-- 마지막 패키지 지움 -->	
	<!-- <logger name="com.spring.controller"> -->
	<logger name="com.spring">  
		<level value="info" />
	</logger>

	<!-- SQL Loggers -->
    <logger name="jdbc.sqlonly" additivity="false">
        <level value="info" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.sqltiming" additivity="false">
        <level value="off" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.connection" additivity="false">
        <level value="off" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.resultsettable" additivity="false">
        <level value="info" />
        <appender-ref ref="console" />
    </logger>
```

- jdbc.sqlonly : SQL문만을 로그로 보여준다. param으로 설정한 값도 보여준다.
- jdbc.sqltiming : SQL문과 SQL을 실행시키는데 수행된 시간을 보여준다.
- jdbc.connection : connection의 open & close 기록을 보여준다.
- jdbc.resultsettable : SQL 결과 테이블을 보여준다.

level value="off" 로 하면 보여주지 않는다.



## Controller.java

```java
@Controller
public class HomeController {
    
    @Autowired
	private SqlSession sqlSession;  // MyBatis 사용을 위한 객체
	SqlInterface inter;
    
    @RequestMapping(value = "/")
	public String list(Model model) {
		inter = sqlSession.getMapper(SqlInterface.class);
		model.addAttribute("list", inter.list());
		
		return "list";
	}
    
    // ...
}
```



## dao/SqlInterface.java

```java
public interface SqlInterface {
	
	ArrayList<BoardBean> list();
	void write(String userName, String subject, String content);
	// ...
}
```



## dao/*mapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">    
<mapper namespace="패키지.인터페이스">
    <!--
    <select id="메소드명" resultType="반환형">
        쿼리문 (인자는 #{param1} 형식으로 받음)
	</select>
	...
	-->
</mapper>
```



# MyBatis

## Controller.java

```java
@Controller
public class HomeController {
    
    @Autowired
	private SqlSession sqlSession;  // MyBatis 사용을 위한 객체
	SqlInterface inter;
    
    @RequestMapping(value = "/")
	public String list(Model model) {
		inter = sqlSession.getMapper(SqlInterface.class);
		model.addAttribute("list", inter.list());
		
		return "list";
	}
    
    // ...
}
```



## dao/SqlInterface.java

```java
public interface SqlInterface {
	
	ArrayList<BoardBean> list();
	void write(String userName, String subject, String content);
	// ...
}
```



## dao/*mapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">    
<mapper namespace="패키지.인터페이스">
    <!--
    <select id="메소드명" resultType="반환형">
        쿼리문 (인자는 #{param1} 형식으로 받음)
	</select>
	...
	-->
</mapper>
```



# DBCP

## pom.xml

```xml
<!-- Commons DBCP -->
<dependency>
    <groupId>commons-dbcp</groupId>
    <artifactId>commons-dbcp</artifactId>
    <version>1.4</version>
</dependency>
```



## servlet-context.xml

```xml
<!-- MyBatis 설정(기존) -->
<beans:bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <beans:property name="dataSource" ref="dataSource"/>
    <beans:property name="mapperLocations" value="classpath:com/spring/dao/*mapper.xml"/>
    <!-- DBCP 설정 파일 추가 -->
    <beans:property name="configLocation" value="classpath:/config/mybatis-config.xml"/>
</beans:bean>
```



## resources/config/mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<environments default="development">
		<environment id="development">
			<transactionManager type="JDBC"></transactionManager>
			<dataSource type="POOLED">
				<property name="poolMaximumActiveConnections" value="10"/>
				<property name="poolMaximumIdleConnections" value="10"/>
				<property name="poolMaximumCheckoutTime" value="20000"/>
				<property name="poolTimeToWait" value="10000"/>
			</dataSource>
		</environment>
	</environments>
</configuration>
```

- transactionManager type="JDBC | MANAGED" : 트랜잭션 자동 처리를 JDBC | MyBatis 에게 맡긴다.
- dataSource type="POOLED | UNPOOLED" : Pool 사용 여부
- poolMaximumActiveConnections : 최대 활성화 커넥션 수
- poolMaximumIdleConnections : 최대 대기 커넥션 수
- poolMaximumCheckoutTime (ms) : 커넥션 요청 후 획득까지 기다리는 시간
- poolTimeToWait (ms) : 커넥션 획득을 기다리는 시간



# Log4Jdbc

JDBC에서 수행하는 내용을 log로 보여준다.

## pom.xml

```xml
        <!-- Log4Jdbc Remix -->
        <dependency>
            <groupId>org.lazyluke</groupId>
            <artifactId>log4jdbc-remix</artifactId>
            <version>0.2.7</version>
        </dependency>
```



## log4j.xml

```xml
    <!-- SQL Loggers -->
    <logger name="jdbc.sqlonly" additivity="false">
        <level value="info" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.sqltiming" additivity="false">
        <level value="off" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.connection" additivity="false">
        <level value="off" />
        <appender-ref ref="console" />
    </logger>
    <logger name="jdbc.resultsettable" additivity="false">
        <level value="info" />
        <appender-ref ref="console" />
    </logger>
```

- jdbc.sqlonly : SQL문만을 로그로 보여준다. param으로 설정한 값도 보여준다.
- jdbc.sqltiming : SQL문과 SQL을 실행시키는데 수행된 시간을 보여준다.
- jdbc.connection : connection의 open & close 기록을 보여준다.
- jdbc.resultsettable : SQL 결과 테이블을 보여준다.

level value="off" 로 하면 보여주지 않는다.



## servlet-context.xml

```xml
<!-- DB 접속 정보 설정(기존) -->
<beans:bean name="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
	<!-- 기존
    <beans:property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/>
    <beans:property name="url" value="jdbc:oracle:thin:@localhost:1521:xe"/>
	-->
    <beans:property name="driverClassName" value="net.sf.log4jdbc.DriverSpy"/>
    <beans:property name="url" value="jdbc:log4jdbc:oracle:thin:@localhost:1521:xe"/>
    <beans:property name="username" value="web_user"/>
    <beans:property name="password" value="pass"/>
</beans:bean>
```



