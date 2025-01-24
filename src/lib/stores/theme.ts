import { writable } from 'svelte/store';
import { browser } from '$app/environment';

// Get initial theme from localStorage or default to light
const initialTheme = browser ? localStorage.getItem('theme') || 'light' : 'light';

export const theme = writable<'dark' | 'light'>(initialTheme as 'dark' | 'light');

// Subscribe to changes and update localStorage
if (browser) {
  theme.subscribe((value) => {
    localStorage.setItem('theme', value);
    document.documentElement.classList.toggle('dark', value === 'dark');
  });
}
