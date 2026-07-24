use std::path::Path;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let proto_dir = Path::new("../shared");

    let proto_files = [
        proto_dir.join("errors/errors.proto"),
        proto_dir.join("api/server.proto"),
        proto_dir.join("api/config.proto"),
        proto_dir.join("api/users.proto"),
        proto_dir.join("api/media.proto"),
        proto_dir.join("api/logs.proto"),
        proto_dir.join("api/metrics.proto"),
        proto_dir.join("api/plugins.proto"),
        proto_dir.join("protocols/events.proto"),
    ];

    let includes = [proto_dir];

    prost_build::compile_protos(&proto_files, &includes)?;

    Ok(())
}
