<script lang="ts">
	import { supabase } from '$lib/supabase/client';
	import { goto } from '$app/navigation';

	let email = '';
	let password = '';
	let loading = false;
	let error: string | null = null;

	async function handleLogin() {
		try {
			loading = true;
			error = null;

			const { data, error: signInError } = await supabase.auth.signInWithPassword({
				email,
				password,
				options: {
					// Keep user logged in for 30 days
					persistSession: true
				}
			});

			if (signInError) {
				throw signInError;
			}

			// Store the session in localStorage
			if (data?.session) {
				localStorage.setItem('serenyx-auth', JSON.stringify(data.session));
			}

			goto('/admin');
		} catch (e) {
			error = e.message;
		} finally {
			loading = false;
		}
	}
</script>

<div class="flex min-h-screen items-center justify-center bg-gray-900">
	<div class="w-full max-w-md space-y-8 rounded-lg bg-gray-800 p-6 shadow-lg">
		<div>
			<h2 class="text-center text-2xl font-normal uppercase tracking-widest text-white">
				Serenyx <span class="text-red-bold font-normal">login</span>
			</h2>
		</div>

		<form class="mt-8 space-y-6" on:submit|preventDefault={handleLogin}>
			<div class="-space-y-px rounded-md shadow-sm">
				<div>
					<label for="email" class="sr-only">Email address</label>
					<input
						bind:value={email}
						id="email"
						name="email"
						type="email"
						required
						class="relative block w-full rounded-t-md border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
						placeholder="Email address"
					/>
				</div>
				<div>
					<label for="password" class="sr-only">Password</label>
					<input
						bind:value={password}
						id="password"
						name="password"
						type="password"
						required
						class="relative block w-full rounded-b-md border-0 py-1.5 text-gray-900 ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:z-10 focus:ring-2 focus:ring-inset focus:ring-red-600 sm:text-sm sm:leading-6"
						placeholder="Password"
					/>
				</div>
			</div>

			{#if error}
				<div class="rounded-md bg-red-500 p-4">
					<p class="text-sm text-white">{error}</p>
				</div>
			{/if}

			<div>
				<button
					type="submit"
					disabled={loading}
					class="group relative flex w-full justify-center rounded-md bg-red-600 px-3 py-2 text-sm font-semibold text-white hover:bg-red-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-red-600 disabled:opacity-50"
				>
					{loading ? 'Signing in...' : 'Sign in'}
				</button>
			</div>
		</form>
	</div>
</div>
