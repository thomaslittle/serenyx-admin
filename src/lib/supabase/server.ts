import { createServerClient } from "@supabase/ssr";
import {
  PUBLIC_SUPABASE_ANON_KEY,
  PUBLIC_SUPABASE_URL,
} from "$env/static/public";
import type { Database } from "./types";

export function createSupabaseServerClient(
  cookies: Partial<Record<string, string>>,
  authToken?: string,
) {
  const client = createServerClient<Database>(
    PUBLIC_SUPABASE_URL,
    PUBLIC_SUPABASE_ANON_KEY,
    {
      cookies: {
        get: (key) => cookies[key] || "",
        set: (key, value, options) => {
          // This is handled by the platform
        },
        remove: (key, options) => {
          // This is handled by the platform
        },
      },
      global: {
        headers: authToken
          ? {
            Authorization: `Bearer ${authToken}`,
          }
          : {},
      },
    },
  );

  return client;
}
