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
        
		<!-- CGLIB(트랜잭션) -->
		<dependency>
		    <groupId>cglib</groupId>
		    <artifactId>cglib</artifactId>
		    <version>3.2.4</version>
		</dependency>
        
		<!-- RestFul -->
		<!-- Jackson Databind -->
		<dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-databind</artifactId>
		    <version>2.9.4</version>
		</dependency>
		<!-- Jackson Core -->
		<dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-core</artifactId>
		    <version>2.9.4</version>
		</dependency>
        
		<!-- 파일 업로드 -->		
		<!-- Apache Commons FileUpload -->
		<dependency>
		    <groupId>commons-fileupload</groupId>
		    <artifactId>commons-fileupload</artifactId>
		    <version>1.3.2</version>
		</dependency>
		
		<!-- MultipartFile 사용 -->
		<!-- Apache Commons IO -->
		<dependency>
		    <groupId>commons-io</groupId>
		    <artifactId>commons-io</artifactId>
		    <version>2.5</version>
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
	<context:component-scan base-package="패키지.service" />
	
	<!-- MyBatis 설정 import -->
	<beans:import resource="classpath:config/mybatis.xml" />

	<!-- 트랜잭션 설정 import -->
	<beans:import resource="classpath:config/transaction.xml" />

	<!-- 파일 서비스 설정 import -->
	<beans:import resource="classpath:config/fileService.xml" />
```



## resources/config/mybatis.xml

Spring Bean Configuration File로 생성
Namespaces : beans

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
		<!-- mapper import -->
	    <property name="mapperLocations" value="classpath:패키지/dao/*mapper.xml"/>
		<!-- DBCP 설정 -->
	    <property name="environment" value="classpath:config/dbcp.xml"/>
		<!-- alias 설정 -->
	    <property name="configLocation" value="classpath:config/alias.xml"/>
	</bean>
	
	<!-- template 설정(XML과 Java를 연결) -->
	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">
	    <constructor-arg index="0" ref="sqlSessionFactory"/>
	</bean>

</beans>
```



## resources/config/dataSource.xml

Spring Bean Configuration File로 생성
Namespaces : beans

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



## resources/config/dbcp.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<!-- <configuration> -->
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
<!--</configuration> -->
```

- transactionManager type="JDBC | MANAGED" : 트랜잭션 자동 처리를 JDBC | MyBatis 에게 맡긴다.
- dataSource type="POOLED | UNPOOLED" : Pool 사용 여부
- poolMaximumActiveConnections : 최대 활성화 커넥션 수
- poolMaximumIdleConnections : 최대 대기 커넥션 수
- poolMaximumCheckoutTime (ms) : 커넥션 요청 후 획득까지 기다리는 시간
- poolTimeToWait (ms) : 커넥션 획득을 기다리는 시간



## resources/config/alias.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
	<typeAliases>
        <!-- 방법 1 -->
		<typeAlias alias="별칭" type="패키지.클래스(풀네임)" />
        <!-- 방법 2 -->
		<package name="패키지" /> <!-- 해당 클래스에 @Alias("별칭") 명시 -->
	</typeAliases>
</configuration>
```



## resources/config/transaction.xml

Spring Bean Configuration File로 생성
Namespaces : beans, tf

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-4.3.xsd">

	<!-- transaction manager 빈 등록 -->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	
	<!-- @Transactional을 메소드에 사용하도록 -->
	<tx:annotation-driven proxy-target-class="false"/>

</beans>
```



## resources/config/transaction.xml

Spring Bean Configuration File로 생성
Namespaces : beans

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
		<!-- 인코딩 -->
		<property name="defaultEncoding" value="UTF-8" />
		<!-- 용량 제한(byte) -->
		<property name="maxUploadSize" value="10000000" />
		<!-- 버퍼 용량(byte) -->
		<property name="maxInMemorySize" value="10000000" />
	</bean>
	
</beans>
```



## log4j.xml

```xml
	<!-- Application Loggers 마지막 패키지 지움 -->
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

- level
  - off, fatal, error, warn, info, debug, trace
- jdbc.sqlonly : SQL문만을 로그로 보여준다. param으로 설정한 값도 보여준다.
- jdbc.sqltiming : SQL문과 SQL을 실행시키는데 수행된 시간을 보여준다.
- jdbc.connection : connection의 open & close 기록을 보여준다.
- jdbc.resultsettable : SQL 결과 테이블을 보여준다.



## Controller.java

```java
@Controller
public class HomeController {
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    
    /* 방법 1. 컨트롤러에서 직접 처리 */
    @Autowired
	private SqlSession sqlSession;  
	SqlInterface inter;
    
    @RequestMapping(value = "/list")
	public String list(Model model) {
		inter = sqlSession.getMapper(SqlInterface.class);
		model.addAttribute("list", inter.list());
		
		return "list";
	}
    
    /* 방법 2. 서비스 이용 */
	@Autowired
	Service service;
    
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public ModelAndView join(@RequestParam HashMap<String, String> map) {
		logger.info("회원가입 요청");
		logger.info("id : " + map.get("user_id"));
		logger.info("pw : " + map.get("user_pw"));
		logger.info("name : " + map.get("user_name"));
		logger.info("age : " + map.get("user_age"));
		logger.info("gender : " + map.get("user_gender"));
		logger.info("email : " + map.get("user_email"));
		
		return service.join(map);
	}
    
}
```



## Service.java

```java
@Service
public class Service {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
    @Autowired
	private SqlSession sqlSession;
	MemberInter inter;

	public ModelAndView join(HashMap<String, String> map) {
		// mapper 연결
		inter = sqlSession.getMapper(MemberInter.class);
		
		// 쿼리 실행
		int success = inter.join(map);
		logger.info("join 결과 : " + success);

		// 결과 확인
		String page = "joinForm";
		String msg = "회원가입에 실패했습니다.";
		if (success > 0) {
			page = "main";
			msg = "회원가입에 성공했습니다.";
		}
		
		// ModelAndView에 데이터 넣기
		ModelAndView mav = new ModelAndView();
		mav.addObject("msg", msg);
		mav.setViewName(page);
		
		return mav;
	}

}
```



## dao/SqlInterface.java

```java
public interface SqlInterface {
	
	ArrayList<BoardBean> list();
	void write(HashMap<String, String> map);
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
    <select id="메소드명" [속성 ...]>
        쿼리문... 인자는 #{param1}, #{변수명} 형식으로 받음
	</select>
	-->
    <!-- 속성값
	parameterType : 파라미터 클래스명
	resultType : 반환값 클래스명
	useGeneratedKeys : 실행 후 키 생성 여부
	keyProperty : 키가 될 필드
	keyColumn : 키를 저장할 컬럼
	-->
    <!-- 변수
	#{param1}, #{변수명}
	${param1}, ${변수명} : 작은따옴표 없이 삽입
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

- level
  - off, fatal, error, warn, info, debug, trace
- jdbc.sqlonly : SQL문만을 로그로 보여준다. param으로 설정한 값도 보여준다.
- jdbc.sqltiming : SQL문과 SQL을 실행시키는데 수행된 시간을 보여준다.
- jdbc.connection : connection의 open & close 기록을 보여준다.
- jdbc.resultsettable : SQL 결과 테이블을 보여준다.



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



# 모든 클래스에서 Logger 사용

```java
private Logger logger = LoggerFactory.getLogger(this.getClass());
```



# @RequestParam

@RequestParam("파라미터명") String 변수명 : 특정 파라미터를 받는다.
@RequestParam HashMap<String, String> map : 모든 파라미터를 받는다.

```java
@RequestMapping(value = "/join", method = RequestMethod.POST)
public String join(@RequestParam HashMap<String, String> map) {
    logger.info("회원가입 요청");
    logger.info("id : " + map.get("user_id"));
    logger.info("pw : " + map.get("user_pw"));
    logger.info("name : " + map.get("user_name"));
    logger.info("age : " + map.get("user_age"));
    logger.info("gender : " + map.get("user_gender"));
    logger.info("email : " + map.get("user_email"));

    return "/loginForm";
}
```



# 트랜잭션

## pom.xml

```xml
        <!-- CGLIB -->
		<dependency>
		    <groupId>cglib</groupId>
		    <artifactId>cglib</artifactId>
		    <version>3.2.4</version>
		</dependency>
```



## servlet.xml

```xml
	<!-- 트랜잭션 설정 import -->
	<beans:import resource="classpath:config/transaction.xml" />
```



## resources/config/transaction.xml

Spring Bean Configuration File로 생성
Namespaces : beans, tf

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-4.3.xsd">

	<!-- transaction manager 빈 등록 -->
	<bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
		<property name="dataSource" ref="dataSource" />
	</bean>
	
	<!-- @Transactional을 메소드에 사용하도록 -->
	<tx:annotation-driven proxy-target-class="false"/>

</beans>
```



## Service.java

```java
	// 상세보기
	@Transactional  // 메소드에 트랜잭션 걸어줌
	public ModelAndView detail(String idx) {
		ModelAndView mav = new ModelAndView();
		
		inter = sqlSession.getMapper(BoardInter.class);
		// 조회수 올리기
		inter.upHit(idx);
		// 상세보기
		mav.addObject("dto", inter.detail(idx));
		mav.setViewName("detail");
		return mav;
	}
```



# Restful

Java 객체를 JSON으로 변환(jackson)

## pom.xml

```xml
		<!-- Jackson Databind -->
		<dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-databind</artifactId>
		    <version>2.9.4</version>
		</dependency>
		
		<!-- Jackson Core -->
		<dependency>
		    <groupId>com.fasterxml.jackson.core</groupId>
		    <artifactId>jackson-core</artifactId>
		    <version>2.9.4</version>
		</dependency>
```



## 방법 1. @ResponseBody이용

#### HomeController.java

```java
	// list
	@RequestMapping(value = "/list")
	public @ResponseBody ArrayList<String> respList() {
		ArrayList<String> list = new ArrayList<String>();
		list.add("first");
		list.add("second");
		list.add("third");
		return list;
        // url에 /list 입력 시
        // ["first","second","third"]
	}
	
	// map
	@RequestMapping(value = "/map")
	public @ResponseBody HashMap<String, Object> respMap() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "hello");
		map.put("age", 22);
		map.put("married", false);
		return map;
        // {"msg":"hello","married":false,"age":22}
	}
	
	// obj
	@RequestMapping(value = "/obj")
	public @ResponseBody UserInfo respObj() {
		UserInfo info = new UserInfo();
		info.setId("user1");
		info.setName("Kim");
		info.setAge(26);
		info.setMarried(false);
		return info;
        // {"id":"user1","name":"Kim","age":26,"married":false}
	}
```



## 방법 2. @RestController 이용

#### AjaxController.java

```java
// @RestController를 쓰면 반환타입에 @ResponseBody를 사용하지 않아도 된다.
@RestController
@RequestMapping(value = "/rest")
public class AjaxController {
    
    private static final Logger logger = LoggerFactory.getLogger(AjaxController.class);
	
	// list
	@RequestMapping(value = "/list")
	public ArrayList<String> respList() {
		logger.info("/rest/list 요청");
		ArrayList<String> list = new ArrayList<String>();
		list.add("first");
		list.add("second");
		list.add("third");
		return list;
        // url에 /rest/list 입력 시
        // ["first","second","third"]
	}
	
	// map
	@RequestMapping(value = "/map")
	public HashMap<String, Object> respMap() {
		logger.info("/rest/map 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "hello");
		map.put("age", 22);
		map.put("married", false);
		return map;
	}
	
	// obj
	@RequestMapping(value = "/obj")
	public UserInfo respObj() {
		logger.info("/rest/obj 요청");
		UserInfo info = new UserInfo();
		info.setId("user1");
		info.setName("Kim");
		info.setAge(26);
		info.setMarried(false);
		return info;
	}
	
	
}
```



# @PathVariable

URL를 인자로 받을 수 있다.

```java
	@RequestMapping(value = "/test/{num1}/{num2}")
	public String test(@PathVariable String num1, @PathVariable String num2) {
        // 인자를 int형으로도 받을 수 있다.
		logger.info(num1);
		logger.info(num2);
		return "home";
	}
```



# Ajax

## JavaScript

```javascript
	$.ajax({
        url: "./login",
        type: "post",
        data: {
            id: $("#id").val(),
            pw: $("#pw").val()
        },
        dataType: "json",
        success: function(data) {
            console.log(data);
        },
        error: function(err) {console.log(err);}
    });
```

## Controller.java

```java
	@RequestMapping(value = "/login")
	public @ResponseBody HashMap<String, Object> list(@RequestParam HashMap<String, String> params) {
		HashMap<String, Object> map = new HashMap<>();
		
		String id = params.get("id");
		String pw = params.get("pw");
		
		logger.info(id);
		logger.info(pw);
		
		map.put("id", id);
		map.put("pw", pw);
		
		return map;  // JSON 형태로 변환하여 반환(@ResponseBody 때문)
	}
```



# 동적 쿼리

http://www.mybatis.org/mybatis-3/ko/dynamic-sql.html

파라미터를 작은따옴표를 제외하고 입력하려면 #이 아닌 $를 쓰면 된다.

UPDATE teams SET ${param2} = #{param3} WHERE num = #{param1}


