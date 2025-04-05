package com.petHis.project.system.appointments.service.impl;

import java.util.List;

import com.petHis.common.utils.security.ShiroUtils;
import com.petHis.project.system.user.domain.UserRole;
import com.petHis.project.system.user.mapper.UserRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.project.system.appointments.mapper.AppointmentsMapper;
import com.petHis.project.system.appointments.domain.Appointments;
import com.petHis.project.system.appointments.service.IAppointmentsService;
import com.petHis.common.utils.text.Convert;

/**
 * 预约Service业务层处理
 * 
 * @author petHis
 * @date 2025-02-16
 */
@Service
public class AppointmentsServiceImpl implements IAppointmentsService 
{
    @Autowired
    private AppointmentsMapper appointmentsMapper;

    @Autowired
    private UserRoleMapper userRoleMapper;

    /**
     * 查询预约
     * 
     * @param appointmentId 预约主键
     * @return 预约
     */
    @Override
    public Appointments selectAppointmentsByAppointmentId(Long appointmentId)
    {
        return appointmentsMapper.selectAppointmentsByAppointmentId(appointmentId);
    }

    /**
     * 查询预约列表
     * 
     * @param appointments 预约
     * @return 预约
     */
    @Override
    public List<Appointments> selectAppointmentsList(Appointments appointments)
    {
        List<UserRole> userRoles = userRoleMapper.selectUserRoleByUserId(ShiroUtils.getUserId());
        System.out.println("-----------------------juese");
        System.out.println(userRoles);
        if (!userRoles.isEmpty()){
//            获取第一个对象里的roleId
            Long roleId = userRoles.get(0).getRoleId();
            if (roleId==2){
//                appointments.setCreateBy(ShiroUtils.getLoginName());
                appointments.setDoctorId(ShiroUtils.getUserId());
                System.out.println(appointments);
            }
        }
        return appointmentsMapper.selectAppointmentsList(appointments);
    }

    /**
     * 新增预约
     * 
     * @param appointments 预约
     * @return 结果
     */
    @Override
    public int insertAppointments(Appointments appointments)
    {
        // 在保存前进行数据判断
        if (isPetAlreadyBookedOnDate(appointments) > 0){
            throw new RuntimeException("该预约数据已存在，请勿重复添加。");
        }
        return appointmentsMapper.insertAppointments(appointments);
    }

    /**
     * 修改预约
     * 
     * @param appointments 预约
     * @return 结果
     */
    @Override
    public int updateAppointments(Appointments appointments)
    {
        int i = appointmentsMapper.updateAppointments(appointments);
        return i;
    }

    /**
     * 批量删除预约
     * 
     * @param appointmentIds 需要删除的预约主键
     * @return 结果
     */
    @Override
    public int deleteAppointmentsByAppointmentIds(String appointmentIds)
    {
        return appointmentsMapper.deleteAppointmentsByAppointmentIds(Convert.toStrArray(appointmentIds));
    }

    /**
     * 删除预约信息
     * 
     * @param appointmentId 预约主键
     * @return 结果
     */
    @Override
    public int deleteAppointmentsByAppointmentId(Long appointmentId)
    {
        return appointmentsMapper.deleteAppointmentsByAppointmentId(appointmentId);
    }

    @Override
    public int isPetAlreadyBookedOnDate(Appointments appointments){
        return appointmentsMapper.isPetAlreadyBookedOnDate(appointments);
    }
}
