<template>
  <div class="merchant-manage">
    <el-card>
      <el-tabs v-model="activeTab" @tab-change="handleTabChange">
        <el-tab-pane label="待审核" name="0"></el-tab-pane>
        <el-tab-pane label="审核通过" name="1"></el-tab-pane>
        <el-tab-pane label="审核驳回" name="2"></el-tab-pane>
        <el-tab-pane label="已停用" name="3"></el-tab-pane>
      </el-tabs>
      
      <el-table :data="merchants" stripe v-loading="loading">
        <el-table-column prop="merchantName" label="商户名称" />
        <el-table-column prop="contactPerson" label="联系人" />
        <el-table-column prop="contactPhone" label="联系电话" />
        <el-table-column prop="createTime" label="申请时间" width="180" />
        <el-table-column label="状态" width="100">
          <template #default="{ row }">
            <el-tag v-if="row.status === 0" type="warning">待审核</el-tag>
            <el-tag v-else-if="row.status === 1" type="success">审核通过</el-tag>
            <el-tag v-else-if="row.status === 2" type="danger">审核驳回</el-tag>
            <el-tag v-else type="info">已停用</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="viewDetail(row)">查看</el-button>
            <el-button v-if="row.status === 0" link type="success" @click="handleAudit(row, 1)">通过</el-button>
            <el-button v-if="row.status === 0" link type="danger" @click="handleAudit(row, 2)">驳回</el-button>
            <el-button v-if="row.status === 1" link type="warning" @click="handleDisable(row)">停用</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <el-pagination
        v-model:current-page="pageNum"
        v-model:page-size="pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @current-change="loadMerchants"
        style="margin-top: 20px; justify-content: flex-end;"
      />
    </el-card>
    
    <el-dialog v-model="dialogVisible" title="审核商户" width="500px">
      <el-form :model="auditForm" label-width="100px">
        <el-form-item label="审核结果">
          <el-radio-group v-model="auditForm.status">
            <el-radio :label="1">通过</el-radio>
            <el-radio :label="2">驳回</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="驳回原因" v-if="auditForm.status === 2">
          <el-input v-model="auditForm.rejectReason" type="textarea" :rows="3" />
        </el-form-item>
        <el-form-item label="抽成比例" v-if="auditForm.status === 1">
          <el-input-number v-model="auditForm.commissionRate" :min="0" :max="100" :precision="2" />
          <span style="margin-left: 10px;">%</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitAudit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted, reactive } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import request from '@/utils/request'

const activeTab = ref('0')
const merchants = ref([])
const loading = ref(false)
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)

const auditForm = reactive({
  id: null,
  status: 1,
  rejectReason: '',
  commissionRate: 5
})

onMounted(() => {
  loadMerchants()
})

const handleTabChange = () => {
  pageNum.value = 1
  loadMerchants()
}

const loadMerchants = async () => {
  loading.value = true
  try {
    const res = await request.get('/admin/merchant/list', {
      status: activeTab.value,
      pageNum: pageNum.value,
      pageSize: pageSize.value
    })
    merchants.value = res.records
    total.value = res.total
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}

const viewDetail = (row) => {
  ElMessageBox.alert(`
    <p><strong>商户名称:</strong> ${row.merchantName}</p>
    <p><strong>联系人:</strong> ${row.contactPerson}</p>
    <p><strong>联系电话:</strong> ${row.contactPhone}</p>
    <p><strong>营业执照:</strong> ${row.businessLicense || '未上传'}</p>
  `, '商户详情', {
    dangerouslyUseHTMLString: true
  })
}

const handleAudit = (row, status) => {
  auditForm.id = row.id
  auditForm.status = status
  auditForm.rejectReason = ''
  auditForm.commissionRate = 5
  dialogVisible.value = true
}

const submitAudit = async () => {
  try {
    await request.post('/admin/merchant/audit', auditForm)
    ElMessage.success('审核成功')
    dialogVisible.value = false
    loadMerchants()
  } catch (error) {
    console.error(error)
  }
}

const handleDisable = async (row) => {
  try {
    await ElMessageBox.confirm('确定要停用该商户吗?', '提示', {
      type: 'warning'
    })
    await request.post('/admin/merchant/disable', { id: row.id })
    ElMessage.success('操作成功')
    loadMerchants()
  } catch (error) {
    console.error(error)
  }
}
</script>

<style scoped>
.merchant-manage {
  
}
</style>
