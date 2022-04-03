# 클래스
## 클래스란?
## : 반복되는 변수 & 메서드(함수)를 미리 정해놓은 틀(설계도)
## 함수와의 차이점.
## 클래스는 instance라고 여러 variation을 찍어낼 수 있다.


class Calculator:  # class명은 대문자로 쓰는게 국룰
    def __init__(self):
        self.result = 0

    def add(self, num):
        self.result += num
        return self.result


cal1 = Calculator()
cal2 = Calculator()

print(cal1.add(3))
print(cal1.add(4))
print(cal2.add(3))
print(cal2.add(7))

## 클래스는 과자틀, 설계도다.


class FoulCaltest:
    pass  # 일단은 만들어졌는지 확인하기 위해 pass를 넣어 확인해 봄.


a = FoulCaltest()
print(a)
print(type(a))

## 클래스 안에 있는 함수를 메소드라고 부름.
class FoulCal:
    ### init의 뜻 : 맨 처음
    ### 예약어 중 하나로써 클래스 생성 시 무조건 맨 처음 수행됨.
    ### 맨 처음 실행되는 걸 생성자라고 함.
    ### 생성자를 실행할 때는 인자를 다 전달해줘야만 실행된다.
    def __init__(self, first, second):
        self.first = first
        self.second = second

    def setdata(self, first, second):
        self.first = first
        self.second = second

    def add(self):
        result = self.first + self.second
        return result

    def mul(self):
        result = self.first * self.second
        return result

    def sub(self):
        result = self.first - self.second
        return result

    def div(self):
        result = self.first / self.second
        return result


a = FoulCal(4, 2)  # 생성자때문에 first, second 값을 전달해줘야만 함 a = FoulCal() -> 오류
a.setdata(4, 2)  # a -> self, 4 -> first, 2 -> second
print(a.add())

# 클래스의 상속
## 이미 만들어진 클래스(설계도)에 살을 붙여서 변형하는 것.


class MoreFourCaltest(FoulCal):  # 부모 클래스(FoulCal)를 상속받은 자식 클래스(MoreFourCal)
    pass  # pass만 써도 부모 클래스의 메소드는 모두 이용 가능함.


## 상속은 왜 하나요?
## 클래스를 활용하기 위해서!
### 메소드 추가하기
class MoreFourCal(FoulCal):
    def pow(self):
        result = self.first**self.second
        return result


### 메소드 오버라이딩 : 부모의 함수를 덮어쓴다!(Overriding) 자식 클래스가 우선 (자식이기는 부모 없다...)
class SafeFourCal(FoulCal):
    def div(self):
        if self.second == 0:
            return 0
        else:
            return self.first / self.second


## 클래스 변수 : 클래스안에 직접 정의, 클래스 전체에 공통적으로 적용
class ClassVarTest:
    first = 2
    second = 3


## 객체 변수 : 클래스 내부 함수에서 정의, 각각 객체(함수)마다 적용
class ObjectiVarTest:
    def __init__(self, first, second):
        self.first = first
        self.second = second


# 모듈 : 미리 만들어 놓은 .py 파일 (함수, 변수, 클래스 등)
import mod1  # mod1.py를 불러옴

print(mod1.add(1, 2))  # 다른 파일에 정의된 함수를 사용할 수 있는 모습

## 다른 방법!
from mod1 import add  # 이런 식으로 불러올 수도 있다. mod1파일에 있는 수 많은 함수 중 add라는 함수만 불러오겠다는 뜻.

## 장점 : 속도가 빠르다.
print(add(1, 2))  # add를 직접 불러왔기 떄문에 mod.add가 아닌 add를 쓰면 됨다.


## from 파일명 import 함수명을 더 자주 쓰는 이유
## import mod1을 했는데 mod1.py파일 안에 print("Hi")가 있다면
## import 해오면서 print("Hi")도 같이 실해하기 때문에
## 원치 않은 출력이 나올 수 있다.
## 이를 방지하기 위해 from 파일명 import 함수명 방식을 쓰는게 더 좋다.

## 다른 방법으로 mod1.py에
if __name__ == "__main__":  # __단어__ 이 형식은 보통 특별한 의미를 가지고 있다.(예약어일 확률 높음)
    print("Hello World")
## 를 추가해준다.
## 위 코드의 의미는, 현재 이 코드가 작성된 파일에서만 코드가 실행된다는 의미
## import된 mod1은 main이 아니기 때문에 다른 파일에서 불러오면 이 코드는 실행되지 않는다.

## 같은 디렉토리가 아닌 파일을 임포트하려면 path를 입력해줘야 함.
## sys.path.append 사용
import sys

sys.path.append("C:\\ITStudy\\01_pythonBasic\\jumpToPython")
import mod1

print(mod1.add(3, 4))

# 패키지 : 모듈을 여러개 합쳐놓은 것.
## 가상의 game 패키지 예
"""
game/
    __init__.py
    sonund/
        __init__.py
        echo.py
    graphic/
    __init__.py
    render.py
"""
## python 3.3 ver 이후로는 __init__을 굳이 안써도 된다고 함.
## 하지만 예전 버전과의 호환을 위해서 __init__을 써줌

### 위 패키지에서 echo.py 파일 안에 정의 된 echo_test()메소드를 불러온다고 하면,
### import game.sound.echo
### game.sound.echo.echo_test()

### 다른 예시
### from game.sound.echo import echo_test
### echo_test()

### 다른 예시2
### from game.sound.echo import echo_test as e
### e()

## *은 뭔가요?
### from game.sound import *
### game.sound에 있는 모든 파일을 import 한다는 의미.
### 단, __init__.py 파일에 __all__에 명시되어 있는 메소드, 함수들만을 가져오기 떄문에
### import할 폴더의 __init__.py파일에 __all__을 설정해줘야 함.

# relative 패키지 : 모듈안에서만 사용 가능! / 인터프리터에서 사용 시, 시스템 에러
## .. : 보통 경로에서 이전(상위, 부모) 폴더를 의미
## from game.sound.echo import echo_test
## ..sound.echo import echo_test    -> relative하게 import 했다..

# 예외처리 : 오류발생 시 어떻게 할 지 정하는 것.
## 기본 구조
"""
try:
    오류가 발생할 수 있는 구문
except Exception as e:
    오류 발생 시 실행
else:
    오류가 발생하지 않으면 실행
finally:
    무조건 마지막에 실행
"""
f = open("없는 파일", "r")  # 오류 발생
print("이은호 화이팅")  # 오류 발생으로 실행 안됨

try:
    4 / 0
except ZeroDivisionError as e:
    print(e)
print("이은호 화이팅")  # 오류 발생해도 예외처리해줬기 때문에 실행됨.

try:
    f = open("none", "r")
except FileNotFoundError as e:
    pass  # 특정 오류 발생 시, 그냥 통과시키는 방법. 종종 쓰인다.
else:
    data = f.read()
    print(data)
    f.close()

try:
    f = open("none", "r")
except Exception as e:  # 모든 오류(어떤 에러가 발생할 지 예상할 수 없을 떄 보통 사용)
    print(str(e))
finally:  # 오류가 나건, 안나건 무조건 마지막에 실행
    f.close()

## 일부러 오류 발생시키기
class Bird:
    def fly(self):
        raise NotImplementedError  # 일부러 에러를 발생시킴


class Eagle(Bird):  # Bird 클래스 상속받음
    def fly(self):  # 메소드 오버라이딩
        print("very fast")


eagle = Eagle()
eagle.fly()  # 자식이 이기기 때문에 오류발생 X, very fast 출력
### 보통 한 클래스의 메소드가 상속될 때 필수로 변형시키게 할 때 사용
### 오류를 피하기 위해 무조건 메소드 오버라이딩 해야함.
### 부모 클래스를 상속받는 자식 클래스는 반드시 특정 함수를 구현하도록 만들고 싶은 경우(강제로 그렇게 하고 싶은 경우)

# 내장함수(절대 외우지 마세요)
## 파이썬에서 기본적으로 포함하고 있는 함수
## ex) print(), type()...
"""
abs ; 절대값
all : 모두 참인지 검사
any : 하나라도 참이 있는가?
chr : ASCII 코드 입력받아 문자 출력
dir : 리스트, 딕셔너리 객체 관련 함수(메소드)를 보여줌
divmod : 몫과 나머지를 튜플로 돌려줌
enumerate : 열거하다, 순서가 있는 자료형을 입력받아 인덱스 값을 포함하는 enumerate 객체로 반환
eval : 실행 가능한 문자열(ex. "1+2"을 입력으로 받아 문자열을 실행한 결과값(ex.3)을 돌려주는 함수
filter(first, second) : first -> 함수, second -> first 함수에 들어갈 수 있는 반복 가능한 자료형
                        second가 first에 입력됐을 떄, 참인 값들만 반환
hex : 정수를 16진수로 변환
id : 객체를 입력받아 객체의 고유 주소값 반환
input : 사용자 입력을 받음
int : 문자열 형태의 숫자, 소숫점 숫자 등을 정수형태로 변환
isinstance : 인스턴스, 클래스를 순차적으로 받아 입력받은 인스턴스가 입력받은 클래스의 인스턴스이면 True, 아니면 False
len : 입력값의 길이(요소의 전체 개수)를 반환
list : 반복 가능한 자료형 s를 입력받아 리스트로 만들어 반환
map : 함수와 반복가능한 자료형을 입력받아, 입력받은 자료형의 각 요소를 함수가 실행한 결과를 묶어서 반환
max, min : 최소, 최대
oct : 정수를 8진수 문자열로 변환
open : 파일이름, 읽기 방법
pow : 제곱
ord : 문자의 ASCII 코드 값 반환
range : 범위 값을 반복 가능한 객체로 만들어 반환
round : 반올림
sorted : 정렬
str : 문자열 형태로 변환
sum : 더하기
tuple : 반복 가능한 자료형 입력받아 튜플형태로 변환
type : 입력갑의 자료형 판별
zip : 동일한 개수로 이루어진 반복가능한 자료형을 묶어줌
"""


def positive(x):
    return x > 0


list1 = [1, -1, 2, 0, -5, 6]
a = list(filter(positive, list1))  # list1의 요소들을 postive 함수에 하나씩 넣어 참인 값들만 반환
print(a)

# 외장함수 (마찬가지로 외우지 마세요)
## 라이브러리 함수, import 해서 쓰는 것.

"""
sys : 변수와 함수를 직접 제어할 수 있게 해주는 모듈
pickle : 객체의 형태를 유지하면서 파일에 저장하고 불러올 수 있게 해주는 모듈
OS : 환경 변수나 디렉터리, 파일 등의 OS 자원 제어할 수 있게 해주는 모듈
shutil : 파일을 복사해주는 파이썬 모듈
glob : 특정 디렉터리에 있는 파일 이름을 모두 알 수 있게 해주는 모듈
templefile : 파일을 임시로 만들어서 사용할 때 유용한 모듈
time : 시간과 관련된 모듈
random : 난수 발생시키는 모듈
webbrowser : 자신의 시스템에서 사용하는 기본 웹 브라우저를 자동으로 실행하는 모듈
"""
import pickle

f = open("test.txt", "wb")
data = {1: "python", 2: "you need"}
pickle.dump(data, f)  # 딕셔너리 객체인 data를 그대로 파일에 저장
f.close()

import time

print(time.time())  # 1970년 1월 1일 0시 0분 0초를 기준으로 지난 시간 초
time.sleep(1)  # 1초 쉬어라.(텀을 줘야할 떄)

# 내장함수나 외장함수나 외우지 말고
# 우리에게는 구글이 있습니다.
# 이런게 있구나... 만 알아두고
# 필요할 때 찾아서 쓰기!
