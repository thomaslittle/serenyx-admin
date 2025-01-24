<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<div class="flex min-h-screen items-center justify-center bg-neutral-900">
  <div class="w-full max-w-md space-y-8 rounded-lg bg-neutral-800 p-6 text-center shadow-lg">
    <div class="text-white">
      <h2 class="mb-4 text-3xl font-bold">Check your email</h2>
      <p class="mb-8 text-gray-400">
        We've sent you a verification link. Please check your email to complete the signup process.
      </p>

      <button on:click={() => goto('/login')} class="text-primary hover:text-red-500">
        Return to login
      </button>
    </div>
  </div>
</div>
