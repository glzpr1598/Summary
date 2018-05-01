# 변수

```javascript
var num = 1;
var name = "Kim";
```



# 비교

> == : 동등 연산자(데이터타입이 달라도 같은 값을 의미하면 같다고 처리)
> === : 일치 연산자(데이터타입까지 완전히 일치해야 같다고 처리) <- 사용하는 것 추천

```javascript
1 == 1 		// true
1 == "1" 	// true
1 == true 	// true
1 === 1 	// true
1 === "1" 	// flase
1 === true 	// flase
```



# forEach 문

```javascript
배열.forEach(function(item, index){
    
});
```



# 함수

```javascript
function 함수명([인자 ...]) {
	실행코드;
	[return 반환값;]
}
```



# 배열

### 배열 생성

```javascript
var arr1 = [];
var arr2 = new Array();
```

### 데이터 넣기

```javascript
arr1 = [1, 2, 3, 4];
arr2[0] = "A";
```

### 배열 크기

```javascript
arr.length;
```

### 데이터 추가

```javascript
arr.push(값); // 뒤에 추가
arr.unshift(값); // 앞에 추가
arr1.concat(arr2); // 배열1 뒤에 배열2 추가하여 리턴(원본은 변화 x)
```

### 데이터 삭제

```javascript
arr.pop(); // 마지막 데이터 삭제
arr.shift(); // 첫번째 데이터 삭제
```

### 기타 함수

```javascript
arr.splice(시작점, 개수, [데이터 ...]); // 특정 구간 제거 후 리턴. [옵션] 데이터 추가
arr.slice(시작점, [마지막점]); // 특정 구간 추출
```



# 객체

### 객체 생성

```javascript
var obj1 = {};
var obj2 = new Object();
var obj3 = {"Kim": 100, "Lee": 80, "Park": 90};
```

### 데이터 추가

```javascript
obj1.color = "blue";
obj2["color"] = "blue";
```



# 유효범위(Scope)

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



------

##### References

- 생활코딩 : https://opentutorials.org/course/1