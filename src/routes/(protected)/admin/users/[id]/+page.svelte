<!-- src/routes/(protected)/admin/users/[id]/+page.svelte -->
<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import type { PageData } from './$types';
  import { Button } from '$lib/components/ui/button/index.js';
  import * as Dialog from '$lib/components/ui/dialog/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import { page } from '$app/stores';

  const { data } = $props<{ data: PageData }>();
  const user = data.user;
  const isOwnProfile = data.isOwnProfile;

  let loading = $state(false);
  let error = $state<string | null>(null);
  let showEditDialog = $state(false);
  let editEmail = $state(user.email);

  async function handleRoleChange(newRole: string) {
    try {
      loading = true;
      const { error: updateError } = await supabase.rpc('set_role', {
        input_user_id: user.id,
        input_role: newRole
      });

      if (updateError) throw updateError;
    } catch (e: any) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  async function handleEmailUpdate() {
    try {
      loading = true;
      const { error: updateError } = await supabase.auth.updateUser({
        email: editEmail
      });

      if (updateError) throw updateError;
      showEditDialog = false;
    } catch (e: any) {
      error = e.message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-3xl">
    <div class="mb-8 flex items-center justify-between">
      <h2 class="font-heading text-2xl font-bold uppercase text-neutral-900 dark:text-white">
        User Profile
      </h2>
      <div class="flex items-center gap-2">
        {#if isOwnProfile}
          <Button variant="outline" onclick={() => (showEditDialog = true)}>Edit Profile</Button>
        {/if}
        <Button variant="outline" onclick={() => history.back()}>Back</Button>
      </div>
    </div>

    {#if error}
      <div
        class="mb-4 rounded-md border border-destructive/50 bg-destructive/10 p-3 text-sm text-destructive"
      >
        {error}
      </div>
    {/if}

    {#if loading}
      <div class="flex items-center justify-center p-8">Loading...</div>
    {:else if !user}
      <div class="rounded-lg border p-4 text-center">User not found</div>
    {:else}
      <div class="space-y-6 rounded-lg border p-6">
        <div class="grid gap-1">
          <p class="text-sm text-muted-foreground">Email</p>
          <p class="text-lg font-medium">{user.email}</p>
        </div>

        <div class="grid gap-1">
          <p class="text-sm text-muted-foreground">Role</p>
          <p class="text-lg font-medium capitalize">{user.role}</p>
        </div>

        <div class="grid gap-1">
          <p class="text-sm text-muted-foreground">Last Sign In</p>
          <p class="text-lg font-medium">
            {user.last_sign_in_at ? new Date(user.last_sign_in_at).toLocaleString() : 'Never'}
          </p>
        </div>

        <div class="grid gap-1">
          <p class="text-sm text-muted-foreground">Created At</p>
          <p class="text-lg font-medium">
            {new Date(user.created_at).toLocaleString()}
          </p>
        </div>
      </div>
    {/if}
  </div>
</div>

<Dialog.Root bind:open={showEditDialog}>
  <Dialog.Content>
    <Dialog.Header>
      <Dialog.Title>Edit Profile</Dialog.Title>
      <Dialog.Description>
        Make changes to your profile here. Click save when you're done.
      </Dialog.Description>
    </Dialog.Header>
    <div class="grid gap-4 py-4">
      <div class="grid gap-2">
        <label for="email" class="text-sm font-medium">Email</label>
        <Input id="email" bind:value={editEmail} type="email" placeholder="Enter your email" />
      </div>
    </div>
    <Dialog.Footer>
      <Button variant="outline" onclick={() => (showEditDialog = false)}>Cancel</Button>
      <Button onclick={handleEmailUpdate}>Save changes</Button>
    </Dialog.Footer>
  </Dialog.Content>
</Dialog.Root>
