import { supabase } from '$lib/supabase/client';

export async function saveDocument(type: 'changelog' | 'broadcast_script', content: string) {
  try {
    // Get the current user
    const {
      data: { user }
    } = await supabase.auth.getUser();
    if (!user) throw new Error('Not authenticated');

    // Get the latest version number
    const { data: latestVersion } = await supabase
      .from('versions')
      .select('version_number')
      .eq('document_type', type)
      .order('version_number', { ascending: false })
      .limit(1)
      .single();

    const newVersionNumber = latestVersion ? latestVersion.version_number + 1 : 1;

    // Save new version
    const { data, error } = await supabase.rpc('save_document_version', {
      p_document_type: type,
      p_content: content,
      p_created_by: user.id,
      p_version_number: newVersionNumber
    });

    if (error) throw error;
    return { success: true, version: data.version_number };
  } catch (error) {
    console.error('Error saving document:', error);
    return { success: false, error };
  }
}

export async function getDocumentHistory(type: 'changelog' | 'broadcast_script') {
  const { data, error } = await supabase
    .from('versions_with_users')
    .select('*')
    .eq('document_type', type)
    .order('version_number', { ascending: false });

  if (error) throw error;

  return (data || []).map((version: any) => ({
    id: version.id,
    content: version.content,
    created_at: version.created_at,
    created_by: version.created_by,
    version_number: version.version_number,
    is_current: version.is_current,
    creator: { email: version.user_email || 'Unknown User' }
  }));
}

export async function rollbackToVersion(type: 'changelog' | 'broadcast_script', versionId: string) {
  const { data, error } = await supabase.rpc('rollback_document_version', {
    p_document_type: type,
    p_version_id: versionId
  });

  if (error) throw error;
  return data;
}
