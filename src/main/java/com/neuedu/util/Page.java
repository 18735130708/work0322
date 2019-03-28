package com.neuedu.util;

import lombok.Data;

/**
 * Created by Administrator on 2019/3/26.
 */
@Data
public class Page {
    private Integer pageNo = 1;
    private Integer pageSize = 10;
    private Integer withPage = 1;//1  分页  0  不分页

    public int getPageStart(){
        return (pageNo-1)*pageSize;
    }
}
