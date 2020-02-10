package com.panda.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

/**
 * Created with IDEA.
 * 使用同步方法生成 不同类型的批次号
 * synchronized 关键字
 * @AUTH: Alan
 * Date: 2017/12/4
 * Time: 22:35
 */
public class CreateBatchNoUtil {

    private static String date;


    public static synchronized String createBatchNo() {
        String str = new SimpleDateFormat("yyyyMMddHHSSS").format(new Date());
        if (date == null || !date.equals(str)) {
            date = str;
        }
        long time = System.currentTimeMillis();
        if (time != 0) {
            String top = ("" + time).substring(("" + time).length() - 2, ("" + time).length());
            String bot = str.substring(0, str.length() - 2);
            String oNo = bot + Integer.parseInt(top);
            if (oNo.length() == 12) {
                oNo+=(Random()+"");
            }else if (oNo.length() == 13) {
                oNo+=(Random()+"").substring(1,2);
            }
            return oNo;
        } else {
            String top = str.substring(str.length() - 2, str.length());
            String bot = str.substring(0, str.length() - 2);
            return bot + "" + (Integer.parseInt(top) + Random());
        }
    }

    public static int Random() {
        int max = 20;
        int min = 10;
        Random random = new Random();
        int s = random.nextInt(max) % (max - min + 1) + min;
        return s;
    }


    /**
     * 测试
     * @param args
     * @throws InterruptedException
     */
    public static void main(String args[]) throws InterruptedException {
        String []ma=new String[1000];

        // TODO Auto-generated method stub
        for (int i = 0; i < 1000; i++) {
            Thread.sleep(1);

            System.out.println(createBatchNo().length()!=14?true:"");
        }
    }
}
