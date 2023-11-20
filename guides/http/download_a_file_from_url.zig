const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var client = std.http.Client{ .allocator = allocator };
    defer client.deinit();
    const tarxz_file = try std.fs.cwd().createFile("zig-0.11.0.tar.xz", .{});
    defer tarxz_file.close();
    std.debug.print("Downloading...\n", .{});
    var fetch_result = try client.fetch(allocator, .{
        .location = .{ .url = "https://ziglang.org/download/0.11.0/zig-0.11.0.tar.xz" },
        .response_strategy = .{ .file = tarxz_file },
    });
    defer fetch_result.deinit();
    std.debug.print("Download complete.\n", .{});
}
