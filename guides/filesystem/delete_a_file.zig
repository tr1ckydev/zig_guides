const std = @import("std");

pub fn main() !void {
    // Creating the file
    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();

    // Deleting the file
    try std.fs.cwd().deleteFile("file.txt");
}
