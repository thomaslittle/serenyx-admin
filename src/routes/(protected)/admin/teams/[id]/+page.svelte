<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import ImageUpload from '$lib/components/ImageUpload.svelte';
  import { auth, canDeleteItems } from '$lib/stores/auth';

  type Team = Database['public']['Tables']['teams']['Row'];

  let team: Team | null = null;
  let error: string | null = null;
  let loading = true;
  let saving = false;
  let { role } = $auth;

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

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-3xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="font-heading text-2xl font-bold text-white sm:text-3xl">
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
        <a
          href="/admin/teams"
          class="inline-flex items-center rounded-md bg-neutral-600 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-500"
        >
          Cancel
        </a>
        {#if canDeleteItems(role)}
          <button
            type="button"
            on:click={deleteTeam}
            disabled={saving}
            class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white disabled:opacity-50"
          >
            Delete Team
          </button>
        {/if}
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-red-500 p-4">
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="mt-8 text-white">Loading team information...</div>
    {:else if team}
      <form on:submit|preventDefault={updateTeam} class="mt-8 space-y-6">
        <div>
          <label for="name" class="block text-sm font-medium text-white">Team Name</label>
          <input
            type="text"
            id="name"
            bind:value={team.name}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          />
        </div>

        <div>
          <label for="division" class="block text-sm font-medium text-white">Division</label>
          <input
            type="text"
            id="division"
            bind:value={team.division}
            required
            class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
          />
        </div>

        <div>
          <label class="mb-4 block text-sm font-medium text-white">Team Logo</label>
          <div class="mt-1">
            <ImageUpload
              currentImageUrl={team.logo_url}
              on:upload={handleImageUpload}
              on:error={handleImageError}
            />
          </div>
        </div>

        <div class="grid grid-cols-3 gap-4">
          <div>
            <label for="wins" class="block text-sm font-medium text-white">Wins</label>
            <input
              type="number"
              id="wins"
              bind:value={team.wins}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>

          <div>
            <label for="losses" class="block text-sm font-medium text-white">Losses</label>
            <input
              type="number"
              id="losses"
              bind:value={team.losses}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>

          <div>
            <label for="points" class="block text-sm font-medium text-white">Points</label>
            <input
              type="number"
              id="points"
              bind:value={team.points}
              min="0"
              class="mt-1 block w-full rounded-md border-gray-600 bg-neutral-700 text-white shadow-sm focus:border-red-500 focus:ring-red-500 sm:text-sm"
            />
          </div>
        </div>

        <div class="flex justify-end space-x-4">
          {#if canDeleteItems(role)}
            <button type="button" on:click={deleteTeam} class="bg-red-600 px-4 py-2 text-white">
              Delete Team
            </button>
          {/if}

          <button
            type="submit"
            disabled={saving || !canDeleteItems(role)}
            class="bg-primary px-4 py-2 text-white disabled:opacity-50"
          >
            {saving ? 'Saving...' : 'Save Changes'}
          </button>
        </div>
      </form>
    {:else}
      <div class="mt-8 text-white">Team not found.</div>
    {/if}
  </div>
</div>
