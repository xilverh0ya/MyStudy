import os


def search(dirname):
    try:
        filenames = os.listdir(dirname)
        for filename in filenames:
            full_filename = os.path.join(dirname, filename)
            if os.path.isdir(full_filename):  # full_filename이 폴더면 재귀함수로 다시 실행
                search(full_filename)
            else:  # full_filename이 파일이면?
                ext = os.path.splitext(full_filename)[-1]  # 파일 이름 가장 끝자리 확장자 검사
                if ext == ".py":  # 확장자가 .py라면?
                    print(full_filename)  # 출력
    except PermissionError:  # 권한 오류가 있어도
        pass  # 계속 실행되도록


search("C:/")
