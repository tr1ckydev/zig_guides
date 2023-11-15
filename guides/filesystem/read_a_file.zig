const std = @import("std");

pub fn main() !void {
    // Creating the file
    const file = try std.fs.cwd().createFile("file.txt", .{});
    defer file.close();
    try file.writeAll("Hello, world!");

    // Reading the file using a fixed length buffer
    var buffer: [100]u8 = undefined;
    const contents_buf = try std.fs.cwd().readFile("file.txt", &buffer);
    std.debug.print("{s}\n", .{contents_buf});

    // Reading the file using an allocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    const contents_alloc = try std.fs.cwd().readFileAlloc(allocator, "file.txt", 1024);
    defer allocator.free(contents_alloc);
    std.debug.print("{s}\n", .{contents_alloc});
}
