import { createClient } from "@supabase/supabase-js";
import dotenv from "dotenv";
import { join } from "path";

console.log("Script started...");

// Define the app_role type to match the database enum
type AppRole = "admin" | "moderator";

// Load environment variables
dotenv.config();

const {
  PUBLIC_SUPABASE_URL,
  SUPABASE_SERVICE_ROLE_KEY,
  ADMIN_EMAIL,
  ADMIN_PASSWORD,
} = process.env;

// Check required environment variables
if (
  !PUBLIC_SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY || !ADMIN_EMAIL ||
  !ADMIN_PASSWORD
) {
  console.error("Error: Required environment variables are not set");
  console.error(
    "Please ensure PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, ADMIN_EMAIL, and ADMIN_PASSWORD are set in .env",
  );
  process.exit(1);
}

// Immediately executing async function
(async () => {
  try {
    console.log("Connecting to Supabase URL:", PUBLIC_SUPABASE_URL);

    console.log("Creating Supabase client...");
    const supabase = createClient(
      PUBLIC_SUPABASE_URL,
      SUPABASE_SERVICE_ROLE_KEY,
      {
        auth: {
          autoRefreshToken: false,
          persistSession: false,
        },
      },
    );

    // Configure auth settings using Management API
    console.log("Configuring auth settings...");
    const authConfig = {
      SITE_URL: PUBLIC_SUPABASE_URL,
      ENABLE_SIGNUP: true,
      ENABLE_EMAIL_SIGNUP: true,
      ENABLE_EMAIL_AUTOCONFIRM: true,
      ADDITIONAL_REDIRECT_URLS: `${PUBLIC_SUPABASE_URL}/*`,
    };

    const configResponse = await fetch(
      `${PUBLIC_SUPABASE_URL}/auth/v1/admin/config`,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          "apikey": SUPABASE_SERVICE_ROLE_KEY,
          "Authorization": `Bearer ${SUPABASE_SERVICE_ROLE_KEY}`,
        },
        body: JSON.stringify(authConfig),
      },
    );

    if (!configResponse.ok) {
      console.error(
        "Failed to configure auth settings:",
        await configResponse.text(),
      );
      process.exit(1);
    }

    console.log("Auth settings configured successfully");

    console.log("Checking for existing users...");
    // Check if admin user exists
    const { data: existingUsers, error: listError } = await supabase.auth
      .admin
      .listUsers();

    if (listError) {
      console.error("Error listing users:", listError);
      process.exit(1);
    }

    console.log("Found existing users:", existingUsers?.users?.length || 0);

    const adminUser = existingUsers.users.find((user) =>
      user.email === ADMIN_EMAIL
    );

    if (adminUser) {
      console.log("Admin user already exists");

      console.log("Updating admin role in app_metadata...");
      // Update admin role in app_metadata
      const { error: updateError } = await supabase.auth.admin.updateUserById(
        adminUser.id,
        { app_metadata: { role: "admin" } },
      );

      if (updateError) {
        console.error("Error updating user:", updateError);
        process.exit(1);
      }

      console.log("Updating user_roles table...");
      // Ensure admin role is in user_roles table
      const { error: upsertError } = await supabase
        .from("user_roles")
        .upsert(
          { user_id: adminUser.id, role: "admin" },
          { onConflict: "user_id" },
        );

      if (upsertError) {
        console.error("Error upserting role:", upsertError);
        process.exit(1);
      }

      console.log("Admin role updated successfully");
    } else {
      console.log("Creating new admin user...");
      // Create new admin user
      const { data: newUser, error: createError } = await supabase.auth.admin
        .createUser({
          email: ADMIN_EMAIL,
          password: ADMIN_PASSWORD,
          email_confirm: true,
          app_metadata: { role: "admin" },
        });

      if (createError) {
        console.error("Error creating user:", createError);
        process.exit(1);
      }

      if (!newUser.user) {
        console.error("Failed to create admin user");
        process.exit(1);
      }

      console.log("Adding admin role to user_roles table...");
      // Add admin role to user_roles table
      const { error: insertError } = await supabase
        .from("user_roles")
        .insert({ user_id: newUser.user.id, role: "admin" });

      if (insertError) {
        console.error("Error inserting role:", insertError);
        process.exit(1);
      }

      console.log("Admin user created successfully");
    }

    console.log("Script completed successfully");
    process.exit(0);
  } catch (error) {
    console.error("Top-level error:", error);
    process.exit(1);
  }
})();

// Add unhandled rejection handler
process.on("unhandledRejection", (error) => {
  console.error("Unhandled rejection:", error);
  process.exit(1);
});
