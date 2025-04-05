package com.petHis.project.system.insurance.service;

import java.util.List;
import com.petHis.project.system.insurance.domain.Insurance;

/**
 * 保险Service接口
 * 
 * @author petHis
 * @date 2025-03-17
 */
public interface IInsuranceService 
{
    /**
     * 查询保险
     * 
     * @param insuranceId 保险主键
     * @return 保险
     */
    public Insurance selectInsuranceByInsuranceId(Long insuranceId);

    /**
     * 查询保险列表
     * 
     * @param insurance 保险
     * @return 保险集合
     */
    public List<Insurance> selectInsuranceList(Insurance insurance);

    /**
     * 新增保险
     * 
     * @param insurance 保险
     * @return 结果
     */
    public int insertInsurance(Insurance insurance);

    /**
     * 修改保险
     * 
     * @param insurance 保险
     * @return 结果
     */
    public int updateInsurance(Insurance insurance);

    /**
     * 批量删除保险
     * 
     * @param insuranceIds 需要删除的保险主键集合
     * @return 结果
     */
    public int deleteInsuranceByInsuranceIds(String insuranceIds);

    /**
     * 删除保险信息
     * 
     * @param insuranceId 保险主键
     * @return 结果
     */
    public int deleteInsuranceByInsuranceId(Long insuranceId);
}
