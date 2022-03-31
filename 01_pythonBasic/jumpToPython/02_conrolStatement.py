# 제어문
# 제어문에는 조건문과 반복문이 있다.

# IF문
## 조건문 : 참과 거짓을 판단하는 문장
## if [조건문] :
##     코드 블럭
if False:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

##들여쓰기 매우 중요(4칸 들여쓰기)
##다른 프로그래밍에서는 그렇게 중요하지 않지만,
##파이썬은 들여쓰기로 포함관계를 확인하기 때문에
##들여쓰기 법칙을 꼭 지켜주어야 한다.
money = True
if money:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

##조건문에서 비교연산자를 사용할 때,
## > , < 을 무조건 먼저 쓰고 =를 써야함
## >=, <=
a = 1
b = 2
if a >= b:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

## and, or, not
### and : 조건문 모두 참이여야 참
if True and False:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

### or : 조건문 중 하나라도 참이면 참
if True or False:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

### not : 조건문의 반대 결과
if not False:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

## in
if 1 in [1, 2, 3]:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

if 1 not in [1, 2, 3]:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

## 조건문에서 아무일도 일어나지 않게 하려면? : pass
if 1 in [1, 2, 3]:
    pass  # 말 그대로 지나가라는 의미
else:
    print("걸어가라.")

## 다중 조건 판단 elif
pocket = ["paper", "cellphone"]
card = True

if "money" in pocket:
    pass  # 말 그대로 지나가라는 의미
elif card:
    print("택시를 타고 가라.")
else:
    print("걸어가라.")

## if 검사하고 False면 다음 조건문으로 넘어감
## 앞이 참이면 그대로 하나만 실행
if True:
    print("1")
elif True:
    print("2")
elif True:
    print("3")
elif True:
    print("4")
elif True:
    print("5")
elif True:
    print("6")
else:
    print("7")

## 조건부 표현식
### 타 언어의 '3항 연산자'와 같은 내용
score = 70
if score >= 60:
    message = "success"
else:
    message = "failure"
print(message)

##조건부 표현식으로 바꾸면!
message = "success" if score >= 60 else "failure"  # 성공일 때 실해문을 먼저 써준 뒤, 조건식을 써준다
print(message)

# 반복문


##while문
##디버깅을 하면서 어떻게 흘러가는지 확인해보기
treeHit = 0
while treeHit < 10:
    treeHit = treeHit + 1
    print("나무를 %d번 찍었습니다." % treeHit)
    if treeHit == 10:
        print("나무 넘어갑니다.")

##루프(loop)를 강제로 끝내는 법 (break)
coffee = 10
money = 300
while money:
    print("돈을 받았으니 커피를 줍니다.")
    coffee = coffee - 1
    print("남은 커피의 양은 %d개입니다." % coffee)
    if not coffee:
        print("커피가 다 떨어졌습니다. 판매를 중지합니다.")
        break  # 루프(loop)를 종료

## 루프(loop)의 처음으로 돌아가는 법 (continue)
a = 0
while a < 10:
    a = a + 1
    if a % 2 == 0:
        continue
    print(a)

## 무한루프
while True:
    print("안녕하세요")
    break  ## 다른 예제 수행을 위해 임시로 삽입
### 터미널 상에서 key보드 인터럽트 Ctrl + 'C'를 사용해서 강제로 멈출 수 있음

# for문
## 기본 구조
### for in List(또는 튜플, 문자열1) :
###     코드블럭
test_list = ["one", "two", "three"]
for i in test_list:
    print(i)
### 디버깅 해보면 i에 문자열 리스트 요소들이 하나씩 들어오는걸 확인할 수 있음

### 리스트안에 튜플이 들어있다?
### 하나씩 빼는 개념이기 때문에 어떠한 구조로 되어있던
### 하나씩 빼오게 된다. 그래서 이런것도 가능하다.
a = [(1, 2), (3, 4), (5, 6)]
for first, last in a:  # 리스트 안의 요소가 튜플이기 때문에 튜플로 받아온다.
    # 튜플을 쓸 때 변수 선언 방법 중 : (a, b) = (1, 2) 와 같은 개념
    # (first, last)로 쓰지 않은 이유 : 튜플은 괄호를 생략할 수 있다.
    print(first + last)

marks = [90, 25, 67, 45, 80]

number = 0
for mark in marks:
    number = number + 1
    if mark >= 60:
        print("%d번 학생은 합격입니다." % number)
    else:
        print("%d번 학생은 불합격입니다." % number)
print()
### 디버깅으로 플로우 확인하기

## 다른 언어에서의 for문과 가장 다른 점은
## 파이썬의 for문은 별도의 인덱스를 필요로 하지 않습니다.
## 리스트나 튜플 등 안에 있는 요소들을 하나씩 받아오는 개념입니다.

## for문의 처음으로 돌아가기 (continue)
marks = [90, 25, 67, 45, 80]

number = 0
for mark in marks:
    number = number + 1
    if mark < 60:
        continue
    print(f"{number}번 학생은 합격입니다.")
print()

## for문 탈출하기 (break)
marks = [90, 25, 67, 45, 80]

number = 0
for mark in marks:
    number = number + 1
    if mark < 60:
        break
print("{}번 학생은 불합격입니다.".format(number))
print()

## for문과 함께 자주 사용하는 range 함수
sum = 0

for i in range(1, 11):  # range(start : end + 1 : step)
    sum = sum + i

print(sum)
print()

## 중첩반복문
### 구구단 ver.가로출력
for i in range(1, 10):
    for j in range(2, 10):
        print(
            j, "*", i, "=", i * j, end="\t"
        )  # end="" : 출력의 마지막을 수정하는 옵션(Default : \n)
    print()
print()

###구구단 ver.세로 출력
for i in range(2, 10):
    print(i, "단")
    for j in range(1, 10):
        print(i, "*", j, "=", i * j)
    print()
print()

## 리스트 내포 (List comprehension)
a = [1, 2, 3, 4]
result = [num * 3 for num in a]
print(result)
print()

### 위 구문은 아래와 같은 의미이지만 list comprehension을 사용하여 한 줄로 줄이고 훨씬 직관적(사람언어 친화적)이다.
result = []
for num in a:
    result.append(num * 3)
print()

### 조건문을 포함할 수 있다.
result = [num * 3 for num in a if num % 2 == 0]  # num이 짝수일 때만 3을 곱해서 추가해라
print(result)
print()
