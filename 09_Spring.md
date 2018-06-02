# Spring 프레임워크

## 프레임워크

소프트웨어 개발을 수월하게 하기 위해 약속한 소프트웨어 환경으로, 개발에 있어서 뼈대 역할을 한다.



## STS(Spring Tool Suite) 설치

#### 방법 1

https://spring.io/tools/sts 에서 STS 다운로드

#### 방법 2

이클립스 Marketplace에서 STS 설치



## DI(Dependency Injection)와 IoC 컨테이너

![](img\spring01.PNG)

Spring은 객체를 직접 생성하여 쓰는 것이 아니라, IoC(Inversion of Control) 컨테이너에서 객체(부품)를 가져다 쓰는 방법(조립)을 사용한다.



# DI

## DI 사용의 장점

Java 파일의 수정 없이 스프링 설정 파일만을 수정하여 부품들을 생성/조립할 수 있다.(인터페이스 이용)



## XML을 이용한 DI 설정

#### resources/applicationCTX.xml

Spring Bean Configuration File(스프링 설정 파일)
객체를 가져오기 위한 외부파일(객체 생성)

##### 방법 1. Setter(property) 이용

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

##### 방법 2. 생성자 이용

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


# 생명주기와 범위

## 스프링 IoC 컨테이너 생명주기

1. 생성

```java
GenericXmlApplicationContext ctx = new GenericXmlApplicationContext();
```

2. 설정

```java
ctx.load("classpath:applicationCTX.xml");
ctx.refresh();
```

3. 사용

```java
Student student = ctx.getBean("student", Student.class);
// 사용 코드...
```

4. 종료

```java
ctx.close();
```



## 스프링 빈 생명주기

#### 방법 1. implements를 이용

```java
public class Student implements InitializingBean, DisposalbleBean {
    @Override
    public void afterPropertiesSet() throws Exception {
        // 빈 초기화 과정에서 호출
        // ctx.refesh() 호출할 때
    }
    
    @Override
    public void destroy() throws Exception {
        // 빈 소멸 과정에서 호출
        // ctx.close() 호출할 때
    }
}
```

#### 방법 2. Annotation을 이용

```java
@PostConstruct
public void initMethod() {
    // 빈 초기화 과정에서 호출
}

@PreDestroy
public destroyMethod() {
    // 빈 소멸 과정에서 호출
}
```



## 스프링 빈 범위(scope)

```xml
<bean id="student" class="com.javalec.ex.Student" scope="singleton"/>
```

```java
Student student1 = ctx.getBean("student", Student.class);
Student student2 = ctx.getBean("student", Student.class);
```

- singleton : 객체를 한번만 생성하기 때문에, student1과 student2는 같은 객체를 참조한다.
  즉, 하나의 bean 정의에 대해서 스프링 IoC 컨테이너 내에 단 하나의 객체만 존재한다.
- prototype : getBean()을 호출할 때마다 새로운 객체를 생성한다.
  즉, 하나의 bean 정의에 대해서 다수의 객체가 존재할 수 있다.
- 그 외 : (Spring MVC Web Application에서) request, session, global session



# 외부파일을 이용한 설정

resources 폴더에 .properties 파일 미리 만들어 놓는다.

## Environment 객체 이용

```java
ConfigurableApplicationContext ctx = new GenericXmlApplicationContext();
ConfigurableEnvironment env = ctx.getEnvironment();

// 추가
MutablePropertySources propertySources = env.getPropertySources();
propertySources.addLast(new ResourcePropertySource("classpath:admin.properties"));

// 추출
env.getProperty("admin.id");
```



## properties 파일 이용

resources 폴더에 .properties 파일 미리 만들어 놓는다.

#### 방법 1. XML 파일 이용

```xml
<!-- properties 파일 지정 -->
<context:property-placeholder location="classpath:파일명.properties, ..." />

<bean id="adminConnection" class="패키지.AdminConnection">
	<property name="adminId">
    	<value>${admin.id}</value>
    </property>
    <property name="adminPw">
    	<value>${admin.pw}</value>
    </property>
</bean>
```

xml 파일 아래에 Namespaces 탭에서 context 항목을 체크해줘야 사용 가능

#### 방법 2. Java 파일 이용

```java
@Configuration
public class ApplicationConfig {
    // Value annotation을 통해 properties 파일의 데이터가 자동으로 할당
    @Value("${admin.id}")
    private String adminId;
    @Value("${admin.pw}")
    private String adminPw;
    
    // properties 파일 가져오기
    @Bean
    public static PropertySourcesPlaceholderConfigurer Properties() {
        PropertySourcesPlaceholderConfigurer configurer = 
            new PropertySourcesPlaceholderConfigurer();
        
        Resource[] locations = new Resource[2];
        locations[0] = new ClassPathResource("admin.properties");
        locations[1] = new ClassPathResource("sub_admin.properties");
        configurer.setLocations(locations);
        
        return configurer;
    }
    
    // 객체 생성
    @Bean
    public AdminConnection adminConfig() {
        AdminConnection adminConnection = new AdminConnection();
        adminConnection.setAdminId(adminId);
        adminConnection.setAdminPw(adminPw);
        return adminConnection;
    }
}
```



## profile 속성 이용

환경에 따라 외부파일을 선택하고 싶을 때 사용

#### 방법 1. XML 파일 이용

applicationCTX_dev.xml (개발용)

```xml
<beans ... profile="dev">
	<bean id="serverInfo" class="com.javalec.ex.ServerInfo">
        <!-- 개발용 데이터 set -->
    </bean>
</beans>
```

applicationCTX_run.xml (배포용)

```xml
<beans ... profile="run">
	<bean id="serverInfo" class="com.javalec.ex.ServerInfo">
        <!-- 배포용 데이터 set -->
    </bean>
</beans>
```

MainClass.java

```java
GenericXmlApplicationContext ctx = new GenericXmlApplicationContext();
// 원하는 외부파일을 선택
ctx.getEnvironment().setActiveProfiles("dev");  // 개발용
//ctx.getEnvironment().setActiveProfiles("run");  // 배포용
ctx.load("applicationCTX_dev.xml", "applicationCTX_run.xml");
```

#### 방법 2. Java 파일 이용

ApplicationConfigDev.java (개발용)

```java
@Configuration
@Profile("dev")
public class ApplicationConfigDev {
    @Bean
    public ServerInfo serverInfo() {
        ServerInfo info = new ServerInfo();
        // 개발용 데이터 set
        return info;
    }
}
```

ApplicationConfigRun.java (배포용)

```java
@Configuration
@Profile("run")
public class ApplicationConfigDev {
    @Bean
    public ServerInfo serverInfo() {
        ServerInfo info = new ServerInfo();
        // 배포용 데이터 set
        return info;
    }
}
```

MainClass.java

```java
AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext();
ctx.getEnvironment().setActiveProfiles("dev");  // 개발용
//ctx.getEnvironment().setActiveProfiles("run");  // 배포용
ctx.register(ApplicationConfigDev.class, ApplicationConfigRun.class);
ctx.refresh();
```



# AOP

## AOP란?

Aspect Oriented Programming : 관점 지향 프로그래밍

핵심 기능과 공통 기능을 분리하여, 모듈성을 증가시킨 프로그래밍 방법

- aspect : 공통 기능
- advice : 언제 공통 기능을 수행할 지
- joinpoint : advice를 적용할 대상(method)
- pointcut : jointpoint의 부분, 실제로 advice가 적용된 부분
- weaving : advice를 핵심 기능에 적용하는 행위



## AOP 구현

#### 방법 1. XML 이용

1. 의존 설정(pom.xml)

```xml
<!-- AOP -->
<dependency>
	<groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.7.4</version>
</dependency>
```

라이브러리가 추가됨.

2. 공통 기능 클래스

```java
public class LogAop {
    public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable {
        // joinpoint(메소드명) 출력
        String signatureStr = joinpoint.getSignature().toShortString();
        /* 핵심 기능 전에 수행할 공통 기능... */
        try {
            Object obj = joinpoint.proceed();
            return obj;
        } finally {
            /* 핵심 기능 후에 수행할 공통 기능... */
        }
    }
}
```

3. XML 파일 설정

```xml
<!-- Namespaces에서 aop항목 체크 -->

<bean id="logAop" class="com.javalec.ex.LogApp" />

<aop:config>
	<aop:aspect id="logger" ref="logAop">
    	<aop:pointcut id="publicM" expression="within(com.javalec.ex.*)" />
        <aop:around pointcut-ref="publicM" method="loggerAop" />  <!-- advice -->
    </aop:aspect>
</aop:config>
```

advice 종류

- aop:around : 메소드 실행 전/후, exception 발생 시
- aop:before : 메소드 실행 전
- aop:after : 메소드 실행 후, exception 발생 시
- aop:after-returning : 메소드가 정상적으로 실행 후
- aop:after-throwing : 메소드 실행 중 exception 발생 시

#### 방법 2. @Aspect 이용

1. 의존 설정(pom.xml)

```xml
<!-- AOP -->
<dependency>
	<groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.7.4</version>
</dependency>
```

2. Aspect 클래스

```java
@Aspect
public class LogAop {
    @Pointcut("within(com.javalec.ex.*)")
    private void pointcutMethod() {}
    
    @Around("pointcutMethod()")
    public Object loggerAop(ProceedingJoinPoint joinpoint) throws Throwable {
        // joinpoint(메소드명) 출력
        String signatureStr = joinpoint.getSignature().toShortString();
        /* 핵심 기능 전에 수행할 공통 기능... */
        try {
            Object obj = joinpoint.proceed();
            return obj;
        } finally {
            /* 핵심 기능 후에 수행할 공통 기능... */
        }
    }
    
    // Pointcut 없이 직접 advice 지정 가능
    @Before("within(com.javalec.ex.*)")
    public void beforeAdviece() {
        /* 핵심 기능 전에 수행할 공통 기능... */
    }
}
```

3. XML 파일 설정

```xml
<!-- Namespaces에서 aop항목 체크 -->

<aop:aspectj-autoproxy />
<bean id="logAop" class="com.javalec.ex.LogAop" />
```

#### AspectJ Pointcut 표현식

```java
// .. : 0개 이상

// execution
@Pointcut("execution(public void get*(..))")  // public void인 모든 get 메소드(파라미터 개수 상관 없음)
@Pointcut("execution(* com.javalec.ex.*.*())")  // com.javalec.ex 패키지에 파라미터가 없는 메소드
@Pointcut("execution(* com.javalec.ex..*.*())")  // com.javalec.ex와 하위 패키지에 파라미터가 없는 메소드
@Pointcut("execution(* com.javalec.ex.Worker.*())")  // com.javalec.ex.Worker 클래스의 메소드

// within
@Pointcut("within(com.javalec.ex.*)")  // com.javalec.ex 패키지 안의 메소드
@Pointcut("within(com.javalec.ex..*)")  // com.javalec.ex와 하위 패키지 안의 메소드
@Pointcut("within(com.javalec.ex.Worker)")  // com.javalec.ex.Worker 클래스의 메소드

// bean
@Pointcut("bean(student)")  // student 빈
@Pointcut("bean(*ker)")  // ker로 끝나는 빈
```



# MVC

## 스프링 MVC 구조

![](img\spring02.PNG)

## 한글 처리

web.xml

```xml
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



# Controller

## 컨트롤러 클래스

servlet-context.xml 파일에 명시된 패키지 안에서만 @Controller를 스캔함.

```java
@Controller
public class HomeController {
    // ...
}
```



## 요청 처리 메소드

```java
@ReqeustMapping("/view")
public String view() {
    return "view";
}
```



## 뷰에 데이터 전달

#### 방법 1. Model 객체 이용

```java
@RequestMapping("view")
public String view(Model model) {
    model.addAttribute("name", "Kim");
    return "view";
}
```

#### 방법 2. ModelAndView 객체 이용

```java
@RequestMapping("view")
public ModelAndView view() {
    ModelAndView mv = new ModelAndView();
    mv.addObject("name", "Kim");
    mv.setViewName("view");
    return mv;
}
```

#### 뷰에서 수신

```jsp
${name}
```



## 클래스에 @RequestMapping 적용

클래스에 @RequestMapping을 적용하면 소속 메소드에 공통으로 적용할 수 있다.

```java
@Controller
@RequestMapping("/board")
public class HomeController {
    // 요청 경로 : context명/board/list
    @RequestMapping("/list")
    public String list(Model model) {
        model.addAttribute("name", "Kim");
        return "board/write";
    }
}
```



# Form 데이터 가져오기

## HttpServletRequest 클래스

servlet과 방법이 비슷하다.

```java
@RequestMapping("/board/confirmId")
public String confirmId(HttpServletRequest request, Model model) {
    // 파라미터 get
    String id = request.getParameter("id");
    String pw = request.getParameter("pw");

    // 모델에 데이터 추가
    model.addAttribute("id", id);
    model.addAttribute("pw", pw);

    return "board/confirmId";
}
```



## @RequestParam

파라미터를 받아와서 변수에 할당한다.

```java
@RequestMapping("/board/confirmId")
public String confirmId(@RequestParam("id") String id, @RequestParam("pw") int pw, Model model) {
    // 인자에 명시된 파라미터를 받지 못하면 400에러 발생
    model.addAttribute("id", id);
    model.addAttribute("pw", pw);
    
    return "board/confirmId";
}
```



## 데이터(커맨드) 객체

인자로 객체를 받으면 객체화, setter, addAttribute 과정을 모두 스프링이 알아서 처리해준다.

```java
@RequestMapping("/member/join")
public String joinData(Member member) {
    /* 스프링이 알아서 해준다.
    Member member = new Member();
    member.setName(name);
    ...
    model.addAttribute("member", member);
    */
    return "member/join";
}
```

```jsp
이름 : ${member.name}
```



## @PathVariable

경로에 변수를 넣어 파라미터로 이용할 수 있다. (자주 사용하지는 않는다.)

```java
// 요청 경로 : context명/student/10

@RequestMapping("/student/{studentId}")
public String getStudent(@PathVariable String studentId, Model model) {
    model.addAttribute("studentId", studentId);
    return "student/studentView";
}
```



# @RequestMapping 파라미터

## Get, Post

```java
// Get 방식으로 수신
@RequestMapping(value = "/student", method = RequestMethod.GET)
// Post 방식으로 수신
@RequestMapping(value = "/student", method = RequestMethod.POST)
// Get, Post 모두 수신
@RequestMapping(value = "/student")
```



## @ModelAttribute

커맨드 객체의 이름을 지정할 수 있다.

```java
@RequestMapping("/studentView")
public String studentView(@ModelAttribute("studentInfo") StudentInformation studentInformation) {
    // 원래 커맨드 객체는 studentInformation인데 studentInfo로 줄임.
    return "studentView";
}
```

```jsp
이름 : ${studentInfo.name}
```



## redirect

페이지를 이동할 때 사용

```java
@RequestMapping("/home")
public String home() {
    return "redirect:home";
    // context명/home 경로로 이동
}
```

WEB-INF 안에 있는 파일은 직접 주소를 입력해서 접근할 수 없다.



# 폼 데이터 값 검증

## Validator 이용

```java
@RequestMapping("/student/create")
public String studentCreate(@ModelAttribute("student") Student student, BindingResult result) {

    String page = "createDonePage";  // 성공 시

    StudentValidator validator = new StudentValidator();
    validator.validate(student, result);
    if(result.hasErrors()) {
        page = "createPage"; // 실패 시
    }

    return page;
}
```

```java
public class StudentValidator implements Validator {

	@Override
	public boolean supports(Class<?> arg0) {
		return Student.class.isAssignableFrom(arg0);  // 검증할 객체의 클래스 타입 정보
	}

	@Override
	public void validate(Object obj, Errors errors) {
		System.out.println("validate()");
		Student student = (Student)obj;
		// 문자열 검사
		String studentName = student.getName();
		if(studentName == null || studentName.trim().isEmpty()) {
			System.out.println("studentName is null or empty");
			errors.rejectValue("name", "trouble");
		}
		// 숫자 검사
		int studentId = student.getId();
		if(studentId == 0) {
			System.out.println("studentId is 0");
			errors.rejectValue("id", "trouble");
		}
	}
	
}
```



## ValidationUtils 클래스

validate() 메소드를 좀 더 편리하게 사용할 수 있도록 만든 클래스

```java
/*
String studentName = student.getName();
if(studentName == null || studentName.trim().isEmpty()) {
    System.out.println("studentName is null or empty");
    errors.rejectValue("name", "trouble");
}
*/
ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "trouble");
```



## @Valid와 @InitBinder

직접 호출하지 않고, 스프링 프레임워크에서 호출

```java
@RequestMapping("/student/create")
// 변수 앞에 @Valid 추가
public String studentCreate(@ModelAttribute("student") @Valid Student student, BindingResult result) {

    String page = "createDonePage";
	// 기존 방식
    //StudentValidator validator = new StudentValidator();
    //validator.validate(student, result);
    if(result.hasErrors()) {
        page = "createPage";
    }

    return page;
}
// @InitBinder 추가
@InitBinder
protected void initBinder(WebDataBinder binder){
    binder.setValidator(new StudentValidator());
}
```

```xml
<!-- pom.xml에 의존 추가 -->
<dependency>
	<groupId>org.hibernate</groupId>
    <artifactId>hibernate-validator</artifactId>
    <version>4.2.0.Final</version>
</dependency>
```















