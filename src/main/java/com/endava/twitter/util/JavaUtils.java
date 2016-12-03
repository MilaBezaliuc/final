package com.endava.twitter.util;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

public class JavaUtils {

    public static boolean validateImage(MultipartFile image) {
        if(!image.getContentType().equals("image/jpeg") || !image.getContentType().equals("image/png")) {
            System.out.println("true");
            return false;
        }
        return true;
    }

    public static String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }

}
