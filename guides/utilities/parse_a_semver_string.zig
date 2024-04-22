const std = @import("std");
const builtin = @import("builtin");

pub fn main() !void {
    const semver = try std.SemanticVersion.parse(builtin.zig_version_string);
    std.debug.print("Major: {}\nMinor: {}\nPatch: {}\nPre: {?s}\n", .{
        semver.major,
        semver.minor,
        semver.patch,
        semver.pre,
    });
}
