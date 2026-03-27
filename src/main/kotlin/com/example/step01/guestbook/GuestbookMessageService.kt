package com.example.step01.guestbook

import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.time.Instant

@Service
class GuestbookMessageService(
    private val guestbookMessageRepository: GuestbookMessageRepository,
) {
    @Transactional
    fun create(request: CreateGuestbookMessageRequest): GuestbookMessage =
        guestbookMessageRepository.save(
            author = request.author.trim(),
            message = request.message.trim(),
            createdAt = Instant.now(),
        )

    @Transactional(readOnly = true)
    fun list(): List<GuestbookMessage> = guestbookMessageRepository.findAllNewestFirst()
}
