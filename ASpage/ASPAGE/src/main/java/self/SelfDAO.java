package self;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.PreparedStatement;

public class SelfDAO {
		
	private Connection conn; //DB�� ���Ἲ�� ���� �������̽�
	private ResultSet rs; //SELECT�� ��� �����͸� ���� �������̽��̴�. �����ϴ� ��ü�̴�.
	
	public SelfDAO() { //������ mysql�� �����ϰ� ���ִ� ����
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
		
	}//��������� DB�� ���ᱸ��
	
	public String getDate(){//������ �ð��� �������� �Լ�
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			rs = pstmt.executeQuery(); //������ ���������� ������ ����� �����´�
			if(rs.next()) { //����� �ִ� ���
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return ""; //DB����
	}
	
	public int getNext(){//�Խñ� ��ȣ�� �÷��ִ� �Լ�
		String SQL = "SELECT SelfID FROM Self ORDER BY SELFID DESC"; 
					//BBS���̺��� bbsID�� �����´� bbsID��  ��������(DESC)���� �����ؼ�(ORDER BY)
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			rs = pstmt.executeQuery(); //������ ���������� ������ ����� rs�� �����´�
			if(rs.next()) { //����� �ִ� ���
				return rs.getInt(1) + 1; //bbsID�� +1 �� ���༭ ���ڰ� �þ���Ѵ�
			}//����� ���°�� �Խñ��� ���� ���̱� ������ 1�� �ο��ؼ� ù �Խù����� ������ش�.
			return 1;
			
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -1; //DB����
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO Self VALUES (?, ?, ?, ?, ?, ?)"; 
		//BBS���̺�ȿ� 6���� ���ڰ� �� �� �ְ� �Ѵ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate(); //���������� �־����� 1�̻���  �����Ѵ�
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -1; //DB����
	}

	//Ư�� �������� ���� 10���� �Խù��� �����´�
	public ArrayList<Self> getList(int pageNumber){
		String SQL = "SELECT * FROM self WHERE selfID < ? AND SelfAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; 
		//SELECT * FROM BBS (BBS���� ���� �����´�) WHERE(����) bbsID�� ?���� ������ �׸��� bbsAvailable�� 1�ΰ���
		//ORDER BY bbsID (bbsID�� �������� �����Ѵ�) DESC(��������)���� LIMIT (10���� �����ؼ�)
		ArrayList<Self> list = new ArrayList<Self>(); //bbs���� ������ �ν��Ͻ��� ������ �� �ִ� �ν��Ͻ��� �����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);/*������ �ۼ��� ���� ��ȣ*/
			// ?�� ������ �����Ѵ�. getNext(������ �ۼ��� ���� ��ȣ)-pageNumber�� �Խñ��� 5���ϱ� 1�̴� (1-1=0) * 10 = 0�̴ϱ� ?�� 6�� �ȴ�
			// �Խñ��� 15���� 1�������� ��� ?�� 15�� ���� ������ limit���� 10�� �����̶� 1~10�� �Խñ��� ������
			// 2�������� ��� ?�� (2-1)*10 = 10/  15-10 �� �ؼ� 5�� ������ ������ 5���� �Խñ۸� �����´� 
			rs = pstmt.executeQuery();
			while(rs.next()) { //����� ���ö����� �ݺ�
				Self self = new Self();
				self.setSelfID(rs.getInt(1));
				self.setSelfTitle(rs.getString(2));
				self.setUserID(rs.getString(3));
				self.setSelfDate(rs.getString(4));
				self.setSelfContent(rs.getString(5));
				self.setSelfAvailable(rs.getInt(6)); //6���� ���� bbs�ν��Ͻ��� �־��ش�
				list.add(self); // bbs�ν��Ͻ��� �ִ� ���� list�ȿ� �� �־��ش� 
			}
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return list;// 10�� �̾ƿ� �Խñ� ����Ʈ�� ������ش�
	}

	
	//����¡ó���� �ϴ� �Լ�
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM SELF WHERE selfID < ? AND selfAvailable = 1"; 
		//SELECT * FROM BBS (BBS���� ���� �����´�) WHERE(����) bbsID�� ?���� ������ �׸��� bbsAvailable�� 1�ΰ���
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setInt(1,getNext()/*������ �ۼ��� ���� ��ȣ*/-(pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//����� �ִٸ� true����
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return false;// 10�� �̾ƿ� �Խñ� ����Ʈ�� ������ش�
	}
	
	//�� ������ �ҷ����� �Լ�
	public Self getBbs(int bbsID) {
		String SQL = "SELECT * FROM SELF WHERE selfID = ?"; 
		//SELECT * FROM BBS (BBS���� ���� �����´�) WHERE(����) bbsID�� ?
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setInt(1,bbsID); //?�� bbsID�� �����ϰ� �Խñ��� �����´�
			rs = pstmt.executeQuery();
			
			if(rs.next()) {//����� �ִٸ� true����
				Self self = new Self();
				self.setSelfID(rs.getInt(1));
				self.setSelfTitle(rs.getString(2));
				self.setUserID(rs.getString(3));
				self.setSelfDate(rs.getString(4));
				self.setSelfContent(rs.getString(5));
				self.setSelfAvailable(rs.getInt(6)); //6���� ���� bbs�ν��Ͻ��� �־��ش�
				return self; // bbs�ν��Ͻ��� �ִ� ���� list�ȿ� �� �־��ش� 
			}
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return null;//�ش� ���� �������� �ʴ´ٸ� ������ �����̴� null�� ��ȯ�Ѵ�
		
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE SELF SET selfTitle = ?, selfContent = ? WHERE selfID = ?"; 
		//BBS���̺�ȿ� 6���� ���ڰ� �� �� �ְ� �Ѵ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate(); //���������� �־����� 1�̻���  �����Ѵ�
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -1; //DB����
		
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE self SET selfAvailable = 0 WHERE selfID = ?"; 
		//BBS���̺�ȿ� 6���� ���ڰ� �� �� �ְ� �Ѵ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL������ �����ϴ� �������̽�
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate(); //���������� �־����� 1�̻���  �����Ѵ�
		}catch(Exception e) {
			e.printStackTrace(); //������ �߻� �ٿ����� ã�Ƽ� �ܰ������� ������ ����Ѵ�.
		}
		return -1; //DB����
	}
}


