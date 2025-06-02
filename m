Return-Path: <linux-hyperv+bounces-5713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F03ACBDD8
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F2C7A9E2A
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Jun 2025 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5B7080C;
	Mon,  2 Jun 2025 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+LhN9iG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CD2DF58
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Jun 2025 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748908584; cv=none; b=eex6WfGMRdW8OJpMuwODXTOfvZpjpOJhYaCSeQ2FUFuo8hPWE0gS0wtuS3I02TlPeEXYIRnxixuPletZAeYnRps53US+uQGmEcXPBz40XizHpTupezTMIBZ1x0jqOpz/yBqleMy0RIUJFv2ql4LAmlHmWQAslmzmyPiK03ya89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748908584; c=relaxed/simple;
	bh=Gh/zFxmEz9IyiHGhOZPttuirmL5rZWT5uiIzyzVMsRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYdg2oRA7EUbyo+pt72uq9gV5Xom6r9hn8kJ6+QiosoczkBDkrMd/Pn7JGEjgJ7Tf9dIWg/v46Pz5UW01bYGcuxy73ZX04SAApNBV6uobDpVyp0qV/tY4wcEf5TnEB5oMhZBJRvxgUhsJgWwulGkpu737YXkdH6RZMnNeZWsIIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+LhN9iG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7406c6dd2b1so4830169b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 02 Jun 2025 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748908582; x=1749513382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NuAKjAE9ZLIZUQMzp3Du8tiQOMM0ZjTLdUQ+nz2iXTc=;
        b=Z+LhN9iG4F4NfFBXGSj8heRxpjKpdzfMus47sDd+8zBRYNNPy2NCujdpPrnQHmIHqa
         qSjXPPKnJTaKNl6ba+8UrApEgAdSrIN9DG+05KPHs2Eh3/G09LCgnI4M/BZDkH8OOkj+
         TMUv8BBFingvY82v8SNDJZ/LFUzoF9dv1Didl8Cy4NEDnW6LH/4fkbKVbsvuX73Phgz+
         N9zJKxhAiUv4xOwjBbz4ztgcXbD1JaV9xNKSTomzPJLfKbRK/3Vc3n/IZwrwZ34dGEen
         ASfsJGID+g5/6+7P8u9fCWl0WxdqpJUc26gEX6M5if6leQX9iaoabiSENwrZMy2C9iUx
         mBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748908582; x=1749513382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuAKjAE9ZLIZUQMzp3Du8tiQOMM0ZjTLdUQ+nz2iXTc=;
        b=Fg5i/LkzWNkiakOZBf6NTHixejHfwx2uMjG6YMGS11odpc1WSTjpesKBOLO+nkxJI4
         mhLjjqxWtkU/FdMsqPCRkoNkBOEP4MQer12MyR48Qgq/IsrSznivELJNqyaYA9M48xQw
         m9G1TkcY/a6P9hRCAvNTwUkek2T56kCsDSSB6MsRgR6lG95x9+GOYMEV045b7X+bfpRT
         wD8nuzjSeUoNgD11OoBkZJxy148daQUiZNxEHkN7E61Ws2nrdK0LpwOk1KFSZhAFAYox
         yZ5lLMFjSt4TuytkUTlSipNnMUpgaH31AdSFjDnS8jXFAD8EGZVkyVlilFAlRh3FpR9c
         P9+w==
X-Gm-Message-State: AOJu0YyoGmlcQp1RgtobhXfCUwBL+J7L/gD3y+eZijz9XAH4B05B6j0r
	H6Wq1nJpUsBZ8yIRxPPTi3eYxNJ7M9TT2SDl3EwMISlEC2mWhOwedWU5RbXFvg==
X-Gm-Gg: ASbGncsjga+wxvfMZPaZKMAj0psm2hsoI8pTRKPhJvx9JTNAbXEW0ymHz4boAhpwUqz
	QDw84U0LlOIbj2lVEe0jE9gf/Mvs4fRJ6cdcMUSjR2zWh9rcPGfvh9oPhfxQ6diyFnR7UVNm7Oo
	X3hplOc7PNa97lBhA3GJJbmRFjx6jG6S315X4y0QUTPov+SKHXo1donwiFhYvOtKN/od5SL7bmP
	9LZW/mqGw/D5WIjrQo1fpN2PYb2hmiG4Q+cAtG2h5+O1rYpRKsV0wwKptRAokQzCoJ/7YXRsdz+
	q8LCXUsxyI94ZSbuj8a8CnwxINhtNnlVPA6V9/kVZpcuoF23VcZwgTUmmi5+gsqKPxv55W/qxhV
	FjcPnjPYgtYI5dIijw12EfS0ABxn3o6wdjque4Q==
X-Google-Smtp-Source: AGHT+IEp2gwqNM85cJ0x1XlwKUI3N3MqMNEfipSvcx3RWNNZLW5lQa62exNOd5QYfqJQnBoTlBUuRw==
X-Received: by 2002:a05:6a21:6b0f:b0:215:d1dd:df4c with SMTP id adf61e73a8af0-21d0d002a14mr677348637.6.1748908582381;
        Mon, 02 Jun 2025 16:56:22 -0700 (PDT)
Received: from fc42.mshome.net (p3626248-ipxg13201funabasi.chiba.ocn.ne.jp. [61.207.103.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd4398sm8467274b3a.134.2025.06.02.16.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 16:56:21 -0700 (PDT)
From: yasuenag@gmail.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v2 1/1] Path string from the host should not be treated as wchar_t
Date: Tue,  3 Jun 2025 08:56:12 +0900
Message-ID: <20250602235612.1542-2-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602235612.1542-1-yasuenag@gmail.com>
References: <82cbefe0-c9d0-457e-99dd-82842ee64cef@linux.microsoft.com>
 <20250602235612.1542-1-yasuenag@gmail.com>
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

Signed-off-by: Yasumasa Suenaga <yasuenag@gmail.com>
---
 tools/hv/hv_fcopy_uio_daemon.c | 36 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/tools/hv/hv_fcopy_uio_daemon.c b/tools/hv/hv_fcopy_uio_daemon.c
index 0198321d1..85ec21696 100644
--- a/tools/hv/hv_fcopy_uio_daemon.c
+++ b/tools/hv/hv_fcopy_uio_daemon.c
@@ -62,8 +62,10 @@ static int hv_fcopy_create_file(char *file_name, char *path_name, __u32 flags)
 
 	filesize = 0;
 	p = path_name;
-	snprintf(target_fname, sizeof(target_fname), "%s/%s",
-		 path_name, file_name);
+	if (snprintf(target_fname, sizeof(target_fname), "%s/%s", path_name, file_name) >= sizeof(target_fname)) {
+		/* target file name is too long */
+		goto done;
+	}
 
 	/*
 	 * Check to see if the path is already in place; if not,
@@ -273,6 +275,8 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 	while (len < dest_size) {
 		if (src[len] < 0x80)
 			dest[len++] = (char)(*src++);
+		else if (src[len] == '0')
+			break;
 		else
 			dest[len++] = 'X';
 	}
@@ -282,27 +286,15 @@ static void wcstoutf8(char *dest, const __u16 *src, size_t dest_size)
 
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


