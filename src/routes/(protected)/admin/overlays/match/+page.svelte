<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import * as Select from '$lib/components/ui/select/index.js';
  import * as Form from '$lib/components/ui/form/index.js';
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { toast } from 'svelte-sonner';
  import type { Match } from '$lib/types/match';
  import type { PageData } from './$types';
  import type { FormSchema } from './schema';
  import { formSchema } from './schema';

  export let data: PageData;

  let matches: Match[] = [];
  let selectedMatchId: string | null = null;
  let overlayUrl = '';

  type FormType = {
    matchId: string;
  };

  const { form, errors, enhance } = superForm<FormType>(data.form, {
    id: 'match-form',
    taintedMessage: null,
    dataType: 'json',
    validators: zodClient(formSchema),
    onUpdated: ({ form }) => {
      if (form.valid) {
        selectedMatchId = form.data.matchId;
        generateOverlayUrl();
      }
    }
  });

  onMount(async () => {
    // Fetch active matches
    const { data } = await supabase
      .from('matches')
      .select(
        `
        *,
        team1:teams!team1_id(name),
        team2:teams!team2_id(name)
      `
      )
      .in('status', ['upcoming', 'live']);

    if (data) {
      matches = data;
    }
  });

  function generateOverlayUrl() {
    if (selectedMatchId) {
      const baseUrl = window.location.origin;
      overlayUrl = `${baseUrl}/overlays/match?matchId=${selectedMatchId}`;
    }
  }

  async function updateMatchScore(teamNumber: 1 | 2, increment: boolean) {
    if (!selectedMatchId) return;

    const match = matches.find((m) => m.id === selectedMatchId);
    if (!match) return;

    const scoreField = teamNumber === 1 ? 'team1_score' : 'team2_score';
    const currentScore = teamNumber === 1 ? match.team1_score : match.team2_score;
    const newScore = increment ? currentScore + 1 : Math.max(0, currentScore - 1);

    const { error } = await supabase
      .from('matches')
      .update({ [scoreField]: newScore })
      .eq('id', selectedMatchId);

    if (!error) {
      matches = matches.map((m) => {
        if (m.id === selectedMatchId) {
          return { ...m, [scoreField]: newScore };
        }
        return m;
      });
    }
  }

  async function updateMatchStatus(newStatus: 'upcoming' | 'live' | 'completed') {
    if (!selectedMatchId) return;

    const { error } = await supabase
      .from('matches')
      .update({ status: newStatus })
      .eq('id', selectedMatchId);

    if (!error) {
      matches = matches.map((m) => {
        if (m.id === selectedMatchId) {
          return { ...m, status: newStatus };
        }
        return m;
      });
    }
  }
</script>

<div class="min-h-screen bg-white p-8 dark:bg-neutral-900">
  <div class="mx-auto max-w-7xl">
    <h2 class="font-heading mb-8 text-2xl font-bold text-neutral-900 dark:text-white">
      Match Overlay Control
    </h2>

    <!-- Match Selection -->
    <div class="mb-8 rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
      <h3 class="mb-4 text-lg font-medium text-neutral-900 dark:text-white">Select Match</h3>

      <form method="POST" use:enhance>
        <div class="space-y-2">
          <label for="matchId" class="text-sm font-medium text-neutral-900 dark:text-white"
            >Match</label
          >
          <Select.Root
            type="single"
            value={$form.matchId}
            onValueChange={(value) => {
              $form.matchId = value;
              selectedMatchId = value;
              generateOverlayUrl();
            }}
          >
            <Select.Trigger class="w-full">
              {#if $form.matchId && matches.length}
                {@const match = matches.find((m) => m.id === $form.matchId)}
                {#if match}
                  {match.team1.name} vs {match.team2.name}
                {:else}
                  Select a match
                {/if}
              {:else}
                Select a match
              {/if}
            </Select.Trigger>
            <Select.Content>
              {#each matches as match}
                <Select.Item value={match.id} class="cursor-pointer">
                  {match.team1.name} vs {match.team2.name}
                </Select.Item>
              {/each}
            </Select.Content>
          </Select.Root>
          <p class="text-sm text-gray-400">Select a match to control its overlay</p>
          {#if $errors.matchId}
            <p class="text-sm text-red-500">{$errors.matchId}</p>
          {/if}
        </div>
      </form>
    </div>

    {#if overlayUrl}
      <!-- Overlay URL -->
      <div class="mb-8 rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
        <h3 class="mb-4 text-lg font-medium dark:text-white">Overlay URL</h3>
        <div class="flex items-center space-x-4">
          <input
            type="text"
            readonly
            value={overlayUrl}
            class="flex-1 rounded-md bg-neutral-700 px-4 py-2 text-white"
          />
          <button
            on:click={() => navigator.clipboard.writeText(overlayUrl)}
            class="rounded-md bg-neutral-700 px-4 py-2 text-white hover:bg-neutral-600"
          >
            Copy
          </button>
        </div>
        <p class="mt-2 text-sm text-gray-400">Use this URL as a Browser Source in OBS</p>
      </div>
    {/if}

    {#if selectedMatchId}
      <!-- Match Controls -->
      <div class="grid grid-cols-1 gap-8 md:grid-cols-2">
        <!-- Score Controls -->
        <div class="mb-8 rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3 class="mb-4 text-lg font-medium dark:text-white">Score Controls</h3>

          {#if matches.length}
            {@const match = matches.find((m) => m.id === selectedMatchId)}
            {#if match}
              <div class="space-y-6">
                <!-- Team 1 -->
                <div>
                  <h4 class="mb-2 dark:text-white">{match.team1.name}</h4>
                  <div class="flex items-center space-x-4">
                    <button
                      on:click={() => updateMatchScore(1, false)}
                      class="rounded-md bg-neutral-200 px-4 py-2 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
                    >
                      -
                    </button>
                    <span class="text-xl font-bold dark:text-white">{match.team1_score}</span>
                    <button
                      on:click={() => updateMatchScore(1, true)}
                      class="rounded-md bg-neutral-200 px-4 py-2 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
                    >
                      +
                    </button>
                  </div>
                </div>

                <!-- Team 2 -->
                <div>
                  <h4 class="mb-2 dark:text-white">{match.team2.name}</h4>
                  <div class="flex items-center space-x-4">
                    <button
                      on:click={() => updateMatchScore(2, false)}
                      class="rounded-md bg-neutral-200 px-4 py-2 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
                    >
                      -
                    </button>
                    <span class="text-xl font-bold dark:text-white">{match.team2_score}</span>
                    <button
                      on:click={() => updateMatchScore(2, true)}
                      class="rounded-md bg-neutral-200 px-4 py-2 hover:bg-neutral-300 dark:bg-neutral-700 dark:text-white dark:hover:bg-neutral-600"
                    >
                      +
                    </button>
                  </div>
                </div>
              </div>
            {/if}
          {/if}
        </div>

        <!-- Match Status Controls -->
        <div class="mb-8 rounded-lg bg-neutral-100 p-6 dark:bg-neutral-800">
          <h3 class="mb-4 text-lg font-medium dark:text-white">Match Status</h3>

          <div class="space-y-4">
            {#each ['upcoming', 'live', 'completed'] as status}
              {@const match = matches.find((m) => m.id === selectedMatchId)}
              <button
                on:click={() => updateMatchStatus(status as 'upcoming' | 'live' | 'completed')}
                class="w-full rounded-md px-4 py-2 text-white dark:text-white
                  {match?.status === status
                  ? 'bg-primary '
                  : 'bg-neutral-700 hover:bg-neutral-600'}"
              >
                {status.charAt(0).toUpperCase() + status.slice(1)}
              </button>
            {/each}
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
