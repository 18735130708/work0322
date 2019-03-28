package com.neuedu.util;

import java.util.Random;

/**
 * Created by Administrator on 2019/3/26.
 */
public class CodeUtil {
    static final String CODES = "abdefghijmnqrtyABDEFGHJLMNQRTY23456789";
    static final int LEN = 4;
    public static char[] getCode(){
        char[] arr = new char[LEN];
        Random random = new Random();
        for(int i=0;i<LEN;i++){
            arr[i] = CODES.charAt(random.nextInt(CODES.length()-1));
        }
        return arr;
    }
}
