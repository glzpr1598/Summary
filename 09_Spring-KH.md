# 프로젝트 생성 후 세팅

## maven clean, install 후 서버 동작 확인

## pom.xml 설정

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
    <!-- https://mvnrepository.com/artifact/com.oracle/ojdbc14 -->
    <!-- version뒤에 .0 지움 -->
    <dependency>
        <groupId>com.oracle</groupId>
        <artifactId>ojdbc14</artifactId>
        <version>10.2.0.3</version>
    </dependency>

    <!-- Spring JDBC -->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
    <!-- version 수정 -->
    <dependency>
        <groupId>org.springframework</groupId>
        <artifactId>spring-jdbc</artifactId>
        <version>${org.springframework-version}</version>
    </dependency>

    <!-- MyBatis -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.4.5</version>
    </dependency>

    <!-- MyBatis Spring -->
    <!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis-spring</artifactId>
        <version>1.3.1</version>
    </dependency>
     
</dependencies>
```



## web.xml 설정

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



## servlet-context.xml 설정

```xml
<!-- DB 접속 정보 설정 -->
<beans:bean name="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
    <beans:property name="driverClassName" value="oracle.jdbc.driver.OracleDriver"/>
    <beans:property name="url" value="jdbc:oracle:thin:@localhost:1521:xe"/>
    <beans:property name="username" value="사용자명"/>
    <beans:property name="password" value="비밀번호"/>
</beans:bean>

<!-- MyBatis 설정 -->
<beans:bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
    <beans:property name="dataSource" ref="dataSource"/>
    <beans:property name="mapperLocations" value="classpath:패키지명/dao/*mapper.xml"/>
</beans:bean>

<!-- template 설정(XML과 Java를 연결) -->
<beans:bean id="myBatisMapper" class="org.mybatis.spring.SqlSessionTemplate">
    <beans:constructor-arg index="0" ref="sqlSessionFactory"/>
</beans:bean>
```



## log4j.xml 설정

logger를 모든 패키지에서 사용하기 위해 name="com.spring" 까지만 적어줌.



# MyBatis



## *mapper.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">    
<mapper namespace="패키지.인터페이스">
    <select id="메소드명" resultType="반환형">
        쿼리문
        <!-- 인자는 #{param1} 형식으로 받음 -->
	</select>
</mapper>
```

