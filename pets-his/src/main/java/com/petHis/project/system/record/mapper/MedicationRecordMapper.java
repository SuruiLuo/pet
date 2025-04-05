package com.petHis.project.system.record.mapper;

import java.util.List;
import com.petHis.project.system.record.domain.MedicationRecord;

/**
 * 用药记录Mapper接口
 * 
 * @author petHis
 * @date 2025-02-23
 */
public interface MedicationRecordMapper 
{
    /**
     * 查询用药记录
     * 
     * @param medicationId 用药记录主键
     * @return 用药记录
     */
    public MedicationRecord selectMedicationRecordByMedicationId(Long medicationId);

    /**
     * 查询用药记录列表
     * 
     * @param medicationRecord 用药记录
     * @return 用药记录集合
     */
    public List<MedicationRecord> selectMedicationRecordList(MedicationRecord medicationRecord);

    /**
     * 新增用药记录
     * 
     * @param medicationRecord 用药记录
     * @return 结果
     */
    public int insertMedicationRecord(MedicationRecord medicationRecord);

    /**
     * 修改用药记录
     * 
     * @param medicationRecord 用药记录
     * @return 结果
     */
    public int updateMedicationRecord(MedicationRecord medicationRecord);

    /**
     * 删除用药记录
     * 
     * @param medicationId 用药记录主键
     * @return 结果
     */
    public int deleteMedicationRecordByMedicationId(Long medicationId);

    /**
     * 批量删除用药记录
     * 
     * @param medicationIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteMedicationRecordByMedicationIds(String[] medicationIds);
}
