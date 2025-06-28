Return-Path: <linux-hyperv+bounces-6033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5A9AEC415
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 04:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3804A46E5
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 02:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E64813633F;
	Sat, 28 Jun 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSr8R6Pv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC4EEAA
	for <linux-hyperv@vger.kernel.org>; Sat, 28 Jun 2025 02:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751077366; cv=none; b=NOYyrsgIUxITzs+Nffz9lli6xL6x+ekXI3JTsWelHBuU0LBiYPvnIGUOWrJgVUkU5cju97x5oIqs9CZvyBF2y0kLQ1SyRnTf8G4gC/8NVVlSe/SML9DTGeBfmrM0wkFaHoTfKIWcBe3xoOytJBhMGPScfxvblFuQciO/9h+X5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751077366; c=relaxed/simple;
	bh=+VJ7n12WKAM1lOUp7amqmIQ3EM7W/lii50YmkqPSBF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVvQ4gtdUaB51r0n6VGMO6O3BuIvNa32HGqQ3J03e5xXQkoiW9qFraAZkIs7NzwaFIreLnJnGj9ONW8uTV0jKU2vuyGnE4PfrqMAoByFGDwTg772f4DBd/r3tcE+WbvaQkE53SK2lUadGmVTzLb95rN0yDsRlBDA2dhpCsj/sTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSr8R6Pv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23694cec0feso25798255ad.2
        for <linux-hyperv@vger.kernel.org>; Fri, 27 Jun 2025 19:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751077364; x=1751682164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqCZH1xOKTdFB2U1UkYzbyWqMvmRFsCatXpbEsuTSyo=;
        b=LSr8R6Pvy89oX+947Nni6c+fU0XJV1DgcqJQFmp0jXlHfnOvt7l3gCR6+Lg08ZKvcL
         9sA/sVumNCFswlWneYQ4NhCzuoMCfpGtOw8aWPBa9c4j6Nip9w3Pg3IHBMZ7m2VebC5a
         H3lpOOSdfcbMyaFfEie3NEQMYvM1e2c1ThUjc4gdveWPbKwYAlfTrOv1h1WQpRkoAywI
         ekVaCpPflBs4/sW6OLyaWPAMWk2misGkNLh9XpakBvgjLCYhVfjaT2xUwpOGdDAXWckz
         6i68ghZEeA8vVpJ5/TfdQQoV5IqUgwivNPuK7WiqRpcsr1OLAqMEdElKuF2uCSCBEC/k
         QWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751077364; x=1751682164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqCZH1xOKTdFB2U1UkYzbyWqMvmRFsCatXpbEsuTSyo=;
        b=EOVBmuuxfxu9NKquxTp2npDYktoK3ce6YHnsGwdB0p6l4uWY/2qri1vThznXQBn+/a
         di39TDiqf3U4+VKcoDTxJ0nA23XsHLb/W26e2GVPzeRhd99/Bnb+8s1YLO97TeItLoLm
         5NT7IWv4jgICpOCL8dBgCYJNpLf8fPYzZINuxg/TFS1EkVVdrLfzy8chT6XJVESPlZwP
         5z0i77Q/KLJK6l4cgCfpXGSEPBPCQ99pPLXC020VUOTt/agCQJec9sFIlekQYx999awJ
         8TNNmgTXohyyqKsOMjecxOovzzW0D3ntAmx5Uku2t2W4O4K3tRpnzd5YUuiumYqN0fVn
         yZtw==
X-Forwarded-Encrypted: i=1; AJvYcCUJdezsNpG5Lu21IXX/fERtDEpGVXfmuMr7Sn1VOqGrG9Zxx9fyV4IvXKGUnHXBgOkuF3urV4/bLyx02Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkt7Xh+Q5T2SkbeDl64ekJG6RAvmGb9hYA0N1QXEzHNzEc/Etq
	625KcKvo3gkINyW9pycCTSc4W2620gHDDNIUih/9wcFyFojcBLUlyBoz
X-Gm-Gg: ASbGncsNUvYYepMGJrSRupvskqrwrPhUGuWWpvUdiFgRjapsaoLTDWFFLNDaGCT4FH8
	AwvoGhkFEnG32BhF/g7pmiVGSKZr1XCBmQWibZNU7Bj3qNSWVrCo/dLQsrNJBfsZE0PRXUbj6Bs
	IR7ZF8UKZ/gQn89fUHtgktrW++gk0y6P0DwpitiCzYc5jLuMBU54jyZZElKNpsqrZ4NaHO/57dC
	qi9cEjnrQjzLktlr7FkFTq6WfEhhPM64fEGIGUIRHItzvVB+63h64LHt0l7Fv74tBojzPBItdPI
	FEmY2M1X47jRxU96BLeiyBdAwvwjxBQnuASU4imqQRosKrHD91tKNX+OdZLaFn7mmS45irGZN19
	2o+EjHuDQcEd0D8jlR3TqCBS8/w4ftX9dJAyE/w==
X-Google-Smtp-Source: AGHT+IFeUX1BrfqV0L+jRq+i10IfOvTT1oiFdI/79nxociyqmz1xJYjyoz2wJ3tHR2vdJJcdZ3Ia2Q==
X-Received: by 2002:a17:903:3bc6:b0:234:c549:da13 with SMTP id d9443c01a7336-23ac40f61e2mr76202045ad.17.1751077363902;
        Fri, 27 Jun 2025 19:22:43 -0700 (PDT)
Received: from fc42.mshome.net (p3655040-ipxg13201funabasi.chiba.ocn.ne.jp. [114.145.228.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d35edsm26182045ad.257.2025.06.27.19.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 19:22:43 -0700 (PDT)
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
Subject: [PATCH v5 1/1] tools/hv: fcopy: Fix incorrect file path conversion
Date: Sat, 28 Jun 2025 11:22:17 +0900
Message-ID: <20250628022217.1514-2-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250628022217.1514-1-yasuenag@gmail.com>
References: <20250628022217.1514-1-yasuenag@gmail.com>
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

Fix this by ensuring that file transfers from host to Linux guest
succeed with correctly decoded file names and paths.

- Treats file name and path as __u16 arrays, not wchar_t*.
- Allocates fixed-size buffers (W_MAX_PATH) for converted strings
  instead of using malloc.
- Adds a check for target path length to prevent snprintf() buffer
  overflow.

Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
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


