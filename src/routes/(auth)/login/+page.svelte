<script lang="ts">
  import { SignIn } from 'svelte-clerk';
  import { browser } from '$app/environment';
  import { onMount } from 'svelte';
  import {
    Card,
    CardContent,
    CardHeader,
    CardTitle,
    CardDescription
  } from '$lib/components/ui/card/index.js';

  let origin = '';

  onMount(() => {
    origin = window.location.origin;
  });
</script>

<div class="flex min-h-[calc(100vh-8rem)] items-center justify-center">
  <div class="w-full max-w-md px-4">
    <SignIn
      routing="path"
      path="/login"
      redirectUrl={browser ? `${origin}/` : '/'}
      afterSignInUrl={browser ? `${origin}/` : '/'}
      signUpUrl="/sign-up"
      oauthCallback="https://polite-oryx-44.clerk.accounts.dev/v1/oauth_callback"
      appearance={{
        elements: {
          socialButtonsBlockButton: 'gap-2',
          formButtonPrimary: 'bg-primary hover:bg-primary/90'
        }
      }}
    />
  </div>
</div>

<style>
  :global(.cl-socialButtonsIconButton) {
    height: 2.5rem !important;
  }
  :global(.cl-socialButtonsBlockButton) {
    height: 2.5rem !important;
  }
</style>
