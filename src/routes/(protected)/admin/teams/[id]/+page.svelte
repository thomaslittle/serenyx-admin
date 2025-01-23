<script lang="ts">
	import { fade, fly } from 'svelte/transition';
	import Button from '$lib/components/ui/Button.svelte';
	import { Input, Select, ScrollArea } from '$lib/components/ui/shared';
	import { toast } from 'svelte-sonner';

	export let data;

	let editing = false;
	let saving = false;
	let name = data.team.name;
	let logo = data.team.logo;
	let players = [...data.team.players];

	async function saveTeam() {
		try {
			saving = true;
			const response = await fetch(`/api/teams/${data.team.id}`, {
				method: 'PUT',
				body: JSON.stringify({ name, logo, players })
			});

			if (!response.ok) throw new Error('Failed to save team');
			toast.success('Team saved successfully');
			editing = false;
		} catch (error) {
			toast.error('Failed to save team');
		} finally {
			saving = false;
		}
	}
</script>

<div class="space-y-8" in:fade>
	<div class="flex items-center justify-between">
		<div>
			<h2 class="text-3xl font-bold tracking-tight">{data.team.name}</h2>
			<p class="text-muted-foreground">Manage team details and roster</p>
		</div>

		<div class="flex items-center gap-2">
			{#if editing}
				<Button variant="outline" on:click={() => (editing = false)}>Cancel</Button>
				<Button on:click={saveTeam} disabled={saving}>
					{saving ? 'Saving...' : 'Save Changes'}
				</Button>
			{:else}
				<Button variant="outline" href="/admin/overlays/teams/{data.team.id}">View Overlay</Button>
				<Button on:click={() => (editing = true)}>Edit Team</Button>
			{/if}
		</div>
	</div>

	<div class="grid grid-cols-3 gap-8" in:fly={{ y: 20 }}>
		<div class="col-span-2 space-y-6">
			<div class="bg-card rounded-lg border">
				<div class="border-b p-4">
					<h3 class="font-medium">Team Details</h3>
				</div>
				<div class="space-y-4 p-4">
					{#if editing}
						<div class="space-y-2">
							<label class="text-sm font-medium">Team Name</label>
							<Input bind:value={name} />
						</div>
						<div class="space-y-2">
							<label class="text-sm font-medium">Logo URL</label>
							<Input bind:value={logo} />
						</div>
					{:else}
						<div class="flex items-center gap-4">
							<img src={data.team.logo} alt="" class="h-24 w-24 rounded-lg" />
							<div>
								<h4 class="font-medium">{data.team.name}</h4>
								<p class="text-muted-foreground mt-1 text-sm">
									{data.team.players.length} Players
								</p>
							</div>
						</div>
					{/if}
				</div>
			</div>

			<div class="bg-card rounded-lg border">
				<div class="flex items-center justify-between border-b p-4">
					<h3 class="font-medium">Team Roster</h3>
					{#if editing}
						<Button
							size="sm"
							variant="outline"
							on:click={() =>
								(players = [...players, { id: crypto.randomUUID(), name: '', role: '' }])}
						>
							Add Player
						</Button>
					{/if}
				</div>
				<ScrollArea.Root className="h-[400px]">
					<ScrollArea.Viewport class="space-y-4 p-4">
						{#each players as player, i (player.id)}
							<div class="bg-muted flex items-center gap-4 rounded-lg p-4" in:fly|local={{ y: 10 }}>
								{#if editing}
									<div class="grid flex-1 grid-cols-2 gap-4">
										<Input bind:value={players[i].name} placeholder="Player Name" />
										<Select.Root
											bind:value={players[i].role}
											items={[
												{ value: 'coach', label: 'Coach' },
												{ value: 'captain', label: 'Captain' },
												{ value: 'player', label: 'Player' },
												{ value: 'substitute', label: 'Substitute' }
											]}
										/>
									</div>
									<Button
										variant="ghost"
										size="icon"
										on:click={() => (players = players.filter((_, idx) => idx !== i))}
									>
										×
									</Button>
								{:else}
									<img src={player.avatar} alt="" class="h-10 w-10 rounded-full" />
									<div class="flex-1">
										<p class="font-medium">{player.name}</p>
										<p class="text-muted-foreground text-sm capitalize">{player.role}</p>
									</div>
								{/if}
							</div>
						{/each}
					</ScrollArea.Viewport>
					<ScrollArea.Scrollbar />
				</ScrollArea.Root>
			</div>
		</div>

		<div class="space-y-6">
			<div class="bg-card rounded-lg border">
				<div class="border-b p-4">
					<h3 class="font-medium">Recent Matches</h3>
				</div>
				<div class="space-y-4 p-4">
					{#each data.recentMatches || [] as match}
						<div class="bg-muted space-y-2 rounded-lg p-4">
							<div class="flex items-center justify-between">
								<time class="text-muted-foreground text-sm">
									{new Date(match.date).toLocaleDateString()}
								</time>
								<span class="text-sm font-medium">
									{match.result === 'win' ? 'Won' : 'Lost'}
								</span>
							</div>
							<div class="flex items-center justify-between">
								<div class="flex items-center gap-2">
									<img src={match.opponent.logo} alt="" class="h-6 w-6 rounded-full" />
									<span class="text-sm">{match.opponent.name}</span>
								</div>
								<span class="font-medium">{match.score}</span>
							</div>
						</div>
					{/each}
				</div>
			</div>

			<div class="bg-card rounded-lg border">
				<div class="border-b p-4">
					<h3 class="font-medium">Statistics</h3>
				</div>
				<div class="p-4">
					<div class="grid grid-cols-2 gap-4">
						<div class="bg-muted rounded-lg p-4 text-center">
							<p class="text-2xl font-bold">{data.stats.winRate}%</p>
							<p class="text-muted-foreground text-sm">Win Rate</p>
						</div>
						<div class="bg-muted rounded-lg p-4 text-center">
							<p class="text-2xl font-bold">{data.stats.matchesPlayed}</p>
							<p class="text-muted-foreground text-sm">Matches Played</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
