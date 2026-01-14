//! Core types for Git objects

const Hash = [20]u8;

const ObjectType = enum {};

const Object = union(enum) {
    blob: []const u8,
    tree: Tree,
    commit: Commit,
    tag: Tag,

    pub const Tree = struct {
        // TODO
    };

    pub const Commit = struct {
        // TODO
    };

    pub const Tag = struct {
        // TODO
    };
};
