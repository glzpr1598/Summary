JSP 태그 종류
<%
	<%@ %> : 지시자(page, include, taglib)
	<%! %> : 선언
	<%= %> : 표현식(값 출력)
	<% %> : 스크립트릿(Java 코드)
	<%-- --%> : 주석
	<jsp:action></jsp:action> : 액션태그(자바빈 연결)
%>

include : 다른 페이지 삽입
<% include file="파일경로"%>


내부 객체
<%
	입출력 객체 : request, response, out
	서블릿 객체 : page, config
	세션 객체 : session
	예외 객체 : exception
%>


request 객체
<%
	request.setCharacterEncoding(인코딩) // 문자 인코딩 set
	request.getParameter(name) // name에 해당하는 파라미터 값을 구함.
	request.getParameterNames() // 모든 파라미터 이름을 구함.
	request.getParameterValues(name) // name에 해당하는 파라미터값들을 구함.(checkbox 등)
	
	request.getContextPath() // /01_helloWolrd
	request.getMethod() // GET
	request.getSession() // org.apache.catalina.session.StandardSessionFacade@7b0b1984
	request.getProtocol() // HTTP/1.1
	request.getRequestURL() // http://localhost:8081/01_helloWolrd/index.jsp
	request.getRequestURI() // /01_helloWolrd/index.jsp
	request.getQueryString() // null
%>


response 객체
<%
	response.getCharacterEncoding() // 문자의 인코딩 형태 get
	response.addCookie(Cookie) // 쿠키 추가
	response.sendRedirect(URL) // 지정한 URL로 이동
%>


액션태그
<%
	// 스크립트릿에 작성하는 것 아님!
	
	// forward : 특정 페이지로 이동. URL은 바뀌지 않음.
	<jsp:forward page="sub.jsp"/>
	
	// include : 다른 페이지 삽입
	<jsp:include page="sub.jsp"/> 
	
	// param : 파라미터 전달(forward 안에 작성)
	<jsp:forward page="sub.jsp">
		<jsp:param name="id" value="abcd"/>
		<jsp:param name="pw" value="1234"/>
	</jsp:forward>
%>


쿠키
<%
	// 서버에서 생성하여, 클라이언트에 저장
	// 서버에 요청할 때마다 쿠키를 참조, 변경 가능
	// 하나당 최대 용량 : 4KB, 최대 개수 : 300개
	
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
	setValue(String 값) 
	setMaxAge(int 시간) // 유효 시간(ms)
	setVersion(int version)
	setPath(String 경로) // 유효 디렉토리
	
	// get
	getName()
	getValue()
	getMaxAge()
	getVersion()
	getPath()
%>


세션
<%
	// 쿠키와 달리 서버상에 객체로 존재
	// 보안성이 좋고, 용량 한계가 없음
	// 요청이 올 때마다 session 객체를 만듦(session ID가 모두 다름)
	
	// 관련 메서드
	setAttribute(String 속성, Object 값)
	getAttribute(String 속성) // Object 반환
	getAttributeNames() // Enumeration 반환
	gedId() 
	isNew() // 최초 생성되었는지, 기존에 있던 것인지
	getMaxInactiveInterval(int 시간) // 유효시간 set (기본값 : 30분)
	getMaxInactiveInterval() // 유효시간 get
	removeAttribute(String 속성) // 특정 속성 제거
	invalidate() // 세션 초기화 -> 세션 ID 바뀜
	
	// session 모두 가져오기
	Enumeration enumeration = session.getAttributeNames();
	while(enumeration.hasMoreElements()) {
		String name = enumeration.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name + " / " + value);
	}
%>


예외 페이지
<%
	// 톰켓의 기본 에러 페이지를 사용하면 사용자에게 불쾌감을 줄 수 있다.
	
	/* 방법 1. page 지시자 이용 */
	
	// 예외 발생 가능 페이지
	< %@ page errorPage="errorPage.jsp" % > // 이 페이지로 이동. 
	// 범위 오류 때문에 <와 %사이에 공백 넣음.
	
	// 예외 처리 페이지
	< %@ page isErrorPage="true" % > // 예외 처리 페이지 명시 -> exception 객체 생성됨
	< % reponse.setStatus(200); % > // 정상 페이지라고 명시
	
	< %= exception.getMessage() % > // 에러 메시지 출력

	/* 방법 2. web.xml 파일 이용 */
	<error-page>
		<error-code>404</error-code> // 404에러 발생 시
		<location>/error404.jsp</location> // 특정 페이지로 이동
	</error-page>
	<error-page>
		<error-code>500</error-code>
		<location>/error500.jsp</location>
	</error-page>
	
	// Exception 처리
	<error-page>
		<exception-type>java.io.IOException</exception-type>
		<location>/error/errorIO.jsp</location>
	</error-page>
%>


자바 빈(bean)
<%
	// 데이터를 효율적으로 관리하기 위한 클래스
	
	// 빈 관련 액션 태그
	
	// useBean : 자바의 객체화
	<jsp:useBean id=빈이름 class=클래스명(DTO) scope=범위/>
	// id : 변수명과 비슷(예 : student)
	// class 예 : com.jsp.ex.Student
	// scope : page(생성된 페이지 내), request(요청된 페이지 내), session(웹브라우저 내), application(웹 어플리케이션 내)
	
	// setProperty : 자바의 setter
	<jsp:setProperty name=빈이름 property=속성명 value=값/>
	// 파라미터로 받은 값과 빈의 변수명이 모두 일치할 경우 한번에 set할 수 있다.
	<jsp:setProperty name=빈이름 property="*"/>
	
	// getProperty : 자바의 getter
	<jsp:getProperty name=빈이름 property=속성명/>
	
%>


JDBC(Java Database Connectivity)
<%
	// Java 프로그램에서 SQL문을 실행하여 데이터를 관리하기 위한 API
	// 각 DB의 JDBC만 가져오면 하나의 프로그램으로 각 DB를 관리할 수 있다.
	
	// JDBC 파일 위치
	oracle\product\11.2.0\server\jdbc\lib\ojdbc6_g.jar
	
	// JDBC 추가(이클립스 재부팅 필요)
	Java\jre1.8.0_161\lib\ext\
	
	/* 기본 예제 */
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
%>


// DBCP(Database Connection Pool)
<%
	// 다수의 요청이 발생할 경우 DB에 부하가 발생
	// 이를 해결하기 위해 Connection을 미리 만들어 놓는 기법

	// DBCP 만들기(서버의 context.xml에 Resource 추가)
	<Resource
    	name="jdbc/Oracle" <!-- Resource를 불러올 이름 -->
    	auth="Container"
    	type="javax.sql.DataSource"
    	driverClassName="oracle.jdbc.driver.OracleDriver"
    	url="jdbc:oracle:thin:@localhost:1521:xe"
    	username="web_user"
    	password="pass"
    />
    <!-- 추가 옵션
    maxActive : 연결 최대 허용 수
    maxWait : 최대로 연결되었을 때 대기시간(지나면 Connection 수를 증가시킴)
    maxIdle : 연결을 항상 유지하는 수	
    -->
	
	// jsp(DBCP에서 Connection 가져오기)
	Context context = new InitialContext(); // Context 객체화
	DataSource ds = (DataSource)context.lookup("java:comp/env/jdbc/Oracle"); // DataSource get
	conn = ds.getConnection(); // Connect get
%>


// DAO, DTO
<%
	// DAO(Data Access Object) : DB와 관련된 일을 하는 클래스(모듈화 목적)
	// DTO(Data Transfer Object) : 관련된 데이터를 모아놓은 클래스
%>


// 파일 업로드
<%
	// cos 라이브러리 사용 : http://servlets.com/cos/
	// 프로젝트 - WebContent - WEB-INF - lib 폴더에 cos.jar 저장
	// 업로드한 파일을 저장할 폴더 생성 WebContent - fileFolder
	// 업로드한 파일은 이클립스 프로젝트의 폴더에 저장되지 않고, 톰켓 프로젝트 폴더에 저장된다.
	
	/* fileForm.jsp */
	<form action="fileFormOk.jsp" method="post" enctype="multipart/form-data">
		파일 : <input type="file" name="file"><br />
		<input type="submit" value="File Upload">
	</form>
	
	/* fileFormOk.jsp */
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
	
%>


// EL(Expression Language)
<%
	// 표현식 또는 액션태그를 다른 방법으로 표현
	// 산술, 논리 연산자 사용 가능
	
	${ vlaue } // 표현식 < %= value % > 와 같은 의미
	${ member.name } // <jsp:getProperty name="member" property="name"/> 과 같은 의미
	
	// 내장객체
	pageScope // page 객체 참조
	requestScope
	sessionScope
	applicationScope
	
	param // 요청 파라미터 참조
	paramValues // 요청 파라미터 배열 참조
	initParam // 초기화 파라미터 참조
	cookie
%>


// JSTL(JSP Standard Tag Library)
<%
	// 1.1.2버전 다운로드 : https://tomcat.apache.org/taglibs/standard/
	// lib에 있는 jar파일 2개를 톰켓 폴더/lib에 복사

	// JSTL 로드
	< %@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" % >

	/* 태그 종류 */ 
	// 참조 :  http://gangzzang.tistory.com/entry/JSP-JSTLJSP-Standard-Tag-Library-%EC%BD%94%EC%96%B4-%ED%83%9C%EA%B7%B8?category=525447
	
	// set : JSP에서 사용할 변수 선언
	<c:set var="변수명" value="값" [scope="영역"] />
	<c:set var="변수명" [scope="영역"]>값</c:set>

	// remove
	<c:remove var="var명" scope="영역" />
	
	// if
	<c:if test="조건" var="변수명(test결과(true, false) 저장)">
		실행문
	</c:if>
	
	// choose : Java의 Switch
	<c:choose> <!-- switch -->
		<c:when test="조건1">실행문1</c:when> <!-- case -->
		<c:when test="조건2">실행문2</c:when> <!-- case -->
		<c:otherwise>실행문</c:otherwise> <!-- default -->
	</c:choose>

	// forEach
	<c:forEach var="변수명" items="대상아이템" begin=시작 end=끝 step=증가>
		실행문
	</c:forEach>	

	// import
	<c:import url="URL" var="변수명" scope="영역" charEncoding="인코딩"></c:import>
	
	// redirect
	<c:redirect url="URL" context="컨텍스트경로">
		<c:param name="이름" value="값">
	</c:redirect>

	// catch : Exception 발생 시 변수에 저장
	<c:catch var="변수명"> . . . 익셉션이 발생할 수 있는 코드 . . . </c:catch>
	${ 변수명 } // Exception 출력

	// out : 값 출력
	<c:out value="값" escapeXml="boolean" default="기본값" />
%>


// 인코딩 설정
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); // PrintWriter로 HTML 작성하기 위해
%>


// Servlet에서 HTML 작성
<%
	response.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8");
	
	PrintWriter out = response.getWriter();
	out.println("");
	
	out.close();
%>


참조 : Inflearn JSP 강좌
