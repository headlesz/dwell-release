import AppKit

// The app icon as trydwell.app draws it — the `.large-icon` in its download section, not the
// favicon, which is a different (tighter) drawing. Every number here is that CSS:
//
//   .app-icon      background #1b1b1e; border-radius 23 of 79 (29%)
//   .large-icon    79 × 79 with a 47 × 47 rosette — the flower is 59.5% of the square
//   .rosette i     27.5% of the box, circles, at top/right/bottom/left with 36.25% offsets
//   .rosette b     37.5% of the box, centred
//   colours        centre #5188e9 · top #67bde2 · right #6e68e9 · bottom #a973e3 · left #525de0
//
// Drawn at 1024 on the macOS icon grid: the shape is 824 wide, centred, keeping the margin
// Apple's own icons leave for their shadow. Rendered into an explicit bitmap so a Retina
// display does not double it.

let canvas = 1024
let shape: CGFloat = 824
let inset = (CGFloat(canvas) - shape) / 2

func rgb(_ hex: UInt32, _ alpha: CGFloat = 1) -> NSColor {
    NSColor(srgbRed: CGFloat((hex >> 16) & 0xff) / 255, green: CGFloat((hex >> 8) & 0xff) / 255,
            blue: CGFloat(hex & 0xff) / 255, alpha: alpha)
}

let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: canvas, pixelsHigh: canvas,
                           bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false,
                           colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
NSGraphicsContext.current?.imageInterpolation = .high

// the square
let square = NSRect(x: inset, y: inset, width: shape, height: shape)
let radius = shape * 23 / 79
let squarePath = NSBezierPath(roundedRect: square, xRadius: radius, yRadius: radius)
rgb(0x1b1b1e).setFill()
squarePath.fill()

// The CSS also has an inset top highlight (`inset 0 1px 1px #ffffff50`). Left out on
// purpose: at 1px on a 79px web icon it reads as depth, at 13px on a 1024 one it reads as a
// white smear. The flat dark square is what the icon actually looks like.

// the rosette, in a box 47/79 of the square, centred. CSS y runs down; AppKit's runs up.
let box = shape * 47 / 79
let origin = NSPoint(x: inset + (shape - box) / 2, y: inset + (shape - box) / 2)
func dot(cx: CGFloat, cy: CGFloat, diameter: CGFloat, _ hex: UInt32) {
    let d = diameter * box
    let x = origin.x + cx * box - d / 2
    let y = origin.y + (1 - cy) * box - d / 2
    rgb(hex).setFill()
    NSBezierPath(ovalIn: NSRect(x: x, y: y, width: d, height: d)).fill()
}
let petal: CGFloat = 0.275, centre: CGFloat = 0.375
let edge = petal / 2                       // a petal's centre sits half a petal in from its edge
dot(cx: 0.5,      cy: edge,     diameter: petal,  0x67bde2)   // top
dot(cx: 1 - edge, cy: 0.5,      diameter: petal,  0x6e68e9)   // right
dot(cx: 0.5,      cy: 1 - edge, diameter: petal,  0xa973e3)   // bottom
dot(cx: edge,     cy: 0.5,      diameter: petal,  0x525de0)   // left
dot(cx: 0.5,      cy: 0.5,      diameter: centre, 0x5188e9)   // centre

NSGraphicsContext.restoreGraphicsState()
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments.dropFirst().first ?? "dwell.png"))
print("wrote \(rep.pixelsWide)×\(rep.pixelsHigh)")
