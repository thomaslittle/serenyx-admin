<script lang="ts">
  import { goto } from '$app/navigation';
</script>

<div class="flex min-h-screen items-center justify-center bg-gray-900">
  <div class="w-full max-w-md space-y-8 rounded-lg bg-gray-800 p-6 shadow-lg text-center">
    <div class="text-white">
      <h2 class="text-3xl font-bold mb-4">Check your email</h2>
      <p class="text-gray-400 mb-8">
        We've sent you a verification link. Please check your email to complete the signup process.
      </p>
      
      <button
        on:click={() => goto('/login')}
        class="text-red-600 hover:text-red-500"
      >
        Return to login
      </button>
    </div>
  </div>
</div>
