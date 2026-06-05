package com.example.claninventory.utils;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class HashUtil {

    /**
     * Genera una sal (salt) aleatoria segura.
     * @return Una cadena en Base64 con 16 bytes aleatorios.
     */
    public static String generarSalt() {
        SecureRandom random = new SecureRandom();
        byte[] saltBytes = new byte[16];
        random.nextBytes(saltBytes);
        return Base64.getEncoder().encodeToString(saltBytes);
    }

    /**
     * Aplica el algoritmo SHA-256 combinando la contraseña con una sal.
     * @param input La contraseña en texto plano.
     * @param salt  La cadena aleatoria generada para el usuario.
     * @return El hash SHA-256 final en formato hexadecimal.
     */
    public static String hashConSalt(String input, String salt) {
        if (input == null || salt == null) return null;
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            // Mezclamos la contraseña y el salt
            String combined = input + salt;
            byte[] hash = digest.digest(combined.getBytes("UTF-8"));
            
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
            throw new RuntimeException("Error al hashear la contraseña con SHA-256 y Salt", e);
        }
    }
}
