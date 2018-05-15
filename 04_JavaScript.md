# JavaScript 기본

## 숫자와 문자

작은따옴표나 큰따옴표로 감싸져있으면 string, 그렇지 않으면 number

```javascript
alert(typeof 1); // number 출력
alert(typeof "1"); // string 출력
```



## 변수

```javascript
var num = 1;
var name = "Kim";
```



## 비교

> == : 동등 연산자(데이터타입이 달라도 같은 값을 의미하면 같다고 처리)
> === : 일치 연산자(데이터타입까지 완전히 일치해야 같다고 처리) <- 사용하는 것 추천
> !=, !== 도 위의 관계와 같음

```javascript
1 == 1 		// true
1 == "1" 	// true
1 == true 	// true
1 === 1 	// true
1 === "1" 	// flase
1 === true 	// flase
```



## 조건문

#### if문

```javascript
if (조건문) {
    실행문
} else if (조건문) {
    실행문
} 
...
else {
    실행문
}
```

#### boolean의 대체제

```javascript
// true
1

// false
0
"" // 빈 문자열
undefined 
var a // 할당되지 않은 변수
null
NaN
```



## 반복문

#### while

```javascript
while (조건) {
	실행문
}
```

#### for

```javascript
for (초기화; 반복조건; 반복마다 실행되는 코드) {
    실행문
}
```

#### break, continue

- break : 반복문 중지
- continue : 실행을 중지하고 반복은 지속



## 함수

#### 형식

```javascript
function 함수명([인자, ...]) {
	실행코드;
	[return 반환값;]
}
```

#### 정의와 호출

1. 일반적인 정의, 호출

```javascript
// 정의
function hello() {
    alert("Hello");
}
// 호출
hello();
```

2. 변수에 정의, 호출

```javascript
// 정의
var hello = function() {
    alert("Hello");
}
// 호출
hello(); // 변수이지만 호출하려면 ()을 붙여야 한다.
```

3. 익명함수

```javascript
(function() {
    alert("Hello");
})();
```



## 배열

#### 배열 생성

```javascript
// 방법 1
var member = ["Kim", "Lee", "Park"];

// 방법 2
var member = [];
member[0] = "Kim";
member[1] = "Lee";
member[2] = "Park";

// 방법 3
var member = new Array();
member[0] = "Kim";
member[1] = "Lee";
member[2] = "Park";
```

#### 배열 크기

```javascript
.length;
```

#### 원소 추가

```javascript
.push(값); // 뒤에 추가
.unshift(값); // 앞에 추가
arr1.concat(arr2); // 배열1 뒤에 배열2 추가하여 리턴(원본은 변화 x)
```

#### 원소 제거

```javascript
.pop(); // 마지막 데이터 삭제
.shift(); // 첫번째 데이터 삭제
```

#### 기타 함수

```javascript
.splice(시작점, 개수, [데이터 ...]); // 특정 구간 제거 후 리턴. [옵션] 데이터 추가
.slice(시작점, [마지막점]); // 특정 구간 추출
.sort(); // 정렬
.reverse(); // 역순 정렬
```

#### 반복 작업

```javascript
// 방법 1
for (var i = 0; i < arr.length; i++) {
    실행문
}

// 방법 2
for (item in arr) {
    실행문
}

// 방법 3
arr.forEach(function(item, index) {
    실행문
});
```



## 객체

#### 객체 생성

방법 1

```javascript
// 방법 1
var grades = {"Kim": 100, "Lee": 80, "Park": 90};

// 방법 2
var grades = {};
grades["Kim"] = 10;
grades["Lee"] = 80;
gredes["Park"] = 90;

// 방법 3
var grades = new Object();
grades["Kim"] = 10;
grades["Lee"] = 80;
gredes["Park"] = 90;
```

#### 값 가져오기

```javascript
grades["Kim"];
grades.Kim;
```

#### 반복 작업

```javascript
var grades = {"Kim": 100, "Lee": 80, "Park": 90};
for (key in grades) {
    console.log(key + " : " + grades[key]);
    // grades.key는 에러
}
```



## 모듈

순수 자바스크립트에서는 모듈이라는 개념이 존재하지 않음. 자바스크립트가 구동되는 호스트 환경에서 모듈화 방법 제공.

#### 모듈의 사용

HTML

```html
<head>
	<script src="모듈.js"></script>
</head>
```

Node.js

```javascript
var circle = require('./node.circle.js');
```

#### 라이브러리

모듈이 프로그램을 구성하는 작은 부품으로서의 로직을 의미한다면, 라이브러리는 자주 사용되는 로직을 재사용하기 편리하도록 잘 정리한 일련의 코드들의 집합을 의미

대표적으로, jQuery

```html
<head>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
```



## 정규표현식

Regular expression. 문자열에서 특정한 문자를 찾아내는 도구. 하나의 언어라고 할 수 있음.

#### 컴파일

검출하고자 하는 패턴을 만드는 일.  정규표현식 객체 생성에는 2가지 방법이 존재.

1. 정규표현식 리터럴

```javascript
var pattern = /a/;  // 정규표현식 객체
```

2. 정규표현식 객체 생성자

```javascript
var pattern = new RegExp('a');
```

#### 실행

- RegExp.exec()
  실행 결과 배열로 반환

```javascript
var pattern = /a/;
pattern.exec('abcdef');  // ["a"]
pattern.exec('bcedf');  // null

var pattern = /a./;
pattern.exec('abcdef');  // ["ab"]
```

- RegExp.test()
  존재 유무 반환(true, false)

```javascript
var pattern = /a/;
pattern.test('abcedf');  // true
pattern.test('bcdef');  // false
```

- String.match()
  RegExp.exec()와 비슷. 순서가 반대.

```javascript
var pattern = /a/;
var str = 'abcedf';
str.match(pattern);  // ["a"]
```

- String.replace()
  문자열 치환 후 반환

```javascript
var pattern = /a/;
var str = 'abcdef';
str.replace(pattern, 'A');  // "Abcdef"
```

#### 옵션

- i
  대소문자를 구분하지 않음

```javascript
var xi = /a/;
"Abcde".match(xi);  // null

var oi = /a/i;
"Abcde".match(oi);  // ["A"]
```

- g
  모든 결과 반환(global)

```javascript
var xg = /a/;
"abcda".match(xg);  // ["a"]

var og = /a/g;
"abcda".match(og);  // ["a", "a"]
```

- 여러개 옵션

```javascript
var ig = /a/ig;
"AbcdAa".match(ig);  // ["A", "A", "a"]
```

#### 예제

- 캡처
  문자열을 그룹지어 처리하는 것.

```javascript
var pattern = /(\w+)\s(\w+)/;
var str = "coding everybody";
str.replace(pattern, "$2, $1");  // "everybody, coding"
```

() : 그룹핑
\w : 문자(word) a~z, A~Z, 0~9
\w+ : 문자 1글자 이상(단어)
\s : 공간(space)
(\w+)\s(\w+) : 단어 단어
$1 : 첫번째 그룹

- 치환
  URL을 찾아 html 태그로 치환하는 코드

```javascript
var urlPattern = /\b(?:https?):\/\/[a-z0-9-+&@#\/%?=~_|!:,.;]*/gim;
var content = '생활코딩 : http://opentutorials.org/course/1 입니다. 네이버 : http://naver.com 입니다. ';
var result = content.replace(urlPattern, function(url){
    return '<a href="'+url+'">'+url+'</a>';
});
console.log(result);
```

결과

```html
생활코딩 : <a href="http://opentutorials.org/course/1">http://opentutorials.org/course/1</a> 입니다. 네이버 : <a href="http://naver.com">http://naver.com</a> 입니다.
```





# 함수지향

## 유효범위(Scope)

> JavaScript에서 유효범위는 {}가 아니라 함수이다.
> 함수 안에 선언된 지역변수는 함수 밖에서 접근할 수 없지만,
> for, if문 등에서 {}안에 선언된 변수는 {} 밖에서도 접근 가능하다.

```javascript
for(var i = 0; i < 1; i++){
	var num = 1;
}
console.log(num); // 1 출력
```



### 정적 유효범위

> 함수가 선언된 시점에서의 유효범위를 가진다.

```javascript
var i = 5;

function a(){
    var i = 10;
    b();
}

function b(){
    console.log(i);
	/*
	i가 함수 b에 없다.(지역변수가 아니다.)
	이때, 함수 b를 호출한 함수 a에서 i를 참조하는 것이 아니라,
	함수 b를 선언했을 때의 변수인 전역변수 i를 참조한다.
	*/
}

a(); // 5출력
```



# 객체지향



##### References

- 생활코딩 : https://opentutorials.org/course/1