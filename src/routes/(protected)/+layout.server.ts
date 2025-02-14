import { redirect } from "@sveltejs/kit";
import { clerkClient } from "svelte-clerk/server";
import type { LayoutServerLoad } from "./$types";

export const load: LayoutServerLoad = async ({ locals, url }) => {
  const { userId } = locals.auth;

  if (!userId) {
    throw redirect(303, "/login");
  }

  // Fetch full user data including metadata
  const user = await clerkClient.users.getUser(userId);
  const isAdmin = user?.publicMetadata?.role === "admin";

  // Allow access to these routes even if not admin
  const publicProtectedRoutes = [
    "/admin/matches",
    "/admin/teams",
    "/admin/overlays",
  ];

  if (
    !isAdmin &&
    !publicProtectedRoutes.some((route) => url.pathname.startsWith(route))
  ) {
    throw redirect(303, "/");
  }

  // Return only serializable data
  return {
    userId,
    isAdmin,
    userData: {
      email: user.emailAddresses[0]?.emailAddress,
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      imageUrl: user.imageUrl,
      publicMetadata: user.publicMetadata,
    },
  };
};
