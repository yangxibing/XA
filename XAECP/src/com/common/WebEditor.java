package com.common;
import javax.servlet.http.HttpServletRequest;

import com.fredck.FCKeditor.FCKeditor;
import com.fredck.FCKeditor.FCKeditorConfigurations;

public class WebEditor
{
	public static void createFCKEditor(HttpServletRequest request, String width, String height)
	{
		String path = request.getContextPath();
		FCKeditor oFCKeditor;
		// 定义一个属性来使Action通过request来获得FCKeditor编辑器中的值
		oFCKeditor = new FCKeditor(request, "content");
		FCKeditorConfigurations con = new FCKeditorConfigurations();
		oFCKeditor.setConfig(con);
		oFCKeditor.setBasePath(path + "/FCKeditor/");
		oFCKeditor.setWidth(width);
		oFCKeditor.setHeight(height);
		
		oFCKeditor.setInstanceName("content");
		// 设置FCKeditor编辑器打开时的默认值
		oFCKeditor.setValue("");
		request.setAttribute("editor", oFCKeditor.create());
	}
}
