<template>
  <div class="login-container">
    <el-card class="login-card">
      <h2 class="title">农产品电商平台</h2>
      <el-tabs v-model="loginType" class="login-tabs">
        <el-tab-pane label="平台登录" name="platform"></el-tab-pane>
        <el-tab-pane label="商户登录" name="merchant"></el-tab-pane>
      </el-tabs>
      
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef">
        <el-form-item prop="username">
          <el-input 
            v-model="loginForm.username" 
            placeholder="请输入账号"
            size="large"
            prefix-icon="User"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input 
            v-model="loginForm.password" 
            type="password"
            placeholder="请输入密码"
            size="large"
            prefix-icon="Lock"
            @keyup.enter="handleLogin"
          />
        </el-form-item>
        <el-form-item>
          <el-button 
            type="primary" 
            size="large"
            style="width: 100%"
            :loading="loading"
            @click="handleLogin"
          >
            登录
          </el-button>
        </el-form-item>
        <el-form-item v-if="loginType === 'merchant'">
          <el-link type="primary" @click="goApply">还没有账号?去申请入驻</el-link>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import request from '@/utils/request'

const router = useRouter()
const loginType = ref('platform')
const loading = ref(false)
const loginFormRef = ref(null)

const loginForm = reactive({
  username: '',
  password: ''
})

const rules = {
  username: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

const handleLogin = async () => {
  await loginFormRef.value.validate()
  loading.value = true
  
  try {
    const url = loginType.value === 'platform' ? '/auth/platform/login' : '/auth/merchant/login'
    const res = await request.post(url, loginForm)
    
    localStorage.setItem('token', res.token)
    localStorage.setItem('userType', loginType.value)
    
    ElMessage.success('登录成功')
    
    if (loginType.value === 'platform') {
      router.push('/platform/dashboard')
    } else {
      router.push('/merchant/dashboard')
    }
  } catch (error) {
    console.error(error)
  } finally {
    loading.value = false
  }
}

const goApply = () => {
  router.push('/merchant/apply')
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-card {
  width: 450px;
  padding: 20px;
}

.title {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
}

.login-tabs {
  margin-bottom: 20px;
}
</style>
