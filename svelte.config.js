import adapter from '@sveltejs/adapter-node';
import { mdsvex } from 'mdsvex';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://svelte.dev/docs/kit/integrations
	// for more information about preprocessors
	preprocess: [
		mdsvex({
			extensions: ['.md', '.svx']
		})
	],

	kit: {
		// Using adapter-node instead of adapter-auto
		adapter: adapter()
	},

	extensions: ['.svelte', '.md', '.svx']
};

export default config;
