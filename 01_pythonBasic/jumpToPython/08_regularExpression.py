# 정규 표현식이란?
# 복잡한 문자열을 처리할 때
# 사용하는 기법, 모든 언어 공통

# 정규 표현식은 왜 필요한가?

## 이런 문제가 있다고 가정해보자.
"""
park    800905-1049118
kim     700905-1059119
...

이런 식으로 이름과 주민등록번호가 있다.
주민등록번호의 뒷자리를 보안사항으로 *로 모두 바꿔주고 싶다.
이를 기존 프로그래밍 코드를 이용해서 작성해본다면?
"""

data = """
park 800905-1049118
kim 700905-1059119
"""

result = []
for line in data.split("\n"):  # 한줄 한줄 마다 잘라서 line에 하나씩 넣어줌
    word_result = []
    for word in line.split():  # line에 저장된 문자열은 공백으로 잘라서 word에 하나씩 넣어줌
        if (
            len(word) == 14 and word[:6].isdigit() and word[7:].isdigit()
        ):  # word의 문자가 14자리이고, 앞 6자리와 뒤 7자리가 숫자라면
            word = word[:6] + "-" + "*******"  # 앞 6자리는 그대로 두고, 뒷자리는 "*******"로 바꿔줌
        word_result.append(word)  # 바뀐 주민등록번호를 word_result 리스트에 담아줌
    result.append(" ".join(word_result))
print("\n".join(result))

## 이 문제를 정규표현식으로 처리한다면?
import re

data = """
park 800905-1049118
kim 700905-1059119
"""

pat = re.compile("(\d{6})[-]\d{7}")
print(pat.sub("\g<1>-*******", data))
### 이래서 정규표현식을 씁니다!

# 이렇게 문자열에 관련된 복잡한 문제를 해결해야 될 때,
# 정규 표현시을 사용하게 되면, 짧고 간결하게 문제를 해결할 수 있게 해줍니다.

## 문자클래스 []
## [abc]
## - [] 사이의 문자들과 매치하는지 검사
## - "a"는 정규식과 일치하는 문자인 "a"가 있으므로 매치
## - "before"는 정규식과 일치하는 문자인 "b"가 있으므로 매치
## - "dude"는 정규식과 일치하는 문자인 a, b, c 중 어느 하나도 포함하고 있지 않으므로 매치되지 않음
## - 하이픈을 사용하여 From-To로 표현 가능
##      - ex) [a-c] = [abc], [0-5] = [012345]

## Dot(.)
## a.b
## - 줄바꿈(\n)을 제외한 모든 문자와 매치
## - "aab"는 가운데 문자 "a"가 모든 문자를 의미하는 "."과 일치하므로 정규식과 매치
## - "a0b"는 가운데 문자 "0"이 모든 문자를 의미하는 "."과 일치하므로 정규식과 매치
## - "abc"는 "a"문자와 "b"문자 사이에 어떤 문자라도 하나는 있어야 하는 이 정규식과 일치하지 않으므로 매치되지 않는다.

## 반복 1 (*)
## ca*t
## - "ct"는 "a"가 0번 반복되어 매치
## - "cat"는 "a'"가 0번 이상 반복되어 매치(1번 반복)
## - "caaat"는 "a"가 0번 이상 반복되어 매치(3번 반복)

## 반복 2 (+)
## ca+t
## - "ct"는 "a"가 0번 반복되어 매치되지 않음 (*과의 차이점)
## - "cat"는 "a'"가 1번 이상 반복되어 매치(1번 반복)
## - "caaat"는 "a"가 1번 이상 반복되어 매치(3번 반복)

## 반복 3 ({m,n}, ?)
## ca{2}t <- "a"가 2번 반복되면 매치
## - "cat"는 "a"가 1번만 반복되어 매치되지 않음
## - "caat"는 "a"가 2번 반복되어 매치
## ca{2, 5}t <- a가 2~5번 반복되면 매치
## - "cat"는 "a"가 1번만 반복되어 매치되지 않음
## - "caat"는 "a"가 2번 반복되어 매치
## - "caaaaat"는 "a가" 5번 반복되어 매치
## ab?c <- "b"가 0~1번 사용되면 매치    # ? == {0,1}과 같은 표현
## - "abc"는 "b"가 1번 사용되어 매치
## - "ac"는 "b"가 0번 사용되어 매치

# 파이썬에서 정규 표현식을 지원하는 re 모듈
import re

p = re.compile("ab*")  # p는 패턴 객체라고 함.

## 퍄턴 갹채룰 이용하는 4가지 방법
## 1. match
## 문자의 처음부터 정규식과 매치되는지 조사
import re

p = re.compile("[a-z]+")

m = p.match("python")
print(m)
# <re.Match object; span=(0, 6), match='python'>

m = p.match("3 python")
print(m)
# None

## 2. search
## search는 match와 똑같지만 문자열의 처음부터 검사 X
import re

p = re.compile("[a-z]+")

m = p.search("python")
print(m)
# <re.Match object; span=(0, 6), match='python'>

m = p.search("3 python")
print(m)
print("===================================")
# <re.Match object; span=(2, 8), match='python'>

## 3. findall
## 문자열의 각각 단어들을 정규식과 매치해서 리스트로 돌려준다.
import re

p = re.compile("[a-z]+")

result = p.findall("life is too short")
print(result)
# ['life', 'is', 'too', 'short']

for r in result:
    print(r)
# life
# is
# too
# short

## 3. findall
## 문자열의 각각 단어들을 정규식과 매치해서 리스트로 돌려준다.
import re

p = re.compile("[a-z]+")

result = p.finditer("life is too short")
print(result)
# <callable_iterator object at 0x000001D9D0DBBA60>

for r in result:
    print(r)
# <re.Match object; span=(0, 4), match='life'>
# <re.Match object; span=(5, 7), match='is'>
# <re.Match object; span=(8, 11), match='too'>
# <re.Match object; span=(12, 17), match='short'>

### match 객체로 리턴한다?
### match 객체의 4가지 메서드
### 1.group()   : 매치된 문자열을 리턴
### 2.start()   : 매치된 문자열의 시작 위치를 리턴
### 3.end()     : 매치된 문자열의 끝 위치를 리턴
### 4.span()    : 매치된 문자열의 (시작, 끝)에 해당되는 튜플을 리턴
import re

p = re.compile("[a-z]+")
m = p.match("python")
print(m.group())
print(m.start())
print(m.end())
print(m.span())

# 컴파일 옵션
# DOTALL, S : dot(.) 문자가 줄바꿈 문자도 포함하도록 만드는 옵션
import re

# p = re.compile("a.b")
# m = p.match(a\nb)
# print(m)

p = re.compile("a.b", re.DOTALL)  # re.DOTALL == re.S
m = p.match("a\nb")
print(m)

# IGNORECASE, I : 대소문자 무시하고 매칭
import re

# p = re.compile("[a-z]", re.I)
# print(p.match("python"))
# print(p.match("Python"))
# print(p.match("pYTHON"))

p = re.compile("[a-z]", re.I)
print(p.match("python"))
print(p.match("Python"))
print(p.match("pYTHON"))

# MULTILINE, M
# 여러 라인에 메타문자를 적용시키고 싶을 떄 사용
import re

# p = re.compile("^python\s\w+")
p = re.compile(
    "^python\s\w+", re.M
)  # ^ : 맨처음에 나오는 문자, \s : 공백, \w : 알파벳, 숫자, _ 중의 한 문자
# 즉, python이란 글자가 나오고, 공백, 알파벳/숫자/_ 중 한 문자가 나와야 매치
data = """python one
life is too short
python two
you need python
python three"""

print(p.findall(data))

# VERBOSE, X : 정규표현식에 공백이나 개행을 쓸 수 있도록 해줌(주석을 달 수 있음)
import re

charref = re.compile(r"&[#](0[0-7]+|[0-9]+|x[0-9a-fA-F]+);")

charref = re.compile(
    r"""
&[#]                # Start of a nemeric entity reference
(
    0[0-7]+         # Octal form
    | [0-9]+        # Decimal form
    | x[0-9a-fA-F]  # Hexadecimal form 
)
;                   # Trailling semicolon
""",
    re.X,
)

# 백슬래시 문제
# \\ -> \ 로 인식, \ -> 공백으로 인식
# \section의 경우
p = re.compile("\\section")
# \\section의 경우
p = re.compile("\\\\section")
# 간소화하는 방법
p = re.compile(r"\\section")

# 강력한 정규 표현식
# 메타문자
## | : or와 동일한 의미
p = re.compile("Hello|xilver")
m = p.match("Hello world!")
print(m)
## ^ : 문자열의 맨 처음과 매치
print(re.search("^Life", "Life is too short"))
print(re.search("^Life", "My Life"))
## $ : ^의 반대. 문자열의 끝과 매치
print(re.search("short$", "Life is too short"))
print(re.search("short$", "Life is too short, You need python"))
## \b : 단어 구분자(공백!)
p = re.compile(r"\bclass\b")
print(p.search("no class at all"))
## \A : ^와 같은 의미. 하지만 re.M을 사용하게 되면 줄에 상관없이 전체 문자열의 처음하고만 매치
## \Z : $와 같은 의미. 하지만 re.M을 사용하게 되면 줄에 상관없이 전체 문자열의 맨 끝하고만 매치
## \B : \b의 반대. 이 단어+공백이 없는 경우에만 매치
p = re.compile(r"\Bclass\B")
print(p.search("no class at all"))
print(p.search("the declassdied alforithm"))
print(p.search("onr subclass is"))

# 그루핑 ()
p = re.compile("(ABC)+")
m = p.search("ABCABCABC OK>")
print(m)
print(m.group())
## 그루핑된 객체를 따로 불러올 수 있다.
### group(0) : 매치된 전체 문자열
### group(1) : 첫 번째 그룹에 해당하는 문자열
### group(2) : 두 번째 그룹에 해당하는 문자열
### group(n) : n 번째 그룹에 해당하는 문자열
p = re.compile(r"(\w+)\s+\d+[-]\d+[-]\d+")
m = p.search("park 010-1234-1234")
print(m.group(1))

## 그루핑된 문자열 재참조 : \n ex) \1, \2, \3, ...
p = re.compile(r"(\b\w+)\s+\1")
print(p.search("Paris in the the spring").group())

## 그루핑된 문자열에 이름 붙이기 : ?P<name>
p = re.compile(r"(?P<person_name>\w+)\s+((\d+)[-]\d+[-]\d+)")
m = p.search("park 010-1234-1234")
print(m.group("person_name"))

p = re.compile(r"(?P<word>\b\w+)\s+(?P=word)")
# p = re.compile(r"(?P<word>\b\w+)\s+\1") # 와 같은 결과
print(p.search("Paris in the the spring").group())

# 전방탐색 1 : 긍정형 (?=)
# 검색 조건에는 넣되, 결과에서는 뺄 때 사용
# p = re.compile(".+:")   # :이 나올 떄 까지
p = re.compile(".+(?=:)")  # 위와 같지만 : 빼고 출려
m = p.search("http://google.com")
print(m.group())

# 전방탐색 2 : 부정형 (?!)
# 검색된 문자열을 결과에서 제외시킴
p = re.compile(".*[.](?!bat$).*$", re.M)
l = p.findall(
    """
autoexec.exe
autoexec.bat
autoexec.jpg
"""
)
print(l)

# 문자열 바꾸기 sub
# 정규표현식에 일치하는 내용을 바꿔줌
p = re.compile("(blue|white|red)")
print(p.sub("color", "blue socks and red shoes"))

# Greedy vs Non-Greedy
s = "<html><head><title>Title</title>"
# print(re.match("<.*>", s).group())  # Greedy
## <>사이의 문자열을 출력하려고 하는데
## <html>의 < 와 </title> 의 > 만을 인식하여
## html><head><title>Title</title를 문자열로 인식
## 출력 결과 : <html><head><title>Title</title>
print(re.match("<.*?>", s).group())  # Non-Greedy
## 위와 같은 실수를 방지하기 위해 최소한의 반복을 사용(?)
## 출력 결과 : <html>
