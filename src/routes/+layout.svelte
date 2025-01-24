<script lang="ts">
  import '../app.css';
  import { Toaster } from '$lib/components/ui/sonner/index.js';
  import { invalidate } from '$app/navigation';
  import { onMount } from 'svelte';
  import { createBrowserClient, createServerClient, isBrowser } from '@supabase/ssr';
  import { PUBLIC_SUPABASE_ANON_KEY, PUBLIC_SUPABASE_URL } from '$env/static/public';
  import type { LayoutLoad } from './$types';

  let { children, data } = $props();
  let { session } = data;

  // Supabase client creation logic
  const supabaseClient = isBrowser()
    ? createBrowserClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: {
          fetch
        }
      })
    : createServerClient(PUBLIC_SUPABASE_URL, PUBLIC_SUPABASE_ANON_KEY, {
        global: {
          fetch
        },
        cookies: {
          getAll() {
            return data.cookies;
          }
        }
      });

  onMount(() => {
    const { data } = supabaseClient.auth.onAuthStateChange((_, newSession) => {
      if (newSession?.expires_at !== session?.expires_at) {
        invalidate('supabase:auth');
      }
    });

    return () => data.subscription.unsubscribe();
  });
</script>

<Toaster />
{@render children()}
