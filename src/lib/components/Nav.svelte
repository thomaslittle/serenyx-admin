<script lang="ts">
  import { SignedIn, SignedOut, UserButton, useClerkContext } from 'svelte-clerk';

  const ctx = useClerkContext();
  const isAdmin = $derived(ctx.user?.publicMetadata?.role === 'admin');
</script>

<nav class="flex items-center justify-between p-4">
  <div class="flex items-center space-x-4">
    <a href="/" class="text-xl font-bold">Your App</a>
    <SignedIn>
      {#if isAdmin}
        <a href="/admin" class="text-sm">Admin</a>
      {/if}
    </SignedIn>
  </div>

  <div class="flex items-center space-x-4">
    <SignedIn>
      <UserButton />
    </SignedIn>
    <SignedOut>
      <a href="/login" class="btn">Sign in</a>
      <a href="/sign-up" class="btn">Sign up</a>
    </SignedOut>
  </div>
</nav>
