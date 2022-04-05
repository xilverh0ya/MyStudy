# 내가 프로그램을 만들 수 있을까?
## 문법 어느정도 알겠다.
## 하지만, 이런 지식으로 어떤 프로그램을 만들 수 있을까?

# 프로그램을 만들려면 가장 먼저 '입력'과 '출력'을 생각하라.
## 구구단 프로그램(함수) 만들기
## -n 입력하면 n단 출력
## 라는 예제가 있다면 필요한 것부터 정리를 해야한다.

"""
- 함수 이름은?
    : GuGu
- 입력 받는 값은?
    : 2
- 출력하는 값은?
    : 2, 4, 6, 8, ... , 18
- 결과는 어떤 형태로?
    : 리스트
"""


import string


def GuGu(n):
    result = []
    for i in range(1, 10):
        result.append(n * i)

    # i = 0
    # while(i < 10):
    #     result.append(n * i)
    #     i = i + 1
    # return result

    return result


print(GuGu(2))
print("============================================")
print()
## 3과 5의 배수 합하기
## 10 미만의 자연수에서 3과 5의 배수를 구하면
## 3, 5, 6, 9이다. 이들의 총합은 23이다.
## 1000미만의 자연수에서 3의 배수와 5의 배수의 총합을 구하라.
"""
- 입력 받는 값음?
    - 1 ~ 999 (1000 미만의 자연수)
- 출력하는 값은?
    - 3의 배수와 5의 배수의 총합
- 생각해 볼 것은>
    - 3의 배수와 5의 배수는 어떻게 찾지?
- 3의 배수와 5의 배수가 겹칠 때는 어떻게 하지?
"""
print("-------------------나의 풀이-------------------")
# 1. 3의 배수와 5의 배수가 겹칠 때의 경우를 고려하지 않음
# 2. 함수 이름 처음 시작이 소문자임(? Class가 대문자 시작 아님?)


def threeFive():
    sum = 0
    for i in range(1, 1000):
        if i % 3 == 0:
            sum += i
        if i % 5 == 0:
            sum += i
    return sum


print(threeFive())
print()
print("-------------------강의 풀이-------------------")
# while n < 1000:
#     print(n)
#     n += 1
result = 0
for n in range(1, 1000):
    if n % 3 == 0 or n % 5 == 0:
        result += n
print(result)
print("============================================")
print()

## 게시판 페이징하기
## 게시물의 총 건수와 한 페이지에 보여줄
## 게시물 수를 입력으로 주었을 때, 총 페이지 수를 출력하는 프로그램
"""
- 함수 이름은?
    : GetTotalPage
- 입력받는 값은?
    : 게시물의 총 건수(m), 한 페이지에 보여 줄 게시물 수(n)
- 출력하는 값은?
    : 총 페이지 수
"""
print("-------------------나의 풀이-------------------")
# 몫이 0일 떄를 고려하지 않음(몫이 0이여도 페이지는 1이 출력)
# 딱 나누어 떨어질 때를 고려하지 않음(30/10 -> 몫은 3, 3페이지 필요)


def divPage(total, post):
    return int(total // post)


print(divPage(5, 10))
print(divPage(15, 10))
print(divPage(25, 10))
print(divPage(30, 10))

print()
print("-------------------강의 풀이-------------------")


def getTotalPage(m, n):
    if m % n == 0:
        return m // n
    else:
        return m // n + 1


print(getTotalPage(5, 10))
print(getTotalPage(15, 10))
print(getTotalPage(25, 10))
print(getTotalPage(30, 10))
print("============================================")
print()

## 간단한 메모장 만들기
## 원하는 메모를 파일에 저장하고 추가 및 조회가 가능한
## 간단한 메모장을 만들어보자.
"""
- 필요한 기능은?
    : 메모 추가하기, 메모 조회하기
- 입력 받는 값은?
    : 메모 내용, 프로그램 실행 옵션
- 출력하는 값은?
    :memo.txt

ex) python memo.py -a "Life is too short"
"""
print("-------------------나의 풀이-------------------")


class Memo:
    def __init__(self):
        self.fileName = []
        self.stringArgs = []

    def addString(self, fileName, stringArgs):
        f = open(fileName, "w", encoding="utf-8")
        f.write(stringArgs)
        f.close()

    def openFile(self, fileName):
        f = open(fileName, "r", encoding="utf-8")
        data = f.read()
        print(data)
        f.close()


m = Memo()

m.addString("clPrac.txt", "Hi, I'm xilver")
m.openFile("clPrac.txt")
## 강의 풀이는 memo.py 참조

## 탭을 4개의 공백으로 바꾸기
"""
- 필요한 기능은?
    : 문서 파일 읽어 들이기, 문자열 변경하기
- 입력 받는 값은?
    : 탭을 포함한 문서 파일
- 출력하는 값은?
    : 탭이 공백으로 수정된 문서 파일
"""
# 강의 풀이는 tabto4.py 참조
# 실행 명령어 : python tabto4.py a.txt b.txt

## 하위 디렉토리 검색하기
## 특정 디렉토리부터 시작해서 그 하위 모든 파일
## 중 파이썬 파일(*.py)만 출력해주는
## 프로그램을 만들려면 어떻게 해야 할까?

# 강의 풀이는 sub_dir_search.py 참조

# 끝으로,
# 위의 예제들에 나오는 함수들(외부함수, 내부함수)을
# 외우는게 아닙니다. 이런게 있다는걸 알고 있으면
# 검색으로 충분히 풀 수 있습니다.
# 또한 문제 자체를 구글링해서 해결할 수 있습니다.
# 복붙하면서 개발하는게 국룰이다.
# 결국 연습해야할 것은 "찾아서 해결하는 법"
