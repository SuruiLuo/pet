package com.petHis.project.system.pets.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.petHis.project.system.clients.domain.Clients;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.petHis.framework.aspectj.lang.annotation.Excel;
import com.petHis.framework.web.domain.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
/**
 * 宠物对象 pets
 * 
 * @author petHis
 * @date 2025-02-17
 */
public class Pets extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 宠物ID */
    private Long petId;

    /** 宠物名 */
    @Excel(name = "宠物名")
    private String name;

    /** 宠物图片 */
    private String petPic;

    /** 品种 */
    @Excel(name = "品种ID")
    private Long type;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthday;

    /** 关联客户ID */
    @Excel(name = "关联客户ID")
    private Long clientId;

    /** 健康状况 （0=健康，1=生病）*/
    @Excel(name = "健康状况",readConverterExp = "0=健康，1=生病")
    private String healthStatus;

    public Long getInsuranceId() {
        return insuranceId;
    }

    public void setInsuranceId(Long insuranceId) {
        this.insuranceId = insuranceId;
    }

    @Excel(name = "保险ID")
    private Long insuranceId;

    public Date getInsuranceEndAt() {
        return insuranceEndAt;
    }

    public void setInsuranceEndAt(Date insuranceEndAt) {
        this.insuranceEndAt = insuranceEndAt;
    }

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    @Excel(name = "保险到期时间", width = 30, dateFormat = "yyyy-MM-dd")
    private Date insuranceEndAt;

    @TableField(exist = false) // MyBatis-Plus 标记非数据库字段
    private String clientName; // 非数据库字段：客户名称

    @TableField(exist = false) // MyBatis-Plus 标记非数据库字段
    private String clientPhone; // 非数据库字段：客户电话

    public void setPetId(Long petId) 
    {
        this.petId = petId;
    }

    public Long getPetId() 
    {
        return petId;
    }

    public void setName(String name) 
    {
        this.name = name;
    }

    public String getName() 
    {
        return name;
    }

    public String getPetPic() {
        return petPic;
    }

    public void setPetPic(String petPic) {
        this.petPic = petPic;
    }

    public void setType(Long type)
    {
        this.type = type;
    }

    public Long getType()
    {
        return type;
    }

    public void setBirthday(Date birthday) 
    {
        this.birthday = birthday;
    }

    public Date getBirthday() 
    {
        return birthday;
    }

    public void setClientId(Long clientId) 
    {
        this.clientId = clientId;
    }

    public Long getClientId() 
    {
        return clientId;
    }

    public void setHealthStatus(String healthStatus)
    {
        this.healthStatus = healthStatus;
    }

    public String getHealthStatus()
    {
        return healthStatus;
    }

    public void setClientName(String clientName)
    {
        this.clientName = clientName;
    }

    public String getClientName()
    {
        return clientName;
    }

    public void setClientPhone(String clientPhone)
    {
        this.clientPhone = clientPhone;
    }

    public String getClientPhone()
    {
        return clientPhone;
    }



    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("petId", getPetId())
            .append("name", getName())
            .append("petPic", getPetPic())
            .append("type", getType())
            .append("birthday", getBirthday())
            .append("clientId", getClientId())
            .append("healthStatus", getHealthStatus())
            .append("clientName", getClientName())
            .append("clientPhone", getClientPhone())
            .append("insuranceId", getInsuranceId())
            .append("insuranceEndAt", getInsuranceEndAt())
            .toString();
    }
}
