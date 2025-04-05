package com.petHis.project.system.insurance.service.impl;

import java.util.List;

import com.petHis.contract.service.PetInsuranceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.insurance.mapper.InsuranceMapper;
import com.petHis.project.system.insurance.domain.Insurance;
import com.petHis.project.system.insurance.service.IInsuranceService;
import com.petHis.common.utils.text.Convert;

/**
 * 保险Service业务层处理
 * 
 * @author petHis
 * @date 2025-03-17
 */
@Service
public class InsuranceServiceImpl implements IInsuranceService 
{
    @Autowired
    private InsuranceMapper insuranceMapper;

    @Autowired
    private PetInsuranceService petInsuranceService;

    /**
     * 查询保险
     * 
     * @param insuranceId 保险主键
     * @return 保险
     */
    @Override
    public Insurance selectInsuranceByInsuranceId(Long insuranceId)
    {
        return insuranceMapper.selectInsuranceByInsuranceId(insuranceId);
    }

    /**
     * 查询保险列表
     * 
     * @param insurance 保险
     * @return 保险
     */
    @Override
    public List<Insurance> selectInsuranceList(Insurance insurance)
    {
        return insuranceMapper.selectInsuranceList(insurance);
    }

    /**
     * 新增保险
     * 
     * @param insurance 保险
     * @return 结果
     */
    @Override
    public int insertInsurance(Insurance insurance)
    {
        int i = insuranceMapper.insertInsurance(insurance);
        petInsuranceService.addInsurance(
                insurance.getInsuranceId(),
                insurance.getName(),
                insurance.getLevel1Num().toBigInteger(),
                insurance.getLevel1ClaimRatio().toBigInteger(),
                insurance.getLevel2Num().toBigInteger(),
                insurance.getLevel2ClaimRatio().toBigInteger(),
                insurance.getPremium().toBigInteger()
        );
        return i;
    }

    /**
     * 修改保险
     * 
     * @param insurance 保险
     * @return 结果
     */
    @Override
    public int updateInsurance(Insurance insurance)
    {
        return insuranceMapper.updateInsurance(insurance);
    }

    /**
     * 批量删除保险
     * 
     * @param insuranceIds 需要删除的保险主键
     * @return 结果
     */
    @Override
    public int deleteInsuranceByInsuranceIds(String insuranceIds)
    {
        return insuranceMapper.deleteInsuranceByInsuranceIds(Convert.toStrArray(insuranceIds));
    }

    /**
     * 删除保险信息
     * 
     * @param insuranceId 保险主键
     * @return 结果
     */
    @Override
    public int deleteInsuranceByInsuranceId(Long insuranceId)
    {
        return insuranceMapper.deleteInsuranceByInsuranceId(insuranceId);
    }
}
