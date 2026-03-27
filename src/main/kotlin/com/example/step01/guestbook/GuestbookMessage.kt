package com.example.step01.guestbook

import java.time.Instant

data class GuestbookMessage(
    val id: Long,
    val author: String,
    val message: String,
    val createdAt: Instant,
)
