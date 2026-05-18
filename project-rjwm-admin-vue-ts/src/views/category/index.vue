<template>
  <div class="dashboard-container">
    <div class="container">
      <div class="wm-filter-bar">
        <span class="filter-label">Name</span>
        <el-input
          v-model="name"
          placeholder="Search category name"
          style="width: 200px"
          clearable
          @clear="init"
          @keyup.enter.native="init"
        />
        <span class="filter-label">Type</span>
        <el-select v-model="categoryType" placeholder="All types" clearable style="width: 160px" @clear="init">
          <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
        <div class="filter-actions">
          <el-button @click="init">Reset</el-button>
          <el-button type="primary" @click="init(true)">Search</el-button>
          <el-button type="primary" @click="addClass('class')">+ Dish Category</el-button>
          <el-button type="primary" @click="addClass('meal')">+ Combo Category</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <el-table v-if="tableData.length" :data="tableData" style="width:100%">
          <el-table-column prop="name" label="Category Name" />
          <el-table-column label="Type">
            <template slot-scope="scope">
              <span class="wm-badge" :class="scope.row.type == '1' ? 'badge-blue' : 'badge-orange'">
                <span class="badge-dot" />
                {{ scope.row.type == '1' ? 'Dish' : 'Combo' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="sort" label="Sort Order" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="String(scope.row.status) === '0' ? 'badge-gray' : 'badge-green'">
                <span class="badge-dot" />
                {{ String(scope.row.status) === '0' ? 'Disabled' : 'Enabled' }}
              </span>
            </template>
          </el-table-column>
          <el-table-column prop="updateTime" label="Last Updated" />
          <el-table-column label="Actions" align="center" width="160">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="editHandle(scope.row)">Edit</span>
              <span
                class="wm-action-delete"
                style="margin-left:6px"
                @click="deleteHandle(scope.row.id)"
              >Delete</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No categories found.</div>
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

    <!-- Add/Edit Category Dialog -->
    <el-dialog :title="classData.title"
               :visible.sync="classData.dialogVisible"
               width="30%"
               :before-close="handleClose">
      <el-form ref="classData"
               :model="classData"
               class="demo-form-inline"
               :rules="rules"
               label-width="120px">
        <el-form-item label="Category Name:"
                      prop="name">
          <el-input v-model="classData.name"
                    placeholder="Enter category name"
                    maxlength="20" />
        </el-form-item>
        <el-form-item label="Sort Order:"
                      prop="sort">
          <el-input v-model="classData.sort"
                    placeholder="Enter sort order" />
        </el-form-item>
      </el-form>
      <span slot="footer"
            class="dialog-footer">
        <el-button size="medium"
                   @click="
            ;(classData.dialogVisible = false), $refs.classData.resetFields()
                   ">Cancel</el-button>
        <el-button type="primary"
                   :class="{ continue: actionType === 'add' }"
                   size="medium"
                   @click="submitForm()">Confirm</el-button>
        <el-button v-if="action != 'edit'"
                   type="primary"
                   size="medium"
                   @click="submitForm('go')">
          Save &amp; Add Another
        </el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import HeadLable from '@/components/HeadLable/index.vue'
import {
  getCategoryPage,
  deleCategory,
  editCategory,
  addCategory,
  enableOrDisableEmployee
} from '@/api/category'
import Empty from '@/components/Empty/index.vue'

@Component({
  name: 'Category',
  components: {
    HeadLable,
    Empty
  }
})
export default class extends Vue {
  private options: any = [
    {
      value: 1,
      label: 'Dish Category'
    },
    {
      value: 2,
      label: 'Combo Category'
    }
  ]
  private actionType: string = ''
  private id = ''
  private status = ''
  private categoryType: number = null
  private name: string = ''
  private action: string = ''
  private counts: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private type = ''
  private isSearch: boolean = false
  private classData: any = {
    title: 'Add Dish Category',
    dialogVisible: false,
    categoryId: '',
    name: '',
    sort: ''
  }

  get rules() {
    return {
      name: [
        {
          required: true,
          trigger: 'blur',
          validator: (rule: any, value: string, callback: Function) => {
            var reg = new RegExp('^[A-Za-z一-龥]+$')
            if (!value) {
              callback(new Error(this.classData.title + ' name cannot be empty'))
            } else if (value.length < 2) {
              callback(new Error('Category name must be 2-20 characters'))
            } else if (!reg.test(value)) {
              callback(new Error('Category name contains special characters'))
            } else {
              callback()
            }
          }
        }
      ],
      sort: [
        {
          required: true,
          trigger: 'blur',
          validator: (rule: any, value: string, callback: Function) => {
            if (value || String(value) === '0') {
              const reg = /^\d+$/
              if (!reg.test(value)) {
                callback(new Error('Sort order must be a number'))
              } else if (Number(value) > 99) {
                callback(new Error('Sort order must be 0-99'))
              } else {
                callback()
              }
            } else {
              callback(new Error('Sort order cannot be empty'))
            }
          }
        }
      ]
    }
  }

  created() {
    this.init()
  }

  // Initialize
  private async init(isSearch?) {
    this.isSearch = isSearch
    await getCategoryPage({
      page: this.page,
      pageSize: this.pageSize,
      name: this.name ? this.name : undefined,
      type: this.categoryType ? this.categoryType : undefined
    })
      .then(res => {
        if (String(res.data.code) === '1') {
          this.tableData =
            res && res.data && res.data.data && res.data.data.records
          this.counts = Number(res.data.data.total)
        } else {
          this.$message.error(res.data.desc)
        }
      })
      .catch(err => {
        console.log(err, 'err')
        this.$message.error('Request error: ' + err.message)
      })
  }

  // Add
  private addClass(st: any) {
    if (st == 'class') {
      this.classData.title = 'Add Category'
      this.type = '1'
    } else {
      this.classData.title = 'Add Category'
      this.type = '2'
    }
    this.action = 'add'
    this.classData.name = ''
    this.classData.sort = ''
    this.classData.dialogVisible = true
    this.actionType = 'add'
  }

  // Edit
  private editHandle(dat: any) {
    this.classData.title = 'Edit Category'
    this.action = 'edit'
    this.classData.name = dat.name
    this.classData.sort = dat.sort
    this.classData.id = dat.id
    this.classData.dialogVisible = true
    this.actionType = 'edit'
  }

  // Close dialog
  private handleClose(st: string) {
    console.log(this.$refs.classData, 'this.$refs.classData')
    this.classData.dialogVisible = false
    this.$refs.classData.resetFields()
  }

  // Status change
  private statusHandle(row: any) {
    this.id = row.id
    this.status = row.status
    this.$confirm('Confirm changing status for this category?', 'Hint', {
      confirmButtonText: 'Confirm',
      cancelButtonText: 'Cancel',
      type: 'warning',
      customClass: 'customClass'
    }).then(() => {
      enableOrDisableEmployee({ id: this.id, status: !this.status ? 1 : 0 })
        .then(res => {
          if (String(res.status) === '200') {
            this.$message.success('Category status updated!')
            this.init()
          }
        })
        .catch(err => {
          this.$message.error('Request error: ' + err.message)
        })
    })
  }

  // Delete
  private deleteHandle(id: any) {
    this.$confirm('This will permanently delete this category. Continue?', 'Confirm Delete', {
      confirmButtonText: 'Delete',
      cancelButtonText: 'Cancel',
      type: 'warning'
    }).then(() => {
      deleCategory(id)
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

  $refs!: {
    classData: any
  }

  // Submit form
  submitForm(st: any) {
    if (this.action === 'add') {
      this.$refs.classData.validate((value: boolean) => {
        if (value) {
          addCategory({
            name: this.classData.name,
            type: this.type,
            sort: this.classData.sort
          })
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('Category added successfully!')
                this.$refs.classData.resetFields()
                if (!st) {
                  this.classData.dialogVisible = false
                }
                this.init()
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('Request error: ' + err.message)
            })
        }
      })
    } else {
      this.$refs.classData.validate((value: boolean) => {
        if (value) {
          editCategory({
            id: this.classData.id,
            name: this.classData.name,
            sort: this.classData.sort
          })
            .then(res => {
              if (res.data.code === 1) {
                this.$message.success('Category updated successfully!')
                this.classData.dialogVisible = false
                this.$refs.classData.resetFields()
                this.init()
              } else {
                this.$message.error(res.data.desc || res.data.msg)
              }
            })
            .catch(err => {
              this.$message.error('Request error: ' + err.message)
            })
        }
      })
    }
  }

  // Pagination
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
</style>
