package com.petHis.project.system.clients.mapper;

import java.util.List;
import com.petHis.project.system.clients.domain.Clients;

/**
 * 客户Mapper接口
 * 
 * @author petHis
 * @date 2025-02-16
 */
public interface ClientsMapper 
{


    /**
     * 查询客户
     *
     * @param clientId 客户主键
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
     * 删除客户
     * 
     * @param clientId 客户主键
     * @return 结果
     */
    public int deleteClientsByClientId(Long clientId);

    /**
     * 批量删除客户
     * 
     * @param clientIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteClientsByClientIds(String[] clientIds);

//    public int countByPhone(String phone);
//
//    public List<Clients> selectByPhone(String phone);
}
