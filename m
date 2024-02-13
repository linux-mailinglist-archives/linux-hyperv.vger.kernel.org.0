Return-Path: <linux-hyperv+bounces-1538-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526F8528CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 07:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A9931F24D44
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Feb 2024 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3259D171AF;
	Tue, 13 Feb 2024 06:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1P4jQIj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCB171A5;
	Tue, 13 Feb 2024 06:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805209; cv=none; b=FGgIj1Cjv5tY/qoBtTrARv8BWdJCZmClG7WLG3JUEJNk2ya2IcCCsAenvf3T04hLvsHg4qhaFvXOqypIi4jw8FAshu+4tK3zGCRj4NTEMcb+rpdFgWrOkBMTq2biIU9cafcqwenclZ2NAkjnomvSV9CRf/0mAXsslcW1g7dQeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805209; c=relaxed/simple;
	bh=xgIXZYSXIrqcMkw53O3O1RcP+HVXrGrG1W+8CKl3pCU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=iXFfq/IwQTLCrkZwpBK/PjFID8ACEa9X2MtP1LEZ1gCq9dx4wGeTOl6jBDAvcwBurPnpNo/bI8R7Z/nLaRlS8xxGPSSuioCDbNrWbAEmV4/MyhaSy3JAoi5Fk805J5QCKRBX+eBTWhUcYeE/iKklOITyzkF/dI1e+5wypgI8SR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1P4jQIj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso2745558b3a.1;
        Mon, 12 Feb 2024 22:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707805207; x=1708410007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kofx/nI+3+ZfyrelDKxGbf/J5Ye+MoFyXznYtLtU6o=;
        b=C1P4jQIjsSljCpzpMqNS6Dmd+tFn+pGinHUL21QSPbdcwp1Nawj4jMZCYGhSQHAf20
         oZQ7YAdXedAA/pCp+eRyuJL8ghGHrZgPURqd9dQ7VVnEJVtFQBhNtGk/9WriGmsg9hZh
         3x+bFz7uSrW/mseuElMmBmhvXT/parpt1UJnREkbOKaofXiJAmLSImbUoAVXdmRMFFtG
         rG+C18+8hN4vmsq3Zxu/leJxxJZatwgh/bgP0K9WLYCj7ZuRENxESdC8snrQwvfXWw7R
         DQ/6WrD6XVrb+P7LufMh0BUbUqK6LANyBdtChIiFs/S0hRPd8G0hMZZpteMPQyYuJP3O
         01SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805207; x=1708410007;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kofx/nI+3+ZfyrelDKxGbf/J5Ye+MoFyXznYtLtU6o=;
        b=Q5qA7/o8XualN2QLoq31YlG+RLLDOx+eJYfMFaYOhqtc5P0dF/80LH90LcVZAIok8C
         A7Y7PVr47AQRzTWfTvyS16YbBD1KShZr9ZNu3Xc9LEJ9Vj4WgKjCB47VT9kOz16CwU0C
         vD58s/gMdlhwpSev4fKhiBKqQCNnEj9vjaSuC5jabzb1RMsYWPiaIiGfxHmxrkgGI/Th
         pWKssOpF1ba+caLh+voUhfFa1jfwNNihO2WAnGOPZ0KqqPLJJDmIXx6kzp88M9LNNANj
         u1rW6QjhrDbvTMgSqcJYCw2PYNs09veSxzFWXwj15OD2e0wxKQeZabEAd9ZAfaVXGYeG
         nOFA==
X-Gm-Message-State: AOJu0Yxf/Xtmii5cdJ+zuusYZifE6pk2clXKeNBuqUvHs1XsvWSngJ5b
	LyUG4WLFypFWj0gSWIvsb2ySHxRZmGhsbM7Xm+NfzX3qXaCXoSIT
X-Google-Smtp-Source: AGHT+IHyUo7nOK8uBkU3/T+x1m01hGbINCMe1YWJaeeN9ud0lV4Ba/c2LV2ZmyDrSSWWrDIoUxK/Jg==
X-Received: by 2002:a05:6a20:d39a:b0:19e:427f:9d52 with SMTP id iq26-20020a056a20d39a00b0019e427f9d52mr2376490pzb.14.1707805206684;
        Mon, 12 Feb 2024 22:20:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVM3rcWSlOtxa7y1ukw6p7WxJp5N4lTra55S0XsNahbHX49gM5kAwGMKe5vmkXsfHSRfAwGDtwqwAf47WrUPPSMK8eUlUGUnaiDu0ga+xxJXvJTOyPp0sbxJeSvlbC5WtYYDPurkXMId+GrZufdQSMUZ280GPN+5XIVKyvzGw1z8mfin3zoKmDWqa9W3dbC8gl/cmQKZlT0PMkubtdj85OL7xrJohpFku/5
Received: from mhkubun.hawaii.rr.com (076-173-166-017.res.spectrum.com. [76.173.166.17])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm6464791pfu.76.2024.02.12.22.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:20:06 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory
Date: Mon, 12 Feb 2024 22:19:59 -0800
Message-Id: <20240213061959.782110-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The VMBUS_RING_SIZE macro adds space for a ring buffer header to the
requested ring buffer size.  The header size is always 1 page, and so
its size varies based on the PAGE_SIZE for which the kernel is built.
If the requested ring buffer size is a large power-of-2 size and the header
size is small, the resulting size is inefficient in its use of memory.
For example, a 512 Kbyte ring buffer with a 4 Kbyte page size results in
a 516 Kbyte allocation, which is rounded to up 1 Mbyte by the memory
allocator, and wastes 508 Kbytes of memory.

In such situations, the exact size of the ring buffer isn't that important,
and it's OK to allocate the 4 Kbyte header at the beginning of the 512
Kbytes, leaving the ring buffer itself with just 508 Kbytes. The memory
allocation can be 512 Kbytes instead of 1 Mbyte and nothing is wasted.

Update VMBUS_RING_SIZE to implement this approach for "large" ring buffer
sizes.  "Large" is somewhat arbitrarily defined as 8 times the size of
the ring buffer header (which is of size PAGE_SIZE).  For example, for
4 Kbyte PAGE_SIZE, ring buffers of 32 Kbytes and larger use the first
4 Kbytes as the ring buffer header.  For 64 Kbyte PAGE_SIZE, ring buffers
of 512 Kbytes and larger use the first 64 Kbytes as the ring buffer
header.  In both cases, smaller sizes add space for the header so
the ring size isn't reduced too much by using part of the space for
the header.  For example, with a 64 Kbyte page size, we don't want
a 128 Kbyte ring buffer to be reduced to 64 Kbytes by allocating half
of the space for the header.  In such a case, the memory allocation
is less efficient, but it's the best that can be done.

Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/hyperv.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2b00faf98017..6ef0557b4bff 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -164,8 +164,28 @@ struct hv_ring_buffer {
 	u8 buffer[];
 } __packed;
 
+
+/*
+ * If the requested ring buffer size is at least 8 times the size of the
+ * header, steal space from the ring buffer for the header. Otherwise, add
+ * space for the header so that is doesn't take too much of the ring buffer
+ * space.
+ *
+ * The factor of 8 is somewhat arbitrary. The goal is to prevent adding a
+ * relatively small header (4 Kbytes on x86) to a large-ish power-of-2 ring
+ * buffer size (such as 128 Kbytes) and so end up making a nearly twice as
+ * large allocation that will be almost half wasted. As a contrasting example,
+ * on ARM64 with 64 Kbyte page size, we don't want to take 64 Kbytes for the
+ * header from a 128 Kbyte allocation, leaving only 64 Kbytes for the ring.
+ * In this latter case, we must add 64 Kbytes for the header and not worry
+ * about what's wasted.
+ */
+#define VMBUS_HEADER_ADJ(payload_sz) \
+	((payload_sz) >=  8 * sizeof(struct hv_ring_buffer) ? \
+	0 : sizeof(struct hv_ring_buffer))
+
 /* Calculate the proper size of a ringbuffer, it must be page-aligned */
-#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(sizeof(struct hv_ring_buffer) + \
+#define VMBUS_RING_SIZE(payload_sz) PAGE_ALIGN(VMBUS_HEADER_ADJ(payload_sz) + \
 					       (payload_sz))
 
 struct hv_ring_buffer_info {
-- 
2.25.1


