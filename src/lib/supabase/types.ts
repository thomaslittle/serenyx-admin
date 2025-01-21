export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export interface Database {
  public: {
    Tables: {
      matches: {
        Row: {
          id: string
          created_at: string
          team1_id: string
          team2_id: string
          team1_score: number
          team2_score: number
          status: 'upcoming' | 'live' | 'completed'
          tournament_id: string
          division: string
          start_time: string
        }
        Insert: {
          id?: string
          created_at?: string
          team1_id: string
          team2_id: string
          team1_score?: number
          team2_score?: number
          status?: 'upcoming' | 'live' | 'completed'
          tournament_id: string
          division: string
          start_time: string
        }
        Update: {
          id?: string
          created_at?: string
          team1_id?: string
          team2_id?: string
          team1_score?: number
          team2_score?: number
          status?: 'upcoming' | 'live' | 'completed'
          tournament_id?: string
          division?: string
          start_time?: string
        }
      }
      teams: {
        Row: {
          id: string
          created_at: string
          name: string
          division: string
          wins: number
          losses: number
          points: number
          logo_url?: string
        }
        Insert: {
          id?: string
          created_at?: string
          name: string
          division: string
          wins?: number
          losses?: number
          points?: number
          logo_url?: string
        }
        Update: {
          id?: string
          created_at?: string
          name?: string
          division?: string
          wins?: number
          losses?: number
          points?: number
          logo_url?: string
        }
      }
      players: {
        Row: {
          id: string
          created_at: string
          name: string
          team_id: string
          stats: {
            goals: number
            assists: number
            saves: number
            shots: number
          }
        }
        Insert: {
          id?: string
          created_at?: string
          name: string
          team_id: string
          stats?: {
            goals?: number
            assists?: number
            saves?: number
            shots?: number
          }
        }
        Update: {
          id?: string
          created_at?: string
          name?: string
          team_id?: string
          stats?: {
            goals?: number
            assists?: number
            saves?: number
            shots?: number
          }
        }
      }
    }
  }
}