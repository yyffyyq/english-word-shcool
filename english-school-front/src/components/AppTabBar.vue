<template>
  <view class="app-tab-bar" :style="{ paddingBottom: `${safeAreaBottom}px` }">
    <view
      v-for="item in visibleTabs"
      :key="item.pagePath"
      class="tab-item"
      @tap="handleSwitchTab(item.pagePath)"
    >
      <view class="tab-dot" :class="{ active: item.pagePath === currentPath }" />
      <text class="tab-text" :class="{ active: item.pagePath === currentPath }">
        {{ item.text }}
      </text>
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { getTabBarConfig } from '@/constants/tabBar'
import { useUserStore } from '@/store/user'

const props = defineProps<{
  currentPath: string
}>()

const store = useUserStore()
const safeAreaBottom = ref(0)

const visibleTabs = computed(() =>
  getTabBarConfig(store.isLoggedIn.value, store.state.user?.role),
)

const info = uni.getWindowInfo()
safeAreaBottom.value = info.safeAreaInsets?.bottom || 0

onMounted(() => {
  uni.hideTabBar({ animation: false })
})

function handleSwitchTab(pagePath: string) {
  if (pagePath === props.currentPath) return
  uni.switchTab({ url: `/${pagePath}` })
}
</script>

<style scoped lang="scss">
.app-tab-bar {
  position: fixed;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: space-around;
  min-height: 56px;
  background: #fff;
  border-top: 1rpx solid rgba(0, 0, 0, 0.08);
}

.tab-item {
  display: flex;
  flex: 1;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 56px;
}

.tab-dot {
  width: 20rpx;
  height: 20rpx;
  border-radius: 50%;
  background: #9b9ba1;

  &.active {
    background: #1a1a1a;
  }
}

.tab-text {
  margin-top: 8rpx;
  font-size: 20rpx;
  color: #8e8e93;

  &.active {
    color: #1a1a1a;
  }
}
</style>
