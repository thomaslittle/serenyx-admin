import { redirect } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ url, locals: { supabase } }) => {
	// Log full URL for debugging
	console.log('[SXSERVERLOG] Callback URL:', url.toString());

	const code = url.searchParams.get('code');
	const error = url.searchParams.get('error');
	const errorDescription = url.searchParams.get('error_description');

	console.log('[SXSERVERLOG] Auth callback params:', {
		code: code ? `${code.substring(0, 10)}...` : null,
		error,
		errorDescription,
		searchParams: Object.fromEntries(url.searchParams)
	});

	if (error) {
		console.error('[SXSERVERLOG] Auth error:', error, errorDescription);
		throw redirect(303, `/login#error=${error}&error_description=${errorDescription}`);
	}

	if (!code) {
		console.error('[SXSERVERLOG] No code provided in callback');
		throw redirect(303, '/login#error=no_code&error_description=No authorization code provided');
	}

	try {
		console.log('[SXSERVERLOG] Attempting to exchange code for session...');
		const { data, error: exchangeError } = await supabase.auth.exchangeCodeForSession(code);

		if (exchangeError) {
			console.error('[SXSERVERLOG] Session exchange error:', exchangeError);
			throw redirect(
				303,
				`/login#error=exchange_failed&error_description=${exchangeError.message}`
			);
		}

		console.log('[SXSERVERLOG] Auth successful:', data.user?.id);
		throw redirect(303, '/admin');
	} catch (err) {
		console.error('[SXSERVERLOG] Callback error:', err);
		throw redirect(303, '/login#error=auth_failed&error_description=Authentication failed');
	}
};
