import { z } from 'zod';

export const formSchema = z.object({
  team1_id: z.string().min(1, "Please select Team 1"),
  team2_id: z.string().min(1, "Please select Team 2"),
  start_time: z.string().min(1, "Start time is required"),
  division: z.string().min(1, "Division is required"),
  status: z.enum(['upcoming', 'live', 'completed']),
  team1_score: z.number().min(0),
  team2_score: z.number().min(0)
});

export type FormSchema = typeof formSchema; 