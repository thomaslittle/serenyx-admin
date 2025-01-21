<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { marked } from 'marked';

	let isEditing = false;
	let markdownContent = `

## Pre-Show (30 minutes)

- Opening animation featuring the logo, Fennec decal design with dynamic red and black particle effects
- Openingsegment: Analysis desk with 2-3 commentators discussing:
  - Previous tournament results or intro to the tournament if first stream
  - Team power rankings
  - Key players to watch
  - Bracket predictions

## Match Coverage

### Custom overlay elements:
- Team scores with animated Serenyx logo transitions
- Player stats panel showing:
  - Goals/Assists/Saves
  - Boost meter
  - Stat trackers
- Series score tracker

### Between Games Content:
- Highlight analysis with telestration tools
- Quick technical breakdown of notable plays

## Post-Show Segments
- Winner interviews
- Tournament recap and standings update
- Preview of upcoming events

## Special Production Elements

### Custom Graphics Package
- Geometric transitions using the Serenyx logo elements
- Lower thirds with red/black gradient animations
- Team introduction screens with player cards (if available)
- Stats overlays with minimalist design matching brand
- Countdown timers with custom Fennec silhouettes

### Interactive Elements
- Live Twitter feed integration with custom hashtag
- Fan prediction polls during breaks
- Live tournament bracket updates

## Technical Setup for OBS

### Scene Collection:
- Pre-show desk layout
- Main match overlay
- Analysis screen with split replay capability
- Post-game stats screen
- Social media integration panel
- Transition scenes with animated Serenyx elements

## Unique Segment I
- "Serenyx Spotlight" - Feature on a rising team/player
- "Division Rundown" - Coverage of all 4 divisions
- "Community Corner" - Highlighting community clips/plays`;

	function handleEdit() {
		isEditing = true;
	}

	function handleSave() {
		isEditing = false;
		// TODO save the content to your database
	}

	function handleCancel() {
		isEditing = false;
		// Reset content to last saved version if needed
	}
</script>

<div class="min-h-screen bg-gray-900">
	<div class="mx-auto max-w-7xl px-4 py-8 sm:px-6 lg:px-8">
		<div class="mb-8 flex items-center justify-between">
			<h1 class="text-3xl font-bold uppercase tracking-widest text-white">Broadcast Script</h1>
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
			<div class="rounded-lg bg-gray-800 p-4">
				<textarea
					bind:value={markdownContent}
					class="h-[800px] w-full resize-none rounded bg-gray-700 p-4 font-mono text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
				/>
			</div>
		{:else}
			<div class="prose prose-invert max-w-none">
				{@html marked(markdownContent)}
			</div>
		{/if}
	</div>
</div>
