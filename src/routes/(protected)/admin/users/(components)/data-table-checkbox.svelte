<script lang="ts">
  import { Checkbox } from '$lib/components/ui/checkbox';

  let { checked = false, onCheckedChange } = $props<{
    checked: boolean;
    onCheckedChange: (checked: boolean) => void;
  }>();
</script>

<div class="px-1">
  <Checkbox {checked} onchange={(e) => onCheckedChange(!!e.currentTarget.checked)} />
</div>
