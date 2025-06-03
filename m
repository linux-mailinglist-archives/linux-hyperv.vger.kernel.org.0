Return-Path: <linux-hyperv+bounces-5728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB07ACD059
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 01:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0051897E24
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 23:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D703B19D8AC;
	Tue,  3 Jun 2025 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7BXUzXJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF89155C82
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Jun 2025 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748994200; cv=none; b=t7M+6iBINylgvHzmcbSZEK6ojNhHLsMwCKBxs3GD/CqOup1YclxeJ0YY3Eog5Obq+XbouKyuZusT3i/3El9s0qYdLGoFRDeCJPXTst5O5VOhdPgJ2B0csu/pW/iq4uHiDAn9AJbp33PmmfcONhW0KkCU42VDtGKdF4kiVYMpMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748994200; c=relaxed/simple;
	bh=FSyjhM8QjXhvPZV+lB7p7/FLcRQqvcjbi4ve5jq80DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mw5Zot+a+CMU2VRmCY+GyQV05MgHKcygwYNwUW2yLhd1PFVAEOl3BCOS+Wk4SK9I5ftp69Kju49q+FJHqZ6EeXxGD/fnsK2pxTzdeQBuC33lyANaHgWJQl21fQEJEqQXWqAj/GxTFoxOsrOH0xTnALWP1bxBECbS6W/axlPdsMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7BXUzXJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4803096b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Jun 2025 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748994196; x=1749598996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUZz9Z8zg59FyOi7Yn7eVvVDS9lOnGBnKfxhzl8nXoM=;
        b=f7BXUzXJ6LnsIh4I4chd5AC/uMkJiIcZhnJi+w0RzhZh4mVCv+S44F1mtrlHdb4rZ/
         /WY/d2QfH6fAPTgQbFoOBEJGRwY2Nj8En4pHkwlFpQVoPRArFqYho5Mng185bvL2fKHf
         hufulHbD7DkxySXj1jrm609JKtksKAKJwc4ak7dOodRORtIipXW42CgEsZey12rwSoZM
         dOdFKLpKaVD5Hb7R331vN8sqI4406B4SVvHaYeYJs80MCHeZp2ZZ+jTgVLIQ8/XEh0PV
         3kcWTSRgSxIR76WD5SRtIbIBoGZx31I2e4lwgTnEf8uSoLkCIMiY5fe6POJxPoSgFOH4
         z0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748994196; x=1749598996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUZz9Z8zg59FyOi7Yn7eVvVDS9lOnGBnKfxhzl8nXoM=;
        b=QgjkRvyF0WjkCglJaGfJSIITVwWn6WnlyNF0U2t3nbO78rkvMPyKn8Y8Yq4A7U2iMj
         vhar0GNf1PtyEyX6W32CSxWk8oyv6jGe3LWEorosHCt/27A14j1nplp/4S0Qp8BJCZzz
         z2evMLmxPL/Ed8gVjYoHZjggqXfgutzrthYGpSW6Z7d6EpHsbCk8/rgW9FMrUa1G33o2
         vHtRiKSeD85oLcCNt2NDkMZAh1TBCtteo66hd8akSuTFprPuTw11K/tyWP6OUF9407Iy
         KGWPfi/XWim8SvnV1vNboUkzFTEHiRPcYFiEKfJMMZLYs1509/RGr05R45A5I3oiri5s
         Am4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2c7MiMMwMZoDw05tCAqLkjplds9BdaSPFInuqJwmiEGy2Hm5hsclyQOppLYcml0wQvq88Q4OApebSp+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhmNH3EhckkmrqCzcc2v+dFv8hcdl0eIcGeTaT+JGCMu1jATD
	oDTtKFIqWMX7uPBSfjeSxjpUK+3pkmN265PWyJMa8MYq9g2s4LtnO8bK
X-Gm-Gg: ASbGncul9rq4Hvm1lfbJQFj2ReYPxfYt2bkroppnzeFqzZXpen8JWOdptc1Cd2L3M32
	ep1SJrMOY68u0ruUnwSZaeaWSs0SC8pgTL3AwsSir5nGSqwwr/G0DKGSMwT4VwuiBfL9ylPLx9b
	lKy7M8Dw+5BkYQm8eWaujUK8HsmfJV5cvlwPvCuilAzT1I3jnuL0LpZ2iDoChDWtreEQUcfAD33
	SmeAZ6VpNyaxfe8nJKAOhdp4fPv19BefQ1C66xoF8NOqrRBCf1weCeYv51ySHDi1Pq57pWuiN5v
	Xy5dBudIfm7sjzHQY25RNMq8lXhYXD2tbCeysvNCASO/TCdktbtpa5ZHeBkNRdh8189/Fv+sVjF
	qoXgF2QJLpDf5CQg+OnlCZO9BTohQ+3+0Xxns
X-Google-Smtp-Source: AGHT+IFl8/EB/xCqu2ZDmyUh0pYTqZS36tbHVH/HQWqy8jKBLVhLuot0Cfte38eOjiPSX1cW0hPTng==
X-Received: by 2002:a05:6a21:3a82:b0:21a:de8e:44b4 with SMTP id adf61e73a8af0-21d22c29d80mr820112637.16.1748994196438;
        Tue, 03 Jun 2025 16:43:16 -0700 (PDT)
Received: from fc42.mshome.net (p4149050-ipxg13701funabasi.chiba.ocn.ne.jp. [180.47.146.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb029f0sm7615938a12.15.2025.06.03.16.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 16:43:16 -0700 (PDT)
From: yasuenag@gmail.com
To: eahariha@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v3 1/1] hv_fcopy_uio_daemon: Fix file copy failure between Windows host and Linux guest
Date: Wed,  4 Jun 2025 08:43:00 +0900
Message-ID: <20250603234300.1997-2-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603234300.1997-1-yasuenag@gmail.com>
References: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
 <20250603234300.1997-1-yasuenag@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

Handle file copy request from the host (e.g. Copy-VMFile commandlet)
correctly.
Store file path and name as __u16 arrays in struct hv_start_fcopy.
Convert directly to UTF-8 string without casting to wchar_t* in fcopyd.

Fix string conversion failure caused by wchar_t size difference between
Linux (32bit) and Windows (16bit). Convert each character to char
if the value is less than 0x80 instead of using wcstombs() call.

Add new check to snprintf() call for target path creation to handle
length differences between PATH_MAX (Linux) and W_MAX_PATH (Windows).

Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 37 ++++++++++++++--------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d1..86702f39e 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -62,8 +62,11 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 
 	filesize = 0;
 	p = path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 path_name, file_name);
+	if (snprintf(target_fname, sizeof(target_fname), "%s/%s",
+		     path_name, file_name) >= sizeof(target_fname)) {
+		/* target file name is too long */
+		goto done;
+	}
 
 	/*
 	 * Check to see if the path is already in place; if not,
@@ -273,6 +276,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 	while (len < dest_size) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
+		else if (src[len] == '0')
+			break;
 		else
 			dest[len++] = 'X';
 	}
@@ -282,27 +287,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
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


