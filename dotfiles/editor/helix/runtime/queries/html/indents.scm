(element
  (start_tag) @indent
  (_)*
  (end_tag) @outdent)

(element
  (start_tag) @indent
  (end_tag) @outdent)

[
  "}"
  "</"
] @outdent
