import { env } from "$env/dynamic/private";
import type { RequestHandler } from "./$types";

interface StartGGSet {
  id: string;
  startAt: number;
  slots: Array<{
    entrant: {
      name: string;
    } | null;
  }>;
  fullRoundText: string;
}

interface StartGGEvent {
  name: string;
  startAt: number;
  sets: {
    nodes: StartGGSet[];
  };
  standings: {
    nodes: Array<{
      placement: number;
      entrant: {
        name: string;
      };
    }>;
  };
}

interface StandingNode {
  placement: number;
  entrant: {
    name: string;
  };
}

export const GET: RequestHandler = async () => {
  try {
    const eventSlug =
      "tournament/serenyx-league-na-120-3v3-meltdown-2/event/weekly-120-3v3-meltdown-2";
    const response = await fetch("https://api.start.gg/gql/alpha", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${env.STARTGG_API_KEY}`,
      },
      body: JSON.stringify({
        query: `
          query EventDetails($slug: String!) {
            event(slug: $slug) {
              name
              startAt
              sets(page: 1, perPage: 100, sortType: STANDARD) {
                nodes {
                  id
                  slots {
                    entrant {
                      name
                    }
                  }
                  startAt
                  fullRoundText
                  winnerId
                }
              }
              standings(query: { page: 1, perPage: 8 }) {
                nodes {
                  placement
                  entrant {
                    name
                  }
                }
              }
            }
          }
        `,
        variables: { slug: eventSlug },
      }),
    });

    const { data, errors } = await response.json();

    if (errors) {
      return new Response(JSON.stringify({ error: errors[0].message }), {
        status: 500,
      });
    }

    const event = data.event;
    const eventDate = new Date(event.startAt * 1000).toLocaleDateString([], {
      weekday: "long",
      month: "long",
      day: "numeric",
      year: "numeric",
    });

    const matches = event.sets.nodes
      .map((set: StartGGSet) => {
        if (!set.slots[0]?.entrant?.name || !set.slots[1]?.entrant?.name) {
          return null;
        }

        return {
          id: set.id,
          time: new Date(set.startAt * 1000).toLocaleTimeString([], {
            hour: "numeric",
            minute: "2-digit",
          }),
          team1: set.slots[0].entrant.name,
          team2: set.slots[1].entrant.name,
          division: set.fullRoundText,
        };
      })
      .filter(Boolean);

    const standings = event.standings.nodes.map((node: StandingNode) => ({
      placement: node.placement,
      team: node.entrant.name,
      // For now, we'll use placement as a proxy for score
      score: Math.max(9 - node.placement, 0),
    }));

    return new Response(JSON.stringify({
      eventName: event.name,
      eventDate,
      matches,
      standings,
    }));
  } catch (err) {
    const error = err as Error;
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
    });
  }
};
