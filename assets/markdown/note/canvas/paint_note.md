# Paint画笔属性
## style 和  strokeWidth
style有填充 PaintingStyle.fill 和线条 PaintingStyle.stroke。
strokeWidth 可控制绘制线条的宽度。
## strokeCap 
线帽类型.

- StrokeCap.butt 不出头
- StrokeCap.round 圆头
- StrokeCap.square 方头

## strokeJoin
线接类型.线接类型只适用于Path的线段绘制。它不适用于用【Canvas.drawPoints】绘制的线.

- StrokeJoin.bevel - 斜角
- StrokeJoin.miter - 锐角
- StrokeJoin.round - 圆角

## strokeMiterLimit
斜接限制.strokeMiterLimit只适用于【StrokeJoin.miter】.它是一个对斜接的限定，如果超过阈值，会变成【StrokeJoin.bevel】。 
因为考虑到锐角太尖，会影响视觉。

数字越大，允许出现的尖角就可以越尖

- strokeMiterLimit - double
