# CSS 파일 외부에서 가져오기

```html
<!--방법 1-->
<link rel="stylesheet" type="text/css" href="파일명.css">
<!--방법 2-->
<style>
    @import url("파일명.css")
</style>
```



# 선택자

### 태그 선택자

```css
p {}
```

### 클래스 선택자

```css
.클래스명 {}
```

### 아이디 선택자

```css
#아이디 {}
```

### 복수 선택자

```css
p, div {}
```

### 조상 자손 선택자

```css
div p {}
```

### 부모 자식 선택자

```css
div > p {}
```

### 특정 속성을 가진 태그 선택자

```css
input[type="text"] {}
```

### 띄어쓰기 단위로 구분된 단어를 포함하는 선택자

```css
img[alt~="이미지01"] {}
```

### 단어를 포함하는 선택자

```css
img[alt*="미지02"] {}
```

### 링크가 걸려 있는 상태

```css
a:link {
	color: black;
	text-decoration: none;
}
```

### 마우스를 올렸을 때(hand over)

```css
a:hover {
	text-decoration: underline;
}
```

### 클릭 했을 때

```css
a:active {}
```

### input에 포커스했을 때

```css
input:focus
```

### 링크를 방문했을 때

```css
a:visited {
	color: gray;
}
```

### 체크된 요소

```css
input[type="checkbox"]:checked {}
```



# 캐스케이딩

> 한 요소에 여러개의 스타일이 적용 됐을 때 우선순위
> style 속성 > id 선택자 > class 선택자 > 태그 선택자



# 속성

### 폰트

```css
font-size: 1rem; /* px는 고정값, rem(추천)은 html 태그의 폰트 크기를 따라감. */
font_weight: 600; /* 400: 기본값, 600: 굵은 글씨 */
font-style: 스타일; /* normal, italic */
text-align: 속성; /* left, right, center, justify(양쪽 정렬)*/
text-decoration : 속성; /* none, underline, overline, line-through */
color: 색깔명;
```

### 박스 모델(padding, margin)

```css
padding: 크기;
margin: 크기;
```

### 박스 사이징 

> 크기 지정을 무엇을 기준으로 할 것인지

```css
box-sizing : 속성;
```

- content-box : 기본값, 테두리 안의 사이즈
- border-box : 테두리를 포함한 사이즈

### display

```css
display: 속성;
```

- none : 요소를 없앰(공간까지 없앰)
- block : 화면 가로 전체를 차지
- inline  : 요소 크기만큼만 차지(width, height 지정 불가)
- inline-block : inline에 크기 지정 가능

### visibility

```css
visibility: visible | hidden;
```

### 배경

```css
background-color: red;
background-image: url("img.png");
background-repeat: no-repeat | repeat | repeat-x | repeat-y;
background-attachment: scroll | fixed; /* 페이지를 스크롤 할 때 */
background-position: left top | 10px 10px;
background-size: auto | cover | contain | 100px 100px;
/* 한 번에 입력 가능 */
background: red url("img.png") 0px 0px;
```

### 이미지 크기에 맞게 자르기

```css
img {
    object-fit: cover;
    width: 200px;
    height: 200px;
}
```

IE는 지원하지 않음.

### 위치(포지션)

```css
position: 속성;
```

- static : (기본값)정적인 위치. left, top을 지정해도 움직이지 않음.
- relative : 부모 요소를 기준으로 상대적으로 움직임.
- absolute : static이 아닌 부모 요소 안에서 절대적으로 움직임.
- fixed : 스크롤과 무관하게 움직임.

### 테두리

```css
border-style: none | hidden | solid | dotted | dashed | double;
border-width: thin | medium | thick | 1px;
border-color: 색깔명;
border: thin solid red; /* 한 번에 표현 가능 */
border-collapse: collapse; /* 테이블의 테두리 중복 없앰 */
```
### float, clear

> float : 요소를 위로 뜨게 하는 효과. 텍스트안에 이미지를 삽입할 때 주로 사용
> clear : 해당 요소는 float 속성을 무시하도록 함.

```css
float: left | right;
clear: both | left | right;
```

### 최소, 최대 크기

```css
min-width: 500px;
max-width: 500px;
```

### 컬럼(다단)

```css
column: 숫자; /* 컬럼 수 지정 */
column-width: 크기; /* 컬럼 크기 지정 : 지정된 크기를 유지한 채 여러 컬럼으로 나눔. 위 속성과 조합 가능 */
column-gap: 크기; /* 컬럼 간격 */
column-rule-style: solid; /* 구분선 */
column-rule-width: 5px;
column-rule-color: red;
column-span: all; /* 컬럼을 무시 */
```



### 영어 줄바꿈

```css
word-break: break-all;
```



-------------------------

##### References

- 생활코딩 : https://opentutorials.org/course/1
- w3schools : https://www.w3schools.com/