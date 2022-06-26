package shop;

public class MemberVO {

    // private 멤버변수 선언
    private String memberID;
    private String name;
    private String type;


    // 2. 목록을 조회한다.


    public String getMemberID() {
        return memberID;
    }

    //case2 등록
    public void setMemberID(String memberId)  {
        this.memberID = memberId;
    }

    //case1 목록조회
    public void setMemberId(String MEMBER_ID) {
        this.memberID = MEMBER_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name)  {
        this.name = name;
    }

    public String getType() {
        return type;

    }

    public void setType(boolean type)  {
        this.type = type;
    }


    public MemberVO() {
    }

    public MemberVO(String memberID, String name)  {
        this.memberID = memberID;
        this.name = name;
    }

    @Override
    public String toString() {
        return
                "memberId='" + memberID + '\'' +
                        ", name='" + name + '\'';
    }

}
