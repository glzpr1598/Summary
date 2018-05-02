# jQuery

> 웹페이지를 쉽게 조작할 수 있게 해주는 JavaScript 라이브러리

- 크로스 브라우징을 알아서 처리
- CSS 셀렉터에 기반하여 DOM 조작
- 속성과 프로퍼티 알아서 처리 등 많은 편리한 기능 제공




# jQuery 로드

```html
<script src="//code.jquery.com/jquery-3.3.1.min.js">
```

> 1.x 버전은 IE6 이상 지원
> 2.x 버전은 IE9 이상 지원



# jQuery 객체

```javascript
$(선택자); // jQuery 함수 -> jQuery 객체 반환(유사배열)
$(선택자)[i]; // DOM 객체(jQuery 객체가 아님!)
```



# 효과 API

> 속도 : "fast", "slow", ms
> 가속도 : "linear", "swing"
> 콜백 : 완료되었을 때 실행되는 함수

```javascript
.show([속도], [가속도], [콜백]) 
.hide([속도], [가속도], [콜백])  
.toggle([속도], [가속도], [콜백])

.fadeIn([속도], [가속도], [콜백]) // 불투명해지면서 나타남
.fadeOut([속도], [가속도], [콜백])
.fadeToggle([속도], [가속도], [콜백])
.fadeTo(속도, 불투명도, [가속도], [콜백]) // 특정 불투명도로 변함

.slideDown([속도], [가속도], [콜백]) // 아래로 슬라이드되면서 나타남
.slideUp([속도], [가속도], [콜백])
.slideToggle([속도], [가속도], [콜백])

.animate({스타일}, [속도], [가속도], [콜백]) // 특정 스타일로 옵션에 의해 변함
.stop([clearQueue], [jumpToEnd])
// clearQueue : true로 하면 큐에 쌓여있는 효과도 모두 제거
// jumpToEnd : true로 하면 효과를 즉시 완료시킴
```

> 효과를 chaining하면 순서대로 실행됨.



# HTML API

### Get, Set

```javascript
.html([텍스트노드]) // 텍스트노드 get, set
.text([문자열]) // 문자열 get, set
.val([값]) // form field의 값 get, set
.attr(속성, [값]) // 속성 get, set
.prop(프로퍼티, [값]) // 프로퍼티 get, set
```

### 추가

```javascript
.prepend(텍스트노드) // 객체 안 내용 앞에 텍스트노드 삽입
.append(텍스트노드) // 객체 안 내용 뒤에 텍스트노드 삽입
.before(텍스트노드) // 객체 앞에 텍스트노드 삽입
.after(텍스트노드) // 객체 뒤에 텍스트노드 삽입
```

### 제거

```javascript
.remove([선택자]) // 객체 제거(자식 포함). [옵션] 필터링
.empty([선택자]) // 객체 안 텍스트노드 제거 [옵션] 필터링
```

### CSS

```javascript
.css(속성, [값]) // style 속성 get, set
.addClass(클래스명) // 클래스 추가(클래스에 CSS를 지정하여 사용)
.removeClass(클래스명) // 클래스 제거
.toggleClass(클래스명)
```

### 크기

```javascript
.width() // element 크기 get, set
.height()
.innerWidth() // element + padding
.innerHeight()
.outerWidth() // element + padding + border
.outerHeight()
.outerWidth(true) // element + padding + border + margin
.outerHeight(true)
```



# 추적 API

### 조상

```javascript
.parent([선택자]) // 부모 요소[필터링]
.parents([선택자]) // 모든 조상 요소[필터링]
.parentsUntil([선택자], [필터]) // 선택한 요소 전까지의 조상 요소[필터링]
```

### 후손

```javascript
.children([선택자]) // 자식 요소[필터링]
.find(선택자) // 후손 요소 중 선택. "*" : 모든 후손
```

### 형제

```javascript
.siblings([선택자]) // 형제 요소[필터링]
.next([선택자]) // 바로 아래 형제 요소
.nextAll([선택자]) // 아래의 모든 형제 요소
.nextUntil([선택자], [필터]) // [선택자 전까지][필터를 통과한] 아래의 모든 형제요소
.prev([선택자])
.prevAll([선택자])
.prevUntil([선택자], [필터])
```

### 필터링

```
.first() : 첫번째 요소
.last() : 마지막 요소
.eq(n) : n번째 요소
.filter(셀렉터) : 셀렉터를 통과한 요소
.not(셀릭터) : 셀릭터를 제외한 요소
```



# 이벤트 종류

### 마우스

- click
- dblclock
- mouseenter
- mouseleave
- hover

### 키보드

- keypress
- keydown
- keyup

### form

- submit
- change
- focus
- blur
- focusin
- focusout

### Document, Window

- load
- unload
- resize
- scroll



# 이벤트 등록, 제거

### on

> 엘리먼트에 이벤트 등록(여러 이벤트 등록 가능)

```javascript
.on(이벤트, [셀렉터], [데이터], 핸들러함수)
```

- 셀렉터 : 셀렉터로 대상 필터링
- 데이터 : 핸들러 함수로 전달될 데이터 설정

### off

> 엘리먼트에 등록된 이벤트 제거

```javascript
.off([이벤트], [셀렉터], [핸들러])
```

- 이벤트 : 특정 이벤트 타입 제거
- 셀렉터 : 대상 필터링
- 핸들러 : 이벤트 타입의 특정 핸들러 제거

### 한번에 여러 이벤트 등록

##### 방법 1

```javascript
$("#target").on("이벤트1 이벤트2", function(e){});
```

##### 방법 2 : Chaining

```javascript
$("#target").on("이벤트1", function(e){}).on("이벤트2", function(e){});
```

##### 방법 3 : 객체

```javascript
$("#target").on(
	{
		"이벤트1" : function(e){},
		"이벤트2" : function(e){}
	}
);
```



# 문서 로드 완료

```javascript
$(document).ready(function() {
	// 로드 완료 후 실행할 코드
});
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





------

##### References

- 생활코딩 : https://opentutorials.org/course/1
- w3schools : https://www.w3schools.com/