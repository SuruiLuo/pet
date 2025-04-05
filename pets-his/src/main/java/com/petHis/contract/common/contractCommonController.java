package com.petHis.contract.common;

import com.alibaba.fastjson.JSONObject;
import com.petHis.common.exception.AlertException;
import com.petHis.contract.BlockService;
import com.petHis.contract.data.PetInsurance;
import com.petHis.contract.service.PetInsuranceService;
import com.petHis.project.system.user.domain.User;
import com.petHis.project.system.user.service.UserServiceImpl;
import org.fisco.bcos.sdk.client.protocol.response.BcosBlock;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;


@RestController
@RequestMapping("/common")
public class contractCommonController {

    @Resource
    private BlockService blockService;

    @Resource
    private PetInsuranceService petInsuranceService;

    @Resource
    private UserServiceImpl userService;

    /**
     * Description 分页查询
     * Author jingwen
     * Date 2022-08-29 16:21:58
     **/
    @GetMapping("/getBlockchainInfo")
    public JSONObject getBlockchainInfo() {
        return blockService.getBlockchainInfo();
    }

    @GetMapping("/getBlockNumberDetails")
    public BcosBlock getBlockNumberDetails(@RequestParam Long blockNumber) {
        return blockService.getBlockNumberDetails(blockNumber);
    }

    @GetMapping("/getPhoneNumber")
    public List<com.petHis.contract.data.PetInsurance.TradeLog> getPhoneNumber(@RequestParam Long phoneNumber) {
        User user = userService.selectUserByPhoneNumber(phoneNumber.toString());
        if (user == null) {
            throw new AlertException("不存在该用户");
        }
        List<PetInsurance.TradeLog> tradeLogsByUser = petInsuranceService.getTradeLogsByUser(user.getUserId());
        return tradeLogsByUser;
    }

}

