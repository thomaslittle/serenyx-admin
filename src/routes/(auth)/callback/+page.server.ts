import { supabase } from '$lib/supabase/server';
import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

const DISCORD_CLIENT_ID = '1331360154234392587';
const DISCORD_CLIENT_SECRET = '2dc90428284f46c5abb9ec42111eb4b7c84bfa269822dff948361942c096d792';

export const load: PageServerLoad = async ({ url }) => {
	const code = url.searchParams.get('code');
	console.log(
		'[SXSERVERLOG] Received auth code:',
		code ? code.substring(0, 10) + '...' : 'missing'
	);

	if (!code) {
		console.error('[SXSERVERLOG] No code provided in callback');
		throw redirect(303, '/login?error=no_code');
	}

	try {
		console.log('[SXSERVERLOG] Exchanging code for token...');
		const tokenResponse = await fetch('https://discord.com/api/oauth2/token', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/x-www-form-urlencoded'
			},
			body: new URLSearchParams({
				client_id: DISCORD_CLIENT_ID,
				client_secret: DISCORD_CLIENT_SECRET,
				grant_type: 'authorization_code',
				code,
				redirect_uri: 'http://localhost:5173/auth/callback'
			})
		});

		if (!tokenResponse.ok) {
			const errorData = await tokenResponse.text();
			console.error('[SXSERVERLOG] Token exchange failed:', {
				status: tokenResponse.status,
				statusText: tokenResponse.statusText,
				error: errorData
			});
			throw redirect(303, `/login?error=token_exchange&details=${encodeURIComponent(errorData)}`);
		}

		const tokenData = await tokenResponse.json();
		console.log('[SXSERVERLOG] Token exchange successful');

		const userResponse = await fetch('https://discord.com/api/users/@me', {
			headers: {
				Authorization: `${tokenData.token_type} ${tokenData.access_token}`
			}
		});

		if (!userResponse.ok) {
			const errorData = await userResponse.text();
			console.error('[SXSERVERLOG] User info fetch failed:', {
				status: userResponse.status,
				statusText: userResponse.statusText,
				error: errorData
			});
			throw redirect(303, `/login?error=user_info&details=${encodeURIComponent(errorData)}`);
		}

		const user = await userResponse.json();
		console.log('[SXSERVERLOG] Got Discord user:', user.id);

		const { data: supabaseData, error: signInError } = await supabase.auth.signInWithOAuth({
			provider: 'discord',
			options: {
				redirectTo: 'http://localhost:5173/admin'
			}
		});

		if (signInError) {
			console.error('[SXSERVERLOG] Supabase sign in failed:', {
				code: signInError.code,
				message: signInError.message,
				details: signInError.details
			});
			throw redirect(
				303,
				`/login?error=supabase&details=${encodeURIComponent(signInError.message)}`
			);
		}

		console.log('[SXSERVERLOG] Supabase auth successful:', supabaseData);
		throw redirect(303, '/admin');
	} catch (error: any) {
		console.error('[SXSERVERLOG] OAuth error:', {
			name: error?.name,
			message: error?.message,
			stack: error?.stack
		});
		const errorMessage = error?.message || 'Unknown error occurred';
		throw redirect(303, `/login?error=auth&details=${encodeURIComponent(errorMessage)}`);
	}
};
