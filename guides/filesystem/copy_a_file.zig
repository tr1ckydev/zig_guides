const std = @import("std");

pub fn main() !void {
    // Creating the file
    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();
    try file.writeAll("Hello, world!");

    // Copying the file
    try std.fs.cwd().copyFile("file.txt", std.fs.cwd(), "file_copy.txt", .{});
}
