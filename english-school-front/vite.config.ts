import { defineConfig } from "vite";
import uni from "@dcloudio/vite-plugin-uni";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [uni()],
  // 微信小程序真机对 ?? / 部分 ES2020 语法兼容差，降级构建目标做转译
  build: {
    target: "es2015",
  },
  esbuild: {
    target: "es2015",
  },
});
