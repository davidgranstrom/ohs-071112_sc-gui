/*
    Layout Management in SuperCollider
    
        * GridLayout  - A layout that organizes views in a grid
        * StackLayout - A layout that stacks views on top of each other
        * HLayout     - A layout that distributes views in a horizontal line
        * VLayout     - A layout that distributes views in a vertical line

    Layouts are installed on a View and will distribute the space of that
    View for the the items in the Layout. A basic unit on which a layout
    operates is therefore abstractly called an item and can be a view or
    another layout.
*/


// HLayout basic usage
w = Window();
w.layout_(HLayout(Slider(), TextView(), Slider()));
w.front;

// HLayout using a stretch factor
(
    w = Window().layout_(
        HLayout(
            [ Slider(), stretch:1 ],
            [ TextView()          ],
            [ Slider(), stretch:1 ],
        )
    ).front;
)

// HLayout with a nested VLayout 
(
    w = Window().layout_(
        HLayout(
            TextView(),
            VLayout(
                Button().states_([[ 1 ]]),
                Button().states_([[ 2 ]]),
                Button().states_([[ 3 ]]),
                Button().states_([[ 4 ]]),
            ),
        )
    ).front;
)

// HLayout with a nested VLayout using alignment
// (see the bottom of this file for possible alignments)
(
    w = Window().layout_(
        HLayout(
            VLayout(
                [ Button(), align:\top    ],
                [ Button(), align:\bottom ],
            ),
            Slider2D(),
            VLayout(
                [ Button(), align:\top    ],
                [ Button() ],
                [ Button() ],
                [ Button(), align:\bottom ],
            )
        )
    // using a size constraint on the top view
    ).view.fixedSize_(Size(500,300)).front;
)

// GridLayout
(
    var grid = GridLayout(),
    w        = Window().layout_(grid),
    view     = View().background_(Color.rand),
    num      = 6;

    // add buttons to the GridLayout
    // args: item, row, column, align
    num.do{|i| grid.add(Button().states_([[ i ]]), 0, i) };

    // add a View which vertically span all buttons
    // args: item, row, column, rowSpan: 1, columnSpan: 1, align
    grid.addSpanning(view, 1, 0, 1, num); 
    w.front;
)

// GridLayout can be used for finer tuning
(
    var grid = GridLayout(),
    w        = Window().layout_(grid),
    num      = 30, 
    spacing  = 1,
    rowBreak = 10;

    // add a custom spacing
    grid.hSpacing_(spacing);
    grid.vSpacing_(spacing);

    num.do{|i| 
        grid.add(
            View().background_(Color.rand(0.3,0.6)).layout_(HLayout(Knob())),
            i div: rowBreak, 
            i % rowBreak
        ) 
    };
    // using minSizeHint to resize the window to fit the items of the view
    w.view.resizeTo(w.view.minSizeHint.width, w.view.minSizeHint.height);
    w.front;
)

/* 
    Possible alignments for layouts

    \left
    \center
    \right
    \topLeft
    \top
    \topRight
    \bottomLeft
    \bottom
    \bottomRight
*/
