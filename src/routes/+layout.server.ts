import type { LayoutServerLoad } from "./$types";

export const load: LayoutServerLoad = async ({ locals, url }) => {
  const { userId, user } = locals.auth;

  // Skip auth check for protected routes
  if (url.pathname.startsWith("/admin")) {
    return {
      userId,
      user,
    };
  }

  return {
    userId,
    user,
  };
};
