# JSP 태그 종류

```jsp
<%@ %> : 지시자(page, include, taglib)
<%! %> : 선언
<%= %> : 표현식(값 출력)
<% %> : 스크립트릿(Java 코드)
<%-- --%> : 주석
<jsp:action></jsp:action> : 액션태그(자바빈 연결)
```



# include

다른 페이지 삽입

```jsp
<%@ include file="페이지경로" %>
```



# 내부 객체

- 입출력 객체 : request, response, out
- 서블릿 객체 : page, config
- 세션 객체 : session
- 예외 객체 : exception

### request 객체

```java
request.setCharacterEncoding(인코딩); // 문자 인코딩 set
request.getParameter(name); // name에 해당하는 파라미터 값을 구함.
request.getParameterNames(); // 모든 파라미터 이름을 구함.
request.getParameterValues(name); // name에 해당하는 파라미터값들을 구함.(checkbox 등)

request.getContextPath() // /01_helloWolrd
request.getMethod() // GET
request.getSession() // org.apache.catalina.session.StandardSessionFacade@7b0b1984
request.getProtocol() // HTTP/1.1
request.getRequestURL() // http://localhost:8081/01_helloWolrd/index.jsp
request.getRequestURI() // /01_helloWolrd/index.jsp
request.getQueryString() // null
```

### response 객체

```java
response.getCharacterEncoding() // 문자의 인코딩 형태 get
response.addCookie(Cookie) // 쿠키 추가
response.sendRedirect(URL) // 지정한 URL로 이동
```



# 액션태그

```jsp
<!-- forward : 특정 페이지로 이동. URL은 바뀌지 않음. -->
<jsp:forward page="sub.jsp"/>

<!-- include : 다른 페이지 삽입 -->
<jsp:include page="sub.jsp"/> 

<!-- param : 파라미터 전달 -->
<jsp:forward page="sub.jsp">
	<jsp:param name="id" value="abcd"/>
	<jsp:param name="pw" value="1234"/>
</jsp:forward>

<jsp:include page="sub.jsp">
	<jsp:param name="id" value="abcd"/>
	<jsp:param name="pw" value="1234"/>
</jsp:include>
```



# 쿠키

- 서버에서 생성하여, 클라이언트에 저장
- 서버에 요청할 때마다 쿠키를 참조, 변경 가능
- 하나당 최대 용량 : 4KB, 최대 개수 : 300개

```java
// 쿠키 생성
Cookie cookie = new Cookie(이름, 값);

// 쿠키 추가(저장)
respose.addCookie(cookie);

// 쿠기 가져오기
Cookie[] cookies = request.getCookies();

// 쿠키 삭제
cookies[i].setMaxAge(0);
response.addCookie(cookies[i]);

// set
.setValue(String 값) 
.setMaxAge(int 시간) // 유효 시간(ms)
.setVersion(int version)
.setPath(String 경로) // 유효 디렉토리

// get
.getName()
.getValue()
.getMaxAge()
.getVersion()
.getPath()
```



# 세션

- 쿠키와 달리 서버상에 객체로 존재
- 보안성이 좋고, 용량 한계가 없음
- 요청이 올 때마다 session 객체를 만듦(session ID가 모두 다름)
- 내부객체(session)이므로 생성할 필요 없음

```java
// 관련 메서드
.setAttribute(String 속성, Object 값)
.getAttribute(String 속성) // Object 반환
.getAttributeNames() // Enumeration 반환
.gedId() 
.isNew() // 최초 생성되었는지, 기존에 있던 것인지
.setMaxInactiveInterval(int 시간) // 유효시간 set (기본값 : 30분)
.getMaxInactiveInterval() // 유효시간 get
.removeAttribute(String 속성) // 특정 속성 제거
.invalidate() // 세션 초기화 -> 세션 ID 바뀜

// session 모두 가져오기
Enumeration enumeration = session.getAttributeNames();
while(enumeration.hasMoreElements()) {
	String name = enumeration.nextElement().toString();
	String value = session.getAttribute(name).toString();
	out.println(name + " / " + value);
}
```



# 에러 페이지

톰켓의 기본 에러 페이지를 사용하면 사용자에게 불쾌감을 줄 수 있다.

### 방법 1. page 지시자

에러 발생 가능 페이지.jsp

```jsp
<%@ page errorPage="errorPage.jsp" %>
```
에러 처리 페이지.jsp

```jsp
<%@ page isErrorPage="true" %> <!-- 에러 처리 페이지 명시 -> exception 객체 생성됨 -->
<% reponse.setStatus(200); %> <!-- 정상 페이지라고 명시 -->
<%= exception.getMessage() %> <!-- 에러 메시지 출력 -->
```

### 방법 2. web.xml 파일 이용

```xml
<!-- 에러 처리 -->
<error-page>
	<error-code>404</error-code> // 404에러 발생 시
	<location>/error404.jsp</location> // 특정 페이지로 이동
</error-page>
<error-page>
	<error-code>500</error-code>
	<location>/error500.jsp</location>
</error-page>

<!-- Exception 처리 -->
<error-page>
	<exception-type>java.io.IOException</exception-type>
	<location>/errorIO.jsp</location>
</error-page>

```



# 자바 빈(bean)

데이터를 효율적으로 관리하기 위한 클래스

### useBean

자바의 객체화와 비슷

```jsp
<jsp:useBean id="빈이름" class="클래스명(DTO)" scope="범위"/>
```

- id : 변수명과 비슷(예 : student)
- class 예 : com.jsp.ex.Student
- scope : page(생성된 페이지 내), request(요청된 페이지 내), session(웹브라우저 내), application(웹 어플리케이션 내)

### setProperty, getProperty

자바의 setter, getter

```jsp
<jsp:setProperty name="빈이름" property="속성명" value="값"/>
<!-- 파라미터로 받은 값과 빈의 변수명이 모두 일치할 경우 한번에 set할 수 있다. -->
<jsp:setProperty name=빈이름 property="*"/>

<jsp:getProperty name=빈이름 property=속성명/>
```



# JDBC

Java Database Connectivity

- Java 프로그램에서 DB에 접속하여 데이터를 관리하기 위한 API
- 각 DB의 JDBC만 가져오면 하나의 프로그램으로 각 DB를 관리할 수 있다.

### JDBC 파일 위치

oracle\product\11.2.0\server\jdbc\lib\ojdbc6_g.jar

### JDBC 추가(이클립스 재부팅 필요)

Java\jre1.8.0_161\lib\ext\

### 기본 예제

```java
Connection conn = null;
Statement stmt = null;
//PreparedStatement pstmt = null;
ResultSet rs = null;

String driver = "oracle.jdbc.driver.OracleDriver";
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String user = "web_user";
String password = "1212";

try {
	Class.forName(driver); // JDBC 로드
	conn = DriverManager.getConnection(url, user, password); // DB 연결
	
	// 쿼리 실행
	String sql = "SELECT * FROM member";
	stmt = conn.createStatement();
	//pstmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery(sql);
	//rs = pstmt.executeQuery();
	
	// 데이터 출력
	while(rs.next()) {
		String id = rs.getString("id");
		String pw = rs.getString("pw");
		out.println(id + " / " + pw + "<br/>");
	}
} catch (Exception e) {
	e.printStackTrace();
} finally {
	// 자원 반납
	try {
		if (rs != null) rs.close();
		if (stmt !=null) stmt.close();
		//if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
}
```



# DBCP

Database Connection Pool

- 다수의 요청이 발생할 경우 DB에 부하가 발생
- 이를 해결하기 위해 Connection을 미리 만들어 놓는 기법

### DBCP 라이브러리 다운로드

https://commons.apache.org/proper/commons-dbcp/download_dbcp.cgi

### DBCP 만들기

context.xml

```xml
<Resource
	name="jdbc/Oracle"
	auth="Container"
	type="javax.sql.DataSource"
	driverClassName="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	username="web_user"
	password="pass"
/>
```
추가 옵션

- maxActive : 연결 최대 허용 수
- maxWait : 최대로 연결되었을 때 대기시간(지나면 Connection 수를 증가시킴)
	 maxIdle : 연결을 항상 유지하는 수	

### DBCP에서 Connection 가져오기

jsp 파일

```java
Context context = new InitialContext();
DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/Oracle");
Connection conn = ds.getConnection();
```



# DAO, DTO

- DAO(Data Access Object) : DB와 관련된 일을 하는 클래스(모듈화 목적)
- DTO(Data Transfer Object) : 관련된 데이터를 모아놓은 클래스



# 파일 업로드

- cos 라이브러리 사용 : http://servlets.com/cos/
- 프로젝트 - WebContent - WEB-INF - lib 폴더에 cos.jar 저장
- 업로드한 파일을 저장할 폴더 생성 WebContent - fileFolder
- 업로드한 파일은 이클립스 프로젝트의 폴더에 저장되지 않고, 톰켓 프로젝트 폴더에 저장된다.

### fileForm.jsp

```jsp
<form action="fileFormOk.jsp" method="post" enctype="multipart/form-data">
	파일 : <input type="file" name="file"><br />
	<input type="submit" value="File Upload">
</form>
```

### fileFormOk.jsp

```java
String path = request.getSession().getServletContext().getRealPath("fileFolder");
//String path = request.getRealPath("fileFolder");
int size = 1024 * 1024 * 10; //10M
String file = "";
String oriFile = "";
try{
	// request에서 파일을 추출하여 업로드
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy()); // 같은 이름이 있으면 파일명 뒤에 1, 2, 3, ... 붙이는 정책

    Enumeration files = multi.getFileNames();
    String str = (String)files.nextElement();

    file = multi.getFilesystemName(str);
    oriFile = multi.getOriginalFileName(str);
} catch (Exception e) {
	e.printStackTrace();
}

```



# EL

Expression Language

- 표현식 또는 액션태그를 다른 방법으로 표현
- 산술, 논리 연산자 사용 가능

```jsp
${ value } <!-- < %= value % > 와 같은 의미 -->
${ member.name } <!-- <jsp:getProperty name="member" property="name"/> 과 같은 의미 -->
```

### 내장객체

- pageScope : page 객체 참조
- requestScope
- sessionScope
  - ${sessionScope.loginId} : 세션에 저장된 아이디 반환
- applicationScope
- param : 요청 파라미터 참조
- paramValues : 요청 파라미터 배열 참조
- initParam : 초기화 파라미터 참조
- cookie



# JSTL

JSP Standard Tag Library

1. 다운로드(1.1.2버전) : https://tomcat.apache.org/taglibs/standard/
2. lib에 있는 jar파일 2개를 톰켓 폴더/lib에 복사

### JSTL 로드

```jsp
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
```

### 태그 종류

```jsp
<!-- set : JSP에서 사용할 변수 선언 -->
<c:set var="변수명" value="값" [scope="영역"] />
<c:set var="변수명" [scope="영역"]>값</c:set>
<c:set target="객체명" property="속성이름(key)" value="속성값"/>

<!-- remove -->
<c:remove var="var명" scope="영역" />

<!-- if -->
<c:if test="조건" var="변수명(test결과(true, false) 저장)">
	실행문
</c:if>

<!-- choose : Java의 switch-case문 -->
<c:choose>
	<c:when test="조건1">실행문1</c:when>
	<c:when test="조건2">실행문2</c:when>
	<c:otherwise>실행문</c:otherwise>
</c:choose>

<!-- forEach -->
<c:forEach var="변수명" items="대상아이템" begin=시작 end=끝 step=증가>
	실행문
</c:forEach>	

<!-- import -->
<c:import url="URL" var="변수명" scope="영역" charEncoding="인코딩"></c:import>

<!-- redirect -->
<c:redirect url="URL" context="컨텍스트경로">
	<c:param name="이름" value="값">
</c:redirect>

<!-- catch : Exception 발생 시 변수에 저장 -->
<c:catch var="변수명"> . . . 익셉션이 발생할 수 있는 코드 . . . </c:catch>
${ 변수명 } <!-- Exception 출력 -->

<!-- out : 값 출력 -->
<c:out value="값" escapeXml="boolean" default="기본값" />
```
참조 : http://gangzzang.tistory.com/entry/JSP-JSTLJSP-Standard-Tag-Library-%EC%BD%94%EC%96%B4-%ED%83%9C%EA%B7%B8?category=525447



# 인코딩 설정

```java
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8"); // PrintWriter로 HTML 작성하기 위해
```



# Ajax 통신

> Asynchronous JavaScript and XML
> 비동기적으로 서버와 브라우저가 데이터를 주고 받는 방식(주로 JSON 사용)
> 페이지의 로드 없이 내용을 변경 가능

```javascript
$.ajax(옵션객체);
```

옵션객체

- url : 전송할 URL
- type : 데이터 전송 방법(get, post)
- data : 서버로 데이터를 전송할 데이터
- dataType : 서버에서 받은 데이터를 어떤 형식으로 해석할 지(xml, json, script, html) 지정하지 않으면 알아서 판단
- success : 성공 시 콜백. Function(PlainObject data, String textStatus, jqXHR jqXHR)
- error : 실패 시 콜백

### 예제

> Ajax 통신을 통해 로그인하는 예제

##### JavaScript 부분

```javascript
$("#btn").click(function() {
    $.ajax({
        url: "./login",
        type: "post",
        data: {
            id: $("#id").val(),
            pw: $("#pw").val()
        },
        dataType: "json",
        success: function(data) {
            if (data.success == true) {
                alert("로그인 성공");
            } else {
                alert("로그인 실패");
            }
        },
        error: function(err) {console.log(err);}
    });
});
```

##### Servlet 부분

```java
// 데이터 get
String id = request.getParameter("id");
String pw = request.getParameter("pw");

/* 아이디, 비밀번호 확인하여 result에 true, false 저장 */

// 되돌려보낼 데이터를 HashMap에 담음(JSON과 유사하기 때문)
HashMap<String, Boolean> map = new HashMap<>();
map.put("success", result);

// HashMap을 Json(String)으로 변환
Gson gson = new Gson();
String json = gson.toJson(map); 

// 전송
response.setContentType("text/html; charset=UTF-8"); // 인코딩
response.setHeader("Access-Control-Allow-Origin", "*"); // 크로스 도메인 허용(2번째 인자 : 허용할 도메인)
response.getWriter().println(json);
```



# Servlet에서 HTML 작성

```java
response.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

PrintWriter out = response.getWriter();
out.println("");

out.close();
```



# 페이징(Paging)

게시판에서 페이지 이동 기능

### Controller(Service)

```java
//...

public void pagingList() throws ServletException, IOException {
    /* 파라미터 get */
    String paramPage = request.getParameter("page");  // 현재 페이지
    String paramListCount = request.getParameter("listCount");  // 페이지의 리스트 개수
    String paramPageCount = request.getParameter("pageCount");  // 화면의 페이지 개수

    /* 기본값 설정(파라미터로 받지 못했을 경우) */
    // 현재 페이지
    int page; 
    if (paramPage == null) {
        page = 1;
    } else {
        page = Integer.parseInt(paramPage);
    }
    // 한 페이지에 보여줄 리스트 개수
    int listCount;
    if (paramListCount == null) {
        listCount = 10;
    } else {
        listCount = Integer.parseInt(paramListCount);
    }
    // 한 화면에 보여줄 페이지 개수
    int pageCount;
    if (paramPageCount == null) {
        pageCount = 10;
    } else {
        pageCount = Integer.parseInt(paramPageCount);
    }

    // DB에서 리스트의 총 개수 가져오기
    DAO dao = new DAO();
    int totalCount = dao.totalCount();

    // PageInfo 생성(보여줄 글번호, 보여줄 페이지, 총 페이지수 등 계산)
    PageInfo pageInfo = new PageInfo(page, listCount, pageCount, totalCount);
    int startNum = pageInfo.getStartNum();  // 시작 글번호
    int endNum = pageInfo.getEndNum();  // 마지막 글번호

    // startNum ~ endNum 구간 리스트 가져옴
    dao = new DAO();
    ArrayList<DTO> list = dao.pagedList(startNum, endNum);

    request.setAttribute("list", list);
    request.setAttribute("pageInfo", pageInfo);

    // JSP 파일로 forward
    RequestDispatcher rd = request.getRequestDispatcher("list.jsp");
    rd.forward(request, response);
}

//...
```

### DAO

```java
//...

// 게시글 총 개수 반환
public int totalCount() {
    String sql = "SELECT count(*) AS cnt FROM bbs";
    int cnt = 0;
    try {
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();

        if (rs.next()) {
            cnt = rs.getInt("cnt");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        resClose();  // 자원 반납
    }

    return cnt;
}

// startNum ~ endNum 구간 리스트 반환
public ArrayList<DTO> pagedList(int startNum, int endNum) {
    ArrayList<DTO> list = new ArrayList<>();

    // endNum까지만 검색하여 시간 최소화
    String sql = "SELECT X.rnum, X.컬럼, ... " + 
        "FROM ( " + 
        "	SELECT ROWNUM AS rnum, A.컬럼, ... " + 
        "	FROM ( " + 
        "		SELECT 컬럼, ... " + 
        "		FROM 테이블 " + 
        "		ORDER BY 정렬할컬럼 DESC) A " + 
        "	WHERE ROWNUM <= ?) X " + 
        "WHERE X.rnum >= ?";
    
    /* 학원에서 사용한 쿼리문 */
    /*
    String sql = "SELECT 컬럼, ... "
		"FROM ( " +
		"	SELECT 컬럼, ..., ROW_NUMBER() OVER(ORDER BY 정렬할컬럼 DESC) AS rnum " +
		"	FROM 테이블 " +
		") " +
		"WHERE rnum BETWEEN ? AND ?";
	*/

    try {
        ps = conn.prepareStatement(sql);
        ps.setInt(1, endNum);
        ps.setInt(2, startNum);
        rs = ps.executeQuery();

        while (rs.next()) {
            DTO dto = new DTO();
            dto.set변수(rs.getInt("컬럼"));
            //...
            list.add(dto);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        resClose();  // 자원반납
    }

    return list;
}

//...
```

### PageInfo(DTO)

```java
public class PageInfo {

	// 생성 시 입력할 값
	private int page; // 현재 페이지(보여줄)
	private int listCount; // 한 페이지에 보여줄 리스트 수
	private int pageCount; // 한 화면에 보여줄 페이지 수
	private int totalCount; // 총 게시물 수
	// 계산할 값
	private int startNum;  // 페이지에서 보여줄 첫번째 글번호
	private int endNum;  // 페이지에서 보여줄 마지막 글번호
	private int totalPage; // 총 페이지 수
	private int startPage; // 화면에 보여줄 시작 페이지
	private int endPage; // 화면에 보여줄 마지막 페이지
	private int nextPage;  // 다음 눌렀을 때 이동할 페이지
	private int prevPage;  // 이전 눌렀을 때 이동할 페이지
		
	// 생성자
	public PageInfo(int page, int listCount, int pageCount, int totalCount) {
		this.page = page;
		this.listCount = listCount;
		this.pageCount = pageCount;
		this.totalCount = totalCount;
		
		// 총 페이지수(나누어 떨어질 때 마지막 페이지가 빈페이지로 표시되는 것 방지)
		totalPage = totalCount / listCount;
		if (totalCount % listCount > 0) {
			totalPage++;
		}

		// 총 페이지수보다 큰 페이지를 입력한 경우 처리
		if (totalPage < page) {
			page = totalPage;
		}

		// 화면에 보여줄 시작 페이지
		startPage = ((page - 1) / pageCount) * pageCount + 1;
		// 화면에 보여줄 마지막 페이지
		endPage = startPage + pageCount - 1;

		// 마지막 화면에서의 처리
		if (endPage > totalPage) {
			endPage = totalPage;
		}

		// 페이지에서 보여줄 시작 글번호
		startNum = (page - 1) * listCount + 1;
		// 페이지에서 보여줄 마지막 글번호
		endNum = page * listCount;
		
		// 다음 눌렀을 때 이동할 페이지
		nextPage = endPage + 1;
		// 이전 눌렀을 때 이동할 페이지
		prevPage = startPage - 1;
	}

	// Getters
    // ...
}
```

### list.jsp

```html
<!-- ... -->
<table>
    <tr>
        <th>글번호</th>
        <th>제목</th>
        <th>글쓴이</th>
    </tr>
    <c:forEach items="${ list }" var="item">
        <tr>
            <td>${ item.글번호 }</td>
            <td>${ item.제목 }</td>
            <!-- ... -->
        </tr>
    </c:forEach>
</table>
<div>
	<jsp:include page="paging.jsp"></jsp:include>    
</div>
<!-- ... -->
```

### paging.jsp (list.jsp에 포함된 파일)

```html
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style>
        .paging {
            padding: 10px 0px;
            text-align: center;
        }
        .paging div a {
            display: inline-block;
            padding: 4px;
            margin-right: 3px;
            width: 15px;
            color: black;
            font-size: 12px;
            font-weight: bold;
            border: thin solid lightgray;
            text-align: center;
            text-decoration: none;
        }
        /* 글자(맨앞, 이전, 다음, 맨뒤) */
        .paging div a.text {
            width: 30px;
        }
        /* 현재 페이지, 마우스 올렸을 때 */
        .paging div a#curPage, .paging div a:hover {  
            color: #fff;
            border: 1px solid orange;
            background-color: orange;
        }
    </style>
</head>
<body>
	<div class="paging"></div>
</body>
<script>
    // 맨앞
    if (${pageInfo.startPage} > 1) {
        $(".paging").append("<a class='text' href='?page=1'>맨앞</a>");
    }

    // 이전
    if (${pageInfo.startPage} > 1) {
        $(".paging").append("<a class='text' href='?page=" + ${pageInfo.prevPage}  + "'>이전</a>");
    }

    // 페이지 번호
    for (var i = ${pageInfo.startPage}; i <= ${pageInfo.endPage}; i++) {
        if (i == ${pageInfo.page}) {
            $(".paging").append("<a id='curPage' href='?page=" + i + "'>" + i + "</a>");
        } else {
            $(".paging").append("<a href='?page=" + i + "'>" + i + "</a>");
        }
    }

    // 다음
    if (${pageInfo.endPage} != ${pageInfo.totalPage}) {
        $(".paging").append("<a class='text' href='?page=" + ${pageInfo.nextPage}  + "'>다음</a>");
    }

    // 맨뒤
    if (${pageInfo.endPage} != ${pageInfo.totalPage}) {
        $(".paging").append("<a class='text' href='?page=" + ${pageInfo.totalPage} + "'>맨뒤</a>");
    }
</script>
</html>
```



------

##### References

Inflearn JSP 강좌 

- https://www.inflearn.com/course/%EC%8B%A4%EC%A0%84-jsp-%EA%B0%95%EC%A2%8C/

페이징

- https://okky.kr/article/282819
- https://okky.kr/article/282926