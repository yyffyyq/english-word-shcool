<template>
  <RoleSelectModal
    :visible="auth.showRoleModal"
    @close="auth.closeRoleSelect"
    @select="auth.selectRole"
  />
  <WxLoginModal
    :visible="auth.showWxLoginModal"
    :role="auth.pendingRole"
    :loading="auth.loading"
    :is-mock-env="auth.isMockEnv"
    @close="auth.closeWxLogin"
    @confirm="auth.confirmWxLogin"
  />
</template>

<script setup lang="ts">
import RoleSelectModal from '@/components/RoleSelectModal.vue'
import WxLoginModal from '@/components/WxLoginModal.vue'
import { useAuth } from '@/composables/useAuth'

const auth = useAuth()
</script>
