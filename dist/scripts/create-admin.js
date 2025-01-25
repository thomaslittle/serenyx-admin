"use strict";
const dotenv = require('dotenv');
const { createClient } = require('@supabase/supabase-js');
dotenv.config();
const supabaseUrl = process.env.PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.PUBLIC_SUPABASE_ANON_KEY;
if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error('Missing Supabase environment variables');
}
const supabase = createClient(supabaseUrl, supabaseAnonKey);
async function createAdmin() {
    const { data: authData, error: signUpError } = await supabase.auth.signUp({
        email: 'admin@serenyx.com',
        password: 'admin123',
        options: {
            data: {
                role: 'admin'
            }
        }
    });
    if (signUpError || !authData.user) {
        throw signUpError || new Error('Failed to create user');
    }
    console.log('Admin user created successfully');
}
createAdmin().catch(console.error);
