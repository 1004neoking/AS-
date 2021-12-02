package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class UserDAO {
	
	private Connection conn; //DB와 연결성을 갖는 인터페이스
	private PreparedStatement pstmt; //SQL구문을 실행하는 인터페이스
	private ResultSet rs; //SELECT의 결과 데이터를 갖는 인터페이스이다. 저장하는 객체이다.
	
	public UserDAO() { //실제로 mysql에 접속하게 해주는 구문
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
		
	}
	
	public int login(String userID, String userPW) {
		String SQL = "SELECT userPW FROM USER WHERE userID = ?"; //실제로 데이터베이스에 입력할 명령어 문장을 적는다
		//즉 SELECT(찾는다) userPW를 FROM(어디에서?) USER테이블에서 WHERE(어떤것을?) userID가 [?] 인것을 (?는 매개변수이다)
		try {
			pstmt = conn.prepareStatement(SQL); //SQL 변수에 작성된 쿼리를 pstmt(sql을 실행하는 인터페이스)에 넣는다
			pstmt.setString(1,userID);//쿼리의 첫번째 ?의 값을 userID로 설정해준다.
			rs = pstmt.executeQuery();//rs(SELECT의 결과를 저장할 수 있는 객체)에 실행한 결과를 저장한다.
			if (rs.next()) { //next = rs에 결과가 존재한다면 if문 실행
				if(rs.getString(1).equals(userPW)) { //getString(1) DB를 가져왔기 때문에 테이블이 존재한다 테이블의 1열에있는 값을 GET한다.
					// ***즉 쿼리에서는 id에 맞는 pw를 가져왔고 그 pw랑 login에 넘어온 pw를 비교해 맞는지를
					return 1; //로그인 성공
				}
				else return 0; //비밀번호가 틀림
			}
			return -1; //아이디가 없다면 if를 건너뛰고 -1을 리턴
		}catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -2; //데이터베이스 오류를 의미한다
	}
	
	public int register(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPW());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserBirth());
			pstmt.setString(5, user.getUserPhone());
			pstmt.setString(6, user.getUserEmail());
			pstmt.setString(7, user.getUserAddr());
			return pstmt.executeUpdate(); //insert문을 실행했을때에는 0이상을 반환한다.
		} catch(Exception e) {
			e.printStackTrace(); //에러의 발생 근원지를 찾아서 단계적으로 에러를 출력한다.
		}
		return -1; // DB오류
	}
	
}
