import { writable } from 'svelte/store';
import { browser } from '$app/environment';

export const theme = writable<'dark' | 'light'>('dark');

// Subscribe to changes and update localStorage
if (browser) {
  theme.subscribe((value) => {
    localStorage.setItem('theme', value);
    if (value === 'dark') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  });
}
