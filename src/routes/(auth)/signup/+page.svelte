<script lang="ts">
  import { goto } from '$app/navigation';
  import Button from '$lib/components/ui/Button.svelte';
  import Input from '$lib/components/ui/Input.svelte';
  import { supabase } from '$lib/supabase/client';
  import { toast } from 'svelte-sonner';
  import { fade } from 'svelte/transition';

  let email = '';
  let password = '';
  let loading = false;

  async function handleSignup() {
    try {
      loading = true;
      const { error } = await supabase.auth.signUp({ email, password });
      if (error) throw error;
      toast.success('Verification email sent');
      goto('/login');
    } catch (e: any) {
      toast.error(e.message);
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen grid place-items-center p-4" in:fade>
  <div class="w-full max-w-md space-y-6">
    <div class="text-center space-y-2">
      <h2 class="text-3xl font-bold">Create Account</h2>
      <p class="text-muted-foreground">Sign up to join Serenyx League</p>
    </div>

    <form class="space-y-4" on:submit|preventDefault={handleSignup}>
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

      <Button type="submit" class="w-full" {loading}>
        {loading ? 'Creating...' : 'Create Account'}
      </Button>

      <div class="text-center text-sm">
        Already have an account? 
        <a href="/login" class="text-primary hover:underline">Sign in</a>
      </div>
    </form>
  </div>
</div>