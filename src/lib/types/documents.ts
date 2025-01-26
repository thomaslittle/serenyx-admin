export interface DocumentVersion {
  id: string;
  content: string;
  created_at: string;
  created_by: string;
  version_number: number;
  is_current: boolean;
  creator?: {
    email: string;
  };
}
