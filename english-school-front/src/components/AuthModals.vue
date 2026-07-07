<template>
  <RoleSelectModal
    :visible="showRoleModal"
    @close="closeRoleSelect"
    @select="selectRole"
  />
  <WxLoginModal
    :visible="showWxLoginModal"
    :role="pendingRole"
    :loading="loading"
    :is-mock-env="isMockEnv"
    @close="closeWxLogin"
    @confirm="confirmWxLogin"
  />
</template>

<script setup lang="ts">
import RoleSelectModal from '@/components/RoleSelectModal.vue'
import WxLoginModal from '@/components/WxLoginModal.vue'
import { useAuth } from '@/composables/useAuth'

const {
  showRoleModal,
  showWxLoginModal,
  pendingRole,
  loading,
  isMockEnv,
  closeRoleSelect,
  closeWxLogin,
  selectRole,
  confirmWxLogin,
} = useAuth()
</script>
