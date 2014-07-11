package com.forum.service;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import com.common.UserInfo;
import com.forum.dao.ReviewDAO;
import com.forum.dao.TopicDAO;
import com.forum.dao.UserDAO;
import com.model.Review;
import com.model.Topic;
import com.model.User;

public class ReviewServiceImpl implements ReviewService{

	private ReviewDAO reviewDao;
	private TopicDAO topicDao;
	private UserDAO userDao;
	public void addReview(UserInfo userInfo, ServletContext servletContext)
			throws Exception {
		
		List<Map<String,Object>> list=this.reviewDao.query(userInfo);
		Topic topic=new Topic();
		topic.setId((Integer)list.get(0).get("id"));
		topic.setLastReplyTime(new Date());
		topic.setReplyCount((Integer)list.get(0).get("replyCount")+1);//��������+1
		topic.setUser(userDao.queryById((Integer)list.get(0).get("id")));
		topic.setTopicPath((String)list.get(0).get("topicPath"));
		topic.setPostTopicTime((Date)list.get(0).get("postTopicTime"));
		topicDao.updateReplyTopic(topic);//����topic
		
		Review review=new Review();
		review.setId(reviewDao.getMaxId()+1);
		review.setReviewTime(new Date().toLocaleString());
		review.setTopicId(topic.getId());
		User reviewUser=userDao.load("wang");//ͨ���û�����ѯ�û�
		review.setUser(reviewUser);
		reviewDao.save(review);//���������
		
		//��ָ��Ŀ¼д�ļ�
		String filePath=servletContext.getRealPath("/content")+"/"+reviewUser.getName()
						+"/"+topic.getTopicPath()+"/"+String.valueOf(review.getId()).toString()+".txt";
		OutputStream os=new FileOutputStream(filePath);
		OutputStreamWriter osw=new OutputStreamWriter(os);
		osw.write(userInfo.getContent());
		osw.close();
		os.close();
		
		//��������������reviews��topicPath 
		ArrayList<Review> reviews=(ArrayList)reviewDao.queryByTopicId(review.getTopicId());
		userInfo.setReviews(reviews);
		//userInfo.setTopicPath("/content/"+topic.getUser().getName()+"/"+topic.getTopicPath()+"/");
		userInfo.setPath(topic.getTopicPath());
		
	}

	public void getReviews(UserInfo userInfo,ServletContext servletContext) {
		
		List<Map<String,Object>> list=this.reviewDao.query(userInfo);//�õ�topic
		Topic topic=new Topic();
		System.out.println("topics: "+list.size());
		
		topic.setTopicPath((String)list.get(0).get("topicPath"));
		topic.setName((String)list.get(0).get("name"));
		topic.setLastReplyTime((Date)list.get(0).get("lastReplyTime"));
		topic.setPostTopicTime((Date)list.get(0).get("postTopicTime"));
		topic.setReplyCount((Integer)list.get(0).get("replyCount"));
		User user=userDao.queryById((Integer)list.get(0).get("userId"));
		System.out.println("imagePatH: "+user.getImagePath());
		topic.setUser(userDao.queryById((Integer)list.get(0).get("userId")));
		topic.setId((Integer)list.get(0).get("id"));
		topic.setViewCount((Integer)list.get(0).get("viewCount")+1);
		topicDao.updateById(topic);//����viewCount
		
		//����reviews
		List<Map<String,Object>> list2=reviewDao.queryByTopicId(topic.getId());
		List<Review> reviews=new ArrayList<Review>();
		for(int i=0;i<list2.size();i++){
			Review rev=new Review();
			rev.setId((Integer)list2.get(i).get("id"));
			Date d=(Date)list2.get(i).get("reviewTime");
			rev.setReviewTime(d.toLocaleString());
			rev.setUser(userDao.queryById((Integer)list2.get(i).get("reviewUserId")));
			reviews.add(rev);
		}
		//topic,��ȡtopic��·�����ظ�����jspҳ����Ҫ�õ���id�����ԣ����ظ���·����
		userInfo.setTopic(topic);
		userInfo.setTopicURL("/content/"+topic.getUser().getName()+"/"+topic.getTopicPath()+"/"+"topic.txt");//��ȡtopic��·��
		userInfo.setReviews(reviews);
		userInfo.setTopicPath("/content/"+topic.getUser().getName()+"/"+topic.getTopicPath()+"/");	
		userInfo.setPath(topic.getTopicPath());//��addreviews��ʱ���õ���
	}
	
	
	public TopicDAO getTopicDao() {
		return topicDao;
	}

	public void setTopicDao(TopicDAO topicDao) {
		this.topicDao = topicDao;
	}

	public UserDAO getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDAO userDao) {
		this.userDao = userDao;
	}

	public ReviewDAO getReviewDao() {
		return reviewDao;
	}

	public void setReviewDao(ReviewDAO reviewDao) {
		this.reviewDao = reviewDao;
	}
}