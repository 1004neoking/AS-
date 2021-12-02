package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class UserDAO {
	
	private Connection conn; //DB�� ���Ἲ�� ���� �������̽�
	private PreparedStatement pstmt; //SQL������ �����ϴ� �������̽�
	private ResultSet rs; //SELECT�� ��� �����͸� ���� �������̽��̴�. �����ϴ� ��ü�̴�.
	
	public UserDAO() { //������ mysql�� �����ϰ� ���ִ� ����
		//�����ڰ� ȣ��ȴٸ� ����ó���� ����
		try {
			String dbURL = "jdbc:mysql://localhost:3306/ASS";
			String dbID = "root";
			String dbPassword = "tmdqls123!";
			Class.forName("com.mysql.jdbc.Driver");//DB��ǰ�� �����Ѵ�
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);//url,id,pw�� �α����� �ϰڴٴ°Ͱ���
			//DriverManager JVM���� DB�� �����ϴ� Ŭ���� Driver���, Connection���� ��
			
		}catch (Exception e){
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		
	}
	
	public int login(String userID, String userPW) {
		String SQL = "SELECT userPW FROM USER WHERE userID = ?"; //������ �����ͺ��̽��� �Է��� ��ɾ� ������ ���´�
		//�� SELECT(ã�´�) userPW�� FROM(��𿡼�?) USER���̺��� WHERE(�����?) userID�� [?] �ΰ��� (?�� �Ű������̴�)
		try {
			pstmt = conn.prepareStatement(SQL); //SQL ������ �ۼ��� ������ pstmt(sql�� �����ϴ� �������̽�)�� �ִ´�
			pstmt.setString(1,userID);//������ ù��° ?�� ���� userID�� �������ش�.
			rs = pstmt.executeQuery();//rs(SELECT�� ����� ������ �� �ִ� ��ü)�� ������ ����� �����Ѵ�.
			if (rs.next()) { //next = rs�� ����� �����Ѵٸ� if�� ����
				if(rs.getString(1).equals(userPW)) { //getString(1) DB�� �����Ա� ������ ���̺��� �����Ѵ� ���̺��� 1�����ִ� ���� GET�Ѵ�.
					// ***�� ���������� id�� �´� pw�� �����԰� �� pw�� login�� �Ѿ�� pw�� ���� �´�����
					return 1; //�α��� ����
				}
				else return 0; //��й�ȣ�� Ʋ��
			}
			return -1; //���̵� ���ٸ� if�� �ǳʶٰ� -1�� ����
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -2; //�����ͺ��̽� ������ �ǹ��Ѵ�
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
			return pstmt.executeUpdate(); //insert���� �������������� 0�̻��� ��ȯ�Ѵ�.
		} catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -1; // DB����
	}
	
}
