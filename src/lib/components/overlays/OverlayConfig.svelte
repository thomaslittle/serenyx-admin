<script lang="ts">
  import { fade } from 'svelte/transition';
  import { Select, Input } from '$lib/components/ui/shared';
  import Button from '$lib/components/ui/Button.svelte';

  export let config = {
    theme: 'default',
    animation: 'fade',
    refreshRate: 5,
    customCSS: ''
  };
</script>

<div class="space-y-6">
  <div class="grid grid-cols-2 gap-6">
    <div class="space-y-4">
      <label class="text-sm font-medium">Theme</label>
      <Select.Root
        bind:value={config.theme}
        items={[
          { value: 'default', label: 'Default' },
          { value: 'minimal', label: 'Minimal' },
          { value: 'dynamic', label: 'Dynamic' }
        ]}
      />
    </div>

    <div class="space-y-4">
      <label class="text-sm font-medium">Animation</label>
      <Select.Root
        bind:value={config.animation}
        items={[
          { value: 'fade', label: 'Fade' },
          { value: 'slide', label: 'Slide' },
          { value: 'none', label: 'None' }
        ]}
      />
    </div>
  </div>

  <div class="space-y-4">
    <label class="text-sm font-medium">Refresh Rate (seconds)</label>
    <Input 
      type="number" 
      bind:value={config.refreshRate}
      min="1"
      max="60"
    />
  </div>

  <div class="space-y-4">
    <label class="text-sm font-medium">Custom CSS</label>
    <textarea
      bind:value={config.customCSS}
      class="w-full h-32 rounded-md border bg-transparent px-3 py-2"
      placeholder=":root { --primary: #ff0000; }"
    />
  </div>
</div>