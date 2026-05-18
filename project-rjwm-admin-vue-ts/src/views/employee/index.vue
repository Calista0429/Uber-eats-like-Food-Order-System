<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-page-header">
        <h1 class="wm-page-title">Employee Management</h1>
        <el-button type="primary" @click="addEmployeeHandle('add')">+ Add Employee</el-button>
      </div>

      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="input"
          placeholder="Search employee name"
          style="width:200px"
          clearable
          @clear="init"
          @keyup.enter.native="initFun"
        />
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <el-table v-if="tableData.length" :data="tableData" style="width:100%">
          <el-table-column prop="name" label="Full Name" />
          <el-table-column prop="username" label="Username" />
          <el-table-column prop="phone" label="Phone" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '0' ? 'badge-gray' : 'badge-green'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '0' ? 'Disabled' : 'Active' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="180">
            <template slot-scope="scope">
              <span
                class="wm-action-edit"
                :class="{ 'disabled-text': scope.row.username === 'admin' }"
                @click="scope.row.username !== 'admin' && addEmployeeHandle(scope.row.id, scope.row.username)"
              >Edit</span>
              <span
                v-if="scope.row.username !== 'admin'"
                :class="String(scope.row.status) === '0' ? 'wm-action-enable' : 'wm-action-toggle'"
                style="margin-left:6px"
                @click="statusHandle(scope.row)"
              >{{ String(scope.row.status) === '0' ? 'Enable' : 'Disable' }}</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No employees found.</div>
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
import { getEmployeeList, enableOrDisableEmployee } from '@/api/employee'
import { UserModule } from '@/store/modules/user'
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import Empty from '@/components/Empty/index.vue'

@Component({
  name: 'Employee',
  components: {
    HeadLable,
    InputAutoComplete,
    Empty,
  },
})
export default class extends Vue {
  private input: any = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private id = ''
  private status = ''
  private isSearch: boolean = false

  created() {
    this.init()
  }

  initProp(val) {
    this.input = val
    this.initFun()
  }

  initFun() {
    this.page = 1
    this.init()
  }

  get userName() {
    return UserModule.username
  }

  private async init(isSearch?: boolean) {
    this.isSearch = isSearch
    const params = {
      page: this.page,
      pageSize: this.pageSize,
      name: this.input ? this.input : undefined,
    }
    await getEmployeeList(params)
      .then((res: any) => {
        if (String(res.data.code) === '1') {
          this.tableData = res.data && res.data.data && res.data.data.records
          this.counts = res.data.data.total
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  // 添加
  private addEmployeeHandle(st: string, username: string) {
    if (st === 'add') {
      this.$router.push({ path: '/employee/add' })
    } else {
      if (username === 'admin') {
        return
      }
      this.$router.push({ path: '/employee/add', query: { id: st } })
    }
  }

  //状态修改
  private statusHandle(row: any) {
    if (row.username === 'admin') {
      return
    }
    this.id = row.id
    this.status = row.status
    this.$confirm('Change status of this account?', 'Confirm', {
      confirmButtonText: 'OK',
      cancelButtonText: 'Cancel',
      type: 'warning',
    }).then(() => {
      enableOrDisableEmployee({ id: this.id, status: !this.status ? 1 : 0 })
        .then((res) => {
          if (String(res.status) === '200') {
            this.$message.success('Account status updated!')
            this.init()
          }
        })
        .catch((err) => {
          this.$message.error('Request error: ' + err.message)
        })
    })
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

<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; }
.disabled-text { opacity: 0.4; cursor: not-allowed; }
</style>
