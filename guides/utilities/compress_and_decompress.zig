const std = @import("std");

const data = "Hello world" ** 100;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    try exec(std.compress.flate, allocator);
    try exec(std.compress.zlib, allocator);
    try exec(std.compress.gzip, allocator);
}

fn exec(comptime pkg: type, allocator: std.mem.Allocator) !void {
    std.debug.print("{}\n", .{pkg});
    var buf = std.ArrayList(u8).init(allocator);
    defer buf.deinit();

    // Compress
    var cmp = try pkg.compressor(buf.writer(), .{});
    _ = try cmp.write(data);
    try cmp.finish();
    std.debug.print("├─ Compressed: {} bytes\n", .{buf.items.len});

    // Decompress
    var fbs = std.io.fixedBufferStream(buf.items);
    var dcp = pkg.decompressor(fbs.reader());
    const plain = try dcp.reader().readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(plain);
    std.debug.print("└─ Decompressed: {} bytes\n\n", .{plain.len});
}
