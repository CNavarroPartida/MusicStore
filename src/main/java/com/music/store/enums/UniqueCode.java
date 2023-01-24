package com.music.store.enums;

public enum UniqueCode {
    VALID_USER("VALID_USER"),
    ADMIN_USER("ADMIN_USER"),
    INVALID_CREDENTIALS("INVALID_CREDENTIALS");

    private final String code;

    UniqueCode(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }
}
