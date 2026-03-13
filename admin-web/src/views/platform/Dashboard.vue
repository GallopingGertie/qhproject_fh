<template>
  <div class="dashboard">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background-color: #409eff;">
              <el-icon size="30"><Money /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-value">¥{{ stats.totalSales }}</div>
              <div class="stat-label">销售总额</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background-color: #67c23a;">
              <el-icon size="30"><Tickets /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-value">{{ stats.totalOrders }}</div>
              <div class="stat-label">订单总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background-color: #e6a23c;">
              <el-icon size="30"><Shop /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-value">{{ stats.totalMerchants }}</div>
              <div class="stat-label">商户总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
      
      <el-col :span="6">
        <el-card>
          <div class="stat-card">
            <div class="stat-icon" style="background-color: #f56c6c;">
              <el-icon size="30"><Goods /></el-icon>
            </div>
            <div class="stat-content">
              <div class="stat-value">{{ stats.totalProducts }}</div>
              <div class="stat-label">商品总数</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    
    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>商品销量排行</span>
          </template>
          <el-table :data="topProducts" stripe>
            <el-table-column prop="productName" label="商品名称" />
            <el-table-column prop="sales" label="销量" width="100" />
          </el-table>
        </el-card>
      </el-col>
      
      <el-col :span="12">
        <el-card>
          <template #header>
            <span>商户销量排行</span>
          </template>
          <el-table :data="topMerchants" stripe>
            <el-table-column prop="merchantName" label="商户名称" />
            <el-table-column prop="sales" label="销售额" width="120" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import request from '@/utils/request'

const stats = ref({
  totalSales: 0,
  totalOrders: 0,
  totalMerchants: 0,
  totalProducts: 0
})

const topProducts = ref([])
const topMerchants = ref([])

onMounted(() => {
  loadStats()
  loadTopProducts()
  loadTopMerchants()
})

const loadStats = async () => {
  try {
    const res = await request.get('/admin/dashboard/stats')
    stats.value = res
  } catch (error) {
    console.error(error)
  }
}

const loadTopProducts = async () => {
  try {
    const res = await request.get('/admin/dashboard/top-products')
    topProducts.value = res
  } catch (error) {
    console.error(error)
  }
}

const loadTopMerchants = async () => {
  try {
    const res = await request.get('/admin/dashboard/top-merchants')
    topMerchants.value = res
  } catch (error) {
    console.error(error)
  }
}
</script>

<style scoped>
.stat-card {
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  width: 60px;
  height: 60px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
}

.stat-content {
  flex: 1;
}

.stat-value {
  font-size: 24px;
  font-weight: bold;
  color: #303133;
}

.stat-label {
  font-size: 14px;
  color: #909399;
  margin-top: 5px;
}
</style>
