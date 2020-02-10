package com.panda.controller.system.origin;

import com.panda.service.origin.AssemblySetService;
import com.panda.util.ResultMsgUtil;
import com.panda.util.ResultStateUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/system/createQrCode")
public class CreateQrCodeController {

    @Resource
    private AssemblySetService assemblySetService;

    private static boolean message = false;
    private static Object data = null;

    /**
     * 获取生产线绑定的加工设备信息
     * @param request
     * @param id
     * @param unitUsage
     * @return
     */
    @RequestMapping(value = "/getEquipmentData", method = RequestMethod.POST)
    @ResponseBody
    public Object getEquipmentData(HttpServletRequest request, String id, String unitUsage,String dicTeaAttr) {
        message = false;
        data = null;
        try {
            if (!id.isEmpty() && !unitUsage.isEmpty()) {
                Map query = new HashMap();
                query.put("id",id);
                query.put("unitUsage",unitUsage);
                query.put("dicTeaAttr",dicTeaAttr);
                List<Map> equList = assemblySetService.createQrCodeGetEquipment(query);
                if (equList != null && equList.size() > 0){
                    data = equList;
                    message = true;
                }else{
                    data = ResultStateUtil.NO_MORE_DATA;
                }
            } else {
                data = ResultStateUtil.ERROR_PARAMETER_IS_EMPTY;
            }
        } catch (Exception e) {
            e.printStackTrace();
            data = ResultStateUtil.ERROR_DATABASE_OPERATION;
        }
        return ResultMsgUtil.getResultMsg(message, data);
    }
}
