# 农产品电商平台 MVP 项目

## 项目简介

本项目是一个面向"某省特色农产品销售"的平台型电商系统 MVP 版本，包含用户端、平台端和商户端三个核心模块。

## 项目结构

```
fenghao/
├── server/                          # 后端 Spring Boot 项目
│   ├── src/
│   │   └── main/
│   │       ├── java/com/agri/
│   │       │   ├── auth/           # 认证模块
│   │       │   ├── user/           # 用户模块
│   │       │   ├── merchant/       # 商户模块
│   │       │   ├── product/        # 商品模块
│   │       │   ├── order/          # 订单模块
│   │       │   ├── payment/        # 支付模块
│   │       │   ├── shipment/       # 发货模块
│   │       │   ├── refund/         # 退款模块
│   │       │   ├── settlement/     # 结算模块
│   │       │   ├── admin/          # 平台管理模块
│   │       │   └── common/         # 公共模块
│   │       └── resources/
│   │           └── application.yml
│   └── pom.xml
│
├── client-app/                      # 用户端 uni-app 项目
│   ├── pages/                       # 页面
│   │   ├── index/                  # 首页
│   │   ├── category/               # 分类
│   │   ├── product/                # 商品
│   │   ├── cart/                   # 购物车
│   │   ├── order/                  # 订单
│   │   └── user/                   # 用户中心
│   ├── components/                  # 组件
│   ├── utils/                       # 工具类
│   ├── api/                         # API 接口
│   ├── manifest.json
│   └── pages.json
│
├── admin-web/                       # 后台管理 Vue3 项目
│   ├── src/
│   │   ├── views/
│   │   │   ├── platform/           # 平台端页面
│   │   │   ├── merchant/           # 商户端页面
│   │   │   └── common/             # 公共页面
│   │   ├── components/             # 组件
│   │   ├── api/                    # API 接口
│   │   ├── router/                 # 路由
│   │   ├── store/                  # 状态管理
│   │   ├── utils/                  # 工具类
│   │   ├── App.vue
│   │   └── main.js
│   ├── package.json
│   └── vite.config.js
│
├── docs/                            # 文档
│   └── sql/
│       └── init.sql                # 数据库初始化脚本
│
└── README_农产品电商平台_MVP.md      # 项目需求文档
```

## 技术栈

### 后端
- **框架**: Spring Boot 2.7.14
- **数据库**: MySQL 8.0
- **缓存**: Redis
- **ORM**: MyBatis-Plus 3.5.3.1
- **认证**: JWT (jjwt 0.11.5)
- **工具**: Lombok, FastJSON

### 用户端
- **框架**: uni-app
- **支持平台**: 微信小程序、H5、App

### 后台管理
- **框架**: Vue 3
- **UI 组件**: Element Plus
- **构建工具**: Vite 4
- **路由**: Vue Router 4
- **状态管理**: Pinia
- **HTTP 客户端**: Axios

## 快速开始

### 1. 数据库初始化

```bash
# 执行数据库初始化脚本
mysql -u root -p < docs/sql/init.sql
```

默认管理员账号:
- 用户名: admin
- 密码: admin123

### 2. 启动后端服务

```bash
cd server
mvn clean install
mvn spring-boot:run
```

后端服务将运行在 `http://localhost:8080`

### 3. 启动后台管理系统

```bash
cd admin-web
npm install
npm run dev
```

后台管理系统将运行在 `http://localhost:3000`

访问路径:
- 平台端登录: http://localhost:3000/login (选择"平台登录")
- 商户端登录: http://localhost:3000/login (选择"商户登录")

### 4. 用户端开发

使用 HBuilderX 打开 `client-app` 目录,选择运行到:
- 微信小程序开发工具
- H5 浏览器
- App 模拟器

## 核心功能模块

### 用户端
- ✅ 首页商品展示
- ✅ 商品分类浏览
- ✅ 商品搜索
- ✅ 商品详情
- ✅ 购物车管理
- ✅ 订单提交与支付
- ✅ 订单查询
- ✅ 物流查询
- ✅ 退款申请
- ✅ 个人中心

### 平台端
- ✅ 数据看板
- ✅ 商户审核
- ✅ 商品审核
- ✅ 订单管理
- ✅ 退款管理
- ✅ 结算管理
- ✅ 系统配置

### 商户端
- ✅ 入驻申请
- ✅ 店铺信息维护
- ✅ 商品管理
- ✅ 订单管理
- ✅ 发货管理
- ✅ 财务查看
- ✅ 提现申请

## 数据库表说明

### 用户相关
- `user`: 用户表
- `user_address`: 用户收货地址表

### 商户相关
- `merchant`: 商户表
- `merchant_apply`: 商户入驻申请表
- `merchant_withdraw`: 商户提现申请表

### 商品相关
- `product`: 商品表
- `product_sku`: 商品 SKU 表
- `product_category`: 商品分类表
- `product_audit_log`: 商品审核日志表

### 订单相关
- `order_info`: 订单表
- `order_item`: 订单商品表
- `payment_record`: 支付记录表
- `shipment_record`: 发货记录表
- `refund_record`: 退款记录表

### 平台管理相关
- `admin_user`: 平台管理员表
- `settlement_record`: 结算记录表
- `system_config`: 系统配置表

## API 接口文档

### 认证相关
- `POST /api/auth/platform/login` - 平台管理员登录
- `POST /api/auth/merchant/login` - 商户登录
- `POST /api/auth/user/login` - 用户登录

### 商户相关
- `GET /api/admin/merchant/list` - 商户列表
- `POST /api/admin/merchant/audit` - 商户审核
- `POST /api/admin/merchant/disable` - 停用商户

### 商品相关
- `GET /api/product/list` - 商品列表
- `GET /api/product/detail` - 商品详情
- `POST /api/merchant/product/create` - 创建商品
- `PUT /api/merchant/product/update` - 更新商品

### 订单相关
- `POST /api/order/create` - 创建订单
- `GET /api/order/list` - 订单列表
- `GET /api/order/detail` - 订单详情
- `POST /api/order/pay` - 支付订单

## 配置说明

### 后端配置 (application.yml)

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/agri_platform
    username: root
    password: root
  redis:
    host: localhost
    port: 6379

jwt:
  secret: agri-platform-secret-key-2024
  expiration: 604800
```

### 前端配置

#### 用户端 API 地址
文件: `client-app/utils/request.js`
```javascript
const API_BASE_URL = 'http://localhost:8080/api'
```

#### 后台管理 API 代理
文件: `admin-web/vite.config.js`
```javascript
proxy: {
  '/api': {
    target: 'http://localhost:8080'
  }
}
```

## 开发说明

### 后端开发规范
1. 每个模块包含 controller, service, mapper, entity, dto 五个包
2. 统一使用 Result 封装返回结果
3. 使用 BizException 处理业务异常
4. 使用 MyBatis-Plus 简化数据库操作
5. 使用 JWT 进行认证鉴权

### 前端开发规范
1. 组件化开发,提取公共组件
2. 统一使用 request.js 进行 API 调用
3. 路由守卫验证登录状态
4. 使用 Pinia 进行状态管理
5. 遵循 Vue 3 Composition API 规范

## 部署说明

### 后端部署
```bash
cd server
mvn clean package
java -jar target/agri-platform-1.0.0.jar
```

### 前端部署
```bash
# 后台管理系统
cd admin-web
npm run build
# 将 dist 目录部署到 nginx 或其他静态服务器

# 用户端小程序
# 使用 HBuilderX 发行到微信小程序
```

## 注意事项

1. 本项目为 MVP 版本,仅包含核心功能
2. 密码加密功能需后续完善
3. 支付功能需对接真实支付平台
4. 物流查询需对接第三方物流 API
5. 图片上传需配置 OSS 或本地存储

## 后续规划

- [ ] 完善密码加密功能
- [ ] 对接微信支付/支付宝
- [ ] 对接物流查询接口
- [ ] 实现图片上传功能
- [ ] 添加优惠券功能
- [ ] 添加会员等级功能
- [ ] 实现数据报表功能
- [ ] 添加消息通知功能

## 联系方式

如有问题,请联系开发团队。
