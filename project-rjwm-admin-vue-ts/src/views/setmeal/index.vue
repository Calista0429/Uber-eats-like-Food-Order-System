<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-page-header">
        <h1 class="wm-page-title">Combo Management</h1>
        <el-button type="primary" @click="addSetMeal('add')">+ New Combo</el-button>
      </div>

      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input v-model="input" placeholder="Search combo name" style="width:180px" clearable @clear="init" @keyup.enter.native="initFun" />
        <span class="filter-label">Category</span>
        <el-select v-model="categoryId" style="width:160px" placeholder="All categories" clearable @clear="init">
          <el-option v-for="item in dishCategoryList" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <span class="filter-label">Status</span>
        <el-select v-model="dishStatus" style="width:140px" placeholder="All statuses" clearable @clear="init">
          <el-option v-for="item in saleStatus" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <div class="table-toolbar">
          <div class="toolbar-right">
            <el-button size="small" @click="deleteHandle('batch', null)">Delete Selected</el-button>
          </div>
        </div>
        <el-table v-if="tableData.length" :data="tableData" style="width:100%" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="48" />
          <el-table-column label="Combo" min-width="200">
            <template slot-scope="scope">
              <div style="display:flex;align-items:center;gap:10px">
                <img :src="scope.row.image" style="width:40px;height:40px;border-radius:8px;object-fit:cover;background:#fde8cc" />
                <span style="font-weight:600">{{ scope.row.name }}</span>
              </div>
            </template>
          </el-table-column>
          <el-table-column prop="categoryName" label="Category" />
          <el-table-column label="Price">
            <template slot-scope="scope">
              <span style="color:#f97316;font-weight:700">${{ scope.row.price }}</span>
            </template>
          </el-table-column>
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '1' ? 'badge-green' : 'badge-gray'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '1' ? 'On Sale' : 'Disabled' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="200">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="addSetMeal(scope.row)">Edit</span>
              <span
                :class="String(scope.row.status) === '1' ? 'wm-action-toggle' : 'wm-action-enable'"
                style="margin-left:6px"
                @click="statusHandle(scope.row)"
              >{{ String(scope.row.status) === '1' ? 'Disable' : 'Enable' }}</span>
              <span class="wm-action-delete" style="margin-left:6px" @click="deleteHandle('single', scope.row.id)">Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No combos found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination :current-page="page" :page-size="pageSize" layout="total, prev, pager, next" :total="counts" @current-change="handleCurrentChange" />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import {
  getSetmealPage,
  editSetmeal,
  deleteSetmeal,
  setmealStatusByStatus,
  dishCategoryList
} from '@/api/setMeal'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import Empty from '@/components/Empty/index.vue'
import { baseUrl } from '@/config.json'

@Component({
  name: 'package',
  components: {
    HeadLable,
    InputAutoComplete,
    Empty
  }
})
export default class extends Vue {
  private input: any = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private checkList: any[] = []
  private tableData: [] = []
  private dishCategoryList = []
  private categoryId = ''
  private dishStatus = ''
  private isSearch: boolean = false
  private saleStatus: any = [
    {
      value: 0,
      label: 'Disabled'
    },
    {
      value: 1,
      label: 'On Sale'
    }
  ]

  created() {
    this.init()
    this.getDishCategoryList()
  }

  initProp(val) {
    this.input = val
    this.initFun()
  }

  initFun() {
    this.page = 1
    this.init()
  }

  private async init(isSearch?) {
    this.isSearch = isSearch
    await getSetmealPage({
      page: this.page,
      pageSize: this.pageSize,
      name: this.input || undefined,
      categoryId: this.categoryId || undefined,
      status: this.dishStatus
    })
      .then(res => {
        if (res && res.data && res.data.code === 1) {
          this.tableData = res.data.data.records
          this.counts = Number(res.data.data.total)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch(err => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  // 添加更改
  private addSetMeal(st: any) {
    if (st === 'add') {
      this.$router.push({ path: '/setmeal/add' })
    } else {
      this.$router.push({ path: '/setmeal/add', query: { id: st.id } })
    }
  }

  // 删除
  private deleteHandle(type: string, id: any) {
    if (type === 'batch' && id === null) {
      if (this.checkList.length === 0) {
        return this.$message.error('Please select items to delete')
      }
    }
    this.$confirm('Delete this combo?', 'Confirm Delete', {
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
      type: 'warning'
    }).then(() => {
      deleteSetmeal(type === 'batch' ? this.checkList.join(',') : id)
        .then(res => {
          if (res.data.code === 1) {
            this.$message.success('Deleted successfully!')
            this.init()
          } else {
            this.$message.error(res.data.msg)
          }
        })
        .catch(err => {
          this.$message.error('Request error: ' + err.message)
        })
    })
  }

  //状态更改
  private statusHandle(row: any) {
    let params: any = {}
    if (typeof row === 'string') {
      if (this.checkList.length == 0) {
        this.$message.error('Please select items first!')
        return false
      }
      params.ids = this.checkList.join(',')
      params.status = row
    } else {
      params.ids = row.id
      params.status = row.status ? '0' : '1'
    }

    this.$confirm('Change status of this combo?', 'Confirm', {
      confirmButtonText: 'OK',
      cancelButtonText: 'Cancel',
      type: 'warning'
    }).then(() => {
      setmealStatusByStatus(params)
        .then(res => {
          if (res.data.code === 1) {
            this.$message.success('Status updated successfully!')
            this.init()
          } else {
            this.$message.error(res.data.msg)
          }
        })
        .catch(err => {
          this.$message.error('Request error: ' + err.message)
        })
    })
  }

  //获取套餐分类下拉数据
  private getDishCategoryList() {
    dishCategoryList({
      type: 2
    })
      .then(res => {
        if (res && res.data && res.data.code === 1) {
          this.dishCategoryList = (
            res.data &&
            res.data.data &&
            res.data.data
          ).map(item => {
            return { value: item.id, label: item.name }
          })
        }
      })
      .catch(() => {})
  }

  // 全部操作
  private handleSelectionChange(val: any) {
    let checkArr: string[] = []
    val.forEach((n: any) => {
      checkArr.push(n.id)
    })
    this.checkList = checkArr
  }

  private handleSizeChange(val: any) {
    this.pageSize = val
    this.init()
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.init()
  }
}
</script>
<style lang="scss">
.el-table-column--selection .cell {
  padding-left: 10px;
}
</style>
<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; }
</style>
