<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { goto } from '$app/navigation';

	let isMenuOpen = false;

	async function handleLogout() {
		const { error } = await supabase.auth.signOut();
		if (!error) {
			goto('/login');
		}
	}

	function toggleMenu() {
		isMenuOpen = !isMenuOpen;
	}
</script>

<div class="min-h-screen">
	<!-- Navigation -->
	<nav class="border-b border-zinc-800 bg-zinc-900/50">
		<div class="mx-auto max-w-7xl">
			<div class="flex h-16 items-center justify-between">
				<div class="flex items-center">
					<div class="flex shrink-0 items-center gap-4 px-6 py-5">
						<img
							src="/images/logo.jpg"
							alt="Serenyx Logo"
							class="h-10 w-10 rounded-full bg-white object-cover p-1.5"
						/>
						<span class="text-2xl font-bold uppercase tracking-widest text-white"
							>Serenyx <span class="font-light">Broadcast</span></span
						>
					</div>
				</div>
			</div>
		</div>

		<!-- Mobile menu -->
		<div class={isMenuOpen ? 'block md:hidden' : 'hidden'} id="mobile-menu">
			<div class="space-y-1 px-2 pb-3 pt-2">
				<a
					href="/admin/overlays/match"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
					>Match Overlay</a
				>
				<a
					href="/admin/overlays/teams"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
					>Team Standings</a
				>
				<a
					href="/admin/planning/broadcast-script"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
					>Broadcast Script</a
				>
				<button
					on:click={handleLogout}
					class="block w-full rounded-md px-3 py-2 text-left text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
					>Logout</button
				>
			</div>
		</div>
	</nav>

	<!-- Main content -->
	<main class="mx-auto max-w-7xl p-4">
		<div class="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
			<!-- Quick Actions -->
			<div class="bg-primary rounded-lg p-6">
				<h3
					class="border-l-2 border-red-500 pl-4 text-xl font-normal uppercase tracking-widest text-gray-900 dark:text-white"
				>
					Quick Actions
				</h3>
				<div class="mt-4 space-y-4">
					<a
						href="/admin/overlays/match"
						class="block w-full rounded-md bg-gray-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-gray-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
					>
						Start Match Overlay
					</a>
					<a
						href="/admin/overlays/teams"
						class="block w-full rounded-md bg-gray-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-gray-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
					>
						Show Team Standings
					</a>
				</div>
			</div>

			<!-- Active Matches -->
			<div class="rounded-lg bg-gray-100 p-6 dark:bg-gray-800">
				<h3
					class="border-l-2 border-red-500 pl-4 text-xl font-normal uppercase tracking-widest text-gray-900 dark:text-white"
				>
					Active Matches
				</h3>
				<div class="mt-4">
					<p class="text-gray-600 dark:text-gray-400">No active matches</p>
				</div>
			</div>

			<!-- Recent Updates -->
			<div class="rounded-lg bg-gray-100 p-6 dark:bg-gray-800">
				<h3
					class="border-l-2 border-red-500 pl-4 text-xl font-normal uppercase tracking-widest text-gray-900 dark:text-white"
				>
					Recent Updates
				</h3>
				<div class="mt-4">
					<p class="text-gray-600 dark:text-gray-400">No recent updates</p>
				</div>
			</div>

			<!-- Planning -->
			<div class="rounded-lg bg-gray-100 p-6 dark:bg-gray-800">
				<h3
					class="border-l-2 border-red-500 pl-4 text-xl font-normal uppercase tracking-widest text-gray-900 dark:text-white"
				>
					Planning
				</h3>
				<div class="mt-4 space-y-4">
					<a
						href="/admin/planning/changelog"
						class="block w-full rounded-md bg-gray-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-gray-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
					>
						Changelog
					</a>
					<a
						href="/admin/planning/broadcast-script"
						class="block w-full rounded-md bg-gray-200 px-4 py-2 text-center text-sm font-medium text-gray-900 hover:bg-gray-300 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
					>
						Broadcast Script
					</a>
				</div>
			</div>
		</div>
	</main>
</div>
