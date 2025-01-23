<script lang="ts">
	import { fade } from 'svelte/transition';
	import Button from '$lib/components/ui/Button.svelte';
	import Input from '$lib/components/ui/Input.svelte';
	import { goto } from '$app/navigation';
	import { toast } from 'svelte-sonner';

	let form = {
		name: '',
		logo: '',
		players: [{ name: '', role: 'player' }]
	};

	async function handleSubmit() {
		try {
			const response = await fetch('/api/teams', {
				method: 'POST',
				body: JSON.stringify(form)
			});

			if (!response.ok) throw new Error('Failed to create team');
			toast.success('Team created');
			goto('/admin/teams');
		} catch (error) {
			toast.error('Failed to create team');
		}
	}
</script>

<div class="space-y-8" in:fade>
	<div>
		<h2 class="text-3xl font-bold tracking-tight">New Team</h2>
		<p class="text-muted-foreground">Add a new team to the tournament</p>
	</div>

	<form class="space-y-6" on:submit|preventDefault={handleSubmit}>
		<div class="space-y-4">
			<label class="text-sm font-medium">Team Name</label>
			<Input bind:value={form.name} required />

			<label class="text-sm font-medium">Logo URL</label>
			<Input bind:value={form.logo} type="url" />
		</div>

		<div class="space-y-4">
			<div class="flex items-center justify-between">
				<label class="text-sm font-medium">Players</label>
				<Button
					type="button"
					variant="outline"
					size="sm"
					on:click={() => (form.players = [...form.players, { name: '', role: 'player' }])}
				>
					Add Player
				</Button>
			</div>

			<div class="space-y-4">
				{#each form.players as player, i}
					<div class="flex gap-4">
						<Input bind:value={form.players[i].name} placeholder="Player name" />
						<select
							bind:value={form.players[i].role}
							class="bg-background h-10 w-40 rounded-md border px-3"
						>
							<option value="coach">Coach</option>
							<option value="captain">Captain</option>
							<option value="player">Player</option>
							<option value="substitute">Substitute</option>
						</select>
						{#if i > 0}
							<Button
								type="button"
								variant="ghost"
								size="icon"
								on:click={() => (form.players = form.players.filter((_, idx) => idx !== i))}
							>
								×
							</Button>
						{/if}
					</div>
				{/each}
			</div>
		</div>

		<div class="flex justify-end gap-4">
			<Button variant="outline" href="/admin/teams">Cancel</Button>
			<Button type="submit">Create Team</Button>
		</div>
	</form>
</div>
