const API_BASE_URL = 'http://localhost:8080/api'

export default {
  baseURL: API_BASE_URL,
  
  request(options) {
    return new Promise((resolve, reject) => {
      const token = uni.getStorageSync('token')
      
      uni.request({
        url: API_BASE_URL + options.url,
        method: options.method || 'GET',
        data: options.data || {},
        header: {
          'Content-Type': 'application/json',
          'Authorization': token ? `Bearer ${token}` : ''
        },
        success: (res) => {
          if (res.data.code === 200) {
            resolve(res.data.data)
          } else {
            uni.showToast({
              title: res.data.message || '请求失败',
              icon: 'none'
            })
            reject(res.data)
          }
        },
        fail: (err) => {
          uni.showToast({
            title: '网络请求失败',
            icon: 'none'
          })
          reject(err)
        }
      })
    })
  },
  
  get(url, data) {
    return this.request({ url, data, method: 'GET' })
  },
  
  post(url, data) {
    return this.request({ url, data, method: 'POST' })
  },
  
  put(url, data) {
    return this.request({ url, data, method: 'PUT' })
  },
  
  delete(url, data) {
    return this.request({ url, data, method: 'DELETE' })
  }
}
