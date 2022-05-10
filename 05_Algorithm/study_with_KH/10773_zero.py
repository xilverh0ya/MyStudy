# 10773_zero

# 몇 개의 정수를 입력받을지 cnt 변수에 저장
cnt = int(input())

# 정답을 담을 리스트 생성
answer = []

# cnt의 크기만큼 반복
for i in range(cnt):
    # 반복의 시작마다 기록할 숫자를 입력받음
    n = int(input())
    if n == 0:
        answer.pop()    # 0이 입력되면 이전 입력받은 원소 삭제
    else:   # 이외의 경우에는
        answer.append(n)    # 정답 리스트에 담기

# 정답이 담긴 리스트의 원소 합을 출력
print(sum(answer))