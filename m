Return-Path: <linux-hyperv+bounces-5706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A4AC9EB3
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Jun 2025 15:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818A31894206
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Jun 2025 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E421D52B;
	Sun,  1 Jun 2025 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1VuFL4M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0462F50
	for <linux-hyperv@vger.kernel.org>; Sun,  1 Jun 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748785546; cv=none; b=mMOQ9vTy1zA2YuYb0mujd+ufa2/dm1+jlyXn8yX3M/Ski2kRP67rmoYLff3+8DmkQ78otnVHpOiMdrraxg4qB9JBHLGB//iszs5wUYmndZZZvWQhirmRNlZx9tW8usgY+IUftjuOB5VTnxMfXA/7a/1wb6PF3gd5xk7kLgdItGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748785546; c=relaxed/simple;
	bh=Tvmh3A1JNOfSpS/q9ZqdHn1vWK2fNl9Z+zXojuL28AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dy38jtXsvCLIios2Ph16pCbuLN/nxw66u5HZCV5vIyoitOk1QT1dkmskgErKKfn7wW9VLUJQLTs9t6+FULMQGtbJan9TwDAYLEVcV3+5wEw1HSUILOkF5CRQ6QvHgJfcwDSi4bdVk7Gqg2iXCaNKxZPLRSf33P5BEMM/kazXyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1VuFL4M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23539a1a421so13658905ad.0
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Jun 2025 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748785544; x=1749390344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sFUq6t9cSSVmNBMiKaaQNEqapnn26/h/CVUPlvkBOao=;
        b=W1VuFL4Mc+aFOUGu1fcTA7x32/elF2Fv2+F9ronvfzSUlTdeRpi1t1ZYmd5mnxzTjv
         i84gE9edCpHnvJiaPaCG5CJRv+xLjSw2lUf/0emy5IK76XcAwWa0LzZ8iGAXchkmLSAE
         LI6YChJZphUF1B/O5dnEAgmVodkOd/1NRMFZjp042skg9033BIGs9NuAEW2wMTDIWR71
         RfOPMM+HzvSTmx2WJ0bknZNtWDZhgHy9s2kTzSVY6Bor3FvqdrszzQaf9N43bkyGfn4J
         1xhStquoBDPONrdcdPTkQaoZ5q817T4BstlArU70cbwyKNLzfIUoCUsUqZHFuJ5ZLF/S
         GAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748785544; x=1749390344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFUq6t9cSSVmNBMiKaaQNEqapnn26/h/CVUPlvkBOao=;
        b=Ctmz9/73+9TZ+E+kr5YuW0jL/7BUVeG5rpPfVnkW5yA2OFsuFCf4wzx0UrR7OSQZoS
         y8Wv1DZYEODmkAhiD+GsHRitRcJ1JJ3JZH1SITbU9glOHMknveTRcc299E4ooVUF6r4+
         tM77ltxeH0KRRDUeOJ0jmyFbn8t9R1TOxVkjBZJGd2Fa04+8Ju2bLntwvTzIYWRwVPGN
         Y05fGYvDAjiGXyEGN7ewjgddpgrFp9dUasPt6B5L9rS2v/CBS7tdcy5qtIZptMQCTfr8
         Ym+6sMMzg49KK1tl0Y8j5ATkqQmENrBTtUmSm+KBzmKKMVBSrpN6SX/f/D/8FtmfCv9j
         nWGg==
X-Gm-Message-State: AOJu0YycbvmXYBad586ypQ1nZ8ecORd8JxRBxiAQAjRLhZGL3F/S9qJY
	o2/khnVCZxR34cGJOoywuHpGPo5D/4vazY2VEi9O1/ojINqYIRrSIqBJ
X-Gm-Gg: ASbGncsZ32di0S9zvd2HOikST9gGPWdF5Am121s9j1PeWls73eGshXiRfWCu0WFV51b
	4/GyZtp/SZdp2yo7cVGQ9AOixw3IRaSBnOIUCLRvphK7nnny8a6v6dKXpef0JZLFOb8RLBCcWMl
	T8tLrPVqte5IYCgr3wTZ4xK37iEIF26uxEvAb8GhwlI/JQW/if8OamPSzmkmZIjwCWLmRtdDpEn
	aL5GxlesjxR6syfSKjprLZ5/WHbTA1Znwj6KD9SLilRNnwOniEwZgHBtNdYYeGnrPVT40W2nmuO
	IF32ogMej5FJgS9RvnF7POt8dsf9lWpowIex2dyfkIPEFPY8W1PppRWu/weDzgzQcdvbo2alSLk
	txRt84pR0F3MZc9gIyXEKqKI=
X-Google-Smtp-Source: AGHT+IG06Vw7eu+sm1VMTT+GbrD4HVopc/vA+nlVSiexOeUpzz4WrqSEkxLKCqfDSDlExnPTDWzAcw==
X-Received: by 2002:a17:902:e805:b0:234:c2e7:a102 with SMTP id d9443c01a7336-2355f783199mr74735125ad.43.1748785544309;
        Sun, 01 Jun 2025 06:45:44 -0700 (PDT)
Received: from fc42.mshome.net (p3444091-ipxg13001funabasi.chiba.ocn.ne.jp. [58.88.49.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14de5sm55419605ad.216.2025.06.01.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 06:45:43 -0700 (PDT)
From: yasuenag@gmail.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH] Path string from the host should not be treated as wchar_t
Date: Sun,  1 Jun 2025 22:45:38 +0900
Message-ID: <20250601134538.3299-1-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

hv_fcopy_uio_daemon handles file copy request from the host.
(e.g. Copy-VMFile commandlet)
The request has file path and its name, they would be stored as
__u16 arrays in struct hv_start_fcopy. They are casted to wchar_t*
in fcopyd to convert to UTF-8 string. wchar_t is 32bit in Linux
unlike Windows (16bit), so string conversion would be failed and
the user cannot copy file to Linux guest from Host via fcopyd.

fcopyd converts each characters to char if the value is less
than 0x80. Thus we can convert straightly without wcstombs() call,
it means we are no longer to convert to wchar_t.

Length of path depends on PATH_MAX (Linux) and W_MAX_PATH (Windows),
so this change also addes new check to snprintf() call to make
target path.
---
 tools/hv/hv_fcopy_uio_daemon.c | 38 ++++++++++++++--------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d1..049d4fd9c 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -58,12 +58,16 @@ static unsigned long long filesize;
 static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 {
 	int error = HV_E_FAIL;
+	int ret_snprintf;
 	char *q, *p;
 
 	filesize = 0;
 	p = path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 path_name, file_name);
+	ret_snprintf = snprintf(target_fname, sizeof(target_fname), "%s/%s",
+	                        path_name, file_name);
+	if (ret_snprintf >= sizeof(target_fname))
+		/* target file name is too long */
+		goto done;
 
 	/*
 	 * Check to see if the path is already in place; if not,
@@ -273,6 +277,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 	while (len < dest_size) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
+		else if (src[len] == '0')
+			break;
 		else
 			dest[len++] = 'X';
 	}
@@ -282,27 +288,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
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
+	*/
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


