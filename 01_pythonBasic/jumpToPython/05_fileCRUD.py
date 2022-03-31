# 파일 생상
f = open("newFile.txt", "w")  # w : write(쓰다) - 파일에 내용을 작성할 때
# f = open("newFile.txt", "r")  # r : read(읽다) - 파일을 읽기만 할 때
# f = open("newFile.txt", "a")  # a : append(추가하다) - 파일의 마지막에 새로운 내용을 추가 시킬 때
f.close()

## 모드를 섞어서 쓸 수 있다.

##파일에 내용을 써보기
### 절대주소 : 처음부분부터 주소를 써주는 것. ex) C:/ITStudy/01_pythonBasic/jumpToPython/newFile.txt
### 상대주소 : 현재 실행하는 파일을 기준으로 상대적인 경로를 써주는 것.
f = open("newFile.txt", "w", encoding="UTF-8")
for i in range(1, 11):
    data = f"{i}번째 줄입니다.\n"
    f.write(data)
f.close()
#### 이런식으로 크롤링도 가능하다!

## readline()
f = open("newFile.txt", "r", encoding="UTF-8")
line = f.readline()  # 한 줄씩 읽어옴
print(line)
f.close()

## 여러줄을 읽어오기
f = open("newFile.txt", "r", encoding="UTF-8")
while True:
    line = f.readline()
    if not line:
        break  # line이 없으면 loop를 탈출
    print(line)
f.close()

## readlines()
f = open("newFile.txt", "r", encoding="UTF-8")
lines = f.readlines()  # 파일의 모든 라인을 읽어옴 -> 리스트 형태로 저장
for line in lines:  # 리스트기 때문에 for문을 사용해서 출력
    print(line, end="")  # or print(line, strip("\n"))   # strip은 양쪽 끝에서 특정 문자를 제거해주는 함수
    # print(line.strip("\n"), end=" ")  # 파일 내용을 한 줄로 출력
f.close()

## read()
f = open("newFile.txt", "r", encoding="UTF-8")
data = f.read()  # 파일을 통채로 읽어옴
print(data)
f.close()

### write 모드와 append 모드의 차이
### write는 기존의 파일 내용을 모두 지우고 처음부터 작성
### append는 기존내용에 이어서 작성

## with문과 함께 사용하기
with open("foo.txt", "w", encoding="UTF-8") as f:
    f.write("Life is too short, you need python")
### 별도로 close()를 안해줘도 됨! : 코드 블럭이 끝나면 저절로 닫힘

#
