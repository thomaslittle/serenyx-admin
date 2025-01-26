<script lang="ts">
  import { Checkbox } from '$lib/components/ui/checkbox';

  export let checked: boolean;
  export let onCheckedChange: (checked: boolean) => void;
</script>

<div class="px-1">
  <Checkbox {checked} on:change={(e) => onCheckedChange(!!e.currentTarget.checked)} />
</div>
