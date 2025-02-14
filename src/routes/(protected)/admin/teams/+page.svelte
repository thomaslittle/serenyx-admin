<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import { auth, canDeleteItems } from '$lib/stores/auth';
  import { Skeleton } from '$lib/components/ui/skeleton';

  type Team = Database['public']['Tables']['teams']['Row'];

  let teams: Team[] = [];
  let loading = true;
  let error: string | null = null;
  let { role } = $auth;

  onMount(async () => {
    await fetchTeams();
  });

  async function fetchTeams() {
    try {
      loading = true;
      const { data, error: fetchError } = await supabase
        .from('teams')
        .select('*')
        .order('division')
        .order('points', { ascending: false });

      if (fetchError) throw fetchError;
      teams = data;
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    } finally {
      loading = false;
    }
  }

  async function updateTeamStats(team: Team) {
    try {
      const { error: updateError } = await supabase
        .from('teams')
        .update({
          wins: team.wins,
          losses: team.losses,
          points: team.points
        })
        .eq('id', team.id);

      if (updateError) throw updateError;
      await fetchTeams();
    } catch (e: any) {
      error = e?.message ?? 'An unknown error occurred';
    }
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2
          class="font-heading text-2xl font-bold uppercase text-neutral-900 dark:text-white sm:text-3xl"
        >
          Teams
        </h2>
      </div>

      <div class="mt-4 flex md:ml-4 md:mt-0">
        <a
          href="/admin/teams/new"
          class="inline-flex items-center rounded-md bg-primary px-3 py-2 text-sm font-semibold text-white"
        >
          Add Team
        </a>
      </div>
    </div>

    {#if error}
      <div class="mt-4 rounded-md bg-red-500 p-4">
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    <div class="mt-8">
      {#if loading}
        <div class="overflow-hidden rounded-lg bg-neutral-100 shadow dark:bg-neutral-800">
          <table class="min-w-full divide-y divide-neutral-200 dark:divide-neutral-700">
            <tbody class="divide-y divide-gray-700">
              {#each Array(5) as _}
                <tr>
                  <td class="whitespace-nowrap px-6 py-4">
                    <Skeleton class="h-4 w-32" />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <Skeleton class="h-4 w-40" />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <Skeleton class="h-4 w-24" />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <Skeleton class="h-8 w-24" />
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      {:else}
        <div class="overflow-hidden rounded-lg bg-neutral-100 shadow dark:bg-neutral-800">
          <table class="min-w-full divide-y divide-neutral-200 dark:divide-neutral-700">
            <thead>
              <tr>
                <th class="px-6 py-3 text-left text-sm font-semibold dark:text-white">Team</th>
                <th class="px-6 py-3 text-left text-sm font-semibold dark:text-white">Division</th>
                <th class="px-6 py-3 text-center text-sm font-semibold dark:text-white">Wins</th>
                <th class="px-6 py-3 text-center text-sm font-semibold dark:text-white">Losses</th>
                <th class="px-6 py-3 text-center text-sm font-semibold dark:text-white">Points</th>
                <th class="relative px-6 py-3">
                  <span class="sr-only">Actions</span>
                </th>
              </tr>
            </thead>
            <tbody class="divide-y divide-neutral-200 dark:divide-neutral-700">
              {#each teams as team}
                <tr>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="flex items-center">
                      {#if team.logo_url}
                        <img
                          src={team.logo_url}
                          alt=""
                          class="h-10 w-10 flex-shrink-0 rounded-full"
                        />
                      {/if}
                      <div class="ml-4">
                        <div class="text-sm font-medium text-neutral-900 dark:text-white">
                          {team.name}
                        </div>
                      </div>
                    </div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4">
                    <div class="text-sm text-neutral-900 dark:text-white">{team.division}</div>
                  </td>
                  <td class="whitespace-nowrap px-6 py-4 text-center">
                    <input
                      type="number"
                      value={team.wins}
                      min="0"
                      on:change={(e) =>
                        updateTeamStats({ ...team, wins: parseInt(e.currentTarget.value) })}
                      class="w-16 rounded-md bg-neutral-200 px-2 py-1 text-center text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white"
                    />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4 text-center">
                    <input
                      type="number"
                      value={team.losses}
                      min="0"
                      on:change={(e) =>
                        updateTeamStats({ ...team, losses: parseInt(e.currentTarget.value) })}
                      class="w-16 rounded-md bg-neutral-200 px-2 py-1 text-center text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white"
                    />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4 text-center">
                    <input
                      type="number"
                      value={team.points}
                      min="0"
                      on:change={(e) =>
                        updateTeamStats({ ...team, points: parseInt(e.currentTarget.value) })}
                      class="w-16 rounded-md bg-neutral-200 px-2 py-1 text-center text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white"
                    />
                  </td>
                  <td class="whitespace-nowrap px-6 py-4 text-right text-sm">
                    <a href={`/admin/teams/${team.id}`} class="text-primary hover:text-red-500">
                      {canDeleteItems(role) ? 'Edit' : 'View'}
                    </a>
                  </td>
                </tr>
              {/each}
            </tbody>
          </table>
        </div>
      {/if}
    </div>
  </div>
</div>
