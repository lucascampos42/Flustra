CREATE TABLE IF NOT EXISTS cluster_nodes (
    id TEXT PRIMARY KEY,
    address TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'replica',
    alive BOOLEAN NOT NULL DEFAULT false,
    last_seen TIMESTAMPTZ,
    started_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS transcode_jobs (
    id UUID PRIMARY KEY,
    media_id UUID NOT NULL REFERENCES media_items(id) ON DELETE CASCADE,
    source_path TEXT NOT NULL,
    target_format TEXT NOT NULL,
    target_resolution TEXT,
    status TEXT NOT NULL DEFAULT 'pending',
    progress DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    error_message TEXT,
    assigned_node TEXT REFERENCES cluster_nodes(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_transcode_status ON transcode_jobs(status);
CREATE INDEX IF NOT EXISTS idx_transcode_node ON transcode_jobs(assigned_node);
