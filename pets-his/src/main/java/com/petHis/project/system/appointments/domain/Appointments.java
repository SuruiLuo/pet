package com.petHis.project.system.appointments.domain;

import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;

/**
 * 预约对象 appointments
 * 
 * @author petHis
 * @date 2025-02-16
 */
public class Appointments extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 预约ID */
    private Long appointmentId;

    /** 关联宠物ID */
    @Excel(name = "关联宠物ID")
    private Long petId;

    /** 关联医生ID（对应 sys_user 用户ID） */
    @Excel(name = "关联医生ID", readConverterExp = "对=应,s=ys_user,用=户ID")
    private Long doctorId;

    /** 预约时间 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Excel(name = "预约时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date appointmentTime;

    /** 状态（0待确认，1已确认，2已取消） */
    @Excel(name = "状态", readConverterExp = "0=待确认，1已确认，2已取消")
    private String status;

    @TableField(exist = false) // MyBatis-Plus 标记非数据库字段
    @Excel(name = "客户名")
    private String clientName; // 非数据库字段：客户名

    @TableField(exist = false) // MyBatis-Plus 标记非数据库字段
    @Excel(name = "医生名")
    private String userName; // 非数据库字段：医生名

    @TableField(exist = false) // MyBatis-Plus 标记非数据库字段
    @Excel(name = "宠物名")
    private String petName; // 非数据库字段：宠物名

    public void setAppointmentId(Long appointmentId) 
    {
        this.appointmentId = appointmentId;
    }

    public Long getAppointmentId() 
    {
        return appointmentId;
    }

    public void setPetId(Long petId) 
    {
        this.petId = petId;
    }

    public Long getPetId() 
    {
        return petId;
    }

    public void setDoctorId(Long doctorId) 
    {
        this.doctorId = doctorId;
    }

    public Long getDoctorId() 
    {
        return doctorId;
    }

    public void setAppointmentTime(Date appointmentTime) 
    {
        this.appointmentTime = appointmentTime;
    }

    public Date getAppointmentTime() 
    {
        return appointmentTime;
    }

    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }

    public void setClientName(String clientName) { this.clientName = clientName; }

    public String getClientName() { return clientName; }

    public String getUserName() { return userName; }

    public void setUserName(String userName) { this.userName = userName; }

    public String getPetName() { return petName; }

    public void setPetName(String petName) { this.petName = petName; }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("appointmentId", getAppointmentId())
            .append("petId", getPetId())
            .append("doctorId", getDoctorId())
            .append("appointmentTime", getAppointmentTime())
            .append("status", getStatus())
            .append("clientName", getClientName())
            .append("userName", getUserName())
            .append("petName", getPetName())
            .toString();
    }
}
