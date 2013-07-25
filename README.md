# R2D: 2D Graphics for Ruby

R2Dはを描画(2次元)、アニメーション、オーディオの再生・録音などを行うRubyのライブラリです。

# プロジェクトへのフィードバック

本ライブラリはまだまだできたての開発版です。このため、プロジェクトのゴール、実装、APIが定まっていません。GitHubのpullリクエスト(本ライブラリの修正点)を送る前に [私に連絡する](https://twitter.com/blacktm) か、GitHubのissue(問題の報告)をしてください。

[本ライブラリのロードマップを確認する。](https://github.com/blacktm/r2d/wiki/Roadmap)

# インストール方法

v0.1.0がリリースされるまでは本ライブラリはソースコードからインストールする必要があります。本ライブラリをビルド・インストールするには、Gitコマンドを使ってソースコードをcloneしたディレクトリしたディレクトリで次のコマンドを実行します(ruby 2.0.0-p0以降が必要です):

```
$ gem build r2d.gemspec
$ gem install --local r2d-0.0.0.gem
```

# 最初のR2Dアプリケーション

```ruby
require 'r2d'

window width: 640, height: 480
r = Rectangle.new(0, 0, 100, 100, "blue")
window :show
```

このプログラムは、以下のことを行います。
* 背景が黒で640x480のウインドウを表示する。
* 青で塗りつぶした(0,0)-(100,100)の矩形を描画する。

下記のリファレンスで、R2Dができることの全てを説明しています。また、ソースコードの [examples](/examples) ディレクトリにサンプルアプリケーションがあります。

<!-- TODO: Add note about what `method/=` means -->

# 基本的な描画処理

## 共通の引数

```
x = X(横)軸 (Integer)
y = Y(縦)軸 (Integer)
s = サイズ  (Integer)
w = 幅 (Integer)
h = 高さ (Integer)

c = 色 (String)
または、
c = [r, g, b, a] (Array)
  r, g, b, aの各値は0..255 (Integer) または 0.0..1.0 (Float)
    r = 赤
    g = 緑
    b = 青
    a = 透明度
```

## Common Instance Methods

All objects that can be drawn have the methods:

```
add, remove, show, hide
```

`add` and `show`, along with `remove` and `hide` are aliased.

## Shapes

### Squares

Parameters:

```
x, y, size, color="white", visible=true
```

Instance methods:

```
x/=, y/=, size=, color=
```

Examples:

```ruby
s = Square.new(x, y, size)
s = Square.new(x, y, size, color, false)

s.x = 10
s.y = 20
s.size = 25
s.color = "red"
s.color = [250, 0, 0, 100]
```

### Rectangles

Parameters:

```
x, y, width, height, color="white", visible=true
```

Instance methods:

```
x/=, y/=, width/=, height/=, color=
```

Examples:

```ruby
r = Rectangle.new(x, y, width, height)
r = Rectangle.new(x, y, width, height, color, false)

r.x = 10
r.y = 20
r.width = 200
r.height = 50
r.color = "blue"
r.color = [0, 0, 255, 150]
```

### Quadrilaterals

Parameters:

```
x1, y1, x2, y2, x3, y3, x4, y4, color="white", visible=true
```

Instance methods:

```
x1/=, y1/=, x2/=, y2/=, x3/=, y3/=, x4/=, y4/=, color=
```

Examples:

```ruby
q = Quad.new(x1, y1, x2, y2, x3, y3, x4, y4)
q = Quad.new(x1, y1, x2, y2, x3, y3, x4, y4, color, false)

q.x1 = 10
q.y1 = 20
q.color = "blue"
q.color = [0, 0, 255, 150]
```

### Triangles

Parameters:

```
x1, y1, x2, y2, x3, y3, color="white", visible=true
```

Instance methods:

```
x1/=, y1/=, x2/=, y2/=, x3/=, y3/=, color=
```

Examples:

```ruby
t = Triangle.new(x1, y1, x2, y2, x3, y3)
t = Triangle.new(x1, y1, x2, y2, x3, y3, color, false)

t.x1 = 10
t.y1 = 20
t.color = "red"
t.color = [0, 0, 255, 1]
```

<!--
### Lines

Parameters:

```
x1, y1, x2, y2, color="white", visible=true
```

Examples:

```ruby
l = Line.new(x1, y1, x2, y2, w)
l = Line.new(x1, y1, x2, y2, w, color, false)

l.x1 = 10
l.y1 = 20

l.color = "red"
l.color = [0, 0, 255, 1]
```
-->

## Gradients

### Parameters

All gradient methods take a Hash where keys refer to the corners of the shape, and values represent the color.

```ruby
{ :corner => color }
```

`:corner` is specific to each shape (described below). `color` is either a string...

```ruby
"red", "blue", "yellow", etc
```
...or an array containing red, green, blue, alpha values from 0 to 255 (`Integer`) or 0.0 to 1.0 (`Float`):

```ruby
[r, g, b, a]

# examples
[255, 0, 0, 255]
[1.0, 1.0, 0.8, 0.5]
```

### Squares and Rectangles

`:corners` can be these groupings:

```ruby
# vertical
:top, :bottom

# horizontal
:left, :right

# all corners
:top_left, :top_right, :bottom_left, :bottom_right
```

Examples:

```ruby
r.gradient = {
  top: "red",
  bottom: "blue"
}

r.gradient({
  left: [255, 200, 150, 50],
  right: "blue"
}

r.gradient = {
  top_left: "red",
  top_right: "blue",
  bottom_left: "green",
  bottom_right: "yellow"
}
```

### Quadrilaterals

```ruby
:first, :second, :third, :fourth
```

Examples:

```ruby
q.gradient = {
  first: "red",
  second: "blue",
  third: [0, 200, 255, 255],
  fourth: "yellow"
}
```

### Triangles

The triangle gradient method takes a Hash containing keys (symbols) referring to the first, second, and third points of the triangle.

`:corners` are:

```ruby
:first, :second, :third
```

Examples:

```ruby
t.gradient = {
  first: "red",
  second: "blue",
  third: [0, 200, 255, 255]
}
```

<!--
### Lines

The line gradient method takes a Hash containing keys (symbols) referring to the start and ends.

`:corners` are:

```ruby
:start, :end
```

Examples:

```ruby
l.gradient = {
  start: "red",
  end: "blue",
}
```
-->

## Images

Formats supported: BMP, PNG, JPG.

Parameters:

```
x, y, "path_to_image", visible=true
```

Instance methods:

```
x, y, width/=, height/=
```

Examples:

```ruby
img = Image.new(x, y, "ruby.png")
img = Image.new(x, y, "media/ruby.png", false)

img.x = 10
img.y = 20
img.width = 125
img.height  # returns height
```

## Text

Parameters:

```
x, y, h, "content", c="white", visible=true
```

Instance methods:

```
x/=, y/=, content=, color=
```

Examples:

```ruby
t = Text.new(x, y, 20, "hello world")
t = Text.new(x, y, 20, "hello world", "blue", false)

t.x = 10
t.y = 20
```

# Playing Audio

Formats include: MP3, AAC, WAV.

## Songs

These are long audio clips.

Parameters:

```
"path_to_song", volume=10
```

Instance methods:

```
play, playing?, pause, paused?, stop, loop
```

Examples:

```ruby
s = Song.new("media/track.mp3")
s = Song.new("media/track.mp3", 5)

s.play
s.playing?  # returns `true`

s.pause
s.paused?   # returns `true`

s.stop
s.loop
```

<!--
## Sounds

Sounds are short audio clips kept in memory.

Parameters:

```
"path_to_sound", volume=10
```

Instance methods:

```
play, playing?, pause, paused?, stop, loop
```

Examples:

```ruby
s = Sound.new("media/snare.mp3")
s = Sound.new("media/snare.mp3", 5)

s.play
s.playing?  # returns `true`

s.pause
s.paused?   # returns `true`

s.stop
s.loop
```
-->

# Capturing Input

## Keyboard and Mouse Buttons

To capture a single key press where `<key_string>` is any valid keyboard character `a..z`, `A..Z`, `0..9`, and string representing arrows, alt, control, shift, etc:

```ruby
on_key <key_string> do
  #...
end
```

Example:

```ruby
on_key 'a' do
  # letter 'a' pressed
end
```

Do something repeatedly as a key is held down.

```ruby
key_down <key_string> do
  #...
end
```

Example:

```ruby
key_down 's' do
  # letter 's' held down
end
```

Valid character strings:

```
('a'..'z') || ('A'..'Z') || ('0'..'9')
'up'
'down'
'left'
'right'
'left_alt'
'right_alt'
'left_control'
'right_control'
'left_shift'
'right_shift'
'backspace'
'delete'
'space'
'tab'
'return'
'mouse_left'
'mouse_right'
```

## Cursor Position

Use these helper methods to get the position of the cursor. Mouse positions are relative to the top left corner of the window.

```ruby
         # Returns the mouse:
mouse_x  #  x-coordinate
mouse_y  #  y-coordinate
```

# The Window

R2D will create and manage a window instance for you. The `window` method is provided to send commands to the window instance.

## Window Attributes

Attributes change the appearance and behavior of the window. These are applied before drawing is done.

```ruby
                     # Defaults:
title: "My App"      #  "R2D"
width: 400           #  640
height: 300          #  480
cursor: false        #  `true`
background: "white"  #  "black"
```

Example:

```ruby
window title: 'My App', width: 300, height: 200, cursor: false
```

## Clearing the Window

To remove all objects from the window, use:

```ruby
window :clear
```

Note this does not delete the objects themselves – the references remain intact. This is equivalent to calling `shape.remove`.

# The Update Loop

Do something each time the graphic environment is updated (60 times / second).

```ruby
update do
  # do something
end
```

Examples:

```ruby
update do
  if key_down? <key_string>
    # do something
  end
end
```
