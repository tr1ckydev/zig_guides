const std = @import("std");

pub fn main() !void {
    var buffer: [100]u8 = undefined;
    var len: usize = undefined;

    var buffer_stream = std.io.fixedBufferStream(&buffer);

    var compressor = try std.compress.deflate.compressor(
        std.heap.page_allocator,
        buffer_stream.writer(),
        .{},
    );
    defer compressor.deinit();
    _ = try compressor.write("hello " ** 5);
    _ = try compressor.write("world " ** 5);
    try compressor.close();
    len = compressor.bytesWritten();
    std.debug.print("After compression:\n  Size: {} bytes\n  Content: {s}\n", .{ len, buffer[0..len] });

    buffer_stream.reset();

    var decompressor = try std.compress.deflate.decompressor(
        std.heap.page_allocator,
        buffer_stream.reader(),
        null,
    );
    defer decompressor.deinit();
    len = try decompressor.read(&buffer);
    _ = decompressor.close();
    std.debug.print("After decompression:\n  Size: {} bytes\n  Content: {s}\n", .{ len, buffer[0..len] });
}
