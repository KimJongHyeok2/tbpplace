package com.web.TBP.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@RestController
@RequestMapping("/upload")
public class RestUploadController {
	
	// CommonsMultipartResolver
/*	@RequestMapping(value = "/img", method = RequestMethod.POST)
	public String img(MultipartHttpServletRequest multi) {
		
		String root = multi.getSession().getServletContext().getRealPath("/");
		String path = root + "resources/upload/";
		
		File dir = new File(path);
		if(!dir.isDirectory()) {
			dir.mkdir();
		}
		
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String uploadFile = files.next();
			
			MultipartFile mFile = multi.getFile(uploadFile);
			
			String fileName_original = mFile.getOriginalFilename();
			String file_save_path = "C:\\Users\\jin_a\\Desktop\\Combine\\";
		
			try {
				mFile.transferTo(new File(file_save_path+fileName_original));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "Ok";
	}*/
	
	@RequestMapping(value = "/img", method = RequestMethod.POST)
	public Map<Integer, String> img(HttpServletRequest request, HttpServletResponse response) {
		DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload");
		
		Map<Integer, String> map = new HashMap<Integer, String>();
		
		File dir = new File(saveDirectory);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		try {
			MultipartRequest multi = new MultipartRequest(request, saveDirectory, 10*1024*1024, "UTF-8", rename);
			Enumeration<String> enums = multi.getFileNames();
			int i = 0;
			while(enums.hasMoreElements()) {
				String name = enums.nextElement().toString();
				map.put(i, multi.getOriginalFileName(name));
				i++;
				map.put(i, multi.getFilesystemName(name));
				i++;
			}
			response.setCharacterEncoding("UTF-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return map;
	}
	
}