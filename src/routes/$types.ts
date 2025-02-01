import type { Session, SupabaseClient } from '@supabase/supabase-js';

export interface LayoutData {
  session: Session;
  role: string;
  cookies: Record<string, string>;
  supabase: SupabaseClient;
}
