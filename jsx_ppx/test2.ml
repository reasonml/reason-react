external make :
  ?accessible:bool ->
    ?accessibilityHint:string ->
      ?accessibilityLabel:string ->
        ?allowFontScaling:bool ->
          ?ellipsizeMode:(([ `clip  | `head  | `middle  | `tail ])[@bs.string
                                                                    ])
            ->
            ?numberOfLines:int ->
              ?onLayout:(Event.NativeLayoutEvent.t -> unit) ->
                ?onLongPress:(unit -> unit) ->
                  ?onPress:(unit -> unit) ->
                    ?pressRetentionOffset:Types.insets ->
                      ?selectable:bool ->
                        ?style:Style.t ->
                          ?testID:string ->
                            ?selectionColor:string ->
                              ?textBreakStrategy:(([ `simple  | `highQuality 
                                                   | `balanced ])[@bs.string
                                                                   ])
                                ->
                                ?adjustsFontSizeToFit:bool ->
                                  ?minimumFontScale:float ->
                                    ?suppressHighlighting:bool ->
                                      ?value:string ->
                                        ?children:React.element ->
                                          React.element = "Text"[@@bs.module
                                                                    "react-native"][@@react.component
                                                                  ]