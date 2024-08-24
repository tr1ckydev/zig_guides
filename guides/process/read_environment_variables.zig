const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();
    var iter = env.iterator();
    while (iter.next()) |e| {
        std.debug.print("{s}={s}\n", .{ e.key_ptr.*, e.value_ptr.* });
    }
}
