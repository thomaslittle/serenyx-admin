import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';

// Define the app_role type to match the database enum
type AppRole = 'admin' | 'moderator';

const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '..', '.env') });

const supabaseUrl = process.env.PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('Missing required environment variables');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey, {
  auth: {
    autoRefreshToken: false,
    persistSession: false,
  },
});

const adminEmail = process.env.ADMIN_EMAIL || 'admin@serenyx.com';
const adminPassword = process.env.ADMIN_PASSWORD;

if (!adminPassword) {
  console.error('Missing ADMIN_PASSWORD environment variable');
  process.exit(1);
}

async function createOrUpdateAdminUser() {
  try {
    // Check if admin user exists
    const { data: existingUsers, error: listError } = await supabase.auth.admin.listUsers();
    
    if (listError) {
      throw listError;
    }

    const adminUser = existingUsers.users.find(user => user.email === adminEmail);

    if (adminUser) {
      console.log('Admin user already exists');
      
      // Update admin role in app_metadata
      const { error: updateError } = await supabase.auth.admin.updateUserById(
        adminUser.id,
        { app_metadata: { role: 'admin' } }
      );

      if (updateError) {
        throw updateError;
      }

      // Ensure admin role is in user_roles table
      const { error: upsertError } = await supabase
        .from('user_roles')
        .upsert(
          { user_id: adminUser.id, role: 'admin' },
          { onConflict: 'user_id' }
        );

      if (upsertError) {
        throw upsertError;
      }

      console.log('Admin role updated successfully');
    } else {
      // Create new admin user
      const { data: newUser, error: createError } = await supabase.auth.admin.createUser({
        email: adminEmail,
        password: adminPassword,
        email_confirm: true,
        app_metadata: { role: 'admin' }
      });

      if (createError) {
        throw createError;
      }

      if (!newUser.user) {
        throw new Error('Failed to create admin user');
      }

      // Add admin role to user_roles table
      const { error: insertError } = await supabase
        .from('user_roles')
        .insert({ user_id: newUser.user.id, role: 'admin' });

      if (insertError) {
        throw insertError;
      }

      console.log('Admin user created successfully');
    }
  } catch (error) {
    console.error('Error managing admin user:', error);
  }
}

createOrUpdateAdminUser();
