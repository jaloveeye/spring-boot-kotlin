package com.example.step01.guestbook

import jakarta.validation.Valid
import jakarta.validation.constraints.NotBlank
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/guestbook/messages")
class GuestbookMessageController(
    private val guestbookMessageService: GuestbookMessageService,
) {
    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    fun create(@Valid @RequestBody request: CreateGuestbookMessageRequest): GuestbookMessage =
        guestbookMessageService.create(request)

    @GetMapping
    fun list(): List<GuestbookMessage> = guestbookMessageService.list()
}

data class CreateGuestbookMessageRequest(
    @field:NotBlank
    val author: String,
    @field:NotBlank
    val message: String,
)
