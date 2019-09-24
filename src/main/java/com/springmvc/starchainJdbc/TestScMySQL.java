package com.springmvc.starchainJdbc;

import java.awt.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import com.springmvc.entity.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import com.springmvc.utils.DbControl;


import java.awt.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;



public class TestScMySQL {

	// 登录判断
	public static void login() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String openid = "1111";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'login\',\'" + openid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
				JSONObject object = JSONObject.parseObject(rs.getString("message").trim());
				if (object.getString("SuccessMsg").trim().equals("needRegister")) {
					init();
				} else {
					showMyHomepage();
				}
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 初始化账户
	public static void init() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			// 主键K
			// String name, String wechat, String openid, String point, String
			// evaluation, String times,
			// String myfavorid, String mypublish, String needConfirm, String
			// needSerShare, String needSerPay,
			// String publishfinish, String myapply, String needAppshare, String
			// needAppPay, String applyfinish
			String userid = "user_" + UUID.randomUUID();
			String str = "qweasd,weixin_id,1111,1000,4,0, , , , , , , , , , , ,0,";
			ResultSet rs = st
					.executeQuery("INVOKE INTO 2665637542 VALUES(\'init\',\'" + userid + "\',\'" + str + "\')");
			System.out.println("INVOKE INTO 2665637542 VALUES(\'init\',\'" + userid + "\',\'" + str + "\')");
			System.out.println("11111111111111111111");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 发布商品
	public static void publishGoods() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			// 主键K
			String publishid = "publish_" + UUID.randomUUID();
			String userid="";
			String address="";
			String description="";
			String endDate="";
			String image1="";
			String image2="";
			String image3="";
			String price="";
			String theme="";
			String deposit="";
			String type="";
			String publishStatus=""; //***为publishID***

			// "userid","地址","描述","截止日期","Img1","Img2","Img3","每日价格","主题","押金deposit","类型type","publishid"
			String str = "user_ee0b09d0-c18c-4394-b824-2db250500256,address,miaoshu,2020,Img1,Img2,Img3,10,theme,500,电子产品,publishid";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'publishgoods\',\'" + publishid + "\',\'" + userid + "\',\'" + address + "\',\'" + description + "\',\'" + endDate + "\',\'" + image1 + "\',\'" + image2 + "\',\'" + image3 + "\',\'" + price + "\',\'" + theme + "\',\'" + deposit + "\',\'" + type + "\',\'" + publishStatus + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 未被申请的发布 发布者可删除
	public static void deleteUnPublish() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "";
			String publishid = "";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'deleteUnPublish\',\'" + userid + "\',\'" + publishid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 拒绝申请
	public static void refuseOrder() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = " ";
			String orderid = "order_" + UUID.randomUUID();
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'refuseOrder\',\'" + userid + "\',\'" + orderid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// B申请向A借商品G
	public static void applyBorrow() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "order_" + UUID.randomUUID();
			String applyuserid="";
			String serviceuserid="";
			String publishid="";
			String estimateReturntime="";
			String status="";// ***改为orderID****
			String reason="";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'applyBorrow\',\'" + orderid + "\',\'" + applyuserid + "\',\'" + serviceuserid + "\',\'" + publishid + "\',\'" + estimateReturntime + "\',\'" + status + "\',\'" + reason + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// A确认B的订单申请
	public static void confirmBorrow() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "order_d4e7dfed-f67e-4f1d-aa85-00bc1f468c8e";
			String str = "publish_433002da-501e-447f-ac7a-8417a1968077";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'confirmBorrow\',\'" + orderid + "\',\'" + str + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Ｂ当面向Ａ借物品
	public static void borrow() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "order_d4e7dfed-f67e-4f1d-aa85-00bc1f468c8e";
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
			String begintime = dateFormat.format(now);
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'borrow\',\'" + orderid + "\',\'" + begintime + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// B当面向A归还商品G
	public static void giveback() {
		Connection conn = null;
		try {
			// (String applyuserid, String serviceuserid, String publishid,
			// String begintime, String endtime,String estimateReturntime,
			// String status, String reason, String applyuserRating, String
			// applyuserComment, String serviceuserRating,
			// String serviceuserComment
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "order_d4e7dfed-f67e-4f1d-aa85-00bc1f468c8e";
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
			String endtime = dateFormat.format(now);
			String str = endtime;
			System.out.println(str);
			ResultSet rs = st
					.executeQuery("INVOKE INTO 2665637542 VALUES(\'giveback\',\'" + orderid + "\',\'" + str + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 处理付积分时积分不够后续处理
	public static void pointNotEnough() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "  ";
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
			String nowtime = dateFormat.format(now);
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'pointNotEnough\',\'" + orderid + "\',\'" + nowtime + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 处理过期不还
	public static void overdueNotGiveback() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "  ";
			Date now = new Date();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/ddHH:mm:ss");// 可以方便地修改日期格式
			String nowtime = dateFormat.format(now);
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'overdueNotGiveback\',\'" + orderid + "\',\'" + nowtime + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 评价
	public void comment() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String orderid = "  ";
			String userid = "  ";
			String userRating = "";
			String userComment = "";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'comment\',\'" + orderid + "\',\'" + userid
					+ "\',\'" + userRating + "\',\'" + userComment + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 筛选
	public static void screening() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String type = "";
			String firstTime = "";
			String price1 = "";
			String price2 = "";
			String deposit1 = "";
			String deposit2 = "";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'screening\',\'" + type + "\',\'" + firstTime
					+ "\',\'" + price1 + "\',\'" + price2 + "\',\'" + deposit1 + "\',\'" + deposit2 + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// A添加收藏
	public static void myfavor() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "oOcwj06rZ4bJtOT20cgI2RU_d_g";
			String publishid = "publish_abd4d770-2de2-446b-b9f4-a747c0f247d0";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'myfavor\',\'" + userid + "\',\'" + publishid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Ａ取消收藏
	public static void removeMyfavor() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "oOcwj06rZ4bJtOT20cgI2RU_d_g";
			String publishid = "publish_abd4d770-2de2-446b-b9f4-a747c0f247d0";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'removeMyfavor\',\'" + userid + "\',\'" + publishid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 展示我的主页
	public static void showMyHomepage() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "user_4c4d2595-108b-4430-b1b2-d2aaf0fbdf8c";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyHomepage\',\'" + userid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
				JSONObject object = JSONObject.parseObject(rs.getString("message").trim());
				System.out.println(object.getString("StatusCode"));
				// JSONObject
				// object2=JSONObject.parseObject(object.getString("SuccessMsg"));
				User ServiceUser = JSON.parseObject(object.getString("SuccessMsg").trim(), User.class);
				// System.out.println(object2.getString("name"));
				System.out.println(ServiceUser.getName());
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 可借商品列表
	public static void canBorrowlist() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String type = "电子产品";

			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'canBorrowlist\',\'" + type + "\')");
			while (rs.next()) {
				String strPublish = new String(rs.getString("message").getBytes("gbk"), "utf-8");
				// System.out.println(strPublish);

				JSONObject object = JSONObject.parseObject(strPublish.trim());
				System.out.println(object);
				System.out.println(object.getString("StatusCode"));
				JSONObject object2 = JSONObject.parseObject(object.getString("SuccessMsg"));
				System.out.println(object2.getString("Number"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 展示界面
	public static void show() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "";
			String showType = "";
			ResultSet rs = st
					.executeQuery("INVOKE INTO 2665637542 VALUES(\'show\',\'" + userid + "\',\'" + showType + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 通过id查询publish
	public static void queryByPublishID() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String publishID = " ";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByPublishID\',\'" + publishID + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 通过id查询Order
	public static void queryByOrderID() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String OrderID = " ";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'queryByOrderID\',\'" + OrderID + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 显示我的收藏
	public static void showMyfavor() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = "";
			ResultSet rs = st.executeQuery("INVOKE INTO 2665637542 VALUES(\'showMyfavor\',\'" + userid + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改名字
	public static void modifyName() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = " ";
			String newname = " ";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'modifyName\',\'" + userid + "\',\'" + newname + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 修改微信号
	public static void modifyWechat() {
		Connection conn = null;
		try {
			conn = DbControl.getConnection();
			Statement st = conn.createStatement();
			String userid = " ";
			String newwechat = "";
			ResultSet rs = st.executeQuery(
					"INVOKE INTO 2665637542 VALUES(\'modifyWechat\',\'" + userid + "\',\'" + newwechat + "\')");
			while (rs.next()) {
				System.out.println(rs.getString("message"));
			}
			DbControl.closeConnection(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// init();
		// publishGoods();
		// applyBorrow();
		// confirmBorrow();
		// borrow();
		// giveback();
		// myfavor();
		removeMyfavor();
		// canBorrowlist();
		// showMyHomepage();
		// login();

	}

	// select person.id,person.name,person.age,transaciton.func_name from
	// transaction inner join person on transaction.transaction_id=person.age;

}
