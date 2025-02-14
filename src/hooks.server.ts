import { PUBLIC_CLERK_PUBLISHABLE_KEY } from "$env/static/public";
import { withClerkHandler } from "svelte-clerk/server";

export const handle = withClerkHandler({
  debug: true,
  publishableKey: PUBLIC_CLERK_PUBLISHABLE_KEY,
});
