# angularTree

angularTree is a HTML5 drag and drop tree powered by Angular. Unlike other implementations of HTML tree widgets, angularTree allows you to bring your own markup (BYOM 😄).

## Features

angularTree includes (but is not limited to) following features:

* Bring your own Markup
* AngularJS powered
* Besides Angular (uh oh) no other dependencies, not even jQuery!
* Support for modern browsers (IE8+)
* Written in CoffeeScript
* A test suite

## Installation

```sh
bower install angularTree
```

To use the master version, check out the source and then run
```sh
npm install
```

## Usage

Add angularTree to the list of dependencies.

```js
angular.module('YourApp', ['angularTree'])
```

In your HTML you can now use the directive `angular-tree` to define the tree widget, and the `draggable` directive for defining the draggable elements (Note that the value of the directive must equal `"true"` otherwise browser support is not guaranteed).

```html
  <ul angular-tree>
    <li draggable="true">Alice</li>
    <li draggable="true">Bob</li>
    <li draggable="true">Charlie</li>
  </ul>

  <script src="angular.js"></script>
  <script src="angularTree.js"></script>
```

## License (the MIT license)

Copyright (C) 2013-2014 Mario Uher

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
