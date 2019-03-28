package com.neuedu.controller;

import org.apache.commons.io.FilenameUtils;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created by Administrator on 2019/3/26.
 */
@Controller
public class FrameController {
    @GetMapping("/index")
    public String index(){
        return "index";
    }

    @GetMapping("/upload")
    public String goUpload(){
        return "upload";
    }
    @PostMapping("/upload")
    public void doUpload(MultipartFile img, HttpServletRequest request){
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        StringBuilder builder = new StringBuilder(df.format(new Date()));
        Random random = new Random();
        for(int i=0;i<4;i++)
            builder.append(random.nextInt(10));
        File file = new File(request.getServletContext().getRealPath("/resource/images/")+builder+"."+ FilenameUtils.getExtension(img.getOriginalFilename()));
        try {
            img.transferTo(file);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
