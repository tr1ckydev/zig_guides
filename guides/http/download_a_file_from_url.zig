const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var body = std.ArrayList(u8).init(allocator);
    defer body.deinit();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    std.debug.print("Downloading...\n", .{});
    _ = try client.fetch(.{
        .location = .{ .url = "https://ziglang.org/download/0.12.0/zig-0.12.0.tar.xz" },
        .response_storage = .{ .dynamic = &body },
        .max_append_size = 17099152, // ~16 MB
    });
    const tarxz_file = try std.fs.cwd().createFile("zig-0.12.0.tar.xz", .{});
    defer tarxz_file.close();
    try tarxz_file.writeAll(body.items);
    std.debug.print("Download complete.\n", .{});
}
