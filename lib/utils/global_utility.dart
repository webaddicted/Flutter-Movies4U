import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

int randomNumber() {
  Random random = new Random();
  return random.nextInt(1000);
}

String formatTime(double time) {
  Duration duration = Duration(milliseconds: time.round());
  return [duration.inHours, duration.inMinutes, duration.inSeconds]
      .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
      .join(':');
}

String filesize(dynamic size, [int round = 2]) {
  int divider = 1024;
  int _size;
  try {
    _size = int.parse(size.toString());
  } catch (e) {
    throw ArgumentError("Can not parse the size parameter: $e");
  }

  if (_size < divider) {
    return "$_size B";
  }

  if (_size < divider * divider && _size % divider == 0) {
    return "${(_size / divider).toStringAsFixed(0)} KB";
  }

  if (_size < divider * divider) {
    return "${(_size / divider).toStringAsFixed(round)} KB";
  }

  if (_size < divider * divider * divider && _size % divider == 0) {
    return "${(_size / (divider * divider)).toStringAsFixed(0)} MB";
  }

  if (_size < divider * divider * divider) {
    return "${(_size / divider / divider).toStringAsFixed(round)} MB";
  }

  if (_size < divider * divider * divider * divider && _size % divider == 0) {
    return "${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB";
  }

  if (_size < divider * divider * divider * divider) {
    return "${(_size / divider / divider / divider).toStringAsFixed(round)} GB";
  }

  if (_size < divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider;
    return "${r.toStringAsFixed(0)} TB";
  }

  if (_size < divider * divider * divider * divider * divider) {
    num r = _size / divider / divider / divider / divider;
    return "${r.toStringAsFixed(round)} TB";
  }

  if (_size < divider * divider * divider * divider * divider * divider &&
      _size % divider == 0) {
    num r = _size / divider / divider / divider / divider / divider;
    return "${r.toStringAsFixed(0)} PB";
  } else {
    num r = _size / divider / divider / divider / divider / divider;
    return "${r.toStringAsFixed(round)} PB";
  }
}

List<String> getCategoryMovie() {
  List<String> data = [];
  data.add(
      "https://www.chicagotribune.com/resizer/69RRXBl_mP_9LdXCW_Zmqa_YspQ=/1200x0/top/arc-anglerfish-arc2-prod-tronc.s3.amazonaws.com/public/GFHATTOROZDBNO4X67H7AMNGRQ.jpg"); //Action
  data.add(
      "https://cdn.vox-cdn.com/thumbor/QarJQ8e1fU3YeZVtgzFAd6GvjsI=/0x0:864x1280/1200x800/filters:focal(349x335:487x473)/cdn.vox-cdn.com/uploads/chorus_image/image/66668342/image002_2.0.jpg"); //Advanture
  data.add(
      "https://cnet4.cbsistatic.com/img/DG2zvWnzBgC2SniW2ikN3zoIkxA=/940x0/2019/11/25/48850c74-c475-4b6d-b580-6667b2293954/frozen2header.jpg"); //Animation
  data.add(
      "https://www.todaysparent.com/wp-content/uploads/2018/04/best-animated-movies-for-kids-coco.jpg"); //comedy
  data.add(
      "https://img.starbiz.com/resize/480x-/2020/02/21/vicky-kaushal-bhoot-2-1bc4.jpg"); //crime
  data.add(
      "https://i.ytimg.com/vi/j8QyS9RjJKk/maxresdefault.jpg"); //Documentary
  data.add(
      "https://img.etimg.com/thumb/width-640,height-480,imgsize-186343,resizemode-1,msid-65292511/magazines/panache/mulk-review-the-strong-performance-by-the-actors-manages-to-hold-your-attention/mulk.jpg"); //Drama
  data.add(
      "https://d1dlh1v05qf6d3.cloudfront.net/information/uploads/2019/12/MV5BZTZhZGM5MjEtOThlNS00OGUwLWFmZWYtMjE3MjZjM2VhYjQ1XkEyXkFqcGdeQW1hcmNtYW5u._V1_UX477_CR00477268_AL_.jpg"); //Family
  data.add(
      "https://www.comingsoon.net/assets/uploads/1970/01/file_548344_narniareview.jpg"); //Fantasy
  data.add(
      "https://i.pinimg.com/originals/9c/17/27/9c1727a80cc7ec11a184bc15a9c87e40.jpg"); //History
  data.add("https://i.ytimg.com/vi/aHeOQSB9rfY/maxresdefault.jpg"); //Horror
  data.add(
      "https://www.sbs.com.au/movies/sites/sbs.com.au.film/files/styles/full/public/walk_the_line_704_4.jpg"); //Music
  data.add(
      "https://www.listchallenges.com/f/lists/54e4daf9-6ea2-4c5d-ae86-577657560045.jpg"); //Mystery
  data.add(
      "https://media.glamour.com/photos/5ec2e91dccfbc8c1a8fe8cbf/master/w_400%2Cc_limit/MSDTITA_FE057.jpg"); //Romance

  data.add(
      "https://cdn.pocket-lint.com/r/s/1200x/assets/images/149551-tv-feature-what-is-the-best-order-to-watch-the-x-men-movies-image1-y5wpzep24w.jpg"); //Science Fiction
  data.add("https://i.ytimg.com/vi/0fqVOWWl7Sc/maxresdefault.jpg"); //TV Movie
  data.add("https://i.ytimg.com/vi/5HkA3P9ep_w/maxresdefault.jpg"); //Thriller
  data.add(
      "https://www.screengeek.net/wp-content/uploads/2018/01/12-strong.jpg"); //War
  data.add(
      "https://media.npr.org/assets/img/2016/09/29/94a9df6f8c8ded28e78a87b922f41fa745ab1d0c2fe8d9ae58a6e61d50b2a981_wide-d4d2e41a32c7cfabf7cdb8e91d55d6b15b72575f.jpg?s=1400"); //Western
  data.add(
      "https://occ-0-988-993.1.nflxso.net/dnm/api/v6/0DW6CdE4gYtYx8iy3aj8gs9WtXE/AAAABdYRto3hdSUoIy1ZDbNTNxIoyno1X35Hu2mpzcyCO9LceOO55Y2jcOZb8Ev0mGZyPZhynDm8HHFWMVnvEIwU7N3QfJZ1t7symGaoT9kusfyYmdQaBirsI8t2i4Pj.jpg"); //Science Fiction
  data.add(
      "https://www.superherohype.com/assets/uploads/2019/12/Edge-of-Tomorrow-1280x720.jpg");
  data.add(
      "https://mail.scified.com/articles/march-round-up-six-the-best-sci-fi-movies-netflix-right-now-35.jpg");
  data.add(
      "https://i2.wp.com/cms.sofrep.com/wp-content/uploads/2018/07/ejdainlg3sl2gxdjjfkg.jpg");
  data.add(
      "https://www.telegraph.co.uk/content/dam/films/2017/04/02/TELEMMGLPICT000122907523_trans%2B%2BdVmBEqXtLBaos6dNcYc1NxP1m7Fa_qYfiJXDCd_a37c.jpeg");
  data.add(
      "https://free4kwallpapers.com/uploads/originals/2015/11/17/bad-blue-megamind-wallpaper.jpg");
  data.add(
      "https://i.pinimg.com/originals/21/7c/0a/217c0a19c28b8e0c53239cbc7a9c8b25.jpg");
  return data;
}
void printWarning(String text) {
  print('\x1B[33m$text\x1B[0m');
}

void printError(String text) {
  print('\x1B[31m$text\x1B[0m');
}
