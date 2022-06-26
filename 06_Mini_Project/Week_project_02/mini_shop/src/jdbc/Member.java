package jdbc;

public class Member {

	/**
	 * mID VARCHAR(50) PRIMARY KEY , mPW INT NOT NULL , mTYPE BOOLEAN default false
	 * NOT NULL , mNAME VARCHAR(50)
	 **/

	public String mID;
	private int mPW;
	private boolean mType;
	private String mNAME;

	public String getmID() {
		return mID;
	}

	public void setmID(String mID) {
		this.mID = mID;
	}

	public int getmPW() {
		return mPW;
	}

	public void setmPW(int mPW) {
		this.mPW = mPW;
	}

	public boolean ismType() {
		return mType;
	}

	public void setmType(boolean mType) {
		this.mType = mType;
	}

	public String getmNAME() {
		return mNAME;
	}

	public void setmNAME(String mNAME) {
		this.mNAME = mNAME;
	}

	@Override
	public String toString() {
		return "Member [mID=" + mID + ", mPW=" + mID + ", mType=" + mType + ", mNAME=" + mNAME + "]";
	}

	public Member() {
		super();
	}

	public Member(String mID, int mPW, boolean mType, String mNAME) {
		super();
		this.mID = mID;
		this.mPW = mPW;
		this.mType = mType;
		this.mNAME = mNAME;
	}

}