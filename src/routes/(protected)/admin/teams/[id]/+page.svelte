<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import ImageUpload from '$lib/components/ImageUpload.svelte';
  import { auth, canDeleteItems } from '$lib/stores/auth';
  import { Input } from '$lib/components/ui/input/index.js';
  import { Label } from '$lib/components/ui/label/index.js';
  import { Button } from '$lib/components/ui/button/index.js';

  type Team = Database['public']['Tables']['teams']['Row'];

  let team: Team | null = null;
  let error: string | null = null;
  let loading = true;
  let saving = false;
  const { role } = $auth as { role?: string };

  onMount(async () => {
    await fetchTeam();
  });

  async function fetchTeam() {
    try {
      loading = true;
      const { data, error: fetchError } = await supabase
        .from('teams')
        .select('*')
        .eq('id', $page.params.id)
        .single();

      if (fetchError) throw fetchError;
      team = data;
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    } finally {
      loading = false;
    }
  }

  async function updateTeam() {
    if (!team) return;

    try {
      saving = true;
      const { error: updateError } = await supabase
        .from('teams')
        .update({
          name: team.name,
          division: team.division,
          logo_url: team.logo_url,
          wins: team.wins,
          losses: team.losses,
          points: team.points
        })
        .eq('id', team.id);

      if (updateError) throw updateError;
      goto('/admin/teams');
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    } finally {
      saving = false;
    }
  }

  async function deleteTeam() {
    if (!team || !confirm('Are you sure you want to delete this team?')) return;

    try {
      saving = true;
      // If there's a logo, delete it first
      if (team.logo_url) {
        const url = new URL(team.logo_url);
        const pathMatch = url.pathname.match(/logos\/(.+)/);
        if (pathMatch) {
          const filePath = pathMatch[1];
          await supabase.storage.from('logos').remove([filePath]);
        }
      }

      const { error: deleteError } = await supabase.from('teams').delete().eq('id', team.id);

      if (deleteError) throw deleteError;
      goto('/admin/teams');
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    } finally {
      saving = false;
    }
  }

  function handleImageUpload(event: CustomEvent<{ url: string }>) {
    if (team) {
      team.logo_url = event.detail.url;
    }
  }

  function handleImageError(event: CustomEvent<{ message: string }>) {
    error = event.detail.message;
  }
</script>

<div class="min-h-screen bg-background p-6">
  <div class="mx-auto max-w-3xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="font-heading text-2xl font-bold sm:text-3xl">
          {#if loading}
            Loading...
          {:else if team}
            Edit Team: {team.name}
          {:else}
            Team Not Found
          {/if}
        </h2>
      </div>
      <div class="mt-4 flex space-x-3 md:ml-4 md:mt-0">
        <a href="/admin/teams">
          <Button variant="outline">Cancel</Button>
        </a>
        {#if canDeleteItems(role)}
          <Button variant="destructive" on:click={() => deleteTeam()} disabled={saving}>
            Delete Team
          </Button>
        {/if}
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-destructive p-4">
        <p class="text-sm capitalize leading-none text-destructive-foreground">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="mt-8">Loading team information...</div>
    {:else if team}
      <form on:submit|preventDefault={updateTeam} class="mt-8 space-y-6">
        <div class="grid w-full gap-1.5">
          <Label for="name">Team Name</Label>
          <Input type="text" id="name" bind:value={team.name} required />
        </div>

        <div class="grid w-full gap-1.5">
          <Label for="division">Division</Label>
          <Input type="text" id="division" bind:value={team.division} required />
        </div>

        <div class="grid w-full gap-1.5">
          <Label>Team Logo</Label>
          <div class="mt-1">
            <ImageUpload
              currentImageUrl={team.logo_url}
              on:upload={handleImageUpload}
              on:error={handleImageError}
            />
          </div>
        </div>

        <div class="grid grid-cols-3 gap-4">
          <div class="grid w-full gap-1.5">
            <Label for="wins">Wins</Label>
            <Input type="number" id="wins" bind:value={team.wins} min="0" />
          </div>

          <div class="grid w-full gap-1.5">
            <Label for="losses">Losses</Label>
            <Input type="number" id="losses" bind:value={team.losses} min="0" />
          </div>

          <div class="grid w-full gap-1.5">
            <Label for="points">Points</Label>
            <Input type="number" id="points" bind:value={team.points} min="0" />
          </div>
        </div>

        <div class="flex justify-end space-x-4">
          {#if canDeleteItems(role)}
            <Button type="button" variant="destructive" on:click={() => deleteTeam()}>
              Delete Team
            </Button>
          {/if}

          <Button type="submit" disabled={saving || !canDeleteItems(role)} variant="default">
            {saving ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
      </form>
    {:else}
      <div class="mt-8">Team not found.</div>
    {/if}
  </div>
</div>
