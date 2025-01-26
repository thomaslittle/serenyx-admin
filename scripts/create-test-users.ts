import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '..', '.env') });

const supabase = createClient(
  process.env.PUBLIC_SUPABASE_URL || 'http://localhost:54321',
  process.env.SUPABASE_SERVICE_ROLE_KEY || ''
);

const defaultPassword = process.env.TEST_USER_PASSWORD || 'changeme123';

const testUsers = [
  { email: 'league.commissioner@serenyx.com', role: 'league_commissioner' },
  { email: 'deputy.commissioner@serenyx.com', role: 'deputy_commissioner' },
  { email: 'secretary@serenyx.com', role: 'secretary' },
  { email: 'treasurer@serenyx.com', role: 'treasurer' },
  { email: 'match.commissioner@serenyx.com', role: 'match_commissioner' },
  { email: 'team.manager@serenyx.com', role: 'team_manager' },
  { email: 'player@serenyx.com', role: 'player' }
];

async function createTestUsers() {
  for (const user of testUsers) {
    try {
      // Create user
      const { data: userData, error: createError } = await supabase.auth.admin.createUser({
        email: user.email,
        password: defaultPassword,
        email_confirm: true
      });

      if (createError) {
        console.error(`Error creating user ${user.email}:`, createError);
        continue;
      }

      console.log(`Created user ${user.email}`);

      // Set role using RPC
      const { error: roleError } = await supabase.rpc('set_role', {
        input_user_id: userData.user.id,
        input_role: user.role
      });

      if (roleError) {
        console.error(`Error setting role for ${user.email}:`, roleError);
        continue;
      }

      console.log(`Set role ${user.role} for user ${user.email}`);
    } catch (error) {
      console.error(`Unexpected error for ${user.email}:`, error);
    }
  }
}

createTestUsers(); 