import type { Session } from '@supabase/supabase-js';

export interface LayoutData {
  session: Session;
  role: string;
  cookies: Record<string, string>;
}
