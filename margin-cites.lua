function Cite(cite)
    local citation = cite.citations[1]
    
    -- Deconstruct the citation object
    local key = citation.id
    local mode = citation.mode or "NormalCitation"
    local prefix = citation.prefix and pandoc.utils.stringify(citation.prefix) or "none"
    local suffix = citation.suffix and pandoc.utils.stringify(citation.suffix) or "none"
    local locator = citation.locator or "none"
    local label = citation.label or "none"

    -- Create a Typst function call with deconstructed parts
    local typst_call = string.format(
        '#margincite(<%s>, "%s", "%s", "%s", %s, %s)',
        key, mode, prefix, suffix, locator, label
    )

    return pandoc.Inlines({
        cite,
        pandoc.RawInline('typst', typst_call)
    })
end

