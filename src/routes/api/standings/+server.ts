import { env } from "$env/dynamic/private";
import type { RequestHandler } from "./$types";

function extractEventIdFromSlug(slug: string): string {
  const parts = slug.split("/");
  return parts[parts.length - 1];
}

export const GET: RequestHandler = async ({ url }) => {
  try {
    const slug = url.searchParams.get("slug");
    if (!slug) {
      return new Response(
        JSON.stringify({ error: "Slug parameter is required" }),
        { status: 400 },
      );
    }

    // First query to get event ID
    const idResponse = await fetch("https://api.start.gg/gql/alpha", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${env.STARTGG_API_KEY}`,
      },
      body: JSON.stringify({
        query: `
          query GetEventId($slug: String) {
            event(slug: $slug) {
              id
              name
            }
          }
        `,
        variables: { slug },
      }),
    });

    const { data: idData, errors: idErrors } = await idResponse.json();

    if (idErrors || !idData?.event) {
      return new Response(
        JSON.stringify({ error: "Failed to get event ID", details: idErrors }),
        { status: 404 },
      );
    }

    const eventId = idData.event.id;
    const eventName = idData.event.name;

    // Second query to get standings
    const page = Number(url.searchParams.get("page")) || 1;
    const perPage = Number(url.searchParams.get("perPage")) || 10;

    const standingsResponse = await fetch("https://api.start.gg/gql/alpha", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${env.STARTGG_API_KEY}`,
      },
      body: JSON.stringify({
        query: `
          query EventStandings($eventId: ID!, $page: Int!, $perPage: Int!) {
            event(id: $eventId) {
              standings(query: {
                perPage: $perPage,
                page: $page
              }) {
                nodes {
                  placement
                  entrant {
                    id
                    name
                    participants {
                      gamerTag
                    }
                  }
                }
              }
            }
          }
        `,
        variables: { eventId, page, perPage },
      }),
    });

    const { data, errors } = await standingsResponse.json();

    if (errors) {
      return new Response(
        JSON.stringify({ error: "GraphQL errors", details: errors }),
        { status: 500 },
      );
    }

    const standings = data.event.standings.nodes.map((node: any) => ({
      placement: node.placement,
      name: node.entrant.name,
      participants: node.entrant.participants.map((participant: any) => ({
        gamerTag: participant.gamerTag,
      })),
    }));

    return new Response(JSON.stringify({
      standings,
      tournamentName: eventName,
    }));
  } catch (error) {
    return new Response(
      JSON.stringify({
        error: "Internal server error",
        details: error instanceof Error ? error.message : "Unknown error",
      }),
      { status: 500 },
    );
  }
};
