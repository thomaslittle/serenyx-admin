import { redirect } from "@sveltejs/kit";
import type { LayoutLoad } from "./$types";

export const load: LayoutLoad = async ({ data }) => {
  if (!data.userId) {
    throw redirect(303, "/login");
  }
  return data;
};
