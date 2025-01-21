import containerQueries from '@tailwindcss/container-queries';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';

export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	darkMode: 'class',

	theme: {
		extend: {
			fontFamily: {
				sans: ['DIN Next W1G', 'sans-serif'],
				din: ['DIN Next W1G', 'sans-serif']
			},
			typography: {
				DEFAULT: {
					css: {
						h1: {
							fontFamily: 'DIN Next W1G, sans-serif'
						},
						h2: {
							fontFamily: 'DIN Next W1G, sans-serif'
						},
						h3: {
							fontFamily: 'DIN Next W1G, sans-serif'
						},
						h4: {
							fontFamily: 'DIN Next W1G, sans-serif'
						},
						h5: {
							fontFamily: 'DIN Next W1G, sans-serif'
						},
						h6: {
							fontFamily: 'DIN Next W1G, sans-serif'
						}
					}
				}
			}
		}
	},

	plugins: [typography, forms, containerQueries]
} satisfies Config;
