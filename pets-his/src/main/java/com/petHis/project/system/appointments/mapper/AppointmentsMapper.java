package com.petHis.project.system.appointments.mapper;

import java.util.List;
import com.petHis.project.system.appointments.domain.Appointments;

/**
 * 预约Mapper接口
 * 
 * @author petHis
 * @date 2025-02-16
 */
public interface AppointmentsMapper 
{
    /**
     * 查询预约
     * 
     * @param appointmentId 预约主键
     * @return 预约
     */
    public Appointments selectAppointmentsByAppointmentId(Long appointmentId);

    /**
     * 查询预约列表
     * 
     * @param appointments 预约
     * @return 预约集合
     */
    public List<Appointments> selectAppointmentsList(Appointments appointments);

    /**
     * 新增预约
     * 
     * @param appointments 预约
     * @return 结果
     */
    public int insertAppointments(Appointments appointments);

    /**
     * 修改预约
     * 
     * @param appointments 预约
     * @return 结果
     */
    public int updateAppointments(Appointments appointments);

    /**
     * 删除预约
     * 
     * @param appointmentId 预约主键
     * @return 结果
     */
    public int deleteAppointmentsByAppointmentId(Long appointmentId);

    /**
     * 批量删除预约
     * 
     * @param appointmentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteAppointmentsByAppointmentIds(String[] appointmentIds);

    /**
     * 判断数据表里是否已经存在同宠物同时间的预约信息
     * */
    public int isPetAlreadyBookedOnDate(Appointments appointments);
}
