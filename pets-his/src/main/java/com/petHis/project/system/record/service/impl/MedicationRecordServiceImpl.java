package com.petHis.project.system.record.service.impl;

import java.util.List;
import com.petHis.common.utils.DateUtils;
import com.petHis.contract.service.PetInsuranceService;
import com.petHis.project.system.appointments.domain.Appointments;
import com.petHis.project.system.appointments.service.IAppointmentsService;
import com.petHis.project.system.inventory.domain.DrugInventory;
import com.petHis.project.system.inventory.service.IDrugInventoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.record.mapper.MedicationRecordMapper;
import com.petHis.project.system.record.domain.MedicationRecord;
import com.petHis.project.system.record.service.IMedicationRecordService;
import com.petHis.common.utils.text.Convert;

/**
 * 用药记录Service业务层处理
 * 
 * @author petHis
 * @date 2025-02-23
 */
@Service
public class MedicationRecordServiceImpl implements IMedicationRecordService 
{
    @Autowired
    private MedicationRecordMapper medicationRecordMapper;

    @Autowired
    private IAppointmentsService appointmentsService;

    @Autowired
    private IDrugInventoryService drugInventoryService;

    @Autowired
    private PetInsuranceService petInsuranceService;

    /**
     * 查询用药记录
     * 
     * @param medicationId 用药记录主键
     * @return 用药记录
     */
    @Override
    public MedicationRecord selectMedicationRecordByMedicationId(Long medicationId)
    {
        return medicationRecordMapper.selectMedicationRecordByMedicationId(medicationId);
    }

    /**
     * 查询用药记录列表
     * 
     * @param medicationRecord 用药记录
     * @return 用药记录
     */
    @Override
    public List<MedicationRecord> selectMedicationRecordList(MedicationRecord medicationRecord)
    {
        return medicationRecordMapper.selectMedicationRecordList(medicationRecord);
    }

    /**
     * 新增用药记录
     * 
     * @param medicationRecord 用药记录
     * @return 结果
     */
    @Override
    public int insertMedicationRecord(MedicationRecord medicationRecord)
    {
        medicationRecord.setCreateTime(DateUtils.getNowDate());
        Appointments appointments = appointmentsService.selectAppointmentsByAppointmentId(medicationRecord.getAppointmentId());
        petInsuranceService.claimInsurance(appointments.getPetId(),medicationRecord.getFrequency().toBigInteger());
        return medicationRecordMapper.insertMedicationRecord(medicationRecord);
    }

    /**
     * 修改用药记录
     * 
     * @param medicationRecord 用药记录
     * @return 结果
     */
    @Override
    public int updateMedicationRecord(MedicationRecord medicationRecord)
    {
        return medicationRecordMapper.updateMedicationRecord(medicationRecord);
    }

    /**
     * 批量删除用药记录
     * 
     * @param medicationIds 需要删除的用药记录主键
     * @return 结果
     */
    @Override
    public int deleteMedicationRecordByMedicationIds(String medicationIds)
    {
        return medicationRecordMapper.deleteMedicationRecordByMedicationIds(Convert.toStrArray(medicationIds));
    }

    /**
     * 删除用药记录信息
     * 
     * @param medicationId 用药记录主键
     * @return 结果
     */
    @Override
    public int deleteMedicationRecordByMedicationId(Long medicationId)
    {
        return medicationRecordMapper.deleteMedicationRecordByMedicationId(medicationId);
    }
}
