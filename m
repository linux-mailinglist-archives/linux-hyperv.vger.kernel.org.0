Return-Path: <linux-hyperv+bounces-5894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C55EFAD89CD
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 12:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBF17BC0D
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 10:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F92C375F;
	Fri, 13 Jun 2025 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSwfsVNF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECC1A9B52
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Jun 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811630; cv=none; b=ESESUAwddmhLtGOgCASDQG724VtikHRS1ZYTByBJe8+ArafrC9keVhzBSFrkCHe710MbbNuLptaKE+os4VTiPStob1MtuYi7C9s/7b1DCqS4/mQ4oAf3sTltZDMMKUeaohQk7k5pABElc/QDH4xEmNRUZAdzJSuapBWgMUgwl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811630; c=relaxed/simple;
	bh=xqdUpirmcnxA6UEN0RAC9ol7ESvKZeF831MsPz7R8DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbfWMB0UXNlv/ym73lhtUN2lUUWZCc3dipFe3l/twHFBlkFX5h6208OmgKXQiXMxMfDduJK3zQAa2rC5p/ixw1zbE6wAVsYC0FY9G9uKAkKk9daen+OpzZhj40sbNEMlTP0P+YqUgqyabw9ehwEAYyAgFnH0aqlDimXz3+IsucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSwfsVNF; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so1383016a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Jun 2025 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749811628; x=1750416428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvfMvtiTPeXccXo8hoMwcFIpszcYaNTh89FLruFsFI8=;
        b=SSwfsVNFwtfjsscWiQGFJ3nzSQCO1rFt6h8k2AMfjldfXfX9GY98DV5Int/40xhbmi
         gYWiYaKhj6O2KbWeWBX3da2nYruaGN1kSwqCgfcYfxUuMOddzsmPx61alpvzFAyV6vS7
         ljl6io4ySRDgPzYCkTtV7qAD8l6gCxdfKNgCymy7P3bLZ9Hn6tQwJyv3EFz5Ch6c/wex
         zRv+iIYbODojx5dPklBeyZiqf6grQenXMiaZdFk+lUjWymduCPZTVbAjmU5MsEuj9x8T
         VdoWUapP/okmnhUSOCRr/y5HGmrKfgNOAOC1bjOlaPg5OimbMIzfJFNsF4s2cN7A9Urp
         2JFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811628; x=1750416428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvfMvtiTPeXccXo8hoMwcFIpszcYaNTh89FLruFsFI8=;
        b=omPkxM0aPbLzOTryzupvYnNMtT8+dKutAEc7zHQqhYHlrUPCG8BBqCQMHAVRD+FcjS
         9fBG4HawFTcq5KWZQNY2wfWfX8q/8Ct7Yg7bvmGgz+o4ENVnJ72mW73R3hbD3Ak4ATDm
         01Q6PmSmVo9lesWW72fDB2xsH09ohjLAuPvleqzf4F2WJ/jeQfq79GhZbZIX5mOGJUpA
         SfQuz0ooF1ZtBx/xkQNPWZj17ntubVCOIucDDvxuPzXtZn1CC4iZsJxGdREDqMPXA7lo
         CQx6Ajtfg5eoPr+gnCf/Rz2Fo4XzT6+rIV16JDZR8JBrZtE60AxNv4qD8kHbONOdFdHI
         hYoA==
X-Forwarded-Encrypted: i=1; AJvYcCWVl0KV1tB2H7azpAS6id5bmkiM+cjs4xdMgA47sSCen8yi8hhQeQ13m1SLv30ydMxfHn0lR2Jiu/rZmyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLldpmbTi6y+3LmUt9qikks0YzocE6HvLwsxmTrvgeZVp+s0bP
	THHDaICxLMrX/7os9/2BMaZirDwUoW2C35HVEXiJClfI+jGx/Eyv+mNs
X-Gm-Gg: ASbGncsLZoWX+q8GNkYns9jWXMaOFyVLOkYBHu6cRXtpNZLixs1zqhkCNEakOsTpLoo
	oHSLeOjRWERws/iTkA+x/RKfxP1WJq0OuQUkUL07sul4v0NKOv57yTwJe0LTOJvuv18Bjx9n/0u
	nYCf/N5gRC4X5c09JWIndDtphh6WtcCmSYbvzu5aZ2TjCzNhAHt8HywDv1I51NJzxVp8omfnnDP
	d7brS3wXpY9A+umqArq10pEoJ50t8Z04IjB2SKjVJQeEezf95ddeVggXsxoTHlst2EIu2zIIDve
	O3ciVwmqNIhc/Z09CAnvJwBADsBDZd5Im8c/FzAhHEF4I/FqPY8BGSq+BUQxKzWEiGStQxIs/1f
	ZjWA1EIZPPMa5I22XJe6GZ6KWp68H1pjHn6p26s/loQtVWWyf8A==
X-Google-Smtp-Source: AGHT+IHr82OiOlkEQG4UWwW5fvS6xjhanNiFzSL6Xn1cyXzFmY1vFgApg/ChvEEeadJ84zX49UkD6w==
X-Received: by 2002:a05:6a21:9218:b0:21a:de8e:44b4 with SMTP id adf61e73a8af0-21fac93b3f3mr3638224637.16.1749811627792;
        Fri, 13 Jun 2025 03:47:07 -0700 (PDT)
Received: from fc42.mshome.net (p3711121-ipxg13201funabasi.chiba.ocn.ne.jp. [114.165.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe169205dsm1363759a12.74.2025.06.13.03.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:47:07 -0700 (PDT)
From: yasuenag@gmail.com
To: namjain@linux.microsoft.com
Cc: eahariha@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v4 1/1] tools/hv: Fix incorrect file path conversion in fcopy on Linux
Date: Fri, 13 Jun 2025 19:46:48 +0900
Message-ID: <20250613104648.1212-2-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613104648.1212-1-yasuenag@gmail.com>
References: <20250613104648.1212-1-yasuenag@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

The hv_fcopy_uio_daemon fails to correctly handle file copy requests
from Windows hosts (e.g. via Copy-VMFile) due to wchar_t size
differences between Windows and Linux. On Linux, wchar_t is 32 bit,
whereas Windows uses 16 bit wide characters.

Currently, the code casts __u16 arrays directly to wchar_t* and
uses wcstombs(), which leads to corrupted file paths or even crashes.

This patch changes:
- Treats file name and path as __u16 arrays, not wchar_t*.
- Allocates fixed-size buffers (W_MAX_PATH) for converted strings
  instead of using malloc.
- Adds a check for target path length to prevent snprintf() buffer
  overflow.

This change ensures file transfers from host to Linux guest succeed
with correctly decoded file names and paths.

Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 37 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d1..4b09ed6b6 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 
 	filesize = 0;
 	p = path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 path_name, file_name);
+	if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
+		     path_name, file_name) >= sizeof(target_fname)) {
+		syslog(LOG_ERR, "target file name is too long: %s/%s", path_name, file_name);
+		goto done;
+	}
 
 	/*
 	 * Check to see if the path is already in place; if not,
@@ -270,7 +273,7 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 {
 	size_t len = 0;
 
-	while (len < dest_size) {
+	while (len < dest_size && *src) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
 		else
@@ -282,27 +285,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
 static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
 {
-	setlocale(LC_ALL, "en_US.utf8");
-	size_t file_size, path_size;
-	char *file_name, *path_name;
-	char *in_file_name = (char *)smsg_in->file_name;
-	char *in_path_name = (char *)smsg_in->path_name;
-
-	file_size = wcstombs(NULL, (const wchar_t *restrict)in_file_name, 0) + 1;
-	path_size = wcstombs(NULL, (const wchar_t *restrict)in_path_name, 0) + 1;
-
-	file_name = (char *)malloc(file_size * sizeof(char));
-	path_name = (char *)malloc(path_size * sizeof(char));
-
-	if (!file_name || !path_name) {
-		free(file_name);
-		free(path_name);
-		syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
-		return HV_E_FAIL;
-	}
+	/*
+	 * file_name and path_name should have same length with appropriate
+	 * member of hv_start_fcopy.
+	 */
+	char file_name[W_MAX_PATH], path_name[W_MAX_PATH];
 
-	wcstoutf8(file_name, (__u16 *)in_file_name, file_size);
-	wcstoutf8(path_name, (__u16 *)in_path_name, path_size);
+	setlocale(LC_ALL, "en_US.utf8");
+	wcstoutf8(file_name, smsg_in->file_name, W_MAX_PATH - 1);
+	wcstoutf8(path_name, smsg_in->path_name, W_MAX_PATH - 1);
 
 	return hv_fcopy_create_file(file_name, path_name, smsg_in->copy_flags);
 }
-- 
2.49.0


