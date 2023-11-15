const std = @import("std");

pub fn main() !void {
    const semver = try std.SemanticVersion.parse("2.0.1-alpha.1");
    std.debug.print("Major: {}\nMinor: {}\nPatch: {}\nPre: {?s}\n", .{
        semver.major,
        semver.minor,
        semver.patch,
        semver.pre,
    });
}
