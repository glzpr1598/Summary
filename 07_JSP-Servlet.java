public class Servlet {
	
	// URL 맵핑
	/*
	기존 경로 : http://localhost:8181/helloworld/servlet/com.javalec.ex.HelloWorld
	맵핑 경로 : http://localhost:8181/helloworld/HWorld
	*/
	
	
	// 웹프라우저에 출력
	/* 
	response.setContentType("text/html"); // 응답 방식 set
	PrintWriter writer = response.getWriter(); // 웹브라우저 출력 스트림 get
	writer.println("<html><head></head><body>HelloWolrd</body></html>");
	writer.close();
	 */
	
	
	// Context path
	/*
	// WAS에서 웹어플리케이션을 구분하기 위한 path
	// 일반적으로,  /프로젝트명
	*/
	
	
	// Servlet 생명주기(life cycle)
	/*
	Servlet 객체 생성(최초 한번)
	[선처리 : @PostConstruct]
	Init() 호출(최초 한번)
	service(), doGet(), doPost() 호출(요청 시 매번)
	destroy() 호출(마지막 한번)
	[후처리 : @PreDestroy]
	*/
	
	
	// 한글 처리
	/* 
	// Get 방식 : server.xml 수정
	<Connetor URIEncoding="UTF-8" .../>
	
	// Post 방식
	request.setCharacterEncoding("UTF-8");
	*/
	
	
	// 초기화 파라미터(ServletConfig)
	/* 
	// web.xml 파일에 설정
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
	
	// Servlet 파일에 설정
	@WebServlet(urlPatterns={"/HelloWorld"}, initParams={@WebInitParam(name="id", value="abcd"), @WebInitParams(name="pw", value="1234"), ...})
	
	// 파라미터 get
	String id = getInitParameter("id");
	String pw = getInitParameter("pw");
	*/
	
	
	// 데이터 공유(ServletContext)
	/* 
	// 여러 Servlet에서 데이터 공유(web.xml에 작성)
	<context-param>
		<param-name>id</param-name>
		<param-value>abcd</param-value>
	</context-param>
	
	// ServletContext get
	String id = getServletContext().getInitParameter("id");
	*/
	
	// 참조 : Inflearn JSP 강좌
}