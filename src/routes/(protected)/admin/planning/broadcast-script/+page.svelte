<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { marked } from 'marked';
	import { saveDocument, getDocumentHistory, rollbackToVersion } from '$lib/stores/documents';
	import type { DocumentVersion } from '$lib/types/documents';
	import { onMount } from 'svelte';

	let isEditing = false;
	let showHistory = false;
	let markdownContent = '';
	let versions: DocumentVersion[] = [];
	let loading = false;

	onMount(async () => {
		await loadCurrentVersion();
		await loadHistory();
	});

	async function loadCurrentVersion() {
		const { data } = await supabase
			.from('versions')
			.select('content')
			.eq('document_type', 'broadcast_script')
			.eq('is_current', true)
			.single();

		if (data) {
			markdownContent = data.content;
		}
	}

	async function loadHistory() {
		versions = await getDocumentHistory('broadcast_script');
	}

	async function handleSave() {
		loading = true;
		try {
			const result = await saveDocument('broadcast_script', markdownContent);
			if (result.success) {
				isEditing = false;
				await loadHistory();
			} else {
				alert('Failed to save changes');
			}
		} finally {
			loading = false;
		}
	}

	async function handleRollback(versionId: string) {
		if (confirm('Are you sure you want to rollback to this version?')) {
			loading = true;
			try {
				await rollbackToVersion('broadcast_script', versionId);
				await loadCurrentVersion();
				await loadHistory();
				showHistory = false;
			} finally {
				loading = false;
			}
		}
	}

	function handleCancel() {
		isEditing = false;
		loadCurrentVersion(); // Reset to current version
	}
</script>

<div class="min-h-screen bg-white dark:bg-gray-900">
	<div class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
		<div class="mb-8 flex items-center justify-between">
			<h1 class="text-3xl font-bold uppercase tracking-widest text-gray-900 dark:text-white">
				Broadcast Script
			</h1>
			<div class="space-x-4">
				{#if isEditing}
					<button
						on:click={handleSave}
						disabled={loading}
						class="rounded-md bg-green-600 px-4 py-2 text-sm font-medium text-white hover:bg-green-500 disabled:opacity-50"
					>
						{loading ? 'Saving...' : 'Save'}
					</button>
					<button
						on:click={handleCancel}
						class="rounded-md bg-gray-600 px-4 py-2 text-sm font-medium text-white hover:bg-gray-500"
					>
						Cancel
					</button>
				{:else}
					<button
						on:click={() => (showHistory = !showHistory)}
						class="rounded-md bg-gray-600 px-4 py-2 text-sm font-medium text-white hover:bg-gray-500"
					>
						{showHistory ? 'Hide History' : 'Show History'}
					</button>
					<button
						on:click={() => (isEditing = true)}
						class="rounded-md bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-500"
					>
						Edit
					</button>
				{/if}
			</div>
		</div>

		{#if showHistory}
			<div class="mb-8 rounded-lg bg-gray-100 p-4 dark:bg-gray-800">
				<h2 class="mb-4 text-xl font-semibold text-gray-900 dark:text-white">Version History</h2>
				<div class="space-y-2">
					{#each versions as version}
						<div class="flex items-center justify-between rounded-md bg-white p-3 dark:bg-gray-700">
							<div class="flex flex-col gap-1">
								<span class="text-sm text-gray-600 dark:text-gray-300">
									Version {version.version_number} - {new Date(version.created_at).toLocaleString()}
								</span>
								<span class="text-xs text-gray-500 dark:text-gray-400">
									Edited by {version.creator?.email ?? 'Unknown User'}
								</span>
								{#if version.is_current}
									<span
										class="mt-1 inline-flex w-fit rounded-full bg-green-100 px-2 py-1 text-xs font-medium text-green-800 dark:bg-green-900 dark:text-green-200"
									>
										Current
									</span>
								{/if}
							</div>
							{#if !version.is_current}
								<button
									on:click={() => handleRollback(version.id)}
									class="text-sm text-blue-600 hover:text-blue-500 dark:text-blue-400"
								>
									Rollback to this version
								</button>
							{/if}
						</div>
					{/each}
				</div>
			</div>
		{/if}

		{#if isEditing}
			<div class="rounded-lg bg-gray-100 p-4 dark:bg-gray-800">
				<textarea
					bind:value={markdownContent}
					class="h-[800px] w-full resize-none rounded bg-white p-4 font-mono text-gray-900 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:bg-gray-700 dark:text-white"
				/>
			</div>
		{:else}
			<div class="prose prose-lg max-w-none dark:prose-invert">
				{@html marked(markdownContent)}
			</div>
		{/if}
	</div>
</div>
