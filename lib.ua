┌─╴Quote
  # quote structure
  ~ {
    Text
    Author
  }
└─╴

┌─╴Format
  # trims left side of a string
  # string ? trimmed
  TrimL ↚ ⍢(↘1|+⊃(=@\s)(=@\n)⊢)
  # trims both sides of a string
  # string ? trimmed
  Trim ← TrimL ⍜⇌TrimL

  # joins wrapped box array of string
  # boxes ? string
  Join ↚ /(
    =@\n◇⊸⊣
    ⨬($"_ _")($"__") # we don't need any spaces after newlines
  )

  # wraps (fills) a string into 60 characters width
  # string ? wrapped
  Wrap ↚ (
    :0 °/$"_ _"

    # Experimental!
    Join ◌∧(
      ⊸>₄₅ +⤚◇⧻
      ⨬(⊙∘)(⊙(□$"_\n") ×₀)
    )
  )

  # formats and prints quote text
  # quote ?
  Text ← |1.0 (
    Quote~Text
    ◇(Trim Wrap)
    $"\"\x1B[94m\x1B[1m_\x1B[0m\""
    &p
  )

  # formats and prints quote author if it exists
  # quote ?
  Author ← |1.0 (
    Quote~Author
    ⨬()(&p $"\x1B[93m_\x1B[0m") >₀⊸⧻
  )
└─╴

┌─╴HTTP
  # forms a GET request
  # host request ? uri
  Req ↚ |1.2 (
    ⊙.⍜(°/$"_/_")(⊃(↘₁|⊢))
  
    $$ GET /_ HTTP/1.0
    $$ Host: _
    $$ Connection: close
    $$ 
    $$ 
  )

  # performs a GET request
  # response ? uri
  Get ← |1 (
    ⊙$"_:80" Req
    ⍜(&tcpc :|&rs∞⊸&w:)
  )

  # splits response by `\r\n`
  # string ? boxes
  Split ↚ |1 °/$"_\r\n_"

  # retrievs body from response and deserializes it
  # string ? quote
  Body ← |1 (
    ⊸⊢Split
    ⤚≠₂₀₀⋕ ⊢↻₁ ◇°/$"_ _"
  
    ⨬(
      ⊸(=@)⊣)◇Format~Trim ⊣⊙◌
      ⨬(⊙"")(
        regex "\s*(.+)\s+\\(\s*(.+)?\\)"
        ◇∩Format~Trim ⊃(⊡0_1|⊡0_2)
      )
    )(
      ⍤:⊙$"HTTP _"
    )
  
    Quote
  )
└─╴
