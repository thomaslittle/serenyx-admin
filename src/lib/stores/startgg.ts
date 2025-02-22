import { writable } from "svelte/store";

interface Match {
  id: string;
  time: string;
  team1: string;
  team2: string;
  division: string;
}

interface Standing {
  placement: number;
  team: string;
  score: number;
}

interface EventResponse {
  eventName: string;
  eventDate: string;
  matches: Match[];
  standings: Standing[];
}

// Store for matches
export const matches = writable<Match[]>([]);
export const standings = writable<Standing[]>([]);
export const eventInfo = writable<{ name: string; date: string }>({
  name: "",
  date: "",
});

// Fetch matches from Start.gg API
export async function fetchScheduledMatches(): Promise<EventResponse> {
  try {
    const response = await fetch("/api/matches");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();

    matches.set(data.matches);
    standings.set(data.standings);
    eventInfo.set({ name: data.eventName, date: data.eventDate });

    return data;
  } catch (err) {
    console.error("Error fetching matches:", err);
    throw err;
  }
}

// Subscribe to real-time updates (if needed)
export function subscribeToTournamentUpdates() {
  // Implement real-time updates if Start.gg supports them
  // For now, just return a no-op cleanup function
  return () => {};
}
