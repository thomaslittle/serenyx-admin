<script lang="ts">
  import { onMount, onDestroy } from 'svelte';
  import { supabase } from '$lib/supabase/client';
  import type { RealtimeChannel } from '@supabase/supabase-js';
  import type { Database } from '$lib/supabase/types';
  
  export let matchId: string;
  
  type Match = Database['public']['Tables']['matches']['Row'];
  type Team = Database['public']['Tables']['teams']['Row'];
  type Player = Database['public']['Tables']['players']['Row'];
  
  let match: Match | null = null;
  let team1: Team | null = null;
  let team2: Team | null = null;
  let team1Players: Player[] = [];
  let team2Players: Player[] = [];
  let channel: RealtimeChannel;

  onMount(async () => {
    // Initial data fetch
    await fetchMatchData();
    
    // Set up real-time subscription
    channel = supabase
      .channel(`match_${matchId}`)
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'matches',
          filter: `id=eq.${matchId}`
        },
        (payload) => {
          match = payload.new as Match;
        }
      )
      .subscribe();
  });

  onDestroy(() => {
    if (channel) {
      supabase.removeChannel(channel);
    }
  });

  async function fetchMatchData() {
    // Fetch match data
    const { data: matchData } = await supabase
      .from('matches')
      .select(`
        *,
        team1:teams!team1_id(*),
        team2:teams!team2_id(*)
      `)
      .eq('id', matchId)
      .single();

    if (matchData) {
      match = matchData;
      team1 = matchData.team1;
      team2 = matchData.team2;

      // Fetch players for both teams
      const { data: team1PlayersData } = await supabase
        .from('players')
        .select('*')
        .eq('team_id', team1.id);

      const { data: team2PlayersData } = await supabase
        .from('players')
        .select('*')
        .eq('team_id', team2.id);

      if (team1PlayersData) team1Players = team1PlayersData;
      if (team2PlayersData) team2Players = team2PlayersData;
    }
  }
</script>

<div class="fixed inset-0 pointer-events-none select-none">
  <!-- Top score bar -->
  <div class="absolute top-0 left-0 right-0 h-24 bg-black bg-opacity-90">
    <div class="relative h-full flex items-center justify-center">
      <!-- Red accent line -->
      <div class="absolute top-0 left-0 right-0 h-1 bg-red-600" />
      
      <!-- Team 1 -->
      <div class="flex items-center space-x-8">
        <div class="flex items-center space-x-4">
          {#if team1?.logo_url}
            <img src={team1.logo_url} alt={team1.name} class="w-16 h-16 object-contain" />
          {/if}
          <span class="text-white text-2xl font-bold">{team1?.name || 'TBD'}</span>
        </div>
        
        <!-- Score -->
        <div class="flex items-center space-x-4">
          <div class="w-20 h-16 bg-red-600 flex items-center justify-center">
            <span class="text-white text-3xl font-bold">{match?.team1_score || 0}</span>
          </div>
          <span class="text-red-600 text-2xl font-bold">-</span>
          <div class="w-20 h-16 bg-red-600 flex items-center justify-center">
            <span class="text-white text-3xl font-bold">{match?.team2_score || 0}</span>
          </div>
        </div>
        
        <!-- Team 2 -->
        <div class="flex items-center space-x-4">
          <span class="text-white text-2xl font-bold">{team2?.name || 'TBD'}</span>
          {#if team2?.logo_url}
            <img src={team2.logo_url} alt={team2.name} class="w-16 h-16 object-contain" />
          {/if}
        </div>
      </div>
    </div>
  </div>

  <!-- Player stats (bottom bar) -->
  {#if match?.status === 'live'}
    <div class="absolute bottom-0 left-0 right-0 bg-black bg-opacity-90 py-4">
      <div class="mx-8 grid grid-cols-3 gap-4">
        <!-- Team 1 players -->
        <div class="space-y-2">
          {#each team1Players as player}
            <div class="flex items-center justify-between text-white text-sm">
              <span class="font-bold">{player.name}</span>
              <div class="flex space-x-4">
                <span>G: {player.stats.goals}</span>
                <span>A: {player.stats.assists}</span>
                <span>S: {player.stats.saves}</span>
              </div>
            </div>
          {/each}
        </div>

        <!-- Match stats -->
        <div class="flex flex-col items-center justify-center text-white">
          <div class="text-sm text-red-600 font-bold">MATCH STATS</div>
          <div class="mt-2 grid grid-cols-3 gap-x-8 text-center">
            <div>
              <div class="text-2xl font-bold">{team1Players.reduce((sum, p) => sum + p.stats.shots, 0)}</div>
              <div class="text-xs text-gray-400">SHOTS</div>
            </div>
            <div>
              <div class="text-2xl font-bold">{team1Players.reduce((sum, p) => sum + p.stats.saves, 0)}</div>
              <div class="text-xs text-gray-400">SAVES</div>
            </div>
            <div>
              <div class="text-2xl font-bold">{team1Players.reduce((sum, p) => sum + p.stats.assists, 0)}</div>
              <div class="text-xs text-gray-400">ASSISTS</div>
            </div>
          </div>
        </div>

        <!-- Team 2 players -->
        <div class="space-y-2">
          {#each team2Players as player}
            <div class="flex items-center justify-between text-white text-sm">
              <span class="font-bold">{player.name}</span>
              <div class="flex space-x-4">
                <span>G: {player.stats.goals}</span>
                <span>A: {player.stats.assists}</span>
                <span>S: {player.stats.saves}</span>
              </div>
            </div>
          {/each}
        </div>
      </div>
    </div>
  {/if}
</div>