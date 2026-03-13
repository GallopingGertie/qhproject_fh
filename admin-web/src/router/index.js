import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/common/Login.vue')
  },
  {
    path: '/platform',
    name: 'Platform',
    component: () => import('@/views/platform/Layout.vue'),
    redirect: '/platform/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'PlatformDashboard',
        component: () => import('@/views/platform/Dashboard.vue')
      },
      {
        path: 'merchant',
        name: 'MerchantManage',
        component: () => import('@/views/platform/MerchantManage.vue')
      },
      {
        path: 'product',
        name: 'ProductAudit',
        component: () => import('@/views/platform/ProductAudit.vue')
      },
      {
        path: 'order',
        name: 'OrderManage',
        component: () => import('@/views/platform/OrderManage.vue')
      },
      {
        path: 'refund',
        name: 'RefundManage',
        component: () => import('@/views/platform/RefundManage.vue')
      },
      {
        path: 'settlement',
        name: 'SettlementManage',
        component: () => import('@/views/platform/SettlementManage.vue')
      }
    ]
  },
  {
    path: '/merchant',
    name: 'Merchant',
    component: () => import('@/views/merchant/Layout.vue'),
    redirect: '/merchant/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'MerchantDashboard',
        component: () => import('@/views/merchant/Dashboard.vue')
      },
      {
        path: 'apply',
        name: 'MerchantApply',
        component: () => import('@/views/merchant/Apply.vue')
      },
      {
        path: 'shop',
        name: 'ShopInfo',
        component: () => import('@/views/merchant/ShopInfo.vue')
      },
      {
        path: 'product',
        name: 'MerchantProduct',
        component: () => import('@/views/merchant/ProductManage.vue')
      },
      {
        path: 'order',
        name: 'MerchantOrder',
        component: () => import('@/views/merchant/OrderManage.vue')
      },
      {
        path: 'finance',
        name: 'MerchantFinance',
        component: () => import('@/views/merchant/Finance.vue')
      }
    ]
  },
  {
    path: '/',
    redirect: '/login'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  if (to.path !== '/login' && !token) {
    next('/login')
  } else {
    next()
  }
})

export default router
