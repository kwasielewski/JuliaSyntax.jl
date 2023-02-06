using JuliaSyntax

# Parser fuzz testing tools.

const all_tokens = [
    "#x\n"
    "#==#"
    " "
    "\t"
    "\n"
    "x"
    "@"
    ","
    ";"

    "baremodule"
    "begin"
    "break"
    "const"
    "continue"
    "do"
    "export"
    "for"
    "function"
    "global"
    "if"
    "import"
    "let"
    "local"
    "macro"
    "module"
    "quote"
    "return"
    "struct"
    "try"
    "using"
    "while"
    "catch"
    "finally"
    "else"
    "elseif"
    "end"
    "abstract"
    "as"
    "doc"
    "mutable"
    "outer"
    "primitive"
    "type"
    "var"

    "1"
    "0b1"
    "0x1"
    "0o1"
    "1.0"
    "1.0f0"
    "\"s\""
    "'c'"
    "`s`"
    "true"
    "false"

    "["
    "]"
    "{"
    "}"
    "("
    ")"
    "\""
    "\"\"\""
    "`"
    "```"

    "="
    "+="
    "-="   # Also used for "−="
    "−="
    "*="
    "/="
    "//="
    "|="
    "^="
    "÷="
    "%="
    "<<="
    ">>="
    ">>>="
    "\\="
    "&="
    ":="
    "~"
    "\$="
    "⊻="
    "≔"
    "⩴"
    "≕"

    "=>"

    "?"

    "-->"
    "<--"
    "<-->"
    "←"
    "→"
    "↔"
    "↚"
    "↛"
    "↞"
    "↠"
    "↢"
    "↣"
    "↤"
    "↦"
    "↮"
    "⇎"
    "⇍"
    "⇏"
    "⇐"
    "⇒"
    "⇔"
    "⇴"
    "⇶"
    "⇷"
    "⇸"
    "⇹"
    "⇺"
    "⇻"
    "⇼"
    "⇽"
    "⇾"
    "⇿"
    "⟵"
    "⟶"
    "⟷"
    "⟹"
    "⟺"
    "⟻"
    "⟼"
    "⟽"
    "⟾"
    "⟿"
    "⤀"
    "⤁"
    "⤂"
    "⤃"
    "⤄"
    "⤅"
    "⤆"
    "⤇"
    "⤌"
    "⤍"
    "⤎"
    "⤏"
    "⤐"
    "⤑"
    "⤔"
    "⤕"
    "⤖"
    "⤗"
    "⤘"
    "⤝"
    "⤞"
    "⤟"
    "⤠"
    "⥄"
    "⥅"
    "⥆"
    "⥇"
    "⥈"
    "⥊"
    "⥋"
    "⥎"
    "⥐"
    "⥒"
    "⥓"
    "⥖"
    "⥗"
    "⥚"
    "⥛"
    "⥞"
    "⥟"
    "⥢"
    "⥤"
    "⥦"
    "⥧"
    "⥨"
    "⥩"
    "⥪"
    "⥫"
    "⥬"
    "⥭"
    "⥰"
    "⧴"
    "⬱"
    "⬰"
    "⬲"
    "⬳"
    "⬴"
    "⬵"
    "⬶"
    "⬷"
    "⬸"
    "⬹"
    "⬺"
    "⬻"
    "⬼"
    "⬽"
    "⬾"
    "⬿"
    "⭀"
    "⭁"
    "⭂"
    "⭃"
    "⭄"
    "⭇"
    "⭈"
    "⭉"
    "⭊"
    "⭋"
    "⭌"
    "￩"
    "￫"
    "⇜"
    "⇝"
    "↜"
    "↝"
    "↩"
    "↪"
    "↫"
    "↬"
    "↼"
    "↽"
    "⇀"
    "⇁"
    "⇄"
    "⇆"
    "⇇"
    "⇉"
    "⇋"
    "⇌"
    "⇚"
    "⇛"
    "⇠"
    "⇢"
    "↷"
    "↶"
    "↺"
    "↻"

    "||"

    "&&"

    "<:"
    ">:"
    ">"
    "<"
    ">="
    "≥"
    "<="
    "≤"
    "=="
    "==="
    "≡"
    "!="
    "≠"
    "!=="
    "≢"
    "∈"
    "in"
    "isa"
    "∉"
    "∋"
    "∌"
    "⊆"
    "⊈"
    "⊂"
    "⊄"
    "⊊"
    "∝"
    "∊"
    "∍"
    "∥"
    "∦"
    "∷"
    "∺"
    "∻"
    "∽"
    "∾"
    "≁"
    "≃"
    "≂"
    "≄"
    "≅"
    "≆"
    "≇"
    "≈"
    "≉"
    "≊"
    "≋"
    "≌"
    "≍"
    "≎"
    "≐"
    "≑"
    "≒"
    "≓"
    "≖"
    "≗"
    "≘"
    "≙"
    "≚"
    "≛"
    "≜"
    "≝"
    "≞"
    "≟"
    "≣"
    "≦"
    "≧"
    "≨"
    "≩"
    "≪"
    "≫"
    "≬"
    "≭"
    "≮"
    "≯"
    "≰"
    "≱"
    "≲"
    "≳"
    "≴"
    "≵"
    "≶"
    "≷"
    "≸"
    "≹"
    "≺"
    "≻"
    "≼"
    "≽"
    "≾"
    "≿"
    "⊀"
    "⊁"
    "⊃"
    "⊅"
    "⊇"
    "⊉"
    "⊋"
    "⊏"
    "⊐"
    "⊑"
    "⊒"
    "⊜"
    "⊩"
    "⊬"
    "⊮"
    "⊰"
    "⊱"
    "⊲"
    "⊳"
    "⊴"
    "⊵"
    "⊶"
    "⊷"
    "⋍"
    "⋐"
    "⋑"
    "⋕"
    "⋖"
    "⋗"
    "⋘"
    "⋙"
    "⋚"
    "⋛"
    "⋜"
    "⋝"
    "⋞"
    "⋟"
    "⋠"
    "⋡"
    "⋢"
    "⋣"
    "⋤"
    "⋥"
    "⋦"
    "⋧"
    "⋨"
    "⋩"
    "⋪"
    "⋫"
    "⋬"
    "⋭"
    "⋲"
    "⋳"
    "⋴"
    "⋵"
    "⋶"
    "⋷"
    "⋸"
    "⋹"
    "⋺"
    "⋻"
    "⋼"
    "⋽"
    "⋾"
    "⋿"
    "⟈"
    "⟉"
    "⟒"
    "⦷"
    "⧀"
    "⧁"
    "⧡"
    "⧣"
    "⧤"
    "⧥"
    "⩦"
    "⩧"
    "⩪"
    "⩫"
    "⩬"
    "⩭"
    "⩮"
    "⩯"
    "⩰"
    "⩱"
    "⩲"
    "⩳"
    "⩵"
    "⩶"
    "⩷"
    "⩸"
    "⩹"
    "⩺"
    "⩻"
    "⩼"
    "⩽"
    "⩾"
    "⩿"
    "⪀"
    "⪁"
    "⪂"
    "⪃"
    "⪄"
    "⪅"
    "⪆"
    "⪇"
    "⪈"
    "⪉"
    "⪊"
    "⪋"
    "⪌"
    "⪍"
    "⪎"
    "⪏"
    "⪐"
    "⪑"
    "⪒"
    "⪓"
    "⪔"
    "⪕"
    "⪖"
    "⪗"
    "⪘"
    "⪙"
    "⪚"
    "⪛"
    "⪜"
    "⪝"
    "⪞"
    "⪟"
    "⪠"
    "⪡"
    "⪢"
    "⪣"
    "⪤"
    "⪥"
    "⪦"
    "⪧"
    "⪨"
    "⪩"
    "⪪"
    "⪫"
    "⪬"
    "⪭"
    "⪮"
    "⪯"
    "⪰"
    "⪱"
    "⪲"
    "⪳"
    "⪴"
    "⪵"
    "⪶"
    "⪷"
    "⪸"
    "⪹"
    "⪺"
    "⪻"
    "⪼"
    "⪽"
    "⪾"
    "⪿"
    "⫀"
    "⫁"
    "⫂"
    "⫃"
    "⫄"
    "⫅"
    "⫆"
    "⫇"
    "⫈"
    "⫉"
    "⫊"
    "⫋"
    "⫌"
    "⫍"
    "⫎"
    "⫏"
    "⫐"
    "⫑"
    "⫒"
    "⫓"
    "⫔"
    "⫕"
    "⫖"
    "⫗"
    "⫘"
    "⫙"
    "⫷"
    "⫸"
    "⫹"
    "⫺"
    "⊢"
    "⊣"
    "⟂"
    "⫪"
    "⫫"

    "<|"
    "|>"

    ":"
    ".."
    "…"
    "⁝"
    "⋮"
    "⋱"
    "⋰"
    "⋯"

    "\$"
    "+"
    "-" # also used for "−"
    "−"
    "++"
    "⊕"
    "⊖"
    "⊞"
    "⊟"
    "|"
    "∪"
    "∨"
    "⊔"
    "±"
    "∓"
    "∔"
    "∸"
    "≏"
    "⊎"
    "⊻"
    "⊽"
    "⋎"
    "⋓"
    "⧺"
    "⧻"
    "⨈"
    "⨢"
    "⨣"
    "⨤"
    "⨥"
    "⨦"
    "⨧"
    "⨨"
    "⨩"
    "⨪"
    "⨫"
    "⨬"
    "⨭"
    "⨮"
    "⨹"
    "⨺"
    "⩁"
    "⩂"
    "⩅"
    "⩊"
    "⩌"
    "⩏"
    "⩐"
    "⩒"
    "⩔"
    "⩖"
    "⩗"
    "⩛"
    "⩝"
    "⩡"
    "⩢"
    "⩣"
    "¦"

    "*"
    "/"
    "÷"
    "%"
    "⋅" # also used for lookalikes "·" and "·"
    "·"
    "·"
    "∘"
    "×"
    "\\"
    "&"
    "∩"
    "∧"
    "⊗"
    "⊘"
    "⊙"
    "⊚"
    "⊛"
    "⊠"
    "⊡"
    "⊓"
    "∗"
    "∙"
    "∤"
    "⅋"
    "≀"
    "⊼"
    "⋄"
    "⋆"
    "⋇"
    "⋉"
    "⋊"
    "⋋"
    "⋌"
    "⋏"
    "⋒"
    "⟑"
    "⦸"
    "⦼"
    "⦾"
    "⦿"
    "⧶"
    "⧷"
    "⨇"
    "⨰"
    "⨱"
    "⨲"
    "⨳"
    "⨴"
    "⨵"
    "⨶"
    "⨷"
    "⨸"
    "⨻"
    "⨼"
    "⨽"
    "⩀"
    "⩃"
    "⩄"
    "⩋"
    "⩍"
    "⩎"
    "⩑"
    "⩓"
    "⩕"
    "⩘"
    "⩚"
    "⩜"
    "⩞"
    "⩟"
    "⩠"
    "⫛"
    "⊍"
    "▷"
    "⨝"
    "⟕"
    "⟖"
    "⟗"
    "⌿"
    "⨟"

    "//"

    "<<"
    ">>"
    ">>>"

    "^"
    "↑"
    "↓"
    "⇵"
    "⟰"
    "⟱"
    "⤈"
    "⤉"
    "⤊"
    "⤋"
    "⤒"
    "⤓"
    "⥉"
    "⥌"
    "⥍"
    "⥏"
    "⥑"
    "⥔"
    "⥕"
    "⥘"
    "⥙"
    "⥜"
    "⥝"
    "⥠"
    "⥡"
    "⥣"
    "⥥"
    "⥮"
    "⥯"
    "￪"
    "￬"

    "::"

    "where"

    "."

    "!"
    "'"
    ".'"
    "->"

    "¬"
    "√"
    "∛"
    "∜"
]

const cutdown_tokens = [
    "#x\n"
    "#==#"
    " "
    "\t"
    "\n"
    "x"
    "@"
    ","
    ";"

    "baremodule"
    "begin"
    "break"
    "const"
    "continue"
    "do"
    "export"
    "for"
    "function"
    "global"
    "if"
    "import"
    "let"
    "local"
    "macro"
    "module"
    "quote"
    "return"
    "struct"
    "try"
    "using"
    "while"
    "catch"
    "finally"
    "else"
    "elseif"
    "end"
    "abstract"
    "as"
    "doc"
    "mutable"
    "outer"
    "primitive"
    "type"
    "var"

    "1"
    "0b1"
    "0x1"
    "0o1"
    "1.0"
    "1.0f0"
    "\"s\""
    "'c'"
    "`s`"
    "true"
    "false"

    "["
    "]"
    "{"
    "}"
    "("
    ")"
    "\""
    "\"\"\""
    "`"
    "```"

    "="
    "+="
    "~"

    "=>"

    "?"

    "-->"

    "||"

    "&&"

    "<:"
    ">:"
    ">"
    "<"
    ">="
    "<="
    "=="
    "==="
    "!="

    "<|"
    "|>"

    ":"
    ".."
    "…"

    "\$"
    "+"
    "−"
    "-"
    "|"

    "*"
    "/"
    "⋅" # also used for lookalikes "·" and "·"
    "·"
    "\\"

    "//"

    "<<"

    "^"

    "::"

    "where"

    "."

    "!"
    "'"
    "->"

    "√"
]

#-------------------------------------------------------------------------------

# Rough tokenization interface.
# TODO: We should have something like this in parser_api.jl

struct Token2
    head::JuliaSyntax.SyntaxHead
    range::UnitRange{UInt32}
end

function tokenize(text::String)
    ps = JuliaSyntax.ParseStream(text)
    JuliaSyntax.parse!(ps, rule=:toplevel)
    ts = ps.tokens
    output_tokens = Token2[]
    for i = 2:length(ts)
        if JuliaSyntax.kind(ts[i]) == JuliaSyntax.K"TOMBSTONE"
            continue
        end
        r = ts[i-1].next_byte:thisind(text, ts[i].next_byte-1)
        push!(output_tokens, Token2(JuliaSyntax.head(ts[i]), r))
    end
    output_tokens
end

function split_tokens(text::String)
    [@view text[t.range] for t in tokenize(text)]
end


#-------------------------------------------------------------------------------

function parser_throws_exception(str)
    try
        JuliaSyntax.parseall(JuliaSyntax.SyntaxNode, str, ignore_errors=true)
        false
    catch
        true
    end
end

"""
Reduce test case via combination of bisection and random deletion.

This is suited to randomly generated strings, but it's surprisingly effective
for code-like strings as well.
"""
function rand_reduce(str)
    while true
        if length(str) <= 1
            return str
        end
        m1 = thisind(str, length(str)÷2)
        m2 = nextind(str, m1)
        if parser_throws_exception(str[1:m1])
            str = str[1:m1]
        elseif parser_throws_exception(str[m2:end])
            str = str[m2:end]
        else
            chunklen = clamp(length(str)÷10, 1, 10)
            reduced = false
            for i = 1:100
                m = thisind(str, rand(1:length(str)-chunklen))
                s = str[1:m]*str[nextind(str, m+chunklen):end]
                if parser_throws_exception(s)
                    str = s
                    reduced = true
                    break
                end
            end
            if !reduced
                return str
            end
        end
    end
end

# The parser should never throw an exception. To test whether this is true,
# try passing randomly generated bad input data into it.
function _fuzz_test(bad_input_iter)
    error_strings = []
    for str in bad_input_iter
        try
            JuliaSyntax.parseall(JuliaSyntax.SyntaxNode, str, ignore_errors=true);
        catch exc
            !(exc isa InterruptException) || rethrow()
            rstr = rand_reduce(str)
            @error "Parser threw exception" rstr exception=current_exceptions()
            push!(error_strings, rstr)
        end
    end
    return error_strings
end

"""
Fuzz test parser against all tuples of length `N` with elements taken from
`tokens`.
"""
function fuzz_tokens(tokens, N)
    iter = (join(ts) for ts in Iterators.product([tokens for _ in 1:N]...))
    _fuzz_test(iter)
end

"""Delete `nlines` adjacent lines from code, at `niters` randomly chosen positions"""
function delete_lines(lines, nlines, niters)
    selection = trues(length(lines))
    for j=1:niters
        i = rand(1:length(lines)-nlines)
        selection[i:i+nlines] .= false
    end
    join(lines[selection], '\n')
end

"""Delete `ntokens` adjacent tokens from code, at `niters` randomly chosen positions"""
function delete_tokens(code, tokens, ntokens, niters)
    # [ aa bbbb cc d eeeeee  ]
    #   |  |    |  | |     |
    selection = trues(length(tokens))
    for j=1:niters
        i = rand(1:length(tokens)-ntokens)
        selection[i:i+ntokens] .= false
    end
    io = IOBuffer()
    i = 1
    while true
        while i <= length(selection) && !selection[i]
            i += 1
        end
        if i > length(selection)
            break
        end
        first_ind = first(tokens[i].range)
        while selection[i] && i < length(selection)
            i += 1
        end
        last_ind = last(tokens[i].range)
        write(io, @view code[first_ind:last_ind])
        if i == length(selection)
            break
        end
    end
    return String(take!(io))
end

#-------------------------------------------------------------------------------
# Fuzzer functions

"""
Fuzz test parser against randomly generated binary strings
"""
function fuzz_binary(nbytes, N)
    bad_strs = _fuzz_test(String(rand(UInt8, nbytes)) for _ in 1:N)
    rand_reduce.(bad_strs)
end

"""
Fuzz test by deleting random lines of some given source `code`
"""
function fuzz_lines(code, N; nlines=10, niters=10)
    lines = split(code, '\n')
    _fuzz_test(delete_lines(lines, nlines, niters) for _=1:N)
end

"""
Fuzz test by deleting random tokens from given source `code`
"""
function fuzz_tokens(code, N; ntokens=10, niters=10)
    ts = tokenize(code)
    _fuzz_test(delete_tokens(code, ts, ntokens, niters) for _=1:N)
end

