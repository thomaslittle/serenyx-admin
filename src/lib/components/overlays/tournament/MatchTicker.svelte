<script lang="ts">
	import { onMount, onDestroy } from 'svelte';
	import { Clock } from 'lucide-svelte';
	import { matches } from '$lib/stores/tournament';
	import { fetchScheduledMatches, subscribeToTournamentUpdates } from '$lib/stores/tournament';

	let currentIndex = 0;
	let cleanup: () => void;

	onMount(async () => {
		// Initial data fetch
		await fetchScheduledMatches();

		// Set up real-time subscription
		cleanup = subscribeToTournamentUpdates();

		// Set up rotation timer
		const timer = setInterval(() => {
			if ($matches.length > 0) {
				currentIndex = (currentIndex + 1) % $matches.length;
			}
		}, 5000);

		return () => {
			clearInterval(timer);
			if (cleanup) cleanup();
		};
	});
</script>

<div class="fixed bottom-0 left-0 right-0 bg-black bg-opacity-90">
	<div class="relative h-12 overflow-hidden">
		<!-- Red accent line -->
		<div class="absolute left-0 right-0 top-0 h-1 bg-red-600"></div>

		<!-- Content -->
		<div class="flex h-full items-center px-4">
			<!-- Time indicator -->
			<div class="flex items-center space-x-2 border-r border-red-600 pr-4 text-red-600">
				<Clock class="h-4 w-4" />
				<span class="text-sm font-bold">UPCOMING</span>
			</div>

			<!-- Scrolling matches -->
			<div class="relative h-full flex-1">
				{#each $matches as match, index}
					<div
						class="absolute inset-0 flex items-center justify-between px-4 transition-all duration-500"
						style="transform: translateY({index === currentIndex ? '0' : '100%'}); 
                   opacity: {index === currentIndex ? '1' : '0'}"
					>
						<div class="flex items-center space-x-4">
							<span class="text-red-600">{match.time}</span>
							<span class="text-white">{match.team1}</span>
							<span class="font-bold text-red-600">VS</span>
							<span class="text-white">{match.team2}</span>
						</div>
						<div class="text-sm text-gray-400">{match.division}</div>
					</div>
				{/each}
			</div>

			<!-- Match counter -->
			{#if $matches.length > 0}
				<div class="border-l border-red-600 pl-4 text-sm text-gray-400">
					{currentIndex + 1} / {$matches.length}
				</div>
			{/if}
		</div>
	</div>
</div>
