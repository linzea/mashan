package com.panda.controller.system.index;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import jxl.Workbook;
import jxl.format.Colour;
import jxl.write.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

/**
 * Created with IDEA.
 *
 * @AUTH: Alan
 * Date: 2017/12/8
 * Time: 15:39
 */
@Controller
@RequestMapping(value = "/system/export")
public class ExportFileController {

    /**
     * 设置头的样式
     * @return
     * @throws WriteException
     */
    private WritableCellFormat getHeader() throws WriteException {
        WritableFont font = new WritableFont(WritableFont.createFont("微软雅黑"),24,WritableFont.BOLD);
        font.setColour(jxl.format.Colour.BLUE);// 蓝色字体
        WritableCellFormat format = new WritableCellFormat(font);
        format.setAlignment(jxl.format.Alignment.CENTRE);// 左右居中
        format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);// 上下居中
        format.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK);// 黑色边框
        format.setBackground(jxl.format.Colour.YELLOW); // 黄色背景
        return format;
    }

    /**
     * 设置标题样式
     * @return
     * @throws WriteException
     */
    private WritableCellFormat getTitle() throws WriteException {
        WritableFont font = new WritableFont(WritableFont.createFont("微软雅黑"),12);
        font.setColour(jxl.format.Colour.BLUE);// 蓝色字体
        WritableCellFormat format = new WritableCellFormat(font);
        format.setAlignment(jxl.format.Alignment.CENTRE);
        format.setBackground(jxl.format.Colour.YELLOW);
        format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        format.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK);

        return format;
    }

    /**
     * 设置其他单元格样式
     * @return
     * @throws WriteException
     */
    private WritableCellFormat getNormolCell(String type) throws WriteException { // 12号字体,上下左右居中,带黑色边框
        WritableFont font = new WritableFont(WritableFont.createFont("微软雅黑"),12);
        WritableCellFormat format = new WritableCellFormat(font);
        format.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK);// 黑色边框
        format.setAlignment(jxl.format.Alignment.CENTRE);
        format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
        if (!type.isEmpty() && type.equals("0")){
            format.setBackground(Colour.GREEN);
            font.setColour(Colour.WHITE);
        }else if (type.equals("1")){
            format.setBackground(Colour.RED);
            font.setColour(Colour.WHITE);
        }
        return format;
    }

    /**
     * 导出文件主方法入口
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "exportFileIndex")
    public void exportFileIndex(HttpServletRequest request, HttpServletResponse response,List<Map> exportDataList,String titleName,String fileType) throws Exception {
        if (!exportDataList.isEmpty() && exportDataList.size() > 0 && !titleName.isEmpty()) {
            response.reset();
            //电子表响应MIME类型
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //客户端另存文件时提供一个建议的文件名
            //response.setHeader("Content-Disposition", "attachment; filename="+titleName+".xls");//  inline
            response.setHeader("content-disposition", "attachment;filename="+ URLEncoder.encode(titleName+".xls", "UTF-8"));
            if (fileType.equals("excel")){
                exportExcelFile(response.getOutputStream(), exportDataList,titleName);
            }
        }
    }

    /**
     * 将数据写入EXCEL文件
     * @param os
     * @param exportDataList
     * @throws Exception
     */
    private void exportExcelFile(OutputStream os, List<Map> exportDataList, String fileName) throws Exception {
        WritableWorkbook wwb = Workbook.createWorkbook(os);
        // 创建Excel工作表
        WritableSheet sheet = wwb.createSheet(fileName, 0);// 创建sheet
        for(int i=1;i<15;i++){
            sheet.setColumnView(i, 40);
        }
        sheet.setColumnView(0, 20);
        sheet.setRowView(0, 400);
        sheet.setRowView(1, 400);
        sheet.setRowView(2, 400);
        sheet.mergeCells(0, 0, 4, 1); // 合并单元格
        Label header = new Label(0, 0, fileName, getHeader());
        sheet.addCell(header); // 写入头
        Label l = new Label(0, 2, "前缀", getTitle()); // 第3行
        sheet.addCell(l);
        l = new Label(1, 2, "批次号", getTitle());
        sheet.addCell(l);
        l = new Label(2, 2, "溯源码", getTitle());
        sheet.addCell(l);
        l = new Label(3, 2, "是否使用", getTitle());
        sheet.addCell(l);
        l = new Label(4, 2, "创建时间", getTitle());
        sheet.addCell(l);
        int row = 3;
        for (Map p : exportDataList) {
            sheet.setRowView(row, 400);
            l = new Label(0, row, p.get("prefixVal").toString(), getNormolCell(""));
            sheet.addCell(l);
            l = new Label(1, row, p.get("batchNum").toString(), getNormolCell(""));
            sheet.addCell(l);
            l = new Label(2, row, p.get("originCode").toString(), getNormolCell(""));
            sheet.addCell(l);
            l = new Label(3, row, p.get("createStatus").toString().equals("0")?"未使用":"已使用", getNormolCell(p.get("createStatus").toString()));
            sheet.addCell(l);
            l = new Label(4, row, p.get("createTime").toString(), getNormolCell(""));
            sheet.addCell(l);
            row++;
        }
        // 输出流
        wwb.write();
        // 关闭流
        wwb.close();
    }
}
