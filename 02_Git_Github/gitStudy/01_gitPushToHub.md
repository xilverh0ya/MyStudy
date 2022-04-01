# 1. 초기 설정
  
```bash
$ git config --global user.name "YOUR GITHUB NAME"
$ git config --global user.email "GITHUB E-MAIL"
```

# 2. 로컬 저장소와 깃 생성
  
디렉토리를 만들거나(mkdir), 깃을 만들 디렉토리로 이동(cd)

1) 로컬저장소 생성 / 이동  
  
   로컬저장소 생성
   ```bash
   $ mkdir (Directory Address)
   ```
  
   로컬저장소 이동
   ```bash
   $ cd (Directory Address)
   ```
  

2) Git 생성(Git 초기화)
   ```bash
   $ git init
   ```
   이 명령은 .git 이라는 하위 디렉토리를 생성.  
   .git 디렉토리에는 저장소에 필요한 뼈대 파일(Skeleton)이 들어있다.  
   이 명령만으로는 아직 프로젝트의 어떤 파일도 관리하지 않는다.

# 3. 업로드 할 파일 준비
1) 파일 상태 확인
   ```bash
   $ git status
   ```
   수정된 파일이 있는지, 작업 내역 없이 깨끗한 디렉토리인지 등, 파일의 상태를 볼 수 있는 명령어

2) Staging Area에 파일 올리기
   ```bash
   $ git add (File Name)
   ```
   git add 뒤에 스테이지에 올릴 파일 이름을 적는다.
     
   <git add 관련 명령어>
   ```bash
   git add : 가장 기초적, rm 명령으로 제거된 파일은 add 명령어에 포함되지 않음.

   git add --all
   git add .
   : status에 나온 변경사항을 모두 스테이지에 올려준다.

   git add -u : 하나 이전의 스테이지와 비교해서 변경된 부분만 add. 새롭게 만들어진 파일은 add 하지않음.

   git add -A : 새로 만든 것, 수정, 삭제 등 모든 변경된 파일을 add 해준다.
   ```
<br>

3) 커밋하기
   
   ```bash
   $git commit -m "Message"
   ```

   보통 메세지에는 몇 번째 커밋인지 적는다.  
   ex) "First commit"

# 4. Github에 push 하기
1) 원격저장소 확인
   
   ```bash
   $git remote -v
   ```

   혹시 이전에 원격저장소를 연결한 경우가 있다면, 원격저장소가 있는지 이 명령어로 확인한다.  
   -v는 더 상세하게 알아보고 싶을 때 덧붙인다.

2) 원격저장소 제거
   
   ```bash
   $git remote remove (Existing remote repository alias)
   ```

   ex) git remote remove origin  
   기존의 원격 저장소를 삭제하고 싶다면 예시를 입력해보자.  
   origin은 자동으로 등록되는 원격저장소 이름이다.

3) 원격저장소 추가
   ```bash
   $git remote add (Github repository address)
   ```
   ex) git remote add origin git@github.com/xilverh0ya/Mystudy.git  
   단축이름은 origin 말고 다른 이름도 가능하다.
   
4) 원격저장소에 push하기
   ```bash
   $git push (Remote repository alias) (Branch name)
   ```
   ex) git push origin master

   디폴트 브랜치가 최근에 master에서 main으로 바뀌었다고 한다.  
   하지만 내 경우, master로 잘 실행됐다.  

___

[참고 링크]  
  
https://velog.io/@unu/%EA%B9%83-%ED%84%B0%EB%AF%B8%EB%84%90%EB%A1%9C-%EA%B9%83%ED%97%88%EB%B8%8C%EC%97%90-%EB%82%B4-%ED%8C%8C%EC%9D%BC%ED%8F%B4%EB%8D%94-%EC%98%AC%EB%A6%AC%EA%B8%B0
