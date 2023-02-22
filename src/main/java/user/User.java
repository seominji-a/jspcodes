/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package user; //��� �� ����� ��Ű��

public class User { 

    public String getUserID() { //�ܺο��� ��ü�� �������� ���̵� ������ ����ϴ� �żҵ�
        return userID;
    }

    public void setUserID(String userID) { //�ܺο��� ��ü�� �������� ���̵� �����Ͽ� ������ �� ����ϴ� �żҵ�
        this.userID = userID;
    }

    public String getUserPW() { //�ܺο��� ��ü�� �������� �н����带 ������ ����ϴ� �żҵ�
        return userPW;
    }

    public void setUserPW(String userPW) { //�ܺο��� ��ü�� �������� �н����忡 �����Ͽ� ������ �� ����ϴ� �żҵ�
        this.userPW = userPW;
    }
    private String userID;
    private String userPW;
    
}
