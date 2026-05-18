<template>
  <div class="container">
    <h2 class="homeTitle">Overview</h2>
    <div class="overviewBox">
      <ul>
        <li>
          <p class="tit">Revenue</p>
          <p class="num">{{ overviewData.turnover }}</p>
          <p class="tip">
            YoY Growth<span v-if="overviewData.turnoverGrowth">
              <span
                class="red"
                :class="overviewData.turnoverGrowth > 0 ? '' : 'green'"
                >{{
                  overviewData.turnoverGrowth > 0
                    ? '+' + overviewData.turnoverGrowth
                    : overviewData.turnoverGrowth
                }}%</span
              >
            </span>
            <span v-else>-</span>
          </p>
        </li>
        <li>
          <p class="tit">Valid Orders</p>
          <p class="num">{{ overviewData.validOrderCount }}</p>
          <p class="tip">
            YoY Growth<span v-if="overviewData.validOrderCountGrowth">
              <span
                class="red"
                :class="overviewData.validOrderCountGrowth > 0 ? '' : 'green'"
                >{{
                  overviewData.validOrderCountGrowth > 0
                    ? '+' + overviewData.validOrderCountGrowth
                    : overviewData.validOrderCountGrowth
                }}%</span
              >
            </span>
            <span v-else>-</span>
          </p>
        </li>
        <li>
          <p class="tit">Completion Rate</p>
          <p class="num">
            {{ (overviewData.orderCompletionRate * 100).toFixed(2) }}%
          </p>
          <p class="tip">
            YoY Growth<span v-if="overviewData.orderCompletionRateGrowth">
              <span
                class="red"
                :class="
                  overviewData.orderCompletionRateGrowth > 0 ? '' : 'green'
                "
                >{{
                  overviewData.orderCompletionRateGrowth > 0
                    ? '+' + overviewData.orderCompletionRateGrowth
                    : overviewData.orderCompletionRateGrowth
                }}%</span
              >
            </span>
            <span v-else>-</span>
          </p>
        </li>
        <li>
          <p class="tit">Avg. Order Value</p>
          <p class="num">{{ overviewData.unitPrice.toFixed(2) }}</p>
          <p class="tip">
            YoY Growth<span v-if="overviewData.unitPriceGrowth">
              <span
                class="red"
                :class="overviewData.unitPriceGrowth > 0 ? '' : 'green'"
                >{{
                  overviewData.unitPriceGrowth > 0
                    ? '+' + overviewData.unitPriceGrowth
                    : overviewData.unitPriceGrowth
                }}%</span
              >
            </span>
            <span v-else>-</span>
          </p>
        </li>
        <li>
          <p class="tit">Total Users</p>
          <p class="num">{{ overviewData.totalUsers }}</p>
          <!-- <p class="tip">
            YoY Growth：<span v-if="overviewData.newUsersGrowth">
              <span
                class="red"
                :class="overviewData.newUsersGrowth > 0 ? '' : 'green'"
                >{{
                  overviewData.newUsersGrowth > 0
                    ? '+' + overviewData.newUsersGrowth
                    : overviewData.newUsersGrowth
                }}</span
              ></span
            >
            <span v-else>-</span>
          </p> -->
        </li>
        <li>
          <p class="tit">New Users</p>
          <p class="num">{{ overviewData.newUsers }}</p>
          <p class="tip">
            YoY Growth<span v-if="overviewData.newUsersGrowth">
              <span
                class="red"
                :class="overviewData.newUsersGrowth > 0 ? '' : 'green'"
                >{{
                  overviewData.newUsersGrowth > 0
                    ? '+' + overviewData.newUsersGrowth
                    : overviewData.newUsersGrowth
                }}%</span
              >
            </span>
            <span v-else>-</span>
          </p>
        </li>
      </ul>
    </div>
  </div>
</template>
<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { getday } from '@/utils/formValidate'
@Component({
  name: 'Overview',
})
export default class extends Vue {
  @Prop() private overviewData!: any
  get days() {
    return getday()
  }
}
</script>
