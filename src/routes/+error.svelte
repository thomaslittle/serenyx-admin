<script lang="ts">
  import { page } from '$app/stores';
  import { toast } from 'svelte-sonner';
  import { Button } from '$lib/components/ui/button/index.js';
  import { goto } from '$app/navigation'; // Import goto for navigation

  let copyError = () => {
    const errorText = `${$page.error?.code}: ${$page.error?.message || 'Something went wrong'}`;
    navigator.clipboard.writeText(errorText);
  };

  let returnToPrevious = () => {
    window.history.back(); // Navigate back to the previous page
  };
</script>

<div
  class="bg-light dark:bg-dark flex min-h-screen flex-col items-center justify-center p-8 transition-colors duration-300"
>
  <div class="mx-auto max-w-7xl">
    <div
      class="transform rounded-lg bg-neutral-800 p-8 shadow-lg transition-transform hover:scale-105"
    >
      <h1 class="mb-4 text-9xl font-bold text-primary">
        {$page.status}
      </h1>
      <p class="mb-8 text-xl text-gray-300">
        {$page.error?.message || 'Something went wrong'}
      </p>
      <div class="flex justify-center space-x-4">
        <Button
          class="hover:bg-primary-dark rounded bg-primary px-6 py-3 font-bold text-white transition duration-300 ease-in-out"
          onclick={() => {
            copyError();
            toast('Error message copied to clipboard');
          }}
        >
          Copy Error Message
        </Button>
        <Button
          class="rounded bg-gray-600 px-6 py-3 font-bold text-white transition duration-300 ease-in-out hover:bg-gray-700"
          onclick={returnToPrevious}
        >
          Return to Previous
        </Button>
      </div>
    </div>
  </div>
</div>
