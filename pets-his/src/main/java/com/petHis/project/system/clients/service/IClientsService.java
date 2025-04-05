package com.petHis.project.system.clients.service;

import java.util.List;
import com.petHis.project.system.clients.domain.Clients;

/**
 * 客户Service接口
 * 
 * @author petHis
 * @date 2025-02-16
 */
public interface IClientsService 
{

    /**
     * 查询客户
     *
     * @param userId 客户主键
     * @return 客户
     */
    public Clients selectClientsByUserId(Long userId);
    /**
     * 查询客户
     * 
     * @param clientId 客户主键
     * @return 客户
     */
    public Clients selectClientsByClientId(Long clientId);

    /**
     * 查询客户列表
     * 
     * @param clients 客户
     * @return 客户集合
     */
    public List<Clients> selectClientsList(Clients clients);

    /**
     * 新增客户
     * 
     * @param clients 客户
     * @return 结果
     */
    public int insertClients(Clients clients);

    /**
     * 修改客户
     * 
     * @param clients 客户
     * @return 结果
     */
    public int updateClients(Clients clients);

    /**
     * 批量删除客户
     * 
     * @param clientIds 需要删除的客户主键集合
     * @return 结果
     */
    public int deleteClientsByClientIds(String clientIds);

    /**
     * 删除客户信息
     * 
     * @param clientId 客户主键
     * @return 结果
     */
    public int deleteClientsByClientId(Long clientId);

//    /**
//     * 检查手机号是否存在
//     * */
//    public boolean checkPhoneExists(String phone);
//    /**
//     * 通过手机号查询用户列表
//     * */
//    public List<Clients> selectClientsByPhone(String phone);
}
