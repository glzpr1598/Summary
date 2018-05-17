# URL 맵핑

기존 경로 : http://localhost:8181/helloworld/servlet/com.javalec.ex.HelloWorld
맵핑 경로 : http://localhost:8181/helloworld/HWorld



# 웹브라우저로 출력

```java
response.setCharacterEncoding("UTF-8"); // 인코딩 set
response.setContentType("text/html; charset=utf-8"); // 응답 방식 set

PrintWriter out = response.getWriter(); // 웹브라우저 출력 스트림 get
out.println("<html><head></head><body>HelloWolrd</body></html>");
out.close();
```



# Context path

WAS에서 웹어플리케이션을 구분하기 위한 path
일반적으로,  /프로젝트명



# Servlet 생명주기(life cycle)

Servlet 객체 생성(최초 한번)
[선처리 : @PostConstruct]
Init() : 최초 한번
service(), doGet(), doPost() : 요청 시 매번
destroy() : 마지막 한번
[후처리 : @PreDestroy]



# 한글 처리

### Get 방식

server.xml 수정

```xml
<Connetor URIEncoding="UTF-8" .../>
```

### Post 방식

```java
request.setCharacterEncoding("UTF-8");
```



# 초기화 파라미터(ServletConfig)

### 방법 1. web.xml 파일에 설정

```xml
<servlet>
	<servlet-name>servler_이름</servlet-name> // 임의로 지정
	<servlet-class>com.jsp.ex.HellowWorld</servlet-class>
        <init-param>
        <param-name>id</param-name>
        <param-value>abcd</param-value>
    </init-param>
    <init-param>
        <param-name>pw</param-name>
        <param-value>1234</param-value>
    </init-param>
</servlet>
```

### 방법 2. Servlet 파일에 설정

```java
@WebServlet(urlPatterns={"/HelloWorld"}, initParams={@WebInitParam(name="id", value="abcd"), @WebInitParams(name="pw", value="1234"), ...})
```

### 파라미터 get

```java
String id = getInitParameter("id");
String pw = getInitParameter("pw");
```



# 데이터 공유(Context parameter)

여러 Servlet에서 데이터 공유

web.xml

```xml
<context-param>
	<param-name>id</param-name>
	<param-value>abcd</param-value>
</context-param>
```

Context parameter get

```java
String id = getServletContext().getInitParameter("id");
```



------

#### References

Inflearn JSP 강좌