package self;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.PreparedStatement;

public class SelfDAO {
		
	private Connection conn; //DB와 연결성을 갖는 인터페이스
	private ResultSet rs; //SELECT의 결과 데이터를 갖는 인터페이스이다. 저장하는 객체이다.
	
	public SelfDAO() { //실제로 mysql에 접속하게 해주는 구문
		//생성자가 호출된다면 예외처리문 실행
		try {
			String dbURL = "jdbc:mysql://localhost:3306/ASS";
			String dbID = "root";
			String dbPassword = "tmdqls123!";
			Class.forName("com.mysql.jdbc.Driver");//DB제품을 선택한다
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);//url,id,pw로 로그인을 하겠다는것같다
			//DriverManager JVM에서 DB를 관리하는 클래스 Driver등록, Connection연결 등
			
		}catch (Exception e){
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		
	}//여기까지가 DB와 연결구문
	
	public String getDate(){//현재의 시간을 가져오는 함수
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			rs = pstmt.executeQuery(); //실제로 실행했을때 나오는 결과를 가져온다
			if(rs.next()) { //결과가 있는 경우
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return ""; //DB오류
	}
	
	public int getNext(){//게시글 번호를 늘려주는 함수
		String SQL = "SELECT SelfID FROM Self ORDER BY SELFID DESC"; 
					//BBS테이블에서 bbsID를 가져온다 bbsID를  내림차순(DESC)으로 정렬해서(ORDER BY)
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			rs = pstmt.executeQuery(); //실제로 실행했을때 나오는 결과를 rs로 가져온다
			if(rs.next()) { //결과가 있는 경우
				return rs.getInt(1) + 1; //bbsID에 +1 을 해줘서 숫자가 늘어나게한다
			}//결과가 없는경우 게시글이 없는 것이기 때문에 1을 부여해서 첫 게시물으로 만들어준다.
			return 1;
			
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -1; //DB오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO Self VALUES (?, ?, ?, ?, ?, ?)"; 
		//BBS테이블안에 6개의 인자가 들어갈 수 있게 한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate(); //성공적으로 넣었을때 1이상을  리턴한다
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -1; //DB오류
	}

	//특정 페이지에 따른 10개의 게시물을 가져온다
	public ArrayList<Self> getList(int pageNumber){
		String SQL = "SELECT * FROM self WHERE selfID < ? AND SelfAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; 
		//SELECT * FROM BBS (BBS에서 전부 가져온다) WHERE(조건) bbsID가 ?보다 작은것 그리고 bbsAvailable이 1인것을
		//ORDER BY bbsID (bbsID를 기준으로 정렬한다) DESC(내림차순)으로 LIMIT (10개만 제한해서)
		ArrayList<Self> list = new ArrayList<Self>(); //bbs에서 나오는 인스턴스를 보관할 수 있는 인스턴스를 만든다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);/*다음에 작성될 글의 번호*/
			// ?의 조건을 정의한다. getNext(다음에 작설될 글의 번호)-pageNumber는 게시글이 5개니까 1이다 (1-1=0) * 10 = 0이니까 ?는 6이 된다
			// 게시글이 15개면 1페이지일 경우 ?에 15가 들어간다 하지만 limit으로 10개 제한이라서 1~10번 게시글이 나오고
			// 2페이지일 경우 ?에 (2-1)*10 = 10/  15-10 을 해서 5가 나오기 때문에 5개의 게시글만 가져온다 
			rs = pstmt.executeQuery();
			while(rs.next()) { //결과가 나올때마다 반복
				Self self = new Self();
				self.setSelfID(rs.getInt(1));
				self.setSelfTitle(rs.getString(2));
				self.setUserID(rs.getString(3));
				self.setSelfDate(rs.getString(4));
				self.setSelfContent(rs.getString(5));
				self.setSelfAvailable(rs.getInt(6)); //6개의 값을 bbs인스턴스에 넣어준다
				list.add(self); // bbs인스턴스에 있는 값을 list안에 다 넣어준다 
			}
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return list;// 10개 뽑아온 게시글 리스트를 출력해준다
	}

	
	//페이징처리를 하는 함수
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM SELF WHERE selfID < ? AND selfAvailable = 1"; 
		//SELECT * FROM BBS (BBS에서 전부 가져온다) WHERE(조건) bbsID가 ?보다 작은것 그리고 bbsAvailable이 1인것을
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setInt(1,getNext()/*다음에 작성될 글의 번호*/-(pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//결과가 있다면 true리턴
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return false;// 10개 뽑아온 게시글 리스트를 출력해준다
	}
	
	//글 내용을 불러오는 함수
	public Self getBbs(int bbsID) {
		String SQL = "SELECT * FROM SELF WHERE selfID = ?"; 
		//SELECT * FROM BBS (BBS에서 전부 가져온다) WHERE(조건) bbsID가 ?
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setInt(1,bbsID); //?를 bbsID로 설정하고 게시글을 가져온다
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//결과가 있다면 true리턴
				Self self = new Self();
				self.setSelfID(rs.getInt(1));
				self.setSelfTitle(rs.getString(2));
				self.setUserID(rs.getString(3));
				self.setSelfDate(rs.getString(4));
				self.setSelfContent(rs.getString(5));
				self.setSelfAvailable(rs.getInt(6)); //6개의 값을 bbs인스턴스에 넣어준다
				return self; // bbs인스턴스에 있는 값을 list안에 다 넣어준다 
			}
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return null;//해당 글이 존재하지 않는다면 오류가 날것이니 null을 반환한다
		
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE SELF SET selfTitle = ?, selfContent = ? WHERE selfID = ?"; 
		//BBS테이블안에 6개의 인자가 들어갈 수 있게 한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate(); //성공적으로 넣었을때 1이상을  리턴한다
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -1; //DB오류
		
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE self SET selfAvailable = 0 WHERE selfID = ?"; 
		//BBS테이블안에 6개의 인자가 들어갈 수 있게 한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL구문을 실행하는 인터페이스
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate(); //성공적으로 넣었을때 1이상을  리턴한다
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -1; //DB오류
	}
}


