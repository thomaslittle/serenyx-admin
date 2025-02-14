import { redirect } from "@sveltejs/kit";

export const load = ({ locals }) => {
  const { userId } = locals.auth;

  if (!userId) {
    throw redirect(307, "/login");
  }

  return {
    userId,
  };
};
