const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var env = try std.process.getEnvMap(allocator);
    defer env.deinit();
    const ENV_HOME = env.get("HOME");
    std.debug.print("{?s}\n", .{ENV_HOME});
}
