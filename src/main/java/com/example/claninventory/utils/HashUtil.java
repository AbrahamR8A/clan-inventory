package com.example.claninventory.utils;

import java.security.MessageDigest;

public class HashUtil {

    /**
     * Aplica el algoritmo SHA-256 a una cadena de texto.
     * @param input La contraseña en texto plano.
     * @return El hash SHA-256 en formato hexadecimal.
     */
    public static String hashSHA256(String input) {
        if (input == null) return null;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(input.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error al hashear la contraseña con SHA-256", e);
        }
    }
}
