
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:image/image.dart' as im;

/// Represents a bitmap image
class PdfRaster {
  /// Create a bitmap image
  const PdfRaster(
    this.width,
    this.height,
    this.pixels,
  );

  /// The width of the image
  final int width;

  /// The height of the image
  final int height;

  /// The raw RGBA pixels of the image
  final Uint8List pixels;

  @override
  String toString() => 'Image ${width}x$height ${width * height * 4} bytes';

  /// Decode RGBA raw image to dart:ui Image
  Future<ui.Image> toImage() {
    final comp = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      pixels,
      width,
      height,
      ui.PixelFormat.rgba8888,
      (ui.Image image) => comp.complete(image),
    );
    return comp.future;
  }

  /// Convert to a PNG image
  Future<Uint8List> toPng() async {
    final image = await toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

  /// Returns the image as an [Image] object from the pub:image library
  im.Image asImage() {
    return im.Image.fromBytes(width, height, pixels);
  }
}

/// Image provider for a [PdfRaster]
class PdfRasterImage extends ImageProvider<PdfRaster> {
  /// Create an ImageProvider from a [PdfRaster]
  PdfRasterImage(this.raster);

  /// The image source
  final PdfRaster raster;

  Future<ImageInfo> _loadAsync() async {
    final uiImage = await raster.toImage();
    return ImageInfo(image: uiImage, scale: 1);
  }

  @override
  ImageStreamCompleter load(PdfRaster key, DecoderCallback decode) {
    return OneFrameImageStreamCompleter(_loadAsync());
  }

  @override
  Future<PdfRaster> obtainKey(ImageConfiguration configuration) async {
    return raster;
  }
}