# 农产品电商平台 - 快速启动指南

## 环境要求

### 开发环境
- JDK 1.8+
- Maven 3.6+
- MySQL 8.0+
- Redis 6.0+
- Node.js 16+
- HBuilderX (用于 uni-app 开发)

## 启动步骤

### 第一步:准备数据库

1. 创建数据库并导入数据
```bash
mysql -u root -p
# 输入密码后执行:
source /Users/hefen/Desktop/husband/fenghao/docs/sql/init.sql
```

2. 验证数据库
```sql
USE agri_platform;
SHOW TABLES;
```

应该看到以下表:
- admin_user
- merchant
- merchant_apply
- merchant_withdraw
- order_info
- order_item
- payment_record
- product
- product_audit_log
- product_category
- product_sku
- refund_record
- settlement_record
- shipment_record
- system_config
- user
- user_address

### 第二步:启动 Redis

```bash
redis-server
```

### 第三步:配置并启动后端服务

1. 修改数据库配置(如需要)
编辑文件: `server/src/main/resources/application.yml`
```yaml
spring:
  datasource:
    username: root        # 修改为你的数据库用户名
    password: root        # 修改为你的数据库密码
```

2. 编译并启动后端
```bash
cd /Users/hefen/Desktop/husband/fenghao/server
mvn clean install
mvn spring-boot:run
```

3. 验证后端启动
访问: http://localhost:8080
看到页面说明后端启动成功

### 第四步:启动后台管理系统

1. 安装依赖
```bash
cd /Users/hefen/Desktop/husband/fenghao/admin-web
npm install
```

2. 启动开发服务器
```bash
npm run dev
```

3. 访问后台管理系统
访问: http://localhost:3000

4. 测试登录
- 平台管理员登录:
  - 账号: admin
  - 密码: admin123 (注意:需要在代码中验证密码,当前版本可能需要完善)

### 第五步:开发用户端(可选)

1. 使用 HBuilderX 打开项目
打开目录: `/Users/hefen/Desktop/husband/fenghao/client-app`

2. 运行到微信小程序开发工具
- 点击 HBuilderX 菜单: 运行 -> 运行到小程序模拟器 -> 微信开发者工具

3. 或运行到浏览器
- 点击 HBuilderX 菜单: 运行 -> 运行到浏览器 -> Chrome

## 测试流程

### 测试平台端功能

1. 登录平台管理后台
- 访问: http://localhost:3000
- 选择"平台登录"
- 账号: admin
- 密码: admin123

2. 测试商户审核
- 进入"商户管理"
- 查看待审核商户列表
- 点击"通过"或"驳回"进行审核

3. 测试商品审核
- 进入"商品管理"
- 查看待审核商品列表
- 进行商品审核

4. 查看数据看板
- 进入"数据看板"
- 查看销售统计数据

### 测试商户端功能

1. 商户入驻申请
- 在登录页选择"商户登录"
- 点击"还没有账号?去申请入驻"
- 填写入驻信息并提交

2. 等待平台审核通过后登录

3. 创建商品
- 登录商户后台
- 进入"商品管理"
- 点击"新增商品"
- 填写商品信息并提交审核

4. 管理订单
- 进入"订单管理"
- 查看订单列表
- 进行发货操作

### 测试用户端功能

1. 在 HBuilderX 中运行用户端项目

2. 测试商品浏览
- 查看首页商品列表
- 点击商品查看详情

3. 测试下单流程
- 添加商品到购物车
- 提交订单
- 完成支付(模拟)

4. 测试订单管理
- 查看我的订单
- 查看订单详情
- 查看物流信息

## 常见问题

### 1. 后端启动失败

**问题**: 数据库连接失败
**解决**: 
- 检查 MySQL 是否启动
- 检查数据库账号密码是否正确
- 检查数据库是否已创建

**问题**: 端口 8080 被占用
**解决**: 
修改 `application.yml` 中的端口号:
```yaml
server:
  port: 8081
```

### 2. 前端启动失败

**问题**: npm install 失败
**解决**:
```bash
# 清除缓存
npm cache clean --force
# 使用淘宝镜像
npm install --registry=https://registry.npmmirror.com
```

**问题**: 端口 3000 被占用
**解决**:
修改 `vite.config.js` 中的端口号:
```javascript
server: {
  port: 3001
}
```

### 3. Redis 连接失败

**问题**: 无法连接 Redis
**解决**:
- 检查 Redis 是否启动
- 检查 Redis 端口是否为 6379
- 如需修改 Redis 配置,编辑 `application.yml`

### 4. 跨域问题

**问题**: 前端调用后端 API 出现跨域错误
**解决**:
后端已配置跨域,如仍有问题,检查 `WebConfig.java` 中的跨域配置

## 开发建议

### 后续完善功能

1. **密码加密**
   - 使用 BCrypt 加密用户密码
   - 修改 `AuthService.java` 中的密码验证逻辑

2. **图片上传**
   - 配置本地文件存储或 OSS
   - 实现文件上传接口

3. **支付对接**
   - 对接微信支付 API
   - 实现支付回调处理

4. **物流查询**
   - 对接第三方物流查询 API
   - 实现物流信息实时更新

5. **消息通知**
   - 实现订单状态变更通知
   - 实现审核结果通知

## 项目文件说明

```
/Users/hefen/Desktop/husband/fenghao/
├── README_农产品电商平台_MVP.md  - 原始需求文档
├── PROJECT_README.md              - 项目开发文档
├── GETTING_STARTED.md            - 本启动指南
├── server/                        - 后端项目
├── admin-web/                     - 后台管理项目
├── client-app/                    - 用户端项目
└── docs/                          - 文档和SQL
```

## 技术支持

如遇到问题,请按以下顺序排查:
1. 检查环境要求是否满足
2. 检查配置文件是否正确
3. 查看控制台错误日志
4. 参考常见问题解决方案

祝你开发顺利! 🎉
