package com.example.step01.guestbook

import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc
import org.springframework.http.MediaType
import org.springframework.jdbc.core.JdbcTemplate
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status
import java.sql.Timestamp
import java.time.Instant
import kotlin.test.assertEquals

@SpringBootTest
@AutoConfigureMockMvc
class GuestbookMessageApiTest {
    @Autowired
    private lateinit var mockMvc: MockMvc

    @Autowired
    private lateinit var jdbcTemplate: JdbcTemplate

    @BeforeEach
    fun setUp() {
        jdbcTemplate.update("delete from guestbook_message")
    }

    @Test
    fun `creates a guestbook message and stores it`() {
        mockMvc.perform(
            post("/api/guestbook/messages")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                    """
                    {
                      "author": "Jane",
                      "message": "Hello from step01"
                    }
                    """.trimIndent(),
                ),
        )
            .andExpect(status().isCreated)
            .andExpect(jsonPath("$.id").isNumber)
            .andExpect(jsonPath("$.author").value("Jane"))
            .andExpect(jsonPath("$.message").value("Hello from step01"))
            .andExpect(jsonPath("$.createdAt").isString)

        val count = jdbcTemplate.queryForObject("select count(*) from guestbook_message", Int::class.java)
        assertEquals(1, count)
    }

    @Test
    fun `lists guestbook messages newest first`() {
        insertMessage("Older", "First message", Instant.parse("2026-03-27T10:00:00Z"))
        insertMessage("Newer", "Second message", Instant.parse("2026-03-27T11:00:00Z"))

        mockMvc.perform(get("/api/guestbook/messages"))
            .andExpect(status().isOk)
            .andExpect(jsonPath("$[0].author").value("Newer"))
            .andExpect(jsonPath("$[0].message").value("Second message"))
            .andExpect(jsonPath("$[1].author").value("Older"))
            .andExpect(jsonPath("$[1].message").value("First message"))
    }

    @Test
    fun `rejects a blank author`() {
        mockMvc.perform(
            post("/api/guestbook/messages")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                    """
                    {
                      "author": "   ",
                      "message": "Hello from step01"
                    }
                    """.trimIndent(),
                ),
        )
            .andExpect(status().isBadRequest)
    }

    @Test
    fun `rejects a blank message`() {
        mockMvc.perform(
            post("/api/guestbook/messages")
                .contentType(MediaType.APPLICATION_JSON)
                .content(
                    """
                    {
                      "author": "Jane",
                      "message": "   "
                    }
                    """.trimIndent(),
                ),
        )
            .andExpect(status().isBadRequest)
    }

    private fun insertMessage(author: String, message: String, createdAt: Instant) {
        jdbcTemplate.update(
            "insert into guestbook_message (author, message, created_at) values (?, ?, ?)",
            author,
            message,
            Timestamp.from(createdAt),
        )
    }
}
