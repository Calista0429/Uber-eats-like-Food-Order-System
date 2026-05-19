<template>
  <div class="dashboard-container">
    <TabChange
      :order-statics="orderStatics"
      :default-activity="defaultActivity"
      @tabChange="change"
    />
    <div class="container">
      <div class="wm-filter-bar">
        <span class="filter-label">Order No.</span>
        <el-input
          v-model="input"
          placeholder="Search order number"
          style="width: 180px"
          clearable
          @clear="init(orderStatus)"
          @keyup.enter.native="initFun(orderStatus)"
        />
        <span class="filter-label">Phone</span>
        <el-input
          v-model="phone"
          placeholder="Search phone number"
          style="width: 160px"
          clearable
          @clear="init(orderStatus)"
          @keyup.enter.native="initFun(orderStatus)"
        />
        <span class="filter-label">Placed At</span>
        <el-date-picker
          v-model="valueTime"
          clearable
          value-format="yyyy-MM-dd HH:mm:ss"
          range-separator="to"
          :default-time="['00:00:00', '23:59:59']"
          type="daterange"
          start-placeholder="Start date"
          end-placeholder="End date"
          style="width: 280px"
          @clear="init(orderStatus)"
        />
        <div class="filter-actions">
          <el-button @click="init(orderStatus)">Reset</el-button>
          <el-button type="primary" @click="init(orderStatus, true)">Search</el-button>
        </div>
      </div>

      <div class="wm-table-card">
        <el-table
          v-if="tableData.length"
          :data="tableData"
          style="width: 100%"
        >
          <el-table-column key="number" prop="number" label="Order No." />
          <el-table-column
            v-if="[2, 3, 4].includes(orderStatus)"
            key="orderDishes"
            prop="orderDishes"
            label="Items"
          />
          <el-table-column
            v-if="[0].includes(orderStatus)"
            key="orderDishes2"
            prop="orderDishes"
            label="Items"
          />
          <el-table-column prop="amount" label="Amount" />
          <el-table-column prop="address" label="Address" />
          <el-table-column prop="userName" label="Customer" />
          <el-table-column prop="phone" label="Phone" />
          <el-table-column prop="orderTime" label="Placed At" />
          <el-table-column label="Status">
            <template slot-scope="scope">
              <span class="wm-badge" :class="getOrderStatusClass(scope.row.status)">
                <span class="badge-dot" />
                {{ getOrderStatusLabel(scope.row.status) }}
              </span>
            </template>
          </el-table-column>
          <el-table-column label="Actions" width="180" align="center">
            <template slot-scope="scope">
              <span class="wm-action-edit" @click="handleQuery(scope.row.id)">View</span>
              <span
                v-if="scope.row.status === 2"
                class="wm-action-enable"
                style="margin-left:6px"
                @click="handleReceipt(scope.row.id)"
              >Accept</span>
              <span
                v-if="scope.row.status === 3"
                class="wm-action-enable"
                style="margin-left:6px"
                @click="handleDelivery(scope.row.id)"
              >Deliver</span>
              <span
                v-if="scope.row.status === 2"
                class="wm-action-delete"
                style="margin-left:6px"
                @click="handleReject(scope.row.id)"
              >Reject</span>
            </template>
          </el-table-column>
        </el-table>
        <div v-if="!tableData.length" class="empty-hint">No orders found.</div>
        <div class="wm-pagination-wrap">
          <el-pagination
            :current-page="page"
            :page-size="pageSize"
            layout="total, prev, pager, next"
            :total="total"
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
import InputAutoComplete from '@/components/InputAutoComplete/index.vue'
import TabChange from './tabChange.vue'
import Empty from '@/components/Empty/index.vue'
import {
  getOrderDetailPage,
  queryOrderDetailById,
  completeOrder,
  deliveryOrder,
  orderCancel,
  orderReject,
  orderAccept,
  getOrderListBy,
} from '@/api/order'

@Component({
  components: {
    HeadLable,
    InputAutoComplete,
    TabChange,
    Empty,
  },
})
export default class extends Vue {
  private defaultActivity: any = 0
  private orderStatics = {}
  private row = {}
  private isAutoNext = true
  private isTableOperateBtn = true
  private currentPageIndex = 0 //record index of viewed detail
  private orderId = '' //order number
  private input = '' //search condition: order number
  private phone = '' //search condition: phone
  private valueTime = []
  private dialogVisible = false //detail dialog
  private cancelDialogVisible = false //cancel/reject dialog
  private cancelDialogTitle = '' //cancel/reject dialog title
  private cancelReason = ''
  private remark = '' //custom reason
  private counts: number = 0
  private total: number = 0
  private page: number = 1
  private pageSize: number = 10
  private tableData = []
  private diaForm = []
  private isSearch: boolean = false
  private orderStatus = 0 //order status for list display and pagination
  private dialogOrderStatus = 0 //order status for dialog detail display
  private cancelOrderReasonList = [
    {
      value: 1,
      label: 'Too many orders, temporarily unable to accept',
    },
    {
      value: 2,
      label: 'Menu items sold out, temporarily unable to accept',
    },
    {
      value: 3,
      label: 'Restaurant closed, temporarily unable to accept',
    },
    {
      value: 0,
      label: 'Custom Reason',
    },
  ]

  private cancelrReasonList = [
    {
      value: 1,
      label: 'Too many orders, temporarily unable to accept',
    },
    {
      value: 2,
      label: 'Menu items sold out, temporarily unable to accept',
    },
    {
      value: 3,
      label: 'Not enough riders to deliver',
    },
    {
      value: 4,
      label: 'Customer cancelled by phone',
    },
    {
      value: 0,
      label: 'Custom Reason',
    },
  ]
  private orderList = [
    {
      label: 'All Orders',
      value: 0,
    },
    {
      label: 'Pending Payment',
      value: 1,
    },
    {
      label: 'Pending',
      value: 2,
    },
    {
      label: 'For Delivery',
      value: 3,
    },
    {
      label: 'Delivering',
      value: 4,
    },
    {
      label: 'Completed',
      value: 5,
    },
    {
      label: 'Cancelled',
      value: 6,
    },
  ]

  created() {
    this.init(Number(this.$route.query.status) || 0)
  }

  mounted() {
    if (
      this.$route.query.orderId &&
      this.$route.query.orderId !== 'undefined'
    ) {
      this.goDetail(this.$route.query.orderId, 2)
    }
    if (this.$route.query.status) {
      this.defaultActivity = this.$route.query.status
    }
  }

  initFun(orderStatus) {
    this.page = 1
    this.init(orderStatus)
  }

  change(activeIndex) {
    if (activeIndex === this.orderStatus) return
    this.init(activeIndex)
    this.input = ''
    this.phone = ''
    this.valueTime = []
    this.dialogOrderStatus = 0
    this.$router.push('/order')
    console.log(activeIndex, 'received child index')
  }

  //get pending, for-delivery, in-delivery counts
  getOrderListBy3Status() {
    getOrderListBy({})
      .then((res) => {
        if (res.data.code === 1) {
          this.orderStatics = res.data.data
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  init(activeIndex: number = 0, isSearch?) {
    this.isSearch = isSearch
    const params = {
      page: this.page,
      pageSize: this.pageSize,
      number: this.input || undefined,
      phone: this.phone || undefined,
      beginTime:
        this.valueTime && this.valueTime.length > 0
          ? this.valueTime[0]
          : undefined,
      endTime:
        this.valueTime && this.valueTime.length > 0
          ? this.valueTime[1]
          : undefined,
      status: activeIndex || undefined,
    }
    getOrderDetailPage({ ...params })
      .then((res) => {
        if (res.data.code === 1) {
          this.tableData = res.data.data.records
          this.orderStatus = activeIndex
          this.counts = Number(res.data.data.total)
          this.total = Number(res.data.data.total)
          this.getOrderListBy3Status()
          if (
            this.dialogOrderStatus === 2 &&
            this.orderStatus === 2 &&
            this.isAutoNext &&
            !this.isTableOperateBtn &&
            res.data.data.records.length > 1
          ) {
            const row = res.data.data.records[0]
            this.goDetail(row.id, row.status, row)
          } else {
            return null
          }
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  getOrderType(row: any) {
    if (row.status === 1) {
      return 'Pending Payment'
    } else if (row.status === 2) {
      return 'Pending'
    } else if (row.status === 3) {
      return 'For Delivery'
    } else if (row.status === 4) {
      return 'Delivering'
    } else if (row.status === 5) {
      return 'Completed'
    } else if (row.status === 6) {
      return 'Cancelled'
    } else {
      return 'Refund'
    }
  }

  // view detail
  async goDetail(id: any, status: number, row?: any) {
    this.diaForm = []
    this.dialogVisible = true
    this.dialogOrderStatus = status
    this.orderId = id
    const { data } = await queryOrderDetailById({ orderId: id })
    this.diaForm = data.data
    this.row = row || { id: this.$route.query.orderId, status: status }
    if (this.$route.query.orderId) {
      this.$router.push('/order')
    }
  }

  // open reject dialog
  orderReject(row: any) {
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = 'Reject'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  // accept order
  orderAccept(row: any) {
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    orderAccept({ id: this.orderId })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('Success')
          this.orderId = ''
          this.dialogVisible = false
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  // open cancel order dialog
  cancelOrder(row: any) {
    this.cancelDialogVisible = true
    this.orderId = row.id
    this.dialogOrderStatus = row.status
    this.cancelDialogTitle = 'Cancel'
    this.dialogVisible = false
    this.cancelReason = ''
  }

  // confirm cancel or reject and provide reason
  confirmCancel(type) {
    if (!this.cancelReason) {
      return this.$message.error(`Please select a reason`)
    } else if (this.cancelReason === 'Custom Reason' && !this.remark) {
      return this.$message.error(`Please enter a reason`)
    }

    ;(this.cancelDialogTitle === 'Cancel' ? orderCancel : orderReject)({
      id: this.orderId,
      // eslint-disable-next-line standard/computed-property-even-spacing
      [this.cancelDialogTitle === 'Cancel' ? 'cancelReason' : 'rejectionReason']:
        this.cancelReason === 'Custom Reason' ? this.remark : this.cancelReason,
    })
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('Success')
          this.cancelDialogVisible = false
          this.orderId = ''
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  // deliver or complete
  cancelOrDeliveryOrComplete(status: number, id: string) {
    const params = {
      status,
      id,
    }
    ;(status === 3 ? deliveryOrder : completeOrder)(params)
      .then((res) => {
        if (res.data.code === 1) {
          this.$message.success('Success')
          this.orderId = ''
          this.dialogVisible = false
          this.init(this.orderStatus)
        } else {
          this.$message.error(res.data.msg)
        }
      })
      .catch((err) => {
        this.$message.error('Request error: ' + err.message)
      })
  }

  handleClose() {
    this.dialogVisible = false
  }

  private handleSizeChange(val: any) {
    this.pageSize = val
    this.init(this.orderStatus)
  }

  private handleCurrentChange(val: any) {
    this.page = val
    this.init(this.orderStatus)
  }

  getOrderStatusLabel(status: number): string {
    const map: Record<number, string> = {
      1: 'Pending Payment', 2: 'Pending Accept', 3: 'Accepted',
      4: 'Delivering', 5: 'Completed', 6: 'Cancelled'
    }
    return map[status] || 'Unknown'
  }

  getOrderStatusClass(status: number): string {
    const map: Record<number, string> = {
      1: 'badge-gray', 2: 'badge-orange', 3: 'badge-blue',
      4: 'badge-blue', 5: 'badge-green', 6: 'badge-gray'
    }
    return map[status] || 'badge-gray'
  }

  handleQuery(id: any) {
    const found = this.tableData.find((r: any) => r.id === id)
    this.goDetail(id, found ? found.status : 0)
  }

  handleReceipt(id: any) {
    const row = this.tableData.find((r: any) => r.id === id)
    if (row) this.orderAccept(row)
  }

  handleDelivery(id: any) {
    this.cancelOrDeliveryOrComplete(3, id)
  }

  handleReject(id: any) {
    const row = this.tableData.find((r: any) => r.id === id)
    if (row) this.orderReject(row)
  }
}
</script>

<style lang="scss" scoped>
.container { padding: 0; }
.empty-hint { text-align: center; padding: 40px; color: #9a7c68; font-size: 14px; }
</style>
