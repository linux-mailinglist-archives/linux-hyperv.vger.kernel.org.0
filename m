Return-Path: <linux-hyperv+bounces-1599-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20F86BCF7
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 01:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC831F23D2F
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Feb 2024 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220B15E9C;
	Thu, 29 Feb 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKbBTXkT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD342125CA;
	Thu, 29 Feb 2024 00:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167547; cv=none; b=g4EcDwMd9BdJU1vr63+3gr+3gE6z/s7+HszoXkz7e2Tc8pFmfZyH84r4Mugf+0/NSawV+SLP+Np4lkQf85LrYBEa+mF2cqR3ykMmpegKca61HRSvZibu7DeRyvrAoKHL9b9iYh7tviJ8GbiKf4NhKv+PexBmVGDqawrITZ/bZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167547; c=relaxed/simple;
	bh=mL0+LWudGeaaHDI+xSeK69jieRGtjTjyv0Mt3l1ud8M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=mKQpeVskQ90AUnZzgRukcxKObOOwzAudBrU+kUu85XxSdv2kLiapN/qS0YxHtQiMWJwBc26UMm6hAovWEPWs0wZjRWyexe2GSY0UvN9+pSa/phek95YQt9N62eAUelbp5lusuyrAkbs6ee21T4H+bKL4c7+K8BujNBYi3Y1AMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKbBTXkT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dc96f64c10so3935445ad.1;
        Wed, 28 Feb 2024 16:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167545; x=1709772345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zKxWzZR1Bl8LnE+v4HnmwqndSh4isnczSEaDQ8WzU6k=;
        b=mKbBTXkTd9SfeiBpfiX+6vi+rHegybw7khb7fM21FljAvX22YtYTf41SHnkM1PNtjx
         j2EkpA4VdmTXbHSK/gqdNf3WpaikPiPXkZoTGP8S0aDy/45YpxHLFo+RE9h/tmTkKL64
         33W1oIteOW5sTlcRKLhafDJkoBWHoKnNT3pcCncShHqsBUaFduasFAWmuqKMdMBi6L7O
         qruuVXxV2HSKMSN1mQBTEfeLGBFTp/+pknDwo7m2Dh81LeqwA9U/IIbseynoX6eolBnt
         FfUwMsvQA2ZfW8dGOTgYY7i+Y6962pQmILilKJl4sGmHH2JriY9jzW3RrhRlBQm0ECKT
         zjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167545; x=1709772345;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKxWzZR1Bl8LnE+v4HnmwqndSh4isnczSEaDQ8WzU6k=;
        b=KFyqZoa2gi40cr2TWjIBmm469R1K+YQWbx/Lt7RKiX1+K6AntTPUvIx43lAyi/bRmg
         faFVgn/D2N3oYj1MCNwyPnL89K6cc37grFsks6f7BvvrgdSOFTDe0+dlbPnLKnEFCKtP
         FkSrlj6hDPJTbF58I/moKWeqkGoGZDvaXr1la1ggfExm3UepK/4lQl25ZsJ22xS62P9t
         VBCbBGPxsY/Weq5mV2ABKcN/7gxsSppbvn1vfZ1HkYpq9BvM0MT19jY4gc6HI0L0Gi+d
         /WfZLfVk0LHM2bRQGPoeOm3d2MlpEUweYmltWCEgOoZkUYazvdIFmnYn32LsEjaSK4n4
         2pTA==
X-Forwarded-Encrypted: i=1; AJvYcCVitp5Lem294Dta3URgCrB3lBwQyGqQjR7+V7z/MEZ0xAoKAvs7IvU+KwzbYA/hmzDlIrk+zus3sU0wksfQEN/czzJrAi1p297pmNrp/TkZJHYecqjaICooY5g7jTNcQm1ZtpDyX0F6z4Ly
X-Gm-Message-State: AOJu0Yy40XXhwp96CdPUcwbc8Fldqc03aAGdigo7YJcfbP0MfwS9Jx2e
	+Kt1RKlgTgLe7PvkZeIPfW7SwOc68r+SHrBXC24maU4D69V8KhHE
X-Google-Smtp-Source: AGHT+IEsURmdbvyFDBIimxZQbtTtSxcwklzH2T2C/rOEbg+lYw12Mgs53IuqqfM2xLSpvjjomNmgpQ==
X-Received: by 2002:a17:902:a70c:b0:1dc:a844:a38b with SMTP id w12-20020a170902a70c00b001dca844a38bmr580579plq.67.1709167544830;
        Wed, 28 Feb 2024 16:45:44 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001db5e807cd2sm70418plr.82.2024.02.28.16.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:45:44 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory
Date: Wed, 28 Feb 2024 16:45:33 -0800
Message-Id: <20240229004533.313662-1-mhklinux@outlook.com>
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

While the new algorithm slightly changes the amount of space allocated
for ring buffers by drivers that use VMBUS_RING_SIZE, the devices aren't
known to be sensitive to small changes in ring buffer size, so there
shouldn't be any effect.

Fixes: c1135c7fd0e9 ("Drivers: hv: vmbus: Introduce types of GPADL")
Fixes: 6941f67ad37d ("hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218502
Cc: stable@vger.kernel.org
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
Changes in v2:
* Updated the commit text [Saurabh Sengar]
* Added the second Fixes: tag and Closes: tag [Dexuan Cui]
* Added Cc: stable@vger.kernel.org tag
* Added Reviewed-by: and Tested-by: tags
* No changes to the code

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


