<script lang="ts">
  import { Button } from '$lib/components/ui/button';
  import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js';
  import MoreHorizontal from 'lucide-svelte/icons/more-horizontal';
  import { goto } from '$app/navigation';

  let showDeleteDialog = $state(false);

  let { id, roles, currentRole, onRoleChange, onDelete } = $props<{
    id: string;
    roles: string[];
    currentRole: string;
    onRoleChange: (id: string, role: string) => void;
    onDelete: (id: string) => void;
  }>();

  function handleDelete() {
    onDelete(id);
    showDeleteDialog = false;
  }
</script>

<DropdownMenu.Root>
  <DropdownMenu.Trigger>
    <Button variant="ghost" class="h-8 w-8 p-0">
      <MoreHorizontal class="h-4 w-4" />
      <span class="sr-only">Open menu</span>
    </Button>
  </DropdownMenu.Trigger>
  <DropdownMenu.Content align="end">
    <DropdownMenu.Label>User Actions</DropdownMenu.Label>
    {#each roles as role}
      <DropdownMenu.Item
        class={currentRole === role ? 'bg-accent' : ''}
        onclick={() => onRoleChange(id, role)}
      >
        Make {role}
      </DropdownMenu.Item>
    {/each}
    <DropdownMenu.Separator />
    <DropdownMenu.Item onclick={() => goto(`/admin/users/${id}`)}>View Profile</DropdownMenu.Item>
    <DropdownMenu.Separator />
    <AlertDialog.Root bind:open={showDeleteDialog}>
      <AlertDialog.Trigger class="w-full" asChild>
        <DropdownMenu.Item
          class="w-full text-primary focus:text-primary"
          onclick={(e) => e.preventDefault()}
        >
          Delete User
        </DropdownMenu.Item>
      </AlertDialog.Trigger>
      <AlertDialog.Content>
        <AlertDialog.Header>
          <AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
          <AlertDialog.Description>
            This action cannot be undone. This will permanently delete the user and remove their
            data from our servers.
          </AlertDialog.Description>
        </AlertDialog.Header>
        <AlertDialog.Footer>
          <AlertDialog.Cancel onclick={() => (showDeleteDialog = false)}>Cancel</AlertDialog.Cancel>
          <AlertDialog.Action onclick={handleDelete}>Delete</AlertDialog.Action>
        </AlertDialog.Footer>
      </AlertDialog.Content>
    </AlertDialog.Root>
  </DropdownMenu.Content>
</DropdownMenu.Root>
