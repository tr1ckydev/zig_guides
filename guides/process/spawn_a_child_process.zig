const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const proc = try std.process.Child.run(.{
        .allocator = allocator,
        .argv = &.{ "echo", "Hello, world!" },
    });
    defer allocator.free(proc.stdout);
    defer allocator.free(proc.stderr);
    std.debug.print("{s}", .{proc.stdout});
}
