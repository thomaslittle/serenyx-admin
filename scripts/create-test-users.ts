import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  'http://localhost:54321',
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImV4cCI6MTk4MzgxMjk5Nn0.EGIM96RAZx35lJzdJsyH-qQwv8Hdp7fsn3W0YpN81IU'
);

const testUsers = [
  { email: 'league.commissioner@serenyx.com', password: 'test123', role: 'league_commissioner' },
  { email: 'deputy.commissioner@serenyx.com', password: 'test123', role: 'deputy_commissioner' },
  { email: 'secretary@serenyx.com', password: 'test123', role: 'secretary' },
  { email: 'treasurer@serenyx.com', password: 'test123', role: 'treasurer' },
  { email: 'match.commissioner@serenyx.com', password: 'test123', role: 'match_commissioner' },
  { email: 'team.manager@serenyx.com', password: 'test123', role: 'team_manager' },
  { email: 'player@serenyx.com', password: 'test123', role: 'player' }
];

async function createTestUsers() {
  for (const user of testUsers) {
    try {
      // Create user
      const { data: userData, error: createError } = await supabase.auth.admin.createUser({
        email: user.email,
        password: user.password,
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