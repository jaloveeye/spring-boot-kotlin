package com.example.step01.guestbook

import org.springframework.jdbc.core.namedparam.MapSqlParameterSource
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate
import org.springframework.jdbc.support.GeneratedKeyHolder
import org.springframework.stereotype.Repository
import java.sql.Timestamp
import java.time.Instant

@Repository
class GuestbookMessageRepository(
    private val jdbcTemplate: NamedParameterJdbcTemplate,
) {
    fun save(author: String, message: String, createdAt: Instant): GuestbookMessage {
        val parameters = MapSqlParameterSource()
            .addValue("author", author)
            .addValue("message", message)
            .addValue("createdAt", Timestamp.from(createdAt))
        val keyHolder = GeneratedKeyHolder()

        jdbcTemplate.update(
            """
            insert into guestbook_message (author, message, created_at)
            values (:author, :message, :createdAt)
            """.trimIndent(),
            parameters,
            keyHolder,
            arrayOf("id"),
        )

        val id = keyHolder.key?.toLong()
            ?: error("Failed to capture generated guestbook_message id")

        return GuestbookMessage(
            id = id,
            author = author,
            message = message,
            createdAt = createdAt,
        )
    }

    fun findAllNewestFirst(): List<GuestbookMessage> =
        jdbcTemplate.query(
            """
            select id, author, message, created_at
            from guestbook_message
            order by created_at desc, id desc
            """.trimIndent(),
            emptyMap<String, Any>(),
        ) { rs, _ ->
            GuestbookMessage(
                id = rs.getLong("id"),
                author = rs.getString("author"),
                message = rs.getString("message"),
                createdAt = rs.getTimestamp("created_at").toInstant(),
            )
        }
}
