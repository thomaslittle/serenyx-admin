<script lang="ts">
  import { SignUp } from 'svelte-clerk';
  import {
    Card,
    CardContent,
    CardHeader,
    CardTitle,
    CardDescription
  } from '$lib/components/ui/card/index.js';
</script>

<div class="flex min-h-[calc(100vh-8rem)] items-center justify-center">
  <div class="w-full max-w-md px-4">
    <Card>
      <CardHeader class="space-y-1">
        <CardTitle class="text-center text-2xl">Create an account</CardTitle>
        <CardDescription class="text-center">Enter your details to get started</CardDescription>
      </CardHeader>
      <CardContent>
        <SignUp routing="path" path="/sign-up" />
      </CardContent>
    </Card>
  </div>
</div>
