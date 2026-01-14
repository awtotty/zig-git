# zig-git

A git clone in Zig. For fun.

## Notes

### Core Concepts

Git is fundamentally a content-addressable filesystem - it's a key-value store where you can insert any content and get back a unique key (SHA-1 hash) that you can use to retrieve that content later.

#### The Object Database

Git stores everything as objects in .git/objects/. There are four types:

- Blobs - Store file contents. Just the raw data, no filename or metadata. Each unique file content gets one blob.
- Trees - Represent directories. They contain pointers to blobs (files) and other trees (subdirectories), along with filenames, permissions, and object types. Think of them as snapshots of a directory structure.
- Commits - Point to a tree (the root directory snapshot), contain metadata (author, committer, timestamp, message), and point to parent commit(s). This creates the version history chain.
- Tags - Annotated tags that point to commits with additional metadata.

Each object is:

1. Compressed with zlib
2. Stored in .git/objects/ using its SHA-1 hash as the filename (first 2 chars as directory, remaining 38 as filename)
3. Prefixed with its type and size

#### The Index (Staging Area)

The .git/index file is a binary file that tracks what will go into the next commit. It's essentially a cached tree structure that holds:

- File paths
- SHA-1 hashes of file contents
- File metadata (timestamps, permissions)
- Staging information

#### References

.git/refs/ contains pointers to commits:

- branches (refs/heads/) - mutable pointers to commits
- remote branches (refs/remotes/) - tracking remote state
- tags (refs/tags/) - usually immutable pointers

HEAD (.git/HEAD) is a special reference that points to the current branch (or directly to a commit in detached HEAD state).

### Key Operations

- Hashing & Storage - Take content, compute SHA-1, compress, store in object database.
- Adding files (git add) - Hash file contents into blobs, update the index to track them.
- Committing (git commit) - Create tree objects from the index structure, create a commit object pointing to that tree and the parent commit, update the current branch reference.
- Branching - Just creating a new file in refs/heads/ pointing to a commit.
- Checking out - Update HEAD to point to a branch, rebuild the working directory from that commit's tree, update the index.
- Merging - Find common ancestor, perform three-way merge of trees, create new commit with multiple parents.

### O.G. Source Code

(https://github.com/git/git/tree/master/builtin)[https://github.com/git/git/tree/master/builtin]

### TODO

Start with:

-[] Object storage/retrieval (hash-object, cat-file)
-[] Index manipulation (add, ls-files)
-[] Tree building from index
-[] Commit creation
-[] Branch/HEAD management
-[] Basic log traversal
-[] Checkout (restoring working tree from commits)
