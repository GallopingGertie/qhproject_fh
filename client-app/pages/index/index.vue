<template>
  <view class="container">
    <view class="search-bar">
      <input class="search-input" placeholder="搜索商品" @confirm="handleSearch" />
    </view>
    
    <view class="category-nav">
      <view 
        v-for="cat in categories" 
        :key="cat.id" 
        class="category-item"
        @click="goCategory(cat.id)"
      >
        {{ cat.name }}
      </view>
    </view>
    
    <view class="product-list">
      <view 
        v-for="product in products" 
        :key="product.id" 
        class="product-item"
        @click="goDetail(product.id)"
      >
        <image :src="product.mainImage" class="product-image" mode="aspectFill" />
        <view class="product-info">
          <text class="product-name">{{ product.productName }}</text>
          <view class="product-bottom">
            <text class="product-price">¥{{ product.price }}</text>
            <text class="product-origin">{{ product.originPlace }}</text>
          </view>
        </view>
      </view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request'

export default {
  data() {
    return {
      categories: [],
      products: []
    }
  },
  onLoad() {
    this.loadCategories()
    this.loadProducts()
  },
  methods: {
    loadCategories() {
      request.get('/product/category/list').then(res => {
        this.categories = res
      })
    },
    loadProducts() {
      request.get('/product/list', { status: 4 }).then(res => {
        this.products = res.records
      })
    },
    handleSearch(e) {
      const keyword = e.detail.value
      uni.navigateTo({
        url: `/pages/product/search?keyword=${keyword}`
      })
    },
    goCategory(categoryId) {
      uni.switchTab({
        url: '/pages/category/category'
      })
    },
    goDetail(productId) {
      uni.navigateTo({
        url: `/pages/product/detail?id=${productId}`
      })
    }
  }
}
</script>

<style scoped>
.container {
  background-color: #f5f5f5;
  min-height: 100vh;
}

.search-bar {
  padding: 20rpx;
  background-color: #fff;
}

.search-input {
  height: 70rpx;
  background-color: #f5f5f5;
  border-radius: 35rpx;
  padding: 0 30rpx;
}

.category-nav {
  display: flex;
  padding: 20rpx;
  background-color: #fff;
  margin-top: 20rpx;
  overflow-x: auto;
}

.category-item {
  padding: 10rpx 30rpx;
  margin-right: 20rpx;
  background-color: #f5f5f5;
  border-radius: 30rpx;
  white-space: nowrap;
}

.product-list {
  padding: 20rpx;
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

.product-item {
  width: 340rpx;
  background-color: #fff;
  border-radius: 10rpx;
  margin-bottom: 20rpx;
  overflow: hidden;
}

.product-image {
  width: 100%;
  height: 340rpx;
}

.product-info {
  padding: 20rpx;
}

.product-name {
  font-size: 28rpx;
  color: #333;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.product-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 20rpx;
}

.product-price {
  font-size: 32rpx;
  color: #ff6b6b;
  font-weight: bold;
}

.product-origin {
  font-size: 24rpx;
  color: #999;
}
</style>
