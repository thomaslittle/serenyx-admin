export interface TeamStanding {
  name: string;
  wins: number;
  losses: number;
  points: number;
}

export interface DivisionStanding {
  name: string;
  teams: TeamStanding[];
}

export interface ScheduledMatch {
  id: string;
  time: string;
  team1: string;
  team2: string;
  division: string;
  status: 'upcoming' | 'live' | 'completed';
}
