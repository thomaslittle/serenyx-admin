<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import { goto } from '$app/navigation';
  import { page } from '$app/stores';
  import { toast } from 'svelte-sonner';
  import Button from '$lib/components/ui/Button.svelte';
  import Input from '$lib/components/ui/Input.svelte';
  import { spring } from 'svelte/motion';
  import { fade, fly } from 'svelte/transition';

  let email = '';
  let password = '';
  let loading = false;
  let error: string | null = null;

  const formScale = spring(0.97);
  $: formScale.set(loading ? 0.97 : 1);

  async function handleDiscordLogin() {
    try {
      loading = true;
      const { data, error: signInError } = await supabase.auth.signInWithOAuth({
        provider: 'discord',
        options: {
          redirectTo: `${window.location.origin}/callback`,
          scopes: 'identify email'
        }
      });

      if (signInError) throw signInError;
      if (!data?.url) throw new Error('No OAuth URL received');
      
      window.location.href = data.url;
    } catch (e: any) {
      error = e.message;
      toast.error(error);
    } finally {
      loading = false;
    }
  }

  async function handleLogin() {
    try {
      loading = true;
      error = null;

      const { error: signInError } = await supabase.auth.signInWithPassword({
        email,
        password
      });

      if (signInError) throw signInError;
      goto('/admin');
    } catch (e: any) {
      error = e.message;
      toast.error(error);
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen flex items-center justify-center bg-background p-4"
     style="background-image: radial-gradient(circle at center, rgba(var(--primary) / 0.15), transparent 70%)">
  <div class="w-full max-w-md space-y-8" in:fly={{ y: 20, duration: 300 }} style="transform: scale({$formScale})">
    <div class="text-center space-y-2" in:fade>
      <div class="w-20 h-20 mx-auto">
        <img src="/logo.svg" alt="Serenyx" class="w-full" />
      </div>
      <h2 class="text-3xl font-bold">Welcome Back</h2>
      <p class="text-muted-foreground">Sign in to your Serenyx account</p>
    </div>

    <div class="space-y-4">
      <Button 
        variant="outline" 
        class="w-full justify-center gap-2" 
        on:click={handleDiscordLogin}
        disabled={loading}
      >
        <svg class="w-5 h-5" viewBox="0 0 71 55" fill="currentColor">
          <path d="M60.1045 4.8978C55.5792 2.8214 50.7265 1.2916 45.6527 0.41542C45.5603 0.39851 45.468 0.440769 45.4204 0.525289C44.7963 1.6353 44.105 3.0834 43.6209 4.2216C38.1637 3.4046 32.7345 3.4046 27.3892 4.2216C26.905 3.0581 26.1886 1.6353 25.5617 0.525289C25.5141 0.443589 25.4218 0.40133 25.3294 0.41542C20.2584 1.2888 15.4057 2.8186 10.8776 4.8978C10.8384 4.9147 10.8048 4.9429 10.7825 4.9795C1.57795 18.7309 -0.943561 32.1443 0.293408 45.3914C0.299005 45.4562 0.335386 45.5182 0.385761 45.5576C6.45866 50.0174 12.3413 52.7249 18.1147 54.5195C18.2071 54.5477 18.305 54.5139 18.3638 54.4378C19.7295 52.5728 20.9469 50.6063 21.9907 48.5383C22.0523 48.4172 21.9935 48.2735 21.8676 48.2256C19.9366 47.4931 18.0979 46.6 16.3292 45.5858C16.1893 45.5041 16.1781 45.304 16.3068 45.2082C16.679 44.9293 17.0513 44.6391 17.4067 44.3461C17.471 44.2926 17.5606 44.2813 17.6362 44.3151C29.2558 49.6202 41.8354 49.6202 53.3179 44.3151C53.3935 44.2785 53.4831 44.2898 53.5502 44.3433C53.9057 44.6363 54.2779 44.9293 54.6529 45.2082C54.7816 45.304 54.7732 45.5041 54.6333 45.5858C52.8646 46.6197 51.0259 47.4931 49.0921 48.2228C48.9662 48.2707 48.9102 48.4172 48.9718 48.5383C50.038 50.6034 51.2554 52.5699 52.5959 54.435C52.6519 54.5139 52.7526 54.5477 52.845 54.5195C58.6464 52.7249 64.529 50.0174 70.6019 45.5576C70.6551 45.5182 70.6887 45.459 70.6943 45.3942C72.1747 30.0791 68.2147 16.7757 60.1968 4.9823C60.1772 4.9429 60.1437 4.9147 60.1045 4.8978Z" />
        </svg>
        {loading ? 'Connecting...' : 'Continue with Discord'}
      </Button>

      <div class="relative">
        <div class="absolute inset-0 flex items-center">
          <div class="w-full border-t" />
        </div>
        <div class="relative flex justify-center text-sm">
          <span class="bg-background px-2 text-muted-foreground">Or continue with email</span>
        </div>
      </div>

      <form class="space-y-4" on:submit|preventDefault={handleLogin}>
        <Input
          type="email"
          placeholder="Email address"
          bind:value={email}
          required
        />
        
        <Input
          type="password"
          placeholder="Password"
          bind:value={password}
          required
        />

        {#if error}
          <div class="p-3 rounded-md bg-destructive/15 text-destructive text-sm" transition:fade>
            {error}
          </div>
        {/if}

        <div class="flex justify-between text-sm">
          <a href="/reset-password" class="text-primary hover:underline">
            Forgot password?
          </a>
          <a href="/signup" class="text-primary hover:underline">
            Create account
          </a>
        </div>

        <Button type="submit" class="w-full" disabled={loading}>
          {#if loading}
            <svg class="animate-spin -ml-1 mr-3 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4" />
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
            </svg>
            Signing in...
          {:else}
            Sign in
          {/if}
        </Button>
      </form>
    </div>
  </div>
</div>