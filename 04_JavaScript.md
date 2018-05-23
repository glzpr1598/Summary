# JavaScript 기본

## 숫자와 문자

작은따옴표나 큰따옴표로 감싸져있으면 string, 그렇지 않으면 number

```javascript
typeof 1; // number
typeof "1"; // string
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
/* true */
1

/* false */
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

#### 지역변수와 전역변수

함수안에서 var를 쓰지 않으면 전역변수에 접근한다.
var를 쓰는 것을 습관화!

```javascript
var vscope = 'global';
function fscope(){
    vscope = 'local';  // 전역변수의 값을 'local'로 변경
    alert('함수안 '+ vscope);  // local 출력
}
fscope();
alert('함수밖 '+ vscope);  // global이 아닌 local 출력!!
```

JavaScript에서 유효범위는 {}가 아니라 함수이다.
함수 안에 선언된 지역변수는 함수 밖에서 접근할 수 없지만,
for, if문 등에서 {}안에 선언된 변수는 {} 밖에서도 접근 가능하다.

```javascript
for(var i = 0; i < 1; i++){
	var num = 1;
}
console.log(num); // 1 출력
```

####  전역변수의 사용

불가피하게 전역변수를 사용해야하는 경우, 객체를 전연변수로 만들어 관리

```javascript
MYAPP = {}
MYAPP.calculator = {
    'left' : null,
    'right' : null
}
MYAPP.coordinate = {
    'left' : null,
    'right' : null
}
 
MYAPP.calculator.left = 10;
MYAPP.calculator.right = 20;
function sum(){
    return MYAPP.calculator.left + MYAPP.calculator.right;
}
console.log(sum());
```

전역변수를 완전히 사용하고 싶지 않다면 익명함수 활용(라이브러리에서 모듈화를 위해 많이 사용하는 방법)

```javascript
(function(){
    var MYAPP = {}
    MYAPP.calculator = {
        'left' : null,
        'right' : null
    }
    MYAPP.coordinate = {
        'left' : null,
        'right' : null
    }
    MYAPP.calculator.left = 10;
    MYAPP.calculator.right = 20;
    function sum(){
        return MYAPP.calculator.left + MYAPP.calculator.right;
    }
    document.write(sum());
}())
```

#### 유효범위의 대상

자바스크립트는 함수에 대한 유효범위만을 제공(블록이 아님!)

```javascript
for (var i = 0; i < 1; i++) {
    var name = 'coding everybody';
}
console.log(name);  // coding everybody 출력됨!
```

#### 정적 유효범위

자바스크립트는 함수가 선언된 시점에서 유효범위를 가진다.

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



## 값으로서의 함수와 콜백

#### 값으로서의 함수

자바스크립트에서는 함수도 객체이다. 즉, 일종의 값이다.

```javascript
function a(){}
```

위에서 함수 a는 변수 a에 담겨진 값이다.

또한 함수는 개체의 값이 될 수 있다. 객체의 값으로 담겨진 함수를 메소드(method)라 한다.

```javascript
a = {
    b: function(){}
}
```

함수는 값이기 때문에 함수의 인자로 전달될 수도 있고, 반환값이 될 수도 있으며, 배열의 값으로도 사용될 수 있다.

#### 콜백

원래 함수의 인자로 함수를 전달하여 원래 함수의 동작을 바꿀 수 있다. 이때, 인자로 전달되는 함수를 콜백함수라 한다.

```javascript
function sortFunc(a,b){
    return a-b;
}
var numbers = [20,10,9,8,7,6,5,4,3,2,1];
alert(numbers.sort(sortFunc));
// numbers.sort()만 하게되면 20과 10이 제대로 정렬되지 않음.
// 콜백함수를 전달하면 정렬할 때마다 콜백함수를 실행한다.
// 콜백함수가 1을 반환하면 a를 큰수로 정렬한다.
```

콜백은 비동기처리에서도 사용된다. 어떤 작업이 완료된 후에 처리해야 할 일을 콜백으로 지정하여 사용한다.



## 클로저

클로저는 내부함수가 외부함수의 맥락(context)에 접근할 수 있는 것을 의미한다.

#### 내부함수

함수 안에서 또 다른 함수를 선언할 수 있다. 내부함수는 외부함수의 지역변수에 접근할 수 있다.

#### 클로저

클로저란 내부함수가 외부함수의 지역변수(맥락)에 접근할 수 있고, 외부함수는 외부함수의 지역변수를 사용하는 내부함수가 소멸될 때까지 소멸되지 않는 특성을 의미한다.

```javascript
function outter(){
    var title = 'coding everybody';  
    return function(){        
        alert(title);
    }
}
inner = outter();  // 내부함수 반환, outter는 함수가 종료되었지만 내부함수가 소멸되지 않았기 때문에 소멸되지 않는다.
inner();  // cording everybody 출력
```

클로저를 이용한 객체 정의

```javascript
function factory_movie(title){
    return {
        get_title : function (){  // 클로저 이용
            return title;
        },
        set_title : function(_title){
            title = _title
        }
    }
}  // title은 private한 성질을 갖게됨.(직접 접근 불가)

ghost = factory_movie('Ghost in the shell');
matrix = factory_movie('Matrix');
 
alert(ghost.get_title());  // Ghost in the shell
alert(matrix.get_title());  // Matrix
 
ghost.set_title('공각기동대');
 
alert(ghost.get_title());  // 공각기동대
alert(matrix.get_title());  // Matrix
```

클로저 관련 주의해야 할 예제

```javascript
var arr = [];
for(var i = 0; i < 5; i++){
    arr[i] = function(){
        return i;  // 클로저
    }
}
for(var index in arr) {
    console.log(arr[index]());  // 5 5 5 5 5 출력됨..
    // i가 소멸되지 않고 5인 상태이므로 호출하면 5를 반환
}
```

0 1 2 3 4 를 출력하기 위해서는 아래와 같이 고쳐야 한다.

```javascript
var arr = [];
for(var i = 0; i < 5; i++){
    arr[i] = function(idx) {
        return function(){
            return idx;
        }
    }(i);
}
for(var index in arr) {
    console.log(arr[index]());  // 0 1 2 3 4 출력
}
```



## arguments

함수에는 arguments라는 유사 배열이 있다. 이 배열에는 함수를 호출할 때 입력한 인자가 담겨있다.

```javascript
function sum() {
    var i, _sum = 0;    
    for(i = 0; i < arguments.length; i++){
        document.write(i+' : '+arguments[i]+'<br />');
        _sum += arguments[i];
    }   
    return _sum;
}
document.write('result : ' + sum(1,2,3,4));
```

#### 매개변수의 수

함수명.length : 함수에 정의된 인자의 수
arguments.length : 실제 전달된 인자의 수

```javascript
function zero(){
    console.log(
        'zero.length', zero.length,
        'arguments.length', arguments.length
    );
}
function one(arg1){
    console.log(
        'one.length', one.length,
        'arguments.length', arguments.length
    );
}
function two(arg1, arg2){
    console.log(
        'two.length', two.length,
        'arguments.length', arguments.length
    );
}
zero();  // zero.length 0 arguments.length 0 
one('val1', 'val2');  // one.length 1 arguments.length 2 
two('val1');  // two.length 2 arguments.length 1
```



## 함수의 호출

#### 일반적인 방법

```javascript
function func() {}
func();
```

#### apply(), call()

```javascript
function sum(arg1, arg2) {
    return arg1 + arg2;
}
alert(sum.apply(null, [1,2]));
```

- 첫 번째 인자 : 함수가 실행될 맥락(contenxt)
- 두 번째 인자 : 인자로 전달할 배열

#### 예제

```javascript
o1 = {val1:1, val2:2, val3:3};
o2 = {v1:10, v2:50, v3:100, v4:25};
function sum(){
    var _sum = 0;
    for(name in this){
        _sum += this[name];
    }
    return _sum;
}
alert(sum.apply(o1));  // 6
alert(sum.apply(o2));  // 185
```

함수에서 this는 객체 자신을 의미한다. apply의 첫 번째 인자가 함수를 실행한 맥락이므로, this는 이를 의미한다.

o1에 sum 함수를 값으로 추가해도 비슷한 코드가 되지만, _sum을 출력할 때 함수도 출력하게 되므로 깔끔한 코드가 되지 못한다.



# 객체지향

## 생성자와 new

- 프로퍼티(Property) : 객체 내의 변수
- 메소드(Method) : 객체 내의 함수

```javascript
function Person(name) {
    this.name = name;
    this.introduce = function() {
        return 'My name is ' + this.name;
    }
}

var p1 = new Person('Kim');  // 함수에 new를 붙임.
console.log(p1.introduce());

var p2 = new Person('Lee');
console.log(p2.introduce());
```

일반적인 객체지향 언어에서 생성자는 클래스 소속이지만,
JavaScript에서 객체를 만드는 주체는 함수이다.



## 전역객체(Global object)

모든 전역변수와 함수는 window 객체의 프로퍼티이다.



## this

this는 함수 내에서 함수 호출 맥락(context)를 의미한다.
함수와 객체의 관계가 느슨한 자바스크립트에서 this는 이 둘을 연결시켜주는 실질적인 연결점의 역할을 한다. 

- 함수 호출 시 this -> window
- 메소드 호출 시 this -> 객체

#### aplly, call

함수의 메소드인 apply, call을 이용하면 this를 제어할 수 있다.

```javascript
var o = {};
var p = {};
function func(){
    switch(this){
        case o:
            document.write('o<br />');
            break;
        case p:
            document.write('p<br />');
            break;
        case window:
            document.write('window<br />');
            break;          
    }
}
func();  // window
func.apply(o);  // o (o 맥락에서 함수 실행)
func.apply(p);  // p
```



## 상속

```javascript
function Person(name){
    this.name = name;
}
Person.prototype.name=null;
Person.prototype.introduce = function(){
    return 'My name is '+this.name; 
}
 
function Programmer(name){
    this.name = name;
}
Programmer.prototype = new Person();  // Person 상속받음
Programmer.prototype.coding = function(){  // 새로운 메소드 추가
    return "hello world";
}
 
var p1 = new Programmer('egoing');
document.write(p1.introduce()+"<br />");  // My name is egoing (Person의 기능)
document.write(p1.coding()+"<br />");  // hello world (새로운 기능)
```



## Prototype

객체의 원형을 의미한다. prototype에 저장된 속성들은 생성자를 통해서 객체가 만들어질 때 그 객체에 연결된다.

```javascript
function Ultra(){}
Ultra.prototype.ultraProp = true;
 
function Super(){}
Super.prototype = new Ultra();
 
function Sub(){}
Sub.prototype = new Super();
 
var o = new Sub();
console.log(o.ultraProp);  // true
```

1. 객체 o에서 ultraProp를 찾는다.
2. 없다면 Sub.prototype.ultraProp를 찾는다.
3. 없다면 Super.prototype.ultraProp를 찾는다.
4. 없다면 Ultra.prototype.ultraProp를 찾는다.

prototype은 객체와 객체를 연결하는 체인의 역할을 한다. 이러한 관계를 prototype chain이라고 한다.



## 표준 내장 객체의 확장

#### 표준 내장 객체(Standart Built-in Object)

JavaScript가 기본적으로 가지고 있는 객체

- Object
- Function
- Array
- String
- Boolean
- Number
- Math
- Date
- RegExp

#### 배열 확장

```javascript
Array.prototype.rand = function(){
	// 0~5 사이의 난수를 발생시키고, 소수점 버림(floor)
    var index = Math.floor(this.length*Math.random());
    return this[index];
}
var arr = new Array('seoul','new york','ladarkh','pusan', 'Tsukuba');
console.log(arr.rand());
```

이렇게 하면 배열에 내장된 메소드인 것처럼 사용할 수 있다.



## Object

Object 객체는 가장 기본적인 형태를 가지고 있는 객체이다. 모든 객체는 Object 객체를 상속받는다.

아래는 Object 객체를 확장하여 모든 객체가 접근할 수 있는 API를 만든 예시이다.

```javascript
Object.prototype.contain = function(needle) {  // needle in a haystack
    for(var name in this){
        if(this[name] === needle){
            return true;
        }
    }
    return false;
}
var o = {'name':'egoing', 'city':'seoul'}
console.log(o.contain('egoing'));
var a = ['egoing','leezche','grapittie'];
console.log(a.contain('leezche'));
```

하지만 Object 객체는 모든 객체에 영향을 주기 때문에 확장하지 않는 것이 바람직하다.

확장 후에 아래 코드를 실행하면,

```javascript
for (var name in o) {
    console.log(name);
}
```

결과

```javascript
name
city
contain
```

기본 프로퍼티 외에 다른 프로퍼티가 있으면 개발자에게 혼란을 준다. 이를 구분하기 위해 포러퍼티가 해당 객체의 소속인지를 체크할 수 있는 hasOwnProperty를 사용하면 된다.

```javascript
for (var name in o) {
    if (o.hasOwnProperty(name)) {
        console.log(name);
    }
}
```

결과

```javascript
name
city
// contain은 o의 프로퍼티가 아니라 Object의 프로퍼티이므로 출력되지 않음.
```



## 데이터 타입

데이터 타입은 크게 두 가지로 구분할 수 있다. 원시 데이터 타입(primite type)과 참조 데이터 타입(referece type). 참조 데이터 타입은 객체이다.

#### 원시 데이터 타입

- 숫자
- 문자열
- boolean
- null
- undefined

#### 래퍼 객체(Wrapper object)

```javascript
var str = 'coding';
console.log(str.length);  // 6
```

문자열은 프로퍼티와 메소드가 있다.  하지만 객체가 아닌 원시 데이터 타입인 이유는 문자열 작업을 할 때 자바스크립트가 임시적으로 문자열 객체를 만들기 때문이다.

```javascript
var str = 'coding';
str.prop = 'everybody';
console.log(str.prop);  // undefined
```

str.prop을 하는 순간에는 내부적으로 String 객체가 만들어지지만, 바로 제거되기 때문에 undefined가 출력된다.

원시 데이터 타입과 관련한 필요한 기능을 제공하기 위해 원시 데이터 타입을 객체처럼 다룰 수 있도록 하기 위한 객체를 래퍼 객체라고 한다.

- String
- Number
- Boolean



## 참조

#### 복제

```javascript
var a = 1;
var b = a;
b = 2;
console.log(a);  // 1
```

#### 참조

```javascript
var a = {'id': 1};
var b = a;
b.id = 2;
console.log(a.id);  // 2
```

원시 데이터 타입은 값이 복제되지만, 참조 데이터 타입(객체)은 값을 참조한다.

#### 함수

원시 데이터 타입을 인자로 넘겼을 때

```javascript
var a = 1;
function func(b) {
    b = 2;
}
func(a);
console.log(a);  // 1
```

참조 데이터 타입을 인자로 넘겼을 때

```javascript
var a = {'id': 1};
function func(b) {
    b = {'id': 2};
}
func(a);
console.log(a.id);  // 1
// b를 새로운 객체로 대체하였기 때문에 1이 출력된다.
```

```javascript
var a = {'id': 1};
function func(b) {
    b.id = 2;
}
func(a);
console.log(a.id);  // 2
```



------

##### References

- 생활코딩 : https://opentutorials.org/course/743