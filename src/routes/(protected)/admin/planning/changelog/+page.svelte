<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { marked } from 'marked';

	let isEditing = false;
	let markdownContent = `# Changelog

## Version 0.1.0 (Current)

### ✨ New Features
- Match overlay system with real-time score updates
- Team standings display with division breakdowns
- Broadcast script editor with markdown support
- Dark/Light mode toggle
- Authentication system with Supabase
- Responsive admin dashboard
- OBS URL generation for overlays

### 🐛 Known Issues
- [ ] Copy button not working for OBS URLs
- [ ] Division standings click state not expanding properly
- [ ] Series scores not updating consistently across sections
- [ ] Overlay data needs to be converted to real-time updates

### 🚧 In Progress
- Real-time data synchronization
- Team management system
- Match history tracking

### ✅ Completed
- Basic authentication flow
- Admin dashboard layout
- Broadcast script editor
- Dark/light mode implementation
- Initial overlay system
- Team standings display
- Match overlay base functionality

### 📋 Planned Features
- Tournament bracket system
- Player statistics tracking
- Advanced overlay customization
- Team profile pages
- Match scheduling system
- Automated social media updates

## Development Notes

### Priority Tasks
1. Fix real-time data synchronization
2. Implement proper error handling
3. Add comprehensive logging
4. Complete team management system

### Recent Updates
- Added dark/light mode toggle
- Implemented broadcast script editor
- Set up basic overlay system
- Created team standings display
- Implemented match overlay base functionality`;

	function handleEdit() {
		isEditing = true;
	}

	function handleSave() {
		isEditing = false;
		// TODO: Save to database
	}

	function handleCancel() {
		isEditing = false;
		// Reset content to last saved version if needed
	}
</script>

<div class="min-h-screen bg-white dark:bg-gray-900">
	<div class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
		<div class="mb-8 flex items-center justify-between">
			<h1 class="text-3xl font-bold uppercase tracking-widest text-gray-900 dark:text-white">
				Development Changelog
			</h1>
			<div class="space-x-4">
				{#if isEditing}
					<button
						on:click={handleSave}
						class="rounded-md bg-green-600 px-4 py-2 text-sm font-medium text-white hover:bg-green-500"
					>
						Save
					</button>
					<button
						on:click={handleCancel}
						class="rounded-md bg-gray-600 px-4 py-2 text-sm font-medium text-white hover:bg-gray-500"
					>
						Cancel
					</button>
				{:else}
					<button
						on:click={handleEdit}
						class="rounded-md bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-500"
					>
						Edit
					</button>
				{/if}
			</div>
		</div>

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
