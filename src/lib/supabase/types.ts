export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[];

export interface Database {
  public: {
    Tables: {
      versions: {
        Row: {
          id: string;
          created_at: string;
          document_type: 'changelog' | 'broadcast_script';
          content: string;
          created_by: string;
          version_number: number;
          is_current: boolean;
        };
        Insert: {
          id?: string;
          created_at?: string;
          document_type: 'changelog' | 'broadcast_script';
          content: string;
          created_by: string;
          version_number: number;
          is_current?: boolean;
        };
        Update: {
          id?: string;
          created_at?: string;
          document_type?: 'changelog' | 'broadcast_script';
          content?: string;
          created_by?: string;
          version_number?: number;
          is_current?: boolean;
        };
      };
      matches: {
        Row: {
          id: string;
          created_at: string;
          team1_id: string;
          team2_id: string;
          team1_score: number;
          team2_score: number;
          status: 'upcoming' | 'live' | 'completed';
          tournament_id: string;
          division: string;
          start_time: string;
        };
        Insert: {
          id?: string;
          created_at?: string;
          team1_id: string;
          team2_id: string;
          team1_score?: number;
          team2_score?: number;
          status?: 'upcoming' | 'live' | 'completed';
          tournament_id: string;
          division: string;
          start_time: string;
        };
        Update: {
          id?: string;
          created_at?: string;
          team1_id?: string;
          team2_id?: string;
          team1_score?: number;
          team2_score?: number;
          status?: 'upcoming' | 'live' | 'completed';
          tournament_id?: string;
          division?: string;
          start_time?: string;
        };
      };
      teams: {
        Row: {
          id: string;
          created_at: string;
          name: string;
          division: string;
          wins: number;
          losses: number;
          points: number;
          logo_url?: string;
        };
        Insert: {
          id?: string;
          created_at?: string;
          name: string;
          division: string;
          wins?: number;
          losses?: number;
          points?: number;
          logo_url?: string;
        };
        Update: {
          id?: string;
          created_at?: string;
          name?: string;
          division?: string;
          wins?: number;
          losses?: number;
          points?: number;
          logo_url?: string;
        };
      };
      players: {
        Row: {
          id: string;
          created_at: string;
          name: string;
          team_id: string;
          stats: {
            goals: number;
            assists: number;
            saves: number;
            shots: number;
          };
        };
        Insert: {
          id?: string;
          created_at?: string;
          name: string;
          team_id: string;
          stats?: {
            goals?: number;
            assists?: number;
            saves?: number;
            shots?: number;
          };
        };
        Update: {
          id?: string;
          created_at?: string;
          name?: string;
          team_id?: string;
          stats?: {
            goals?: number;
            assists?: number;
            saves?: number;
            shots?: number;
          };
        };
      };
    };
    Functions: {
      save_document_version: {
        Args: {
          p_document_type: 'changelog' | 'broadcast_script';
          p_content: string;
          p_created_by: string;
          p_version_number: number;
        };
        Returns: void;
      };
      rollback_document_version: {
        Args: {
          p_document_type: 'changelog' | 'broadcast_script';
          p_version_id: string;
        };
        Returns: void;
      };
    };
  };
}
