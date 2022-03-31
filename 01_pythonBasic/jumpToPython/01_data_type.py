a = 1

print(type(a))

a = 3
b = 4

print(a + b)
print(a - b)
print(a * b)
print(a / b)

print(a // b)  # 몫 연산
print(a % b)  # 나머지 연산

print(a**b)  # a의 b 제곱

a = "Hello world"

print(type(a))

a = "Python's favrite food is perl"  # 문장부호의 중복 조심
a = "Python's favrite food is perl"  # 이스케이핑 문자 사용

print(a)

a = "Life is too short\nYou need Python"  # 이스케이핑 + n -> 개행문자

print(a)

# 문자열 더하기

a = "Python"
b = "is fun!"

print(a + b)
print(a * 100)

# 문자열 인덱싱

a = "Life is too short. You need Python"
print(a[2])
print(a[-1])

# 슬라이싱 a[Start : End : Step]

print(a[0:4])
print(a[::2])

# 문자열 포매팅 1 (%)

a = "I eat %d apples." % 3
print(a)

num = 10
day = "three"
a = "I ate %d apples. so I was sick for %s days." % (num, day)

print(a)

# %d => 정수, %f => 실수, %s => 문자열
# %s를 쓰면 int형, float형 등도 문자열로 바뀌어서 출력됨
# 따라서, %s를 사용하면 모두 출력이 가능함
# 하지만 올바른 flow를 이해하기 위해 맞춰서 쓰자!(연습 단계니까!)

# 문자열 포매팅 2 (.format 메소드 활용)

a = "asdf asdfr we asdf {} asdfawe".format("안녕")

print(a)

# 변수 이름을 줘서 사용할 수 있음

a = "asdf {age} asdfr we asdf {name} asdfawe".format(name="이은호", age=3)
# 꼭 순서대로 입력하지 않아도 알아서 변수 이름을 찾아서 들어감

# python 6.5 이상부터 가능한 포매팅

name = "이은호"
a = f"나의 이름은 {name}입니다."

print(a)

# 정렬과 공백

a = "%10d apples." % 3  # 10만큼의 공백을 준 뒤 출력(우측정렬)
print(a)

a = "%-10d apples." % 3  # 출력 후 10만큼의 공백을 출력(좌측정렬)
print(a)

a = "실수 %-10.4f 출력" % 3.42314234  # %[간격].[소수점 남기는 자리 수]f
print(a)

# 문자열 개수 세기(count)
a = "hobby"

print(a.count("b"))  # a에 b가 몇 개 들어있는지

# 위치 알려주기 1 (find)

print(a.find("b"))  # a에서 b가 어디에 있니? -> 인덱스 번호를 알려줌(가장 먼저 나오는)

# 찾는 요소가 없으면 -1 출력
print(a.find("ㅊ"))

# 위치 알려주기 2 (index)

print(a.index("b"))
# 쓰기에는 find가 더 편할 것 : index는 값이 없으면 ValueError를 Return하기 때문

# (join)

a = ",".join(["a", "b", "c"])  # 리스트의 요소들을 ,를 구분점으로 결합

print(a)

# 대/소문자 바꾸어 출력 -> (upper/lower)

a = "hobby"
print(a.upper())  # 모든 문자 대문자로 바꿔서 출력
print(a.lower())  # 모든 문자 소문자로 바꿔서 출력

# 양쪽 공백 지우기(strip)

a = "   hi   "
a.strip()

# 문자열 바꾸기 (replace)

a = "Life is too short!"
print(a.replace("Life", "Your leg"))

# 문자열 나누기 (split)

print(a.split())  # 띄어쓰기 기준으로 리스트 생성

# 리스트
##리스트를 왜 쓰냐?

a = "이은호"
b = "이은주"
c = "이민지"
d = "황병천"
e = "김진호"
f = "이중현"
g = "홍준표"

##이렇게 있으면 하나하나 찾기가 너무 힘듦
##리스트로 관리하면 엄청 편하다 이말이야!

##하나의 변수에 여러개의 데이터를 관리할 때
a = ["이은호", "이은주", "이민지", "황병천", "김진호", "이중현", "홍준표"]

print(a)

##리스트 안에 또 다른 리스트 생성 가능
a = ["이은호", ["이은주", "이민지"], "황병천", ["김진호", "이중현", "홍준표"]]

print(a)

# 리스트의 인덱싱

a = [1, 2, 3, 4, 5]

print(a[0])  # 리스트의 첫 번째 요소(1)
print(a[0] + a[2])  # 리스트의 첫 번째 요소와 세 번째 요소의 합(1 + 3)

# 리스트의 슬라이싱[이상 : 미만 : 간격]
##[Start : End - 1 : Step]

a = [1, 2, 3, 4, 5]

print(a[0:2])
print(a[:2])
print(a[2:])

# 리스트의 연산

a = [1, 2, 3]
b = [4, 5, 6]

print(a + b)
print(a * 3)

# 리스트의 값 수정하기

a = ["이은호", "이은주", "이민지"]
a[0] = "김동규"  # 리스트의 첫 번째 요소의 값을 변경
print(a)

##연속되게 수정하는 법
a[0:2] = ["xilver", "h0ya"]
print(a)

# 리스트의 값 삭제

a[0:2] = []
print(a)

##다른 방법 (del)
a = ["이은호", "이은주", "이민지"]
del a[0]
print(a)

# 리스트에서 사용하는 함수

##리스트에 요소 추가 (append)
a = [1, 2, 3]
a.append(4)
print(a)

# 리스트 정렬(sort)

##문자는 가나다 or abc 순
a = ["아이네", "릴파", "고세구", "주르르", "비챤", "징버거"]
a.sort()
print(a)

##숫자는 오름차순
b = [1, 25, 23]
b.sort()
print(b)


##뒤집기(reverse)
a.reverse()
print(a)

b.reverse()
print(b)

# 위치 반환(index)

a = [1, 5, 3]

print(a.index(5))

# 리스트에 요소 삽입(insert)

a = [1, 2, 3]
a.insert(0, 4)  # 0번째 인덱스에 4를 삽입
print(a)

# 리스트에 요소 삭제(remove)
a = [4, 1, 2, 3, 4]
a.remove(4)  # 리스트에서 4라는 값을 지워라(인덱스 순으로 맨 첫번 째 걸린 값 삭제)
print(a)
###나중에 반복문을 사용해서 여러개를 한꺼번에 지울 수 있음

# 리스트의 요소 꺼내기(pop)

a = [1, 5, 3]
print(a.pop())  # a 리스트 가장 끝 요소를 꺼냄
print(a)  # 꺼낸 요소는 리스트에서 찾을 수 없음

# 리스트에 포함된 요소의 개수 세기(count)

a = [1, 5, 3, 1, 1]
print(a.count(1))  # a 리스트에 1이란 값이 몇개나 있니?

# 리스트 확장(extend)

a = [1, 5, 3, 1, 1]
a.extend([2, 3])
print(a)

# 튜플
##리스트와 튜플은 거의 똑같다!
##리스트 = [] / 튜플 = ()
##리스트는 변경 가능! / 튜플은 변경 불가능!

t1 = (1, 2, "a", "b")
##에러(TypeError)
###del t1[0]
###t1[0] = 'x'
##튜플은 값을 변경할 수 없기 때문!


##튜플의 인덱싱, 슬라이싱
t1 = (1, 2, "a", "b")
print(t1[0])
print(t1[1:])

##튜플의 더하기 곱하기
t2 = (3, 4)
print(t1 + t2)
print(t1 * 3)

# 딕셔너리 자료형
##Hash, Map, Object, JSON이 딕셔너리 자료형
##엄청 많이 쓰이기 떄문에 중요한 자료형이다!
##연관 배열(Associative array) 또는 해시(Hash)라고도 불림
##단어 그대로 해석하면 사전이라는 뜻
##Key를 통해 Value를 얻는다.

dic = {"name": "Eric", "age": 15}
print(dic["name"])  # key를 사용해서 value를 얻을 수 있음!

##딕셔너리 쌍 추가하기
a = {1: "a"}
a[2] = "b"  # 딕셔너리 a에 key값 2와 value값 'b' 추가
print(a)

##딕셔너리 요소 삭제하기
del a[1]  # a 딕셔너리에서 key값이 1인 쌍 삭제
print(a)

###이를 통해 dic[n]에서 대괄호 안의 값은 인덱스 값이 아닌 key값임을 알 수 있음
###또한 딕셔너리에는 순서가 없음

##딕셔너리 만들 때 주의사항

###value는 같아도 되지만, key는 같으면 안됨!(key 중복 x)
###key가 같으면 계속해서 값이 갱신되어 마지막에 입력한 value값만 남음
dic = {1: "a", 1: "b"}
print(dic)

##key 객체 만들기
a = {1: "고세구", 2: "아이네", 3: "주르르", 4: "릴파"}
print(a.keys())  # a 딕셔너리의 key값들만 빼와서 리스트 형성
###key()아니고 keys()야!!!!

##value 객체 만들기
print(a.values())  # a 딕셔너리의 value값들만 빼와서 리스트 형성
###value() 아니고 values()

##key,value 쌍 얻어 객체 만들기
print(a.items())
###item() 아니고 items()

###위의 세 객체는 반복문(for문)을 사용하여 값을 뽑아낼 때 주로 사용 됨

##모두 지우기(clear)
a.clear()
print(a)

##key로 밸류 얻기(get)
a = {1: "고세구", 2: "아이네", 3: "주르르", 4: "릴파"}
print(a.get(1))
###a[key]와의 차이점
###a[key]는 없는 key를 입력하면 에러가 나지만
###get메소드는 없는 key를 입력하면 None을 Return해준다
###Default값 지정 가능
print(a.get(8, "없음"))  # 8이 없으면 '없음' Return

###in도 사용 가능
print(8 in a)  # bool 자료형으로 표시
print(1 in a)

# 집합 자료형
##집합에 관련된 것들을 쉽게 처리하기 위해 만들어진 자료형
##집합의 핵심 : 중복된 요소를 가질 수 없다. (원소가 고유하다.)
##순서가 없다(Unordered).
###순서가 없다? : 인덱싱을 통해 자료형의 값을 얻을 수 없다.

##집합 정의하는 법
s1 = set([1, 2, 3])  # 1.리스트를 set으로 형변환
s1 = {1, 2, 3}  # 2. {}를 사용
print(type(s1))
print(s1)

##어디에 쓰이나요? : 중복 제거할 때 진짜 많이 쓰입니다.
l = [1, 2, 2, 3, 3]
newList = list(set(l))  # set 형변환으로 중복 제거 후, 다시 list 자료형으로 형변환
print(newList)  # 중복이 제거된 list가 Return 됨.

##문자열도 가능
s1 = "Hello"
s2 = set("Hello")
print(s2)  # 중복이 제거되고, 순서가 뒤죽박죽인걸 확인할 수 있음

##교집합
s1 = set([1, 2, 3, 4, 5, 6])
s2 = set([4, 5, 6, 7, 8, 9])
print(s1 & s2)  # 각 집합 간, 중복된 요소 추출
print(s1.intersection(s2))  # intersection = 교집합

##합집합
print(s1 | s2)  # 각 집합의 요소를 중복을 제거하여 합침.
print(s1.union(s2))  # union = 합집합

##차집합
print(s1 - s2)  # s1에서 s2와의 교집합을 제거
print(s1.difference(s2))  # difference : 차집합

##값 1개 추가(add)
s1.add(7)  # 값을 추가만 해주고 Return은 없음 따라서
print(s1)  # 추가한 다음 출력해야 값이 나옴. print(s1.add(value)) -> 값이 추가만 되고 출력은 안됨!

##값 여러개 추가하기(update)
s1.update([7, 8, 9])
print(s1)

###추가할 때, 이미 집합안에 있는 값을 추가하면 추가안됨. why? : 집합은 중복을 허용하지 않으니까!

##특정 값 제거(remove)
s1.remove(7)
s1.remove(8)
s1.remove(9)  # 한 번에 하나씩만 지울 수 있음
print(s1)

# 불 자료형 (=불리언(boolean) 자료형)
##참/거짓을 판단하는 자료형
###python에서는 문자열, 리스트, 튜플, 딕셔너리 등에서 '값이 있으면' True로 인식

##굉장히 유용한 예제
a = [1, 2, 3, 4]
while a:  # a에 값이 있으면 계속해서 반복
    print(a.pop())  # a의 마지막 값을 하나씩 추출
    print(a)  # a안에 남아있는 값들을 출력

# Immutable vs Mutable
## Immutable : 변하지 않는 자료형
### 정수, 실수, 문자열, 튜플

## Mutable : 변할 수 있는 자료형
### 리스트, 딕셔너리, 집합

# 변수
##변수 : 자료형의 값을 저장하는 공간
##메모리에 저장
##변수에는 메모리의 주소가 담겨있고, 주소를 통해 메모리에 접근하여 메모리에 있는 값(객체)에 접근할 수 있다.
##단, 변수에 메모리 주소가 '저장되는 것은 아니다!', 그저 가리키는 것.
##변수를 만들 때는 '=(assignment)' 기호를 사용
##이때 '='은 '같다'의 의미가 아닌 '오른쪽의 값을 왼쪽의 변수에 대입한다(넣는다)'의 의미
##python에서 사용하는 변수는 객체를 가리키는 것
##객체 = 자료형이라고 보면 됨

# 복사 (얕은복사, 깊은복사)
##얕은 복사
###예시를 먼저 보자
a = [1, 2, 3]
b = a  # b에 a를 복사
a[1] = 4  # a의 값을 변경했는데
print(b)  # b의 값도 변경됐다?!?!
####b에 a의 값을 넣어준게 아니라, a의 주소값을 넣어줬기 때문에 완전한 복사가 이루어지지 않았다.
print(id(a))
print(id(b))  # 같은 주소를 바라보고 있음을 알 수 있다.
print(a is b)  # a 와 b가 같은 주소를 바라보고 있냐?

##그렇다면 어떻게 해야 복사를 할 수 있을까?

##깊은 복사
###첫 번째 방법 : 슬라이싱
a = [1, 2, 3]
b = a[:]  # b에 a의 처음부터 끝까지(인덱싱) 복사
a[1] = 4  # a의 값을 변경했는데
print(b)  # b의 값은 변경되지 않음!
####슬라이싱을 활요하면 새로운 [1, 2, 3]이라는 리스트가 생기기 때문에
####따로 저장이 됨. 말그대로 '복사'가 된다.
print(id(a))
print(id(b))  # 다른 주소를 바라보고 있음!
print(a is b)  # a 와 b가 같은 주소를 바라보고 있냐?

###두 번째 방법 : copy 모듈 사용
from copy import copy

a = [1, 2, 3]
b = copy(a)  # b에 copy모듈을 통해 a를 복사
a[1] = 4  # a의 값을 변경
print(b)  # b는 변경되지 않음!

print(id(a))
print(id(b))  # 다른 주소를 바라보고 있음!
print(a is b)  # a 와 b가 같은 주소를 바라보고 있냐?

##변수를 만드는 여러가지 방법
a, b = ("python", "life")  # 튜플을 통한 할당
(a, b) = "python", "life"  # 위와 같은 방식

a = b = "hello"

##파이썬에서 값을 교환하는 법
###보통의 방법
a = 3
b = 5

tmp = b  # 임시 저장소를 만들어 값을 잠시 보관
b = a  # b에 a의 값을 덮어 씀.(이를 위해 b의 값을 임시 저장소에 보관했던 것)
a = tmp  # 잠시 보관했던 값 다시 a에 대입

print(a)
print(b)

###하지만 킹갓python은?
a = 3
b = 5
a, b = b, a  # 튜플형식으로 변수 값 대입하여 값 교환

print(a)
print(b)
