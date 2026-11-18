# Enclosed for Railway: the official image, pinned by version and digest.
# Bump both together; see CHANGELOG.md.
FROM corentinth/enclosed:1.16.1@sha256:e65f73b085823ceeab1a39c515614c1a24e9b5c69b8e1221d3d7071a4f8bc4a8

# Fixed settings for Railway. Notes and attachments go to /app/.data, which the
# template mounts as a Railway volume. Override any of these as service variables.
ENV NODE_ENV=production \
    PORT=8787 \
    STORAGE_DRIVER_FS_LITE_PATH=/app/.data

WORKDIR /app
EXPOSE 8787

# The upstream start command. The image runs as root, so the root-owned Railway
# volume at /app/.data is writable without a wrapper.
CMD ["node", "index.cjs"]
