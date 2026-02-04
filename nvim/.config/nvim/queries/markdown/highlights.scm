;; extends

; heading markdown markers (#) - all levels
(atx_heading (atx_h1_marker) @markup.heading.marker)
(atx_heading (atx_h2_marker) @markup.heading.marker)
(atx_heading (atx_h3_marker) @markup.heading.marker)
(atx_heading (atx_h4_marker) @markup.heading.marker)
(atx_heading (atx_h5_marker) @markup.heading.marker)

; heading markdown text - all levels
(atx_heading
    (inline) @markup.heading.content
)

; heading markdown text - individual levels
(atx_heading
    (atx_h1_marker)
    (inline) @markup.heading.content.level1
)

(atx_heading
    (atx_h2_marker)
    (inline) @markup.heading.content.level2
)

(atx_heading
    (atx_h3_marker)
    (inline) @markup.heading.content.level3
)

(fenced_code_block) @markup.raw.block
