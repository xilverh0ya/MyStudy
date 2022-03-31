# 함수
## 함수란 입력값(Input)을 받아 어떻게 출력(Output)을 할 것인지?
## 입력과 출력이 없을 수 있다.

## 기본 구조
## def 함수명(매개변수 ) :
##     코드블럭
##     return 리턴 값


from re import A


def sum(a, b):
    result = a + b
    return result  # 함수를 호출했을 때의 함수의 기능을 하고 반환할 값


### 단순히 함수를 정의했다고 끝이 아님
### 함수는 호출 당했을 때 동작하므로
### 사용하려면 호출을 해줘야 한다.
print(sum(1, 3))
print()

### 입력값이 없는 경우 ex) list.pop()
def say():
    return "Hi"


print(say())
print()

### 출력값(return)이 없는 경우 ex) list.append(something)
def sum(a, b):
    print("{}, {}의 합은 {}입니다.".format(a, b, a + b))


sum(1, 2)
print()

### 입력값도 출력값도 없는 경우
def say():
    print("Hello")
    print()


say()

### 여러개의 입력값을 받는 경우
def sum_many(*args):  # *args를 쓰게 되면, 몇 개든 상관없이 입력받을 수 있다.
    sum = 0
    for i in args:
        sum = sum + i
    return sum


### 놀랍게도 *star 이렇게 써도 된다. 관습처럼 *args라고 쓰는 것.
def sum_many(*star):
    sum = 0
    for i in star:
        sum = sum + i
    return sum


def print_kwargs(**kwargs):  # **kwargs : dict 자료형의 key값들을 여러개 받을 수 있다.
    for k in kwargs.keys():
        if k == "name":
            print("당신의 이름은 : " + kwargs[k])


print_kwargs(name="int 조수", b="2")
print()

## 함수의 결과값은 언제나 하나이다.
def sum_and_mul(a, b):
    return a + b, a * b


print(sum_and_mul(1, 2))
### 두 개 인것 같지만? 튜플형태로 묶여서 나온 '하나의 결과값'이다.

## 초기값을 미리 설정할 수 있다.
def say_myself(name, old, man=True):
    print(f"나의 이름은 {name}입니다.")
    print(f"나이는 {old}살입니다.")
    if man:
        print("남자입니다.")
    else:
        print("여자입니다.")


say_myself("이은호", 28)
print()
say_myself("고세구", 25, False)
print()
### 함수의 입력값은 순서대로 해야한다.
# say_myself(28, "이은호") -> 오류
### 정 하고싶다면!
say_myself(old=26, name="주르르", man=False)  # 각각 어디로 들어가는지 알려주면 쓸 수 있다!
print()
### 그래서 초기값을 설정하려면 매개변수 중 가장 마지막에 넣는게 좋다.

## 함수 안에서 선언된 변수의 효력 범위(life cycle)
a = 1  # 전역변수 a # 상수할당 = Immutable


def vartest(a):  # 둘 다
    a = a + 1  # 지역변수 a : 이 함수에서만 효력이 있음


vartest(a)
print(a)
print()
### 전역변수 : 선언된 코드 전반에서 효력이 있음
### 지역변수 : 선언된 블럭 안에서만 효력이 있음

### 지역변수를 전역변수화 하는 법 1 : 재할당
def vartest(a):
    a = a + 1
    return a


a = vartest(a)  # 리턴값을 전역변수 a에 재할당
print(a)
print()

a = 1
### 지역변수를 전역병수화 하는 법 2 : global
def vartest():  # 여기서 a를 받으면 parameter오류가 발생한다.
    global a  # 전역변수 a를 쓸게요!
    a = a + 1


vartest()
print(a)
print()

## Lambda : 함수를 간편하게 표현하는 방법
# def add(a, b):
#    return a+b

add = lambda a, b: a + b
print(add(1, 2))
print()
### 위 함수는 간단하기도 한데 저런식으로 쓰지 못하는 함수도 존재
### ex) myList = [def adsf] -> 리스트 안에 함수를 정의하기는 불가능
### 하지만 lambda는 가능하다.
myList = [lambda a, b: a + b, lambda a, b: a * b]  # 리스트 안에 2개의 함수를 정의한 것.
print(myList[0](1, 2))  # myList에 정의된 첫 번째 함수를 호출
print(myList[1](1, 2))  # myList에 정의된 두 번째 함수를 호출
print()

b = [1, 2, 3]  # Mutable


def vartest2(b):
    b = b.append(4)


vartest2(b)
print(b)
## 전역변수여도 mutable하기 때문에 지역변수로도 영향을 줄 수 있다.
