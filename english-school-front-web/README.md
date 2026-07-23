# 英语学堂管理后台（english-school-front-web）

基于 [RuoYi-Vue3](https://gitee.com/y_project/RuoYi-Vue3)（v3.9.2）的前后端分离管理端。

## 技术栈

- Vue 3 + Vite + Pinia + Vue Router
- Element Plus
- Axios

## 快速开始

```bash
npm install
npm run dev
```

默认访问：http://localhost:5173

## 常用脚本

| 命令 | 说明 |
| --- | --- |
| `npm run dev` | 本地开发 |
| `npm run build:prod` | 生产构建 |
| `npm run build:stage` | 预发布构建 |
| `npm run preview` | 预览构建产物 |

## 配置说明

- 页面标题：`.env.*` 中的 `VITE_APP_TITLE`
- 接口前缀：开发 `/dev-api`，生产 `/prod-api`
- 后端代理：`vite.config.js` 中 `baseUrl`（默认 `http://localhost:8081`，`/dev-api` 会改写为 `/api`）

## 登录接口

- 地址：`POST /api/userAccount/system/login`
- 请求体：`{ "username": "", "password": "" }`
- 成功码：`code === 0`
- 前端开发请求：`/dev-api/userAccount/system/login` → 代理到 `http://localhost:8081/api/userAccount/system/login`
