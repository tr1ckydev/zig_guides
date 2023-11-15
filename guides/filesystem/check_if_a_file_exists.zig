const std = @import("std");

pub fn main() !void {
    // Creating the file
    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();

    // Using `access`
    var flag1 = true;
    std.fs.cwd().access("file.txt", .{}) catch |err| {
        flag1 = if (err == error.FileNotFound) false else true;
    };
    std.debug.print("{}\n", .{flag1});

    // Using `openFile`
    var flag2 = true;
    _ = std.fs.cwd().openFile("file_not_exists.txt", .{}) catch |err| {
        flag2 = if (err == error.FileNotFound) false else true;
    };
    std.debug.print("{}\n", .{flag2});
}
