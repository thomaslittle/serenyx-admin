import { superValidate } from "sveltekit-superforms";
import { zod } from "sveltekit-superforms/adapters";
import type { Actions, PageServerLoad } from "./$types";
import { error, fail, redirect } from "@sveltejs/kit";
import { formSchema } from "./schema";
import { createSupabaseServerClient } from "$lib/supabase/server";
import { clerkClient } from "svelte-clerk/server";

export const load: PageServerLoad = async ({ locals, cookies }) => {
  const { userId, sessionId, getToken } = locals.auth;

  if (!userId || !sessionId) {
    throw error(401, "Unauthorized");
  }

  // Fetch full user data including metadata
  const user = await clerkClient.users.getUser(userId);
  const isAdmin = user?.publicMetadata?.role === "admin";

  if (!isAdmin) {
    throw error(403, "Unauthorized");
  }

  const form = await superValidate(zod(formSchema));
  return { form };
};

export const actions: Actions = {
  default: async ({ request, locals, cookies }) => {
    const form = await superValidate(request, zod(formSchema));
    console.log("Validated form:", form);

    if (!form.valid) {
      console.log("Form validation failed:", form.errors);
      return fail(400, { form });
    }

    try {
      const { userId, sessionId, getToken } = locals.auth;

      if (!userId || !sessionId) {
        return fail(401, { form, error: "Unauthorized" });
      }

      // Fetch full user data including metadata
      const user = await clerkClient.users.getUser(userId);
      const isAdmin = user?.publicMetadata?.role === "admin";

      if (!isAdmin) {
        return fail(403, { form, error: "Unauthorized" });
      }

      // Get the JWT token
      const token = await getToken({ template: "supabase" });

      if (!token) {
        return fail(401, { form, error: "Failed to get authorization token" });
      }

      // Convert cookies to a plain object
      const cookieData: Record<string, string> = {};
      for (const key of cookies.getAll().map((c) => c.name)) {
        const value = cookies.get(key);
        if (value) cookieData[key] = value;
      }

      const supabase = createSupabaseServerClient(cookieData, token);
      console.log("Inserting match:", form.data);
      const { data: matchData, error: createError } = await supabase
        .from("matches")
        .insert([{
          team1_id: form.data.team1_id,
          team2_id: form.data.team2_id,
          start_time: form.data.start_time,
          division: form.data.division,
          status: form.data.status,
          team1_score: form.data.team1_score,
          team2_score: form.data.team2_score,
        }])
        .select()
        .single();

      if (createError) {
        console.error("Database error:", createError);
        return fail(500, {
          form,
          error: createError.message,
        });
      }

      console.log("Match created:", matchData);
      throw redirect(303, "/admin/matches");
    } catch (e) {
      if (e instanceof Error) {
        console.error("Error creating match:", e);
        return fail(500, {
          form,
          error: e.message,
        });
      }
      throw e;
    }
  },
};
