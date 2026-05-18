<template>
  <div class="dashboard-container">
    <div class="inform-header wm-card">
      <ul class="tab-list">
        <li
          v-for="(item, index) in tabList"
          :key="index"
          :class="{ 'tab-active': activeIndex === index }"
          @click="handleClass(index)"
        >
          <el-badge
            class="item"
            :value="ountUnread === 0 ? null : ountUnread > 99 ? '99+' : ountUnread"
            :hidden="!([1].includes(item.value) && ountUnread)"
          >{{ item.label }}</el-badge>
        </li>
      </ul>
      <el-button
        v-if="status === 1 && baseData.length > 0"
        size="small"
        class="mark-all-btn"
        @click="handleBatch"
      >Mark All as Read</el-button>
      <el-button v-else size="small" disabled class="mark-all-btn">Mark All as Read</el-button>
    </div>

    <div class="inform-list wm-card" v-if="baseData.length > 0">
      <div v-for="(item, index) in baseData" :key="index" class="inform-item">
        <!-- type 1: Pending order -->
        <div v-if="item.type === 1" class="inform-content">
          <span class="inform-tag tag-pending">Pending</span>
          {{ item.arrNew[0] }}
          <router-link :to="'/order?status=2'" class="inform-link" @click.native="handleSetStatus(item.id)">
            {{ item.arrNew[1] }}
          </router-link>
          {{ item.arrNew[2] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <!-- type 2: Urgent pending order -->
        <div v-if="item.type === 2" class="inform-content">
          <span class="inform-tag tag-urgent">Urgent</span>
          <span class="inform-tag tag-pending">Pending</span>
          {{ item.arrNew[0] }}
          <router-link :to="'/order?status=2'" class="inform-link" @click.native="handleSetStatus(item.id)">
            {{ item.arrNew[1] }}
          </router-link>
          {{ item.arrNew[2] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <!-- type 3: For delivery -->
        <div v-if="item.type === 3" class="inform-content">
          <span class="inform-tag tag-reminder">Delivery</span>
          {{ item.arrNew[0] }}
          <router-link :to="'/order?status=2'" class="inform-link" @click.native="handleSetStatus(item.id)">
            {{ item.arrNew[1] }}
          </router-link>
          {{ item.arrNew[2] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <!-- type 4: Reminder -->
        <div v-if="item.type === 4" class="inform-content">
          <span class="inform-tag tag-reminder">Reminder</span>
          {{ item.arrNew[0] }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
        <!-- type 5: Daily summary -->
        <div v-if="item.type === 5" class="inform-content">
          <span class="inform-tag tag-pending">Daily Summary</span>
          {{ item.content }}
          <span class="inform-time">{{ item.createTime }}</span>
        </div>
      </div>
    </div>
    <div v-else class="empty-hint wm-card">No notifications.</div>
  </div>
</template>

<script lang="ts">
import { Component, Vue, Inject } from 'vue-property-decorator'
import Empty from '@/components/Empty/index.vue'
import { getNewData, setNewData } from '@/utils/cookies'
import { AppModule } from '@/store/modules/app'
// 接口
import {
  getInformData,
  batchMsg,
  setStatus,
  getCountUnread,
} from '@/api/inform'
@Component({
  name: 'Inform',
  components: {
    Empty,
  },
})
export default class extends Vue {
  // @Inject('reload') readonly reload!: Function
  private activeIndex = 0
  private shopShow = false
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private status = 1
  private baseData = []
  // private ountUnread = 0 as any
  private showIndex = 0
  private isSearch: boolean = false
  private isActive: boolean = false

  get tabList() {
    return [
      {
        label: 'Unread',
        value: 1,
        // num: this.ountUnread,
      },
      {
        label: 'Read',
        value: 2,
        // num: 0,
      },
    ]
  }
  get ountUnread() {
    return AppModule.statusNumber
  }
  created() {
    this.getData()
  }
  // 获取列表数据
  async getData() {
    const parent = {
      pageNum: this.page,
      pageSize: this.pageSize,
      status: this.status,
    }
    const { data } = await getInformData(parent)
    if (data.code === 1) {
      this.baseData = data.data.records
      this.counts = data.data.total
      let objNew = {} as any
      let arrDetails = []
      this.baseData.forEach((val) => {
        // 处理后端返回的状订单字符串转义
        const arrContent = val.content.split(' ')
        // 处理催单、闭店详情数据
        val.arrNew = arrContent
        objNew = { ...val }
        objNew.details = eval('(' + objNew.details + ')')
        arrDetails.push(objNew)
      })

      this.baseData = arrDetails
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }

  // 全部已读
  async handleBatch() {
    const ids = []
    this.baseData.forEach((val) => {
      ids.push(val.id)
    })
    const { data } = await batchMsg(ids)
    if (data.code === 1) {
      // this.status = 2
      // this.activeIndex = 1
      this.getCountUnread()
      this.getData()
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }
  // 设置单个订单已读
  async handleSetStatus(id) {
    const { data } = await setStatus(id)
    if (data.code === 1) {
      // this.status = 2
      // this.activeIndex = 1
      if (!this.isActive) {
        this.getCountUnread()
        this.getData()
      }

      // this.reload()
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }
  // 获取未读消息
  async getCountUnread() {
    const { data } = await getCountUnread()
    if (data.code === 1) {
      AppModule.StatusNumber(data.data)
      // this.$message.success('操作成功！')
    } else {
      this.$message.error(data.msg)
    }
  }
  // 触发已读未读按钮
  handleClass(index) {
    this.activeIndex = index
    if (index === 0) {
      this.status = 1
    } else {
      this.status = 2
    }
    this.getData()
  }
  // 下拉菜单显示
  toggleShow(id, index) {
    this.shopShow = true
    this.showIndex = index
    let t = 3
    let timer = setInterval(() => {
      t--
      if (t === 0) {
        if (this.status === 1) {
          this.isActive = true
          this.handleSetStatus(id)
        }

        clearInterval(timer)
      }
    }, 1000)
  }
  // 下拉菜单隐藏
  mouseLeaves(index) {
    this.shopShow = false
    this.showIndex = index
  }
  private handleSizeChange(val: any) {
    this.pageSize = val
    this.getData()
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.getData()
  }
}
</script>

<style lang="scss" scoped>
.inform-header {
  display: flex;
  align-items: center;
  padding: 0 20px;
  margin-bottom: 16px;
  border-radius: 12px;
}
.tab-list {
  display: flex;
  list-style: none;
  gap: 0;
  flex: 1;
  li {
    padding: 16px 20px;
    cursor: pointer;
    font-size: 14px;
    color: #9a7c68;
    border-bottom: 2px solid transparent;
    transition: color 0.15s, border-color 0.15s;
    &:hover { color: #f97316; }
  }
  .tab-active {
    color: #f97316;
    border-bottom-color: #f97316;
    font-weight: 600;
  }
}
.mark-all-btn { flex-shrink: 0; }
.inform-list { padding: 8px 0; }
.inform-item {
  padding: 14px 20px;
  border-bottom: 1px solid #f5ede6;
  &:last-child { border-bottom: none; }
}
.inform-content { font-size: 13px; color: #2c1a0e; line-height: 1.6; }
.inform-tag {
  display: inline-block;
  font-size: 11px;
  font-weight: 700;
  padding: 2px 8px;
  border-radius: 4px;
  margin-right: 6px;
}
.tag-pending  { background: #fff7ed; color: #ea580c; }
.tag-urgent   { background: #fff5f5; color: #ef4444; }
.tag-reminder { background: #eff6ff; color: #3b82f6; }
.inform-link  { color: #f97316; font-weight: 600; text-decoration: none; &:hover { text-decoration: underline; } }
.inform-time  { float: right; color: #b8a090; font-size: 11px; }
.empty-hint   { text-align: center; padding: 40px; color: #9a7c68; }
</style>
