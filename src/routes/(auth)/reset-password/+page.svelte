<script lang="ts">
  import { fade } from 'svelte/transition';
  import Button from '$lib/components/ui/Button.svelte';
  import Input from '$lib/components/ui/Input.svelte';
  import { toast } from 'svelte-sonner';
  import { supabase } from '$lib/supabase/client';

  let email = '';
  let loading = false;

  async function handleReset() {
    try {
      loading = true;
      const { error } = await supabase.auth.resetPasswordForEmail(email);
      if (error) throw error;
      toast.success('Password reset email sent');
    } catch (e: any) {
      toast.error(e.message);
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen grid place-items-center p-4" in:fade>
  <div class="w-full max-w-md space-y-6">
    <div class="text-center">
      <h2 class="text-3xl font-bold">Reset Password</h2>
      <p class="text-muted-foreground mt-2">Enter your email to receive reset instructions</p>
    </div>

    <form class="space-y-4" on:submit|preventDefault={handleReset}>
      <Input
        type="email"
        placeholder="Email address"
        bind:value={email}
        required
      />

      <Button type="submit" class="w-full" {loading}>
        {loading ? 'Sending...' : 'Send Reset Link'}
      </Button>

      <div class="text-center">
        <a href="/login" class="text-sm text-primary hover:underline">
          Back to login
        </a>
      </div>
    </form>
  </div>
</div>