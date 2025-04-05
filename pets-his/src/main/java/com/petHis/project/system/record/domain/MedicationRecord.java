package com.petHis.project.system.record.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;

import java.math.BigDecimal;
import java.util.Date;


/**
 * 用药记录对象 medication_record
 * 
 * @author petHis
 * @date 2025-02-23
 */
public class MedicationRecord extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用药记录ID */
    private Long medicationId;

    /** 诊疗记录ID */
    @Excel(name = "预约记录ID")
    private Long appointmentId;

    /** 药品ID */
    @Excel(name = "药品ID")
    private Long drugId;

    /** 用量（示例：2粒/次） */
    @Excel(name = "用量", readConverterExp = "示=例：2粒/次")
    private String dosage;

    /** 用法 */
    @Excel(name = "用法")
    private String usageMethod;

    /** 收费 */
    @Excel(name = "收费")
    private BigDecimal frequency;

//    /** 频次 */
//    @Excel(name = "创建时间")
//    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", timezone = "UTC")
//    private String createTime;

    /** 创建时间 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Excel(name = "创建时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date createTime;

    /**吃几天药*/
    @Excel(name = "吃几天药")
    private BigDecimal days;

    // 新增临时字段（不映射到数据库）
    @TableField(exist = false)
    private Long totalQuantity;

// 新增临时字段（不映射到数据库）
    @TableField(exist = false)
    private String createBy;

    // 新增临时字段（不映射到数据库）
    @TableField(exist = false)
    private String drugName;


    // 新增临时字段（不映射到数据库）
    @TableField(exist = false)
    private String petName;

    public void setMedicationId(Long medicationId) 
    {
        this.medicationId = medicationId;
    }

    public Long getMedicationId() 
    {
        return medicationId;
    }

    public Long getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(Long appointmentId) {
        this.appointmentId = appointmentId;
    }

    public void setDrugId(Long drugId)
    {
        this.drugId = drugId;
    }

    public Long getDrugId() 
    {
        return drugId;
    }

    public void setDosage(String dosage) 
    {
        this.dosage = dosage;
    }

    public String getDosage() 
    {
        return dosage;
    }

    public void setUsageMethod(String usageMethod) 
    {
        this.usageMethod = usageMethod;
    }

    public String getUsageMethod() 
    {
        return usageMethod;
    }

    public BigDecimal getFrequency() {
        return frequency;
    }

    public void setFrequency(BigDecimal frequency) {
        this.frequency = frequency;
    }

    @Override
    public String getCreateBy() {
        return createBy;
    }

    @Override
    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getDrugName() {
        return drugName;
    }

    public void setDrugName(String drugName) {
        this.drugName = drugName;
    }

    public String getPetName() {
        return petName;
    }

    public void setPetName(String petName) {
        this.petName = petName;
    }

    public BigDecimal getDays() {
        return days;
    }

    public void setDays(BigDecimal days) {
        this.days = days;
    }

    @Override
    public Date getCreateTime() {
        return createTime;
    }

    @Override
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Long getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(Long totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("medicationId", getMedicationId())
            .append("appointmentId", getAppointmentId())
            .append("drugId", getDrugId())
            .append("dosage", getDosage())
            .append("usageMethod", getUsageMethod())
            .append("frequency", getFrequency())
            .append("createTime", getCreateTime())
            .append("days", getDays())
            .append("totalQuantity", getTotalQuantity())
            .append("createBy", getCreateBy())
            .append("drugName", getDrugName())
            .append("petName", getPetName())
            .toString();
    }
}
