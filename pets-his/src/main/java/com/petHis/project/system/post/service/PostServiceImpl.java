package com.petHis.project.system.post.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.petHis.common.constant.UserConstants;
import com.petHis.common.exception.ServiceException;
import com.petHis.common.utils.StringUtils;
import com.petHis.common.utils.security.ShiroUtils;
import com.petHis.common.utils.text.Convert;
import com.petHis.project.system.post.domain.Post;
import com.petHis.project.system.post.mapper.PostMapper;
import com.petHis.project.system.user.mapper.UserPostMapper;

/**
 * 岗位信息 服务层处理
 * 
 * @author petHis
 */
@Service
public class PostServiceImpl implements IPostService
{
    @Autowired
    private PostMapper postMapper;

    @Autowired
    private UserPostMapper userPostMapper;

    /**
     * 查询岗位信息集合
     * 
     * @param post 岗位信息
     * @return 岗位信息集合
     */
    @Override
    public List<Post> selectPostList(Post post)
    {
        return postMapper.selectPostList(post);
    }

    /**
     * 查询所有岗位
     * 
     * @return 岗位列表
     */
    @Override
    public List<Post> selectPostAll()
    {
        return postMapper.selectPostAll();
    }

    /**
     * 根据用户ID查询岗位
     * 
     * @param userId 用户ID
     * @return 岗位列表
     */
    @Override
    public List<Post> selectPostsByUserId(Long userId)
    {
        List<Post> userPosts = postMapper.selectPostsByUserId(userId);
        List<Post> posts = postMapper.selectPostAll();
        for (Post post : posts)
        {
            for (Post userRole : userPosts)
            {
                if (post.getPostId().longValue() == userRole.getPostId().longValue())
                {
                    post.setFlag(true);
                    break;
                }
            }
        }
        return posts;
    }

    /**
     * 通过岗位ID查询岗位信息
     * 
     * @param postId 岗位ID
     * @return 角色对象信息
     */
    @Override
    public Post selectPostById(Long postId)
    {
        return postMapper.selectPostById(postId);
    }

    /**
     * 批量删除岗位信息
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deletePostByIds(String ids)
    {
        Long[] postIds = Convert.toLongArray(ids);
        for (Long postId : postIds)
        {
            Post post = selectPostById(postId);
            if (countUserPostById(postId) > 0)
            {
                throw new ServiceException(String.format("%1$s已分配,不能删除", post.getPostName()));
            }
        }
        return postMapper.deletePostByIds(postIds);
    }

    /**
     * 新增保存岗位信息
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public int insertPost(Post post)
    {
        post.setCreateBy(ShiroUtils.getLoginName());
        return postMapper.insertPost(post);
    }

    /**
     * 修改保存岗位信息
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public int updatePost(Post post)
    {
        post.setUpdateBy(ShiroUtils.getLoginName());
        return postMapper.updatePost(post);
    }

    /**
     * 通过岗位ID查询岗位使用数量
     * 
     * @param postId 岗位ID
     * @return 结果
     */
    @Override
    public int countUserPostById(Long postId)
    {
        return userPostMapper.countUserPostById(postId);
    }

    /**
     * 校验岗位名称是否唯一
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostNameUnique(Post post)
    {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        Post info = postMapper.checkPostNameUnique(post.getPostName());
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }

    /**
     * 校验岗位编码是否唯一
     * 
     * @param post 岗位信息
     * @return 结果
     */
    @Override
    public boolean checkPostCodeUnique(Post post)
    {
        Long postId = StringUtils.isNull(post.getPostId()) ? -1L : post.getPostId();
        Post info = postMapper.checkPostCodeUnique(post.getPostCode());
        if (StringUtils.isNotNull(info) && info.getPostId().longValue() != postId.longValue())
        {
            return UserConstants.NOT_UNIQUE;
        }
        return UserConstants.UNIQUE;
    }
}
