# 헤드

### 인코딩

```html
<meta charset="utf-8">
```

### 아이콘

```html
<link rel="icon" href="이미지경로">
```



# 주요 태그

### 제목(headline) 

```html
<h1>test</h1>
<h2>test</h2>
...
<h6>test</h6>
```

### 단락(paragragh)

```html
<p>test</p>
```

### 구분선(horizontal ruel)

```html
<hr/>
```

### 줄바꿈(break)

```html
<br/>
```

### 공백(non-breaking space)

```html
&nbsp;
```

### 텍스트 형식

```html
<b>굵게</b>
<em>강조</em>
<i>Italic</i>
<mark>형광펜</mark>
<small>작게</small>
<del>취소선</del>
<ins>밑줄</ins>
<sub>아래첨자</sub>
<sup>위첨자</sup>
```

### 블록-레벨(block-level) 요소

```html
<div>block-level 요소</div>
```

### 인라인(inline) 요소

```html
<span>inline 요소</span>
```

### 테이블

```html
<table>
	<caption>제목</caption>
	<tr> <!-- 행(table row) -->
		<th>셀 헤더(table header)</th>
		<td>셀(table data)</td>
	</tr>
</table>
```

병합

```html
<td colspan="n">n개 열 병합</th>
<td rowspan="n">n개 행 병합</th>
```

### 이미지

```html
<img src="소스파일 위치" alt="이미지 설명" width="가로" height="세로">
```

### 링크

```html
<a href="링크 주소" target="열기 방식">링크 대상 요소</a>
```

열기 방식

- _self : 현재 창에서 열기
- _blank : 새 탭에서 열기
- _parent : 부모 창에서 열기

### iframe

```html
<iframe src="소스 주소" scrolling="no" width="가로" height="높이"></iframe>
```



# 리스트

### 순서 없는 리스트(unordered lists)

```html
<ul style="list-style-type:none">
    <li>Item</li>
    <li>Item</li>
    <li>Item</li>
</ul>
```

list-style-type : 글머리 스타일

- disc : 원
- circle : 가운데 빈 원
- square : 사각형
- none : 없음

### 순서 있는 리스트(ordered lists)

```html
<ol type="1">
    <li>Item 1</li>
    <li>Item 2</li>
    <li>Item 3</li>
</ol>
```

타입

- 1 : 1, 2, 3
- A : A, B, C
- a : a, b, c
- I : I, II, III, IV
- i : i, ii, iii, iv

### 정의 리스트(description lists)

```html
<dl>
    <dt>정의1</dt>
    <dd>정의에 대한 설명1</dd>
    <dt>정의2</dt>
    <dd>정의에 대한 설명2</dd>
</dl>
```



# 폼(form)

### 폼(form)

```html
<form action="submit시 연결 주소" method="get|post" target="열기 방식">
    폼 요소
</form>
```

### 입력(input)

```html
<input type="타입" name="submit시 이름" value="submit시 값" placeholder="값을 입력하세요.">
```

type 종류

- text, password, submit, reset, radio, checkbox, button, range, date, email, number

### 선택 박스(select)

```html
<select name="cars" size="1">
    <option value="volvo" selected>Volvo</option>
    <option value="saab">Saab</option>
    <option value="fiat">Fiat</option>
    <option value="audi">Audi</option>
</select>
```

### textarea

```html
<textarea name="message" rows="10" cols="30">
    The cat was playing in the garden.
</textarea>
```

input 태그처럼 submit 시 name과 value(태그안 내용) 전송



------

##### Reference

- 생활코딩 : https://opentutorials.org/course/1
- w3schools : https://www.w3schools.com/