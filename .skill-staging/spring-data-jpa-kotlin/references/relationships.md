# Relationships

## General guidance

- Prefer `@ManyToOne` over broad bidirectional graphs when possible.
- Add bidirectional mappings only when both sides truly need navigation.
- Keep fetch strategies intentional.

## Common choices

- Use an explicit join entity instead of `@ManyToMany` when the relationship has its own lifecycle or fields.
- Prefer IDs instead of entity references at boundaries where coupling should stay low.

## Safety checks

- Watch for cascade settings that can delete or update more than intended.
- Review equals/hashCode implications carefully when entities are mutable.
