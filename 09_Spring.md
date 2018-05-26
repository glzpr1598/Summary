# Spring 프레임워크

## 프레임워크

소프트웨어 개발을 수월하게 하기 위해 약속한 소프트웨어 환경으로, 개발에 있어서 뼈대 역할을 한다.



## STS(Spring Tool Suite) 설치

#### 방법 1

https://spring.io/tools/sts 에서 STS 다운로드

#### 방법 2

이클립스 Marketplace에서 STS 설치



## DI(Dependency Injection)와 IOC 컨테이너

![](img\spring01.PNG)

Spring은 객체를 직접 생성하여 쓰는 것이 아니라, IOC 컨테이너에서 객체(부품)를 가져다 쓰는 방법(조립)을 사용한다.



# DI

## DI 사용의 장점

Java 파일의 수정 없이 스프링 설정 파일만을 수정하여 부품들을 생성/조립할 수 있다.(인터페이스 이용)



## XML을 이용한 DI 설정

#### resources/applicationCTX.xml

Spring Bean Configuration File(스프링 설정 파일)
객체를 가져오기 위한 외부파일(객체 생성)

- 방법 1. Setter(property) 이용

```xml
<bean id="bmiCalculator" class="com.javalec.ex.MyInfo">
    <property name="lowWeight">
    	<value>18.5</value>
    </property>
    <property name="normal" value="23"/>
</bean>

<bean id="myInfo" class="com.javalec.ex.MyInfo">
    <!-- 기본 타입 데이터 넣기 -->
    <property name="name">
        <value>홍길동</value>
    </property>
    <property name="height">
        <value>187</value>
    </property>
    <property name="weight">
        <value>84</value>
    </property>
    <!-- 리스트 데이터 넣기 -->
    <property name="hobbys">
        <list>
            <value>수영</value>
            <value>요리</value>
            <value>독서</value>
        </list>
    </property>
    <!-- 객체 참조 -->
    <property name="bmiCalculator">
        <ref bean="bmiCalculator"/>
    </property>
    <!--
	<property name="bmiCalculator" ref="bmiCalculator"/>
	-->
</bean>
```

- 방법 2. 생성자 이용

property 대신에 constructor-arg 를 쓰면 된다.

```xml
<bean id="bmiCalculator" class="com.javalec.ex.MyInfo">
    <constructor-arg>
    	<value>18.5</value>
    </constructor-arg>
    <constructor-arg value="23"/>
</bean>
```

#### MainClass.java

외부파일에서 객체 가져오기

```java
String configFile = "classpath:applicationCTX.xml";
AbstractApplicationContext ctx = new GenericXmlApplicationContext(configFile);
// configFile 여러개도 가능
// new GenericXmlApplicationContext(configFile1, configFile2, ...);

MyInfo myInfo = ctx.getBean("myInfo", MyInfo.class);

// ...
ctx.close();
```



## Java 파일을 이용한 DI 설정

#### ApplicationConfig.java

스프링 설정 파일

```java
// 스프링 설정 파일 명시
@Configuration
public class ApplicationConfig {
    // 객체 생성
    @Bean
    public Student student1() {
        ArrayList<String> hobbys =  new ArrayList<>();
        hobbys.add("수영");
        hobbys.add("요리");
        
        // 생성자 이용
        Student student = new Student("홍길동", 20, hobbys);
        // Setter 이용
        student.setHeight(180);
        student.setWeight(80);
        
        return student;
    }
    
    @Bean
    public Student student2() {
        // ...
    }
}
```

#### MainClass.java

객체 가져오기

```java
AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(ApplicationConfig.class);

Student student1 = ctx.getBean("student1", Student.class);
Student student2 = ctx.getBean("student2", Student.class);

// ...
ctx.close();
```



## XML과 Java를 같이 이용

#### 방법 1. XML 안에 Java 넣기

```xml
<context:annotation-config />
<bean class="com.javalec.ex.ApplicationConfig" />
```

#### 방법 2. Java 안에 XML 넣기

```java
@Configuration
@importResource("classpath:applicationCTX.xml")
public class ApplicationConfig {
    // ...
}
```