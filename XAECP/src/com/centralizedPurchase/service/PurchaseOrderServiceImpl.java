package com.centralizedPurchase.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.centralizedPurchase.dao.PurchaseOrderDao;
import com.model.CentralizedPlanedPurchase;
import com.model.GoodsAddress;
import com.model.Page;
import com.model.PurchaseOrder;
import com.model.PurchaseOrderDetail;
import com.model.Supplier;
import com.model.SupplierProduct;

public class PurchaseOrderServiceImpl implements PurchaseOrderService{
	
	private PurchaseOrderDao purchaseOrderDao;
	
	/**
	 *PurchaseOrderAction.queryPurchaseOrderList()->this.queryPurchaseOrderList()
	 *Get the PurchaseOrder List with parameter specified in purchaseOrder  
	 *
	 * @return List<PurchaseOrder>
	 */
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder){
		return this.purchaseOrderDao.queryPurchaseOrderList(purchaseOrder);
	}
	
	public List<PurchaseOrder> queryPurchaseOrderList(PurchaseOrder purchaseOrder, Page page){
		return this.purchaseOrderDao.queryPurchaseOrderList(purchaseOrder, page);
	}
	
	public Integer purchaseOrderTotalCount(PurchaseOrder purchaseOrder){
		return this.purchaseOrderDao.purchaseOrderTotalCount(purchaseOrder);
	}
	
	/**
	 * PurchaserOrderAction.deletePurchaseOrder()->this.deletePurchaseOrder(String)
	 * Delete not_submitted purchaseOrder according to parameter purchaseOrderList
	 * 		which contain a list of purchase order id.
	 * 
	 * Delete data from PurchaserOrder and PurchaserOrderDetail.
	 * 
	 * @param purchaseOrderList
	 */
	public void deletePurchaseOrder(String purchaseOrderList){
		String[] idArray = purchaseOrderList.split(",");
		for(int index=0; index<idArray.length; index++){
			this.purchaseOrderDao.deletePurchaseOrderById(idArray[index]);
			this.purchaseOrderDao.deletePurchaseOrderDetailById(idArray[index]);
		}
	}
	
	/**
	 * Part of NEW and EDIT a purchaseOrder
	 * Get all the product infomation from the SupplierProduct Table.
	 * 
	 * @return String : contain product information with the following 
	 * format: productId productName MeasureUnit basePrice,productId...
	 * 
	 */
	public String getProductInfo(){
		String str = "";
		List<SupplierProduct> list = this.purchaseOrderDao.queryProductList();
		int index=0;
		if(list.size()>0){
			for(; index<list.size()-1; index++){
				str += list.get(index).getProductId() + " " 
						+ list.get(index).getProductName() + " "
						+ list.get(index).getMeasureUnit() + " "
						+ list.get(index).getPrice() + " "
						+ list.get(index).getNumber() + ",";
			}
			str += list.get(index).getProductId() + " " 
			+ list.get(index).getProductName() + " "
			+ list.get(index).getMeasureUnit() + " "
			+ list.get(index).getPrice() + " "
			+ list.get(index).getNumber();
		}
		return str;
	}
	
	/**
	 * Part of NEW and EDIT a purchaseOrder
	 * Get all the purchaser infomation from the Purchaser Table.
	 * 
	 * @return String : contain product information with the following 
	 * format: orderRate
	 * 
	 */	
	public String getPurchaserInfo(String id){
		String str = "";
		Supplier purchaser = this.purchaseOrderDao.getPurchaserById(id);
		str += purchaser.getOrderRate();
		return str;
	}
	
	/**
	 * Part of NEW and EDIT a purchaseOrder
	 * Get all the Address infomation from the GoodsAddress Table.
	 * 
	 * @return String : contain product information with the following 
	 * format: addressId shippingAddress zipCode contacter telephone defaultOrNot,addressId...
	 * 
	 */
	public String getAddressInfo(GoodsAddress address){
		String str = "";
		List<GoodsAddress> list = this.purchaseOrderDao.queryGoodsAddressList(address);
		if(list.size() > 0){
			int index=0;
			for(; index<list.size()-1; index++){
				str += list.get(index).getAddressId() + " "
						+ list.get(index).getShippingAddress() + " "
						+ list.get(index).getZipCode() + " "
						+ list.get(index).getContacter() + " "
						+ list.get(index).getTelephone() + " "
						+ list.get(index).getDefaultOrNot() + ",";
			}
			str += list.get(index).getAddressId() + " "
				+ list.get(index).getShippingAddress() + " "
				+ list.get(index).getZipCode() + " "
				+ list.get(index).getContacter() + " "
				+ list.get(index).getTelephone() + " "
				+ list.get(index).getDefaultOrNot();
		}
		return str;
	}

	public PurchaseOrder getPurchaseOrderById(String id){
		return this.purchaseOrderDao.getPurchaseOrderById(id);
	}
	
	public PurchaseOrder getPurchaseOrderMoreById(String id){
		return this.purchaseOrderDao.getPurchaseOrderMoreById(id);
	}
	
	public String getPurchaseOrderInfo(String id){
		String str = "";
		PurchaseOrder purchaseOrder = this.purchaseOrderDao.getPurchaseOrderById(id);
		if(purchaseOrder == null)return str;
		str += purchaseOrder.getPurchaseOrderId() + " "
				+ purchaseOrder.getDeliverDate().split(" ")[0] + " "
				+ purchaseOrder.getFare() + " "
				+ purchaseOrder.getTotalPrice() + " "
				+ purchaseOrder.getReceiveAddressId();
		return str;
	}
	
	public String getPurchaseOrderDetailInfo(String id){
		String str = "";
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(id);
		List<PurchaseOrderDetail> list = this.purchaseOrderDao.queryPurchaseOrderDetailById(detail);
		if(list.size() > 0){
			int index = 0;
			for(; index<list.size()-1; index++){
				str += list.get(index).getProductId() + " "
						+ list.get(index).getProductName() + " "
						+ list.get(index).getMeasureUnit() + " "
						+ list.get(index).getPrice() + " "
						+ list.get(index).getNumber() + ",";
			}
			str += list.get(index).getProductId() + " "
				+ list.get(index).getProductName() + " "
				+ list.get(index).getMeasureUnit() + " "
				+ list.get(index).getPrice() + " "
				+ list.get(index).getNumber();
		}
		return str;
	}
	
	/**
	 * PurchaserOrderAction.queryDetailInfo()->this.getGoodsAddressInfoById(String)
	 * 
	 * @return String : Contain the information of an address
	 */
	public String getGoodsAddressInfoById(String id){
		String str="";
		GoodsAddress address = this.purchaseOrderDao.getGoodsAddressById(id);
		if(address == null) return str;
		str += address.getShippingAddress() + " "
			+ address.getZipCode() + " "
			+ address.getContacter() + " "
			+ address.getTelephone();
		return str;
	}
	
	/**
	 * PurchaserOrderAction.addPurchaseOrder()->this.addPurchaseOrder(PurchaseOrder)
	 * Add a new purchase order into the database
	 * 
	 * @return String : the primary key of the new purchase order.
	 */
	public String addPurchaseOrder(PurchaseOrder purchaseOrder){
		return this.purchaseOrderDao.addPurchaseOrder(purchaseOrder);
	}
	
	/**
	 * PurchaserOrderAction.addPurchaseOrder()->this.addPurchaseOrderDetail(String, String)
	 * Insert the products in the order into table PurchaseOrderDetail
	 */
	public void addPurchaseOrderDetail(String list, String pk){

		String[] addList = list.split(",");
		Map<String, Double> addMap = new HashMap<String, Double>();
		if(list != null && list.length() != 0 && list.trim().length() != 0){
			for(int index=0; index<addList.length; index++){
				int end = addList[index].lastIndexOf(" ");
				String key = addList[index].substring(0, end);
				Double value = Double.parseDouble(addList[index].substring(end+1));
				if(addMap.containsKey(key) == true){
					addMap.put(key, addMap.get(key)+value);
				} else {
					addMap.put(key, value);
				}
			}
		}
		
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(pk);		
		for(String key : addMap.keySet()){
			detail.setProductId(key.split(" ")[0]);
			detail.setMeasureUnit(key.split(" ")[2]);
			detail.setPrice(Double.parseDouble(key.split(" ")[3]));
			detail.setNumber(addMap.get(key));
			this.purchaseOrderDao.addPurchaseOrderDetail(detail);
		}
	}
	
	/**
	 * PurchaserOrderAction.updatePurchaseOrder()->this.updatePurchaseOrder(PurchaseOrder)
	 * Update the information of the specified purchase order.
	 * 
	 */
	public void updatePurchaseOrder(PurchaseOrder purchaseOrder){
		this.purchaseOrderDao.updatePurchaseOrder(purchaseOrder);
	}
	
	/**
	 * PurchaserOrderAction.updatePurchaseOrder()->this.updatePurchaseOrderDetail(String, String)
	 * Update the purchase order detail after updating purchase order as above.
	 * 
	 * Notice: some detail may already exits in the database, so you have combine them.
	 */
	public void updatePurchaseOrderDetail(String add, String original, String pk){
		Map<String,Double> originalMap=new HashMap<String, Double>();
		//original != null && original != "" && original.trim() != ""
		if(original != null && original.length() != 0 && original.trim().length() != 0){
			String[] originalList = original.split(",");
			for(int index=0; index<originalList.length; index++){
				originalMap.put(originalList[index].split(" ")[0], Double.parseDouble(originalList[index].split(" ")[4]));
			}
		}

		String[] addList = add.split(",");
		Map<String, Double> addMap = new HashMap<String, Double>();
		if(add != null && add.length() != 0 && add.trim().length() != 0){
			for(int index=0; index<addList.length; index++){
				int end = addList[index].lastIndexOf(" ");
				String key = addList[index].substring(0, end);
				Double value = Double.parseDouble(addList[index].substring(end+1));
				if(addMap.containsKey(key) == true){
					addMap.put(key, addMap.get(key)+value);
				} else {
					addMap.put(key, value);
				}
			}
		}
		
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(pk);		
		for(String key : addMap.keySet()){
			detail.setProductId(key.split(" ")[0]);
			detail.setMeasureUnit(key.split(" ")[2]);
			detail.setPrice(Double.parseDouble(key.split(" ")[3]));
			detail.setNumber(addMap.get(key));
			if(originalMap.containsKey(detail.getProductId())== true){
				detail.setNumber(detail.getNumber()+ originalMap.get(detail.getProductId()));
				this.purchaseOrderDao.updatePurchaseOrderDetail(detail);
			} else {
				this.purchaseOrderDao.addPurchaseOrderDetail(detail);
			}
		}
	}
	
	/**
	 * PurchaserOrderAction.cancelPurchaseOrder()->this.cancelPurchaseOrder(String)
	 * 
	 * Canceling a purchase order means changing its orderState. 
	 */
	public void cancelPurchaseOrder(String id){
		PurchaseOrder order = new PurchaseOrder();
		order.setPurchaseOrderId(id);
		order.setOrderState(3);
		this.purchaseOrderDao.updatePurchaseOrderState(order);
	}
	
	/**
	 * PurchaserOrderAction.comfirmReceiveGoods()->this.comfirmReceiveGoods(String)
	 * Purchaser comfirm receive goods and update the database.
	 * 
	 */
	public void comfirmReceiveGoodsUpdate(String id){
		PurchaseOrder order = new PurchaseOrder();
		order.setPurchaseOrderId(id);
		order.setOrderState(5);
		this.purchaseOrderDao.updatePurchaseOrderState(order);
	}
	
	public void payForDepositUpdate(PurchaseOrder order){
		order.setOrderState(2);
		this.purchaseOrderDao.updatePurchaseOrderState(order);
		this.purchaseOrderDao.updatePurchaseOrderDeposit(order);
	}
	
	public void evaluateForProductUpdate(PurchaseOrderDetail detail){
		this.purchaseOrderDao.evaluateForProductUpdate(detail);
	}
	
	public void payForGoodsUpdate(String id){
		PurchaseOrder order = new PurchaseOrder();
		order.setPurchaseOrderId(id);
		order.setOrderState(6);
		this.purchaseOrderDao.updatePurchaseOrderState(order);
	}
	
	/**
	 * PurchaserOrderAction.logisticsInformation()->this.logisticsInformation(String)
	 * 
	 * @return PurchaseOrder : which contains logistics information 
	 */
	public PurchaseOrder logisticsInformation(String id){
		return this.purchaseOrderDao.logisticsInformation(id);
	}
	
	/**
	 * PurchaserOrderAction.goodsAddressManage()->this.queryGoodsAddress()
	 * 
	 * @return List<GoodsAddress> : the goods address list of the current user.
	 */
	public List<GoodsAddress> queryGoodsAddress(String userId){
		GoodsAddress address = new GoodsAddress();
		address.setUserId(userId);
		address.setSendOrReceive(false);
		return this.purchaseOrderDao.queryGoodsAddressList(address);
	}
	
	public PurchaseOrderDao getPurchaseOrderDao() {
		return purchaseOrderDao;
	}

	public void setPurchaseOrderDao(PurchaseOrderDao purchaseOrderDao) {
		this.purchaseOrderDao = purchaseOrderDao;
	}
	
	public List<PurchaseOrderDetail> queryPurchaseOrderDetail(String id){
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(id);
		return this.purchaseOrderDao.queryPurchaseOrderDetailById(detail);
	}
	
	/**
	 * The current user confirmed the reject and the action update the database here.
	 * 
	 * @return SUCCESS
	 */
	public void updateRejectedPurchaseOrder(PurchaseOrder purchaseOrder){
		this.purchaseOrderDao.updateRejectedPurchaseOrder(purchaseOrder);
		purchaseOrder.setOrderState(7);
		this.purchaseOrderDao.updatePurchaseOrderState(purchaseOrder);
	}
	
	public void updateRejectedPurchaseOrderDetail(String id, String rejectList){
		String[] list = rejectList.split(",");
		PurchaseOrderDetail detail = new PurchaseOrderDetail();
		detail.setPurchaseOrderId(id);
		for(int index=0; index<list.length; index++){
			String[] arr = list[index].split(" ");
			detail.setProductId(arr[0]);
			if(arr.length <=1){
				detail.setReturnNumber(0.0);
			} else {
				detail.setReturnNumber(Double.parseDouble(arr[1]));
			}
			
			this.purchaseOrderDao.updateRejectedPurchaseOrderDetail(detail);
		}
	}
	
	public Integer countNonEndCentralizedPurchase(String cppid){
		return this.purchaseOrderDao.countNonEndCentralizedPurchase(cppid);
	}
	
	public void updateCentralizedPurchaseStateToEnd(CentralizedPlanedPurchase purchase){
		this.purchaseOrderDao.updateCentralizedPurchaseStateToEnd(purchase);
	}
	
	public void updateSupplierIntegrityLevel(Supplier supplier){
		this.purchaseOrderDao.updateSupplierIntegrityLevel(supplier);
	}

	public SupplierProduct getSupplierProductByProductId(String id) {
		return this.purchaseOrderDao.getSupplierProductByProductId(id);
	}
}
