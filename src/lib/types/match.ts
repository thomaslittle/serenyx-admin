import type { Database } from '$lib/supabase/types';

export type Match = Database['public']['Tables']['matches']['Row'] & {
  team1: { name: string };
  team2: { name: string };
};
