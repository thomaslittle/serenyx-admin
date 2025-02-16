import { Clerk } from '@clerk/clerk-js';

const clerk = new Clerk(import.meta.env.VITE_CLERK_PUBLISHABLE_KEY);

// Use production keys in production
if (import.meta.env.PROD) {
  clerk.configure({
    publishableKey: 'pk_live_YOUR_PRODUCTION_KEY'
  });
}

export default clerk;
