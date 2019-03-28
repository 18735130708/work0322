<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/22
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/pages/common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="${path}/css/pintuer.css">
    <link rel="stylesheet" href="${path}/css/admin.css">
    <script src="${path}/js/jquery.js"></script>
    <script src="${path}/js/pintuer.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
</head>
<body>
<form method="post" action="" id="listform">
    <div id="app" class="panel admin-panel">
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <li> <a class="button border-main icon-plus-square-o" href="goAdd">添加用户</a> </li>
                    <li>
                        <select v-model="whereParams.sex" name="s_ishome" class="input" onchange="changesearch()" style="width:60px; line-height:17px; display:inline-block">
                            <option value="">性别</option>
                            <option value="1">男</option>
                            <option value="0">女</option>
                        </select>
                    </li>
                    <li>
                        <input v-model="whereParams.loginId" type="text" placeholder="请输入搜索登录ID" class="input" style="width:150px; line-height:17px;display:inline-block" />
                        <input v-model="whereParams.name" type="text" placeholder="请输入搜索姓名" class="input" style="width:150px; line-height:17px;display:inline-block" />
                        <input v-model="whereParams.phone" type="text" placeholder="请输入搜索电话" class="input" style="width:150px; line-height:17px;display:inline-block" />
                        <a href="javascript:void(0)" class="button border-main icon-search" @click="search()" > 搜索</a>
                    </li>
                </ul>
        </div>
        <table class="table table-hover text-center">
            <thead>
                <tr>
                    <th width="6%" style="text-align:left; padding-left:20px;">ID</th>
                    <th width="8%">登录ID</th>
                    <th width="5%">昵称</th>
                    <th width="10%">电话</th>
                    <th width="5%">性别</th>
                    <th width="10%">生日</th>
                    <th width="10%">邮箱</th>
                    <th width="10%">地址</th>
                    <th width="20%">操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="user in list">
                    <td style="text-align:left; padding-left:20px;"><input type="checkbox" name="id[]" value="" />{{user.id}}</td>
                    <td>{{user.loginId}}</td>
                    <td>{{user.name}}</td>
                    <td>{{user.phone}}</td>
                    <td>
                        <template v-if="user.sex==1">男</template>
                        <template v-else>女</template>
                    </td>
                    <td>{{user.birthday}}</td>
                    <td>{{user.email}}</td>
                    <td>{{user.address}}</td>
                    <%--<td>
                        <div class="button-group">
                            <a class="button border-main" href="goUpdate?id={{user.id}}">
                                <span class="icon-edit"></span> 修改
                            </a>
                            <template v-if="{{user.isDel==1}}">
                                <a class="button border-red" href="javascript:void(0)" onclick="return del('{{user.id}}',1)">
                                    <span class="icon-trash-o"></span> 删除</a>
                            </template>
                            <template v-else>
                                <a class="button border-red" href="javascript:void(0)" onclick="return del('{{user.id}}',0)">
                                    <span class="icon-trash-o"></span> 恢复</a>
                            </template>
                        </div>
                    </td>--%>
                </tr>
            </tbody>

                <tr>
                    <td colspan="8">
                        <div class="pagelist">
                            <a v-if="queryParams.pageNo == 1" href="javascript:void(0)">首页</a>
                            <a v-else href="javascript:void(0)" @click="changePageNo(1)">首页</a>
                            <a v-if="queryParams.pageNo == 1" href="javascript:void(0)">上一页</a>
                            <a v-else href="javascript:void(0)" @click="changePageNo(queryParams.pageNo - 1)">上一页</a>
                            <template v-if="max<=5">
                                <template v-for="n in max">
                                    <span v-if="n == queryParams.pageNo" class="current">{{n}}</span>
                                    <a v-else href="javascript:void(0)" @click="changePageNo(n)">{{n}}</a>
                                </template>
                            </template>
                            <template v-else>
                                <template v-for="n in 5">
                                    <span v-if="(n+size.start-1) == queryParams.pageNo" class="current">{{n+size.start-1}}</span>
                                    <a v-else href="javascript:void(0)" @click="changePageNo(n+size.start-1)">{{n+size.start-1}}</a>
                                </template>
                            </template>
                            <a v-if="queryParams.pageNo == max" href="javascript:void(0)">下一页</a>
                            <a v-else href="javascript:void(0)" @click="changePageNo(queryParams.pageNo + 1)">下一页</a>
                            <a v-if="queryParams.pageNo == max" href="javascript:void(0)">尾页</a>
                            <a v-else href="javascript:void(0)" @click="changePageNo(max)">尾页</a>
                        </div>
                    </td>
                </tr>
        </table>
    </div>
</form>
    <script>
        new Vue({
            el:"#app",
            data(){
                return {
                    list:[],
                    max:0,
                    queryParams:{
                        name:"",
                        loginId:"",
                        phone:"",
                        sex:"",
                        pageNo:1
                    },
                    whereParams:{
                        name:"",
                        loginId:"",
                        phone:"",
                        sex:"",
                        pageNo:1
                    }
                }
            },
            computed:{
                size(){
                    let start = this.queryParams.pageNo-2;
                    let end = this.queryParams.pageNo+2;
                    if(start <= 0){
                        start = 1;
                        end = 5;
                    }
                    if(end >= this.max){
                        end = this.max;
                        start = end-4;
                    }
                    return {
                        start : start,
                        end:end
                    }
                }
            },
            created(){
                this.getList();
            },
            methods:{
                changePageNo(n){
                    this.queryParams.pageNo = n;
                    this.getList();
                },
                getList(){
                    let vue = this;
                    $.ajax({
                        url:"${path}/user/getList",
                        dataType:"json",
                        data:vue.queryParams,
                        success:function (result) {
                            vue.list = result.message.list;
                            vue.queryParams.pageNo = result.message.pageNo;
                            vue.max = result.message.maxSize;
                        }
                    });
                },
                search(){
                    this.queryParams = this.whereParams;
                    this.getList();
                }
            }
        });

    </script>
<script type="text/javascript">





    //搜索
    function changesearch(){

    }

    //单个删除
    function del(id,flag){
        var message = flag==1?"您确定要删除吗?":"您确定要恢复吗?";
        if(confirm(message)){
            window.location.href="del?id="+id+"&flag="+flag;
        }
    }

    //全选
    $("#checkall").click(function(){
        $("input[name='id[]']").each(function(){
            if (this.checked) {
                this.checked = false;
            }
            else {
                this.checked = true;
            }
        });
    })

    //批量删除
    function DelSelect(){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){
            var t=confirm("您确认要删除选中的内容吗？");
            if (t==false) return false;
            $("#listform").submit();
        }
        else{
            alert("请选择您要删除的内容!");
            return false;
        }
    }

    //批量排序
    function sorts(){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");
            return false;
        }
    }


    //批量首页显示
    function changeishome(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量推荐
    function changeisvouch(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){


            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量置顶
    function changeistop(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }


    //批量移动
    function changecate(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量复制
    function changecopy(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){
            var i = 0;
            $("input[name='id[]']").each(function(){
                if (this.checked==true) {
                    i++;
                }
            });
            if(i>1){
                alert("只能选择一条信息!");
                $(o).find("option:first").prop("selected","selected");
            }else{

                $("#listform").submit();
            }
        }
        else{
            alert("请选择要复制的内容!");
            $(o).find("option:first").prop("selected","selected");
            return false;
        }
    }

</script>
</body>
</html>
