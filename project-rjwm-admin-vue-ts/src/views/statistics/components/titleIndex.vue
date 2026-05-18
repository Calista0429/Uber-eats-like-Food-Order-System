<template>
  <div class="title-index">
    <div class="month">
      <ul class="tabs">
        <li
          class="li-tab"
          v-for="(item, index) in tabsParam"
          @click="toggleTabs(index)"
          :class="{ active: index === nowIndex }"
          :key="index"
        >
          {{ item }}
          <span></span>
        </li>
      </ul>
    </div>
    <div class="get-time">
      <p>
        Selected: {{ tateData[0] }} to
        {{ tateData[tateData.length - 1] }}
      </p>
    </div>
    <el-button
      icon="iconfont icon-download"
      class="right-el-button"
      @click="handleExport"
      >Export Data</el-button
    >
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import { exportInfor } from '@/api/index'
@Component({
  name: 'TitleIndex',
})
export default class extends Vue {
  @Prop() private flag!: any
  @Prop() private tateData!: any
  @Prop() private turnoverData!: any

  nowIndex = 2 - 1
  value = []
  tabsParam = ['Yesterday', 'Last 7 Days', 'Last 30 Days', 'This Week', 'This Month']
  @Watch('flag')
  getNowIndex(val) {
    this.nowIndex = val
  }
  // tab切换
  toggleTabs(index: number) {
    this.nowIndex = index
    this.value = []
    this.$emit('sendTitleInd', index + 1)
  }
  //  数据导出
  /** 导出按钮操作 */
  handleExport() {
    this.$confirm('Export last 30 days of operational data?', 'Confirm', {
      confirmButtonText: 'OK',
      cancelButtonText: 'Cancel',
      type: 'warning',
    })
      .then(async function () {
        const { data } = await exportInfor()
        let url = window.URL.createObjectURL(data)
        var a = document.createElement('a')
        document.body.appendChild(a)
        a.href = url
        a.download = 'operational-report.xlsx'
        a.click()
        window.URL.revokeObjectURL(url)
      })
      .then((response) => {})
  }
}
</script>
