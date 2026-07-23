<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :span="24">
        <h2>英语学堂管理后台</h2>
        <p>基于若依 RuoYi-Vue3（Vue3 + Element Plus + Vite）搭建，前后端分离开发。</p>
        <p>当前阶段先完成前端骨架；登录、菜单、权限等接口后续按自有后端对接。</p>
        <el-divider />
        <h3>技术栈</h3>
        <ul>
          <li>Vue 3 / Vue Router / Pinia</li>
          <li>Element Plus</li>
          <li>Axios / Vite</li>
        </ul>
        <h3>常用命令</h3>
        <ul>
          <li><code>npm run dev</code>：本地开发（默认 http://localhost:5173）</li>
          <li><code>npm run build:prod</code>：生产构建</li>
          <li><code>npm run preview</code>：预览构建产物</li>
        </ul>
        <h3>接口代理</h3>
        <p>
          开发环境请求前缀为 <code>/dev-api</code>，已在
          <code>vite.config.js</code> 代理到 <code>http://localhost:8080</code>，可按后端实际地址修改。
        </p>
      </el-col>
    </el-row>
  </div>
</template>

<script setup name="Index">
</script>

<style scoped lang="scss">
.home {
  h2 {
    margin: 0 0 12px;
    font-size: 24px;
  }

  h3 {
    margin: 16px 0 8px;
    font-size: 18px;
  }

  p {
    line-height: 1.7;
    color: #606266;
  }

  ul {
    padding-left: 18px;
    line-height: 1.9;
    color: #606266;
  }

  code {
    padding: 2px 6px;
    border-radius: 4px;
    background: #f5f7fa;
    color: #e6a23c;
  }
}
</style>
