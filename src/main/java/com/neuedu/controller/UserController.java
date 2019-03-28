package com.neuedu.controller;

import com.github.pagehelper.Page;
import com.neuedu.pojo.User;
import com.neuedu.service.user.UserService;
import com.neuedu.util.Message;
import com.neuedu.util.CodeUtil;
import com.neuedu.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;

/**
 * Created by Administrator on 2019/3/22.
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Resource
    UserService userService;
    @GetMapping("/list")
    public String list(){
        return "user/list";
    }
    @GetMapping("/getList")
    @ResponseBody
    public Message getList(User user){
        Page<User> users = (Page<User>)userService.list(user);
        return new Message(1,new Result(users,users.getPageNum(), (int) users.getTotal(),users.getPageSize()));
    }


    @GetMapping("/goAdd")
    public String goAdd(){
        return "user/add";
    }
    /*@PostMapping("/doAdd")
    public String doAdd(User user){
        userService.add(user);
        return "redirect:list";
    }*/
    /*@GetMapping("/goUpdate")
    public String goUpdate(Integer id,ModelMap modelMap){
        modelMap.addAttribute("user",userService.getUserById(id));
        return "user/edit";
    }*/
    /*@PostMapping("/doUpdate")
    public String doUpdate(User user){
        userService.update(user);
        return "redirect:list";
    }*/
    /*@GetMapping("/del")
    public String del(Integer id,Integer flag){
        if(flag==1){
            userService.delete(id);
        }else{
            userService.reback(id);
        }
        return "redirect:list";
    }*/

    @GetMapping("/goLogin")
    public String goLogin(){
        return "user/login";
    }

    @PostMapping("/doLogin")
    @ResponseBody
    public Message doLogin(User user,String code,HttpServletResponse response,HttpSession session) throws IOException {
        Message message = null;
        if(userService.login(user)==null){
            System.out.println("用户不存在");
            message = new Message(0,"用户不存在");
        }else{
            User user1 = userService.login(user);
            if(!user1.getPassword().equals(user.getPassword())){
                System.out.println("密码错误");
                message = new Message(0,"密码错误");
            }else{
                if(session.getAttribute("img")==null){
                    message = new Message(0,"登录超时");
                }else{
                    String img = session.getAttribute("img").toString();
                    if(!img.equalsIgnoreCase(code)){
                        message = new Message(0,"验证码错误");
                    }else{
                        message = new Message(1,"登陆成功");
                    }
                }
            }
        }
        return message;
    }

    @GetMapping("/img")
    public void getImg(HttpServletResponse response, HttpSession session) throws IOException {
        char[] array = CodeUtil.getCode();
        BufferedImage image = new BufferedImage(100,43,BufferedImage.TYPE_INT_RGB);
        Graphics2D graphics = image.createGraphics();
        graphics.setColor(Color.BLACK);
        graphics.fillRect(0,0,100,43);
        graphics.setColor(Color.WHITE);
        graphics.setFont(new Font("微软雅黑",Font.BOLD,32));
        graphics.drawString(new String(array),5,30);
        session.setAttribute("img",new String(array));
        ImageIO.write(image,"JPG",response.getOutputStream());
    }

    /*@GetMapping("/goRegister")
    public String goRegister(){
        return "user/register";
    }

    @PostMapping("/doRegister")
    public String doRegister(User user,ModelMap modelMap){
        List<User> list = userService.list(user);
        for(User u : list){
            if(u.getLoginId().equals(user.getLoginId())){
                modelMap.addAttribute("message","登录ID已存在");
                return "user/register";
            }
        }
        userService.add(user);
        return "redirect:goLogin";
    }*/
}
