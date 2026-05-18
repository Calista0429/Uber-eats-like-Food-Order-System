<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-page-header">
        <h1 class="wm-page-title">Dish Management</h1>
        <el-button type="primary" @click="addDishtype('add')">+ New Dish</el-button>
      </div>

      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="input"
          placeholder="Search dish name"
          style="width: 180px"
          clearable
          @clear="init"
          @keyup.enter.native="initFun"
        />
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
          <span class="selected-info">{{ multipleSelection.length ? `${multipleSelection.length} selected` : '' }}</span>
          <div class="toolbar-right">
            <el-button size="small" @click="deleteHandle('批量', null)">Delete Selected</el-button>
          </div>
        </div>
        <el-table
          v-if="tableData.length"
          :data="tableData"
          style="width:100%"
          @selection-change="handleSelectionChange"
        >
          <el-table-column type="selection" width="48" />
          <el-table-column label="Dish" min-width="200">
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
              <span class="wm-action-edit" @click="addDishtype(scope.row.id)">Edit</span>
              <span
                :class="String(scope.row.status) === '1' ? 'wm-action-toggle' : 'wm-action-enable'"
                style="margin-left:6px"
                @click="statusHandle(String(scope.row.status) === '1' ? '0' : '1', scope.row)"
              >{{ String(scope.row.status) === '1' ? 'Disable' : 'Enable' }}</span>
              <span class="wm-action-delete" style="margin-left:6px" @click="deleteHandle('单', scope.row)">Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No dishes found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination
            :current-page="page"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="counts"
            @current-change="handleCurrentChange"
          />
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import {
  getDishPage,
  editDish,
  deleteDish,
  dishStatusByStatus,
  dishCategoryList
} from '@/api/dish'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import Empty from '@/components/Empty/index.vue'
import { baseUrl } from '@/config.json'

@Component({
  name: 'DishType',
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
  private checkList: string[] = []
  private multipleSelection: any[] = []
  private tableData: [] = []
  private dishState = ''
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
    await getDishPage({
      page: this.page,
      pageSize: this.pageSize,
      name: this.input || undefined,
      categoryId: this.categoryId || undefined,
      status: this.dishStatus
    })
      .then(res => {
        if (res.data.code === 1) {
          this.tableData = res.data && res.data.data && res.data.data.records
          this.counts = Number(res.data.data.total)
        }
      })
      .catch(err => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  // Add
  private addDishtype(st: string) {
    if (st === 'add') {
      this.$router.push({ path: '/dish/add' })
    } else {
      this.$router.push({ path: '/dish/add', query: { id: st } })
    }
  }

  // Delete
  private deleteHandle(type: string, id: any) {
    if (type === '批量' && id === null) {
      if (this.checkList.length === 0) {
        return this.$message.error('Please select items to delete')
      }
    }
    this.$confirm('Confirm deleting this dish?', 'Confirm Delete', {
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
      type: 'warning'
    }).then(() => {
      const deleteId = type === '批量' ? this.checkList.join(',') : (id && id.id ? id.id : id)
      deleteDish(deleteId)
        .then(res => {
          if (res && res.data && res.data.code === 1) {
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

  // Get dish category dropdown data
  private getDishCategoryList() {
    dishCategoryList({
      type: 1
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

  // Status change — accepts (newStatus: string, row: any) or (row: any)
  private statusHandle(statusOrRow: any, row?: any) {
    let params: any = {}
    if (row !== undefined) {
      // Called from new template: statusHandle(newStatus, row)
      params.id = row.id
      params.status = statusOrRow
    } else if (typeof statusOrRow === 'string') {
      if (this.checkList.length === 0) {
        this.$message.error('Please select dishes for bulk operation!')
        return false
      }
      params.id = this.checkList.join(',')
      params.status = statusOrRow
    } else {
      params.id = statusOrRow.id
      params.status = statusOrRow.status ? '0' : '1'
    }
    this.dishState = params
    this.$confirm('Confirm changing dish status?', 'Hint', {
      confirmButtonText: 'Confirm',
      cancelButtonText: 'Cancel',
      type: 'warning'
    }).then(() => {
      dishStatusByStatus(this.dishState)
        .then(res => {
          if (res && res.data && res.data.code === 1) {
            this.$message.success('Dish status updated successfully!')
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

  // Selection change
  private handleSelectionChange(val: any) {
    this.multipleSelection = val
    let checkArr: any[] = []
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
