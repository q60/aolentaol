Lib ~ "lib.ua"
  HTTP   ← Lib~HTTP
  Format ← Lib~Format

"api.forismatic.com/api/1.0/?method=getQuote&format=text&lang=en"

Format~Text . HTTP~Body HTTP~Get
Format~Author
