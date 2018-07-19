/*
Ajax 페이징

1. 아래 코드 붙여넣기
<script src="./resources/paging/paging.js" type="text/javascript"></script>
<link href="./resources/paging/paging.css" type="text/css" rel="stylesheet">
<link href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" rel="stylesheet" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">

2. 페이징 버튼을 넣을 곳에 아래 코드 붙여넣기 
<div id="pagingArea"></div>

3. Ajax를 통해 list를 받아와서 $.paging(list, listCount, pageCount, func) 함수 호출
list : 페이징할 데이터 리스트 
listCount : 페이지당 데이터 개수
pageCount : 화면에 보여줄 페이지 개수
func : 리스트를 출력하는 함수
*/

(function ( $ ) {
    $.paging = function(list, listCount, pageCount, func) {

		// 해쉬 변경 이벤트
		$(window).on("hashchange", function() {
			var page = location.hash.substring(1);
			// 해쉬가 없으면 1페이지로
			if(page == "") {
				page = 1;
			}
			pagingPrint(page);
		})
    	
		// 최초 로드 시 해쉬 가져옴
		var page = location.hash.substring(1);
		// 해쉬가 없으면 1페이지로
		if(page == "") {
			page = 1;
		}
		
		// 해당 페이지 출력
		pagingPrint(page);
		
    	// 페이징하여 출력하는 함수
    	function pagingPrint(page) {
    		var totalCount;  // 총 데이터 수
    		var totalPage;  // 총 페이지 수
    		var startPage;  // 화면에 보여줄 시작 페이지
    		var endPage;  // 화면에 보여줄 마지막 페이지
    		var startNum;   // 페이지에서 보여줄 첫번째 글번호
    		var endNum;   // 페이지에서 보여줄 마지막 글번호
    		var nextPage;   // 다음 눌렀을 때 이동할 페이지
    		var prevPage;   // 이전 눌렀을 때 이동할 페이지
    		
    		/********************
    		 * 변수 계산
    		 ********************/
    		// 총 데이터 수
    		totalCount = list.length;
    		
    		// 총 페이지수(나누어 떨어질 때 마지막 페이지가 빈페이지로 표시되는 것 방지)
    		totalPage = parseInt(totalCount / listCount);
    		if (totalCount % listCount > 0) {
    			totalPage++;
    		}
    		// 총 페이지수보다 큰 페이지를 입력한 경우 처리
    		if (totalPage < page) {
    			page = totalPage;
    		}
    		
    		// 화면에 보여줄 시작 페이지
    		startPage = (parseInt((page - 1) / pageCount)) * pageCount + 1;
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
    		
    		
    		/********************
    		 * 리스트 출력
    		 ********************/
    		// 해당 구간 리스트 추출
    		var result = list.slice(startNum-1, endNum);
    		// 출력
    		func(result);

    		
    		/********************
    		 * 페이징 버튼 출력
    		 ********************/
    		// 초기화
    		$("#pagingArea").html("");
    		
    		// 맨앞
    		if (startPage > 1) {
    			$("#pagingArea").append("<a class='icon' href='#1'>&nbsp;<i class='fas fa-angle-double-left'></i>&nbsp;</a>");
    		}
    		
    		// 이전
    		if (startPage > 1) {
    			$("#pagingArea").append("<a class='icon prev' href='#"+prevPage+"'>&nbsp;<i class='fas fa-angle-left'></i>&nbsp;</a>");
    		}
    		
    		// 페이지 번호
    		for (var i = startPage; i <= endPage; i++) {
    			if (i == page) {  // 현재 페이지는 class='currPage' 부여
    				$("#pagingArea").append("<a class='currPage num' href='#"+i+"'>" + i + "</a>");
    			} else {
    				$("#pagingArea").append("<a class='num' href='#"+i+"'>" + i + "</a>");
    			}
    		}
    		
    		// 다음
    		if (endPage != totalPage) {
    			$("#pagingArea").append("<a class='icon next' href='#"+nextPage+"'>&nbsp;<i class='fas fa-angle-right'></i>&nbsp;</a>");
    		}
    		
    		// 맨뒤
    		if (endPage != totalPage) {
    			$("#pagingArea").append("<a class='icon' href='#"+totalPage+"'>&nbsp;<i class='fas fa-angle-double-right'></i>&nbsp;</a>");
    		}
    	};
    };
    
}( jQuery ));
