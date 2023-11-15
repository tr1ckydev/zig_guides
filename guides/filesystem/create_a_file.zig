const std = @import("std");

pub fn main() !void {
    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();
    try file.writeAll("Hello, world!");
}
