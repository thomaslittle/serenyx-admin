import { writable } from 'svelte/store';
import type { DivisionStanding, ScheduledMatch } from '$lib/types/tournament';
import { supabase } from '$lib/supabase/client';

// Stores
export const divisions = writable<DivisionStanding[]>([]);
export const matches = writable<ScheduledMatch[]>([]);

// Data fetching functions
export async function fetchDivisionStandings() {
  const { data, error } = await supabase
    .from('teams')
    .select('*')
    .order('division')
    .order('points', { ascending: false });

  if (error) {
    console.error('Error fetching standings:', error);
    return;
  }

  // Group teams by division
  const groupedTeams = data.reduce((acc, team) => {
    const division = team.division;
    if (!acc[division]) {
      acc[division] = [];
    }
    acc[division].push({
      name: team.name,
      wins: team.wins,
      losses: team.losses,
      points: team.points
    });
    return acc;
  }, {});

  // Convert to array format
  const divisionStandings = Object.entries(groupedTeams).map(([name, teams]) => ({
    name,
    teams: teams as any[]
  }));

  divisions.set(divisionStandings);
}

export async function fetchScheduledMatches() {
  const { data, error } = await supabase
    .from('matches')
    .select(
      `
      *,
      team1:teams!team1_id(name),
      team2:teams!team2_id(name)
    `
    )
    .in('status', ['upcoming', 'live'])
    .order('start_time');

  if (error) {
    console.error('Error fetching matches:', error);
    return;
  }

  const formattedMatches = data.map((match) => ({
    id: match.id,
    time: new Date(match.start_time).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
    team1: match.team1.name,
    team2: match.team2.name,
    division: match.division,
    status: match.status
  }));

  matches.set(formattedMatches);
}

// Subscribe to real-time changes
export function subscribeToTournamentUpdates() {
  // Subscribe to team updates (standings)
  const teamSubscription = supabase
    .channel('teams_changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'teams'
      },
      () => {
        fetchDivisionStandings();
      }
    )
    .subscribe();

  // Subscribe to match updates
  const matchSubscription = supabase
    .channel('matches_changes')
    .on(
      'postgres_changes',
      {
        event: '*',
        schema: 'public',
        table: 'matches'
      },
      () => {
        fetchScheduledMatches();
      }
    )
    .subscribe();

  // Return cleanup function
  return () => {
    teamSubscription.unsubscribe();
    matchSubscription.unsubscribe();
  };
}
