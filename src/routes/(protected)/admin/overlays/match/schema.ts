import { z } from 'zod';

export const formSchema = z.object({
  matchId: z.string({ required_error: 'Please select a match' })
});

export type FormSchema = typeof formSchema;
