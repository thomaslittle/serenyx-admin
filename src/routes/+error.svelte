<script lang="ts">
  import { page } from '$app/stores';
</script>

<div class="min-h-screen bg-neutral-900 p-8">
  <div class="mx-auto max-w-7xl">
    <div class="rounded-lg bg-neutral-800 p-8">
      <h1 class="text-3xl font-bold text-white">
        {$page.status}: {$page.error?.message || 'Something went wrong'}
      </h1>
    </div>
  </div>
</div>
