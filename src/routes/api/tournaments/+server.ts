import { STARTGG_API_KEY } from "$env/static/private";
import type { RequestHandler } from "./$types";

export const GET: RequestHandler = async () => {
  try {
    const query = `
      query Tournaments($perPage: Int!) {
        tournaments(query: { perPage: $perPage, filter: { name: "Serenyx" } }) {
          nodes {
            id
            name
            slug
          }
        }
      }
    `;

    const response = await fetch("https://api.start.gg/gql/alpha", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${STARTGG_API_KEY}`,
      },
      body: JSON.stringify({
        query,
        variables: { perPage: 10 },
      }),
    });

    const { data, errors } = await response.json();

    if (errors) {
      return new Response(JSON.stringify({ success: false, errors }), {
        status: 500,
      });
    }

    return new Response(JSON.stringify(data?.tournaments?.nodes || []));
  } catch (error) {
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { status: 500 },
    );
  }
};
