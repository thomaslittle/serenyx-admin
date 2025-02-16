<script lang="ts">
  import { goto } from '$app/navigation';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import ImageUpload from '$lib/components/ImageUpload.svelte';

  type Team = Database['public']['Tables']['teams']['Row'];

  let team: Partial<Team> = {
    name: '',
    division: '',
    wins: 0,
    losses: 0,
    points: 0,
    logo_url: ''
  };
  let error: string | null = null;
  let loading = false;

  async function createTeam() {
    try {
      loading = true;
      const { data, error: createError } = await supabase
        .from('teams')
        .insert([team])
        .select()
        .single();

      if (createError) throw createError;
      goto('/admin/teams');
    } catch (e) {
      error = e.message;
    } finally {
      loading = false;
    }
  }

  function handleImageUpload(event: CustomEvent<{ url: string }>) {
    team.logo_url = event.detail.url;
  }

  function handleImageError(event: CustomEvent<{ message: string }>) {
    error = event.detail.message;
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-3xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2 class="font-heading text-2xl font-bold uppercase text-white sm:text-3xl">New Team</h2>
      </div>
      <div class="mt-4 flex md:ml-4 md:mt-0">
        <a
          href="/admin/teams"
          class="inline-flex items-center rounded-md bg-neutral-600 px-3 py-2 text-sm font-semibold text-white hover:bg-neutral-500"
        >
          Cancel
        </a>
      </div>
    </div>

    {#if error}
      <div class="mt-4 flex items-center gap-2 rounded-md border border-primary/40 p-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          class="stroke-primary"
          ><g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5"
            ><path d="M20 16v2m0 4.01l.01-.011M4 6v6s0 3 7 3s7-3 7-3V6" /><path
              d="M11 3c7 0 7 3 7 3s0 3-7 3s-7-3-7-3s0-3 7-3m0 18c-7 0-7-3-7-3v-6"
            /></g
          ></svg
        >
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    <form on:submit|preventDefault={createTeam} class="mt-8 space-y-6">
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

      <div>
        <button
          type="submit"
          disabled={loading}
          class="w-full rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
        >
          {loading ? 'Creating...' : 'Create Team'}
        </button>
      </div>
    </form>
  </div>
</div>
