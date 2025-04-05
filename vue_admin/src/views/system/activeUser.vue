<template>
  <el-card>

    <!--    stripe斑马纹， border边框    -->
    <el-table :data="tableData"
              v-loading="tableLoading"
              stripe
              header-cell-class-name="tableHeader-style"
              @selection-change="handleSelectionChange">
      <el-table-column
          type="selection"
          width="55">
      </el-table-column>
      <el-table-column prop="username" label="用户名" width="100px" align="center"></el-table-column>
      <el-table-column prop="avatar" label="头像" align="center">
        <template slot-scope="scope">
          <el-avatar v-if="scope.row.avatar" :src="scope.row.avatar" shape="square"></el-avatar>
        </template>
      </el-table-column>
      <el-table-column prop="roleList" label="角色" width="180px" align="center">
        <template slot-scope="scope">
          <el-tag
              v-for="(item, index) of scope.row.roleList"
              :key="index"
              style="margin-right:4px;margin-top:4px"
          >
            {{item.roleName}}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="nickname" label="昵称" width="120px" align="center" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="userType" label="用户类型" width="140px" align="center" :show-overflow-tooltip="true"></el-table-column>
      <el-table-column prop="sex" label="性别" align="center">
        <template slot-scope="scope">
          <span v-if="scope.row.sex!=='0'">{{scope.row.sex}}</span>
        </template>
      </el-table-column>
      <el-table-column prop="email" label="邮箱" width="150px" align="center"></el-table-column>
      <el-table-column prop="phone" label="电话" width="150px" align="center"></el-table-column>
      <el-table-column prop="remark" label="备注" align="center" width="200px" :show-overflow-tooltip="true" ></el-table-column>
      <el-table-column prop="createBy" label="创建人" width="100px" align="center"></el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="180px" align="center"></el-table-column>
      <el-table-column prop="updateBy" label="更新人" width="100px" align="center"></el-table-column>
      <el-table-column prop="updateTime" label="更新时间" width="180px" align="center"></el-table-column>
      <el-table-column fixed="right" prop="operate" label="操作" width="280px" align="center">
        <template slot-scope="scope">
          <el-button type="text" class="el-icon-edit"
                     @click="activeUser(scope.row)"> 激活</el-button>
          <el-button type="text" class="el-icon-s-custom"
                     @click="removeUser(scope.row)">取消激活</el-button>
        </template>
      </el-table-column>
    </el-table>
    <Pagination
      :total="total"
      :f_pageNum.sync="queryForm.pageNum"
      :f_pageSize.sync="queryForm.pageSize"
      @pageList = "userPageList">
  </Pagination>

  </el-card>
</template>

<script>
export default {
  name: "activeUser",
  components:{},
  data() {
    return {
      //查询表单
      queryForm: {
        pageNum:0,
        pageSize:10,
        username: '',
        nickname: ''
      },
      total:0,
      //表格数据
      tableData: [],
      //加载表格数据
      tableLoading:true,
    }
  },
  created() {
    this.userPageList()
    this.queryForm.pageNum=0
  },
  methods: {
    userPageList(){
      this.request.post('/api/sysUser/getActiveList',this.queryForm).then(res =>{
        if(res.code === 200) {
          this.tableData = res.data.records
          this.total = res.data.total
          this.tableLoading = false
        }else this.$message.error(res.msg)
      });
    },
    activeUser(row){
      let userId = this.$store.state.user.currentLoginUser.id
      let url = '/api/common/activateUser'
      url += `?userId=${userId}&address=${row.address}&user=${row.id}`
      this.request.get(url, null).then(res => {
        if (res.code === 200) {
          this.$message.success("操作成功")
          this.userPageList()
          this.dialogFormVisible = false
        } else {
          this.$message.error(res.msg)
        }
      })
    },
    removeUser(row){
      let userId = this.$store.state.user.currentLoginUser.id
      let url = '/api/common/deleteUser'
      url += `?userId=${userId}&address=${row.address}&user=${row.id}`
      this.request.get(url, null).then(res => {
        if (res.code === 200) {
          this.$message.success("操作成功")
          this.userPageList()
          this.dialogFormVisible = false
        } else {
          this.$message.error(res.msg)
        }
      })
    }
  }
}
</script>

<style>


</style>
