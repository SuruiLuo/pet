<template>
  <div class="portal-box" style="margin: 10px 10px 10px 10px">
    <div class="portal-box-box">
      <div class="portal-box-iconbox" style="margin-top: 0px;margin-bottom: 20px">
        <span class="inline iconfont iconjihua1" style="font-size: 32px; line-height: 32px;margin-right: 10px;"></span>
        <span style="font-size: 20px;line-height: 30px"></span>
      </div>
      <div class="portal-box-cardbox">
        <div class="portal-box-card">
          最新区块高度
          <span>{{treeData ? treeData.latestBlockNumber : 0}}</span>
        </div>
        <div class="portal-box-card" style="width: 1000px;">
          最新交易哈希
          <span style="color: #ffbf6b">{{treeData ? treeData.latesTransacitionHash : ''}}</span>
        </div>
      </div>
    </div>
    <el-tabs v-model="activeName">
      <el-tab-pane label="区块查询" name="first">
        <el-input
            placeholder="请输入Block Number"
            @change="getBlockNumberDetails"
            v-model="blockNumber"
            clearable>
        </el-input>
        <div class="portal-box-box">
          <div class="portal-box-iconbox" style="margin-top: 0px;margin-bottom: 20px">
            <span class="inline iconfont iconjihua1" style="font-size: 32px; line-height: 32px;margin-right: 10px;"></span>
            <span style="font-size: 20px;line-height: 30px"></span>
          </div>
          <div class="portal-box-cardbox" v-if="blockData != null" style="width: 100%">
            <json-viewer :value="blockData" :expand-depth=3></json-viewer>
          </div>
        </div>
      </el-tab-pane>
      <el-tab-pane label="钱包流水" name="second">
        <el-input
            placeholder="请输入电话号码"
            @change="getPhoneNumber"
            v-model="phoneNumber"
            clearable>
        </el-input>
        <el-table :data="phoneList" style="width: 40%" :row-class-name="tableRowClassName" v-if="phoneList.length > 0">
          <el-table-column prop="info" label="信息" width="400">
            <template slot-scope="scope">
              <span>{{ processedData(scope.row) }}</span>
            </template>
          </el-table-column>
          <el-table-column prop="amount" label="当前余额" width="200">
            <template slot-scope="scope">
              <span>{{ scope.row?.amount }} 元</span>
            </template>
          </el-table-column>
        </el-table>

      </el-tab-pane>
    </el-tabs>

  </div>
</template>

<script>
import moment from "moment";

export default {
  components: {
  },
  data() {
    return {
      treeData: null,
      blockNumber: null,
      blockData: null,
      activeName: 'first',
      phoneNumber: null,
      phoneList: []
    }
  },
  watch: {
  },
  mounted() {
    this.init()
  },
  methods: {
    init() {
      this.request.get('/api/common/getBlockchainInfo', {}).then(res => {
        this.treeData = res
      });
    },
    getBlockNumberDetails() {
      let url = '/api/common/getBlockNumberDetails'
      url += `?blockNumber=${this.blockNumber}`
      this.request.get(url, {}).then(res => {
        if (res.code == 500) {
          this.blockData = null
        }else {
          this.blockData = res
        }
      });
    },
    getPhoneNumber() {
      let url = '/api/common/getPhoneNumber'
      url += `?phoneNumber=${this.phoneNumber}`
      this.request.get(url, {}).then(res => {
        if (res.code == 500) {
          this.phoneList = []
          this.$message.warning(res.msg)
        }else {
          this.phoneList = res
        }
      });
    },
    // 根据 tradeType 设置行背景色
    tableRowClassName({ row }) {
      if (row.tradeType === 0) {
        return "warning-row"; // 红色背景
      } else if (row.tradeType === 1) {
        return "success-row"; // 蓝色背景
      }
      return "";
    },
    // 处理数据，生成需要显示的内容
    processedData(item) {
        const action = item.tradeType === 0 ? "支出" : "获取";
        const info = `用户 ${item.userName} 通过保险 ${item.insuranceUserName} ${action} ${item.number} 元`;
        return  info
    },
    moment,
  },
  computed: {
  }
  }
</script>


<style scoped>
.portal-box {
  height: calc(100vh - 20px);
  overflow-y: scroll;
  padding-bottom: 50px;
}
.portal-box::-webkit-scrollbar {
  display: none;
}

.portal-box-iconbox {
  margin: 10px;
  display: flex;
  align-items: center
}

.portal-box-box {
  background-color: #ffffff;
  padding: 5px 0;
}

.portal-box-cardbox {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
}
.portal-box>div{
  cursor: pointer;
}
.portal-box-card {
  border-radius: 10px;
  background: #ffffff;
  box-shadow: -2px 2px 6px #bebebe,
  2px -2px 6px #ffffff;
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 20px;
  font-weight: 600;
  width: 20vh;
  padding: 15px 0;
  margin: 0 15px;
}
.portal-box > span {
  color: #0f40f5;
  font-size: 42px;
}
.portal-box-iconbox{
  color: #1890ff
}
/* 自定义表格行样式 */
.el-table /deep/ .warning-row {
  background-color: #ffcccc; /* 红色背景 */
}
.el-table /deep/ .success-row {
  background-color: #cce5ff; /* 蓝色背景 */
}
</style>
