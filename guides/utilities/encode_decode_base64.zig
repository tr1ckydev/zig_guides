const std = @import("std");

pub fn main() !void {
    var buffer: [100]u8 = undefined;

    // Encoding string to base64
    const encoder = std.base64.Base64Encoder.init(std.base64.standard_alphabet_chars, null);
    const encoded = encoder.encode(&buffer, "Hello, world!");
    std.debug.print("Encoded: {s}\n", .{encoded});

    // Decoding the above encoded base64 into string
    const decoder = std.base64.Base64Decoder.init(std.base64.standard_alphabet_chars, null);
    try decoder.decode(&buffer, encoded);
    const decoded = buffer[0..try decoder.calcSizeForSlice(encoded)];
    std.debug.print("Decoded: {s}\n", .{decoded});
}
