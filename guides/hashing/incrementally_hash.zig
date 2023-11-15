const std = @import("std");

pub fn main() void {
    var hasher = std.hash.Wyhash.init(std.math.maxInt(u64));
    hasher.update("some data");
    hasher.update(&.{ 1, 2, 3 });
    hasher.update("some more data");
    const hash = hasher.final();
    std.debug.print("{}\n", .{hash});
}
