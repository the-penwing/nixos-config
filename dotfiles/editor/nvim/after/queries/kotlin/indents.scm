; Inheritance / Blocks
[
  (class_body)
  (function_body)
  (statements)
  (enum_class_body)
  (control_structure_body)
] @indent.begin

; Lists / Containers
[
  (value_arguments)
  (function_value_parameters)
  (type_arguments)
  (type_parameters)
  (lambda_literal)
] @indent.begin

; Closing delimiters
[
  "}"
  ")"
  ">"
] @indent.end

; Multi-line expressions/strings
(string_literal) @indent.align

