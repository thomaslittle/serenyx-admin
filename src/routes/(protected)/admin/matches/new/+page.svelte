<script lang="ts">
  import { onMount } from 'svelte';
  import { goto } from '$app/navigation';
  import { supabase } from '$lib/supabase/client';
  import type { Database } from '$lib/supabase/types';
  import * as Form from '$lib/components/ui/form';
  import * as Select from '$lib/components/ui/select';
  import { Input } from '$lib/components/ui/input';
  import { Button } from '$lib/components/ui/button';
  import { superForm } from 'sveltekit-superforms';
  import { zodClient } from 'sveltekit-superforms/adapters';
  import { z } from 'zod';
  import type { PageData } from './$types';
  import type { Infer, SuperValidated } from 'sveltekit-superforms';
  import { formSchema, type FormSchema } from './schema';

  export let data: { form: SuperValidated<z.infer<typeof formSchema>> };

  type Team = Database['public']['Tables']['teams']['Row'];
  type Match = Database['public']['Tables']['matches']['Row'];

  let teams: Team[] = [];
  let error: string | null = null;
  let loading = true;
  let saving = false;

  const form = superForm(data.form, {
    taintedMessage: null,
    validators: zodClient(formSchema),
    onSubmit: () => {
      saving = true;
      return async () => {
        saving = false;
      };
    },
    onResult: ({ result }) => {
      console.log('Form result:', result);
      if (result.type === 'success') {
        goto('/admin/matches');
      } else if (result.type === 'error') {
        error = result.error?.message ?? 'An error occurred';
        console.error('Form error:', result.error);
      }
    }
  });

  const { form: formData, errors: formErrors, enhance: formEnhance } = form;

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
        .order('name');

      if (fetchError) throw fetchError;
      teams = data;
    } catch (e: unknown) {
      error = e instanceof Error ? e.message : 'An error occurred';
    } finally {
      loading = false;
    }
  }

  $: teamsByDivision = teams.reduce(
    (acc, team) => {
      if (!acc[team.division]) {
        acc[team.division] = [];
      }
      acc[team.division].push(team);
      return acc;
    },
    {} as Record<string, Team[]>
  );

  $: divisions = [...new Set(teams.map((team) => team.division))].sort();

  $: if ($formData.team1_id && $formData.team2_id) {
    const team1 = teams.find((t) => t.id === $formData.team1_id);
    const team2 = teams.find((t) => t.id === $formData.team2_id);
    if (team1 && team2 && team1.division === team2.division) {
      $formData.division = team1.division;
    }
  }
</script>

<div class="container mx-auto p-4">
  <h1 class="mb-6 text-2xl font-bold">Create New Match</h1>

  <form method="POST" use:formEnhance class="max-w-2xl space-y-6">
    {#if error}
      <div
        class="relative rounded border border-red-400 bg-red-100 px-4 py-3 text-red-700"
        role="alert"
      >
        <span class="block sm:inline">{error}</span>
      </div>
    {/if}

    {#if $formErrors}
      <div
        class="relative rounded border border-red-400 bg-red-100 px-4 py-3 text-red-700"
        role="alert"
      >
        <span class="block sm:inline">Form has errors. Please check all fields.</span>
      </div>
    {/if}

    <Form.Field {form} name="team1_id">
      <Form.Control let:props>
        {#snippet children({ props })}
          <Form.Label>Team 1</Form.Label>
          <Select.Root type="single" bind:value={$formData.team1_id} {...props}>
            <Select.Trigger class="w-full">
              {$formData.team1_id
                ? teams.find((t) => t.id === $formData.team1_id)?.name
                : 'Select team 1'}
            </Select.Trigger>
            <Select.Content>
              {#each teams as team}
                <Select.Item value={team.id}>{team.name}</Select.Item>
              {/each}
            </Select.Content>
          </Select.Root>
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="team2_id">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Team 2</Form.Label>
          <Select.Root type="single" bind:value={$formData.team2_id} name={props.name}>
            <Select.Trigger {...props}>
              {$formData.team2_id
                ? teams.find((t) => t.id === $formData.team2_id)?.name
                : 'Select team 2'}
            </Select.Trigger>
            <Select.Content>
              {#each teams as team}
                <Select.Item value={team.id} label={team.name} />
              {/each}
            </Select.Content>
          </Select.Root>
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="start_time">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Start Time</Form.Label>
          <Input type="datetime-local" bind:value={$formData.start_time} {...props} />
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="division">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Division</Form.Label>
          <Input type="text" bind:value={$formData.division} {...props} />
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="status">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Status</Form.Label>
          <Select.Root type="single" bind:value={$formData.status} name={props.name}>
            <Select.Trigger {...props}>
              {$formData.status
                ? $formData.status.charAt(0).toUpperCase() + $formData.status.slice(1)
                : 'Select status'}
            </Select.Trigger>
            <Select.Content>
              <Select.Item value="upcoming" label="Upcoming" />
              <Select.Item value="live" label="Live" />
              <Select.Item value="completed" label="Completed" />
            </Select.Content>
          </Select.Root>
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="team1_score">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Team 1 Score</Form.Label>
          <Input type="number" bind:value={$formData.team1_score} {...props} />
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <Form.Field {form} name="team2_score">
      <Form.Control>
        {#snippet children({ props })}
          <Form.Label>Team 2 Score</Form.Label>
          <Input type="number" bind:value={$formData.team2_score} {...props} />
        {/snippet}
      </Form.Control>
      <Form.FieldErrors />
    </Form.Field>

    <div class="flex justify-end gap-4">
      <Button variant="outline" onclick={() => goto('/admin/matches')}>Cancel</Button>
      <Button type="submit" disabled={saving} data-saving={saving}>
        {saving ? 'Creating...' : 'Create Match'}
      </Button>
    </div>
  </form>
</div>
