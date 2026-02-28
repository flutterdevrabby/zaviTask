# Flutter Product Sliver


## 1. How Horizontal Swipe Was Implemented

Used TabBarView which is built on Flutter's PageView internally.
It handles horizontal swipes automatically. 

## 2. Who Owns the Vertical Scroll and Why

NestedScrollView is the single owner of the vertical scroll axis.
It controls both header and tab content scrolling to ensure smooth collapse and independent tab scroll.


## 3. Trade-offs and Limitations

- Slightly more complex than a simple scroll view.
- Large lists may need lazy loading or pagination.
- Horizontal and vertical gestures rely on Flutter’s default gesture system, so custom gestures could conflict.
