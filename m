Return-Path: <linux-hyperv+bounces-5482-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4EAB482F
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4ED6465EF4
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BD614B06C;
	Tue, 13 May 2025 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fg7peFFw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3776632C8B;
	Tue, 13 May 2025 00:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094788; cv=none; b=XFd4rjZF3NNaJn7H0XfwkFdHUPnJarYZlW9hvuiNNnJuUpCojlZIH64ACPndR551/IrYzM5R5e3YMlyez0JUY05bsI4DRVyKVmof3ihH6Mr00s5j+TopxbWPguTCB3Ibzm0yb6Km1fpHiWBrIj0PNxmO/+yaC4HsMmK6Zd0ea7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094788; c=relaxed/simple;
	bh=/3/6voPULjYvpgG6Nnc+zAtZr66zlGPAla6ugxce3l4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5N99biuNJy4YJlrnolLY1f4FR+mahvrlXpyKe0bVxS67vjgVhomcNnrdi7xWmbmVgIXZGnzyq7qPzKNMy9LGh/D00wlTTMKjNf0rN7PxV8r4i5Zqg9ORDIn/9SzfpthTsnJr/ECpMXt3auSzyvMevCl5k9Tb6rx5APE83OXRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fg7peFFw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e16234307so53407175ad.0;
        Mon, 12 May 2025 17:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094786; x=1747699586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nB0R2WkOeQvPRFxPtqwr6m021by5PVJe9qR5v1cbNws=;
        b=Fg7peFFwmYvaeyhB0M6uVUetz9ad98+dY/FOYNSdaKQGhR1QSD+5OVs+BlxV6JgE4n
         6U6t/sjjJVgphZT2xvcmJ/SxYiXwQxhSZp0td8t3oqGppjuJ93a6yzYr06usnAChJCqp
         ic9qjygN/5eCWVPSvR3UVttTLn2nS5Ex1NNSbs9qj0FiCuoRx07cOuawC5nWt+Ft8w0+
         VfYA/6ZmPkeA6+RGP2aQbb7xfrTZ1Z8oDs6O/X8zBc/nQgCjKBRlJEF04ueBXNetG8MH
         jWc27i6OTaH9cAXDnOVocLbBWojROzeyR6yTvi7jJkF+Ql7oQ7BgP9NqahUMN9Xq8ee4
         spuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094786; x=1747699586;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB0R2WkOeQvPRFxPtqwr6m021by5PVJe9qR5v1cbNws=;
        b=Lu38cYCJUnx/26MGS69LKA+dfQS6XByE8JPZsiMHAlaWCP1VP5IlE+Ce8pcLU3/g9o
         EOT5y+B1P7Sq1t1fJxN26BgvyJPhMqF0IClSayCSW+dDBbBuQeCJ4Zkiy26Qyho+dk1f
         t60H5BERLMEfapHLYjAjnQFqWWgPTk+WZtdwS7uH9amFHbpew4i7zY4X360RL4zsc5M7
         HnhM9wU6g5pOIAupN0thvjZgq+VK3IJVOw1Kr7nPk8KU152pu0UWsbvYG5AIRzO2JBZa
         AAXH/GZIeqxbc6WPCxdu0AaZHCVhmyAZLOHxOVxNMUfBiCVkEm7OxDguzfPaOyEMKRii
         vamQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MG+GmtGFPeHgFmp3qMtvWwESJu4e4GhKiqTnC9Pgv+9U+R2E7cj/fJSmPL4sahsNRRF+cMPw@vger.kernel.org, AJvYcCVZgPWOALjR0Ti1uA95INX1wvsdWqcrSsFdmD5QamDIKuCErY/tmkBT0PdYfiKSVDkbXLpKR4cnNYTDbmA=@vger.kernel.org, AJvYcCWwxIKU/UvHNvt91qqeTCJge2fR/6TTgWpRtWMwhNXb3lOfHL9UGrvSduZ0S5quBP5TQf7AGMQQ@vger.kernel.org, AJvYcCXDCAAT4vy7Xj66rjl3QHkgLhwNLL4+WerppIHvnAV0HozizCGTeHUM4/CbmiUGfwDrCblmY8IoWfGgJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTHwBJCU4ratFWBKgfDkLDDkvXE4+bW8r2+yxaf+V/vdTzboJ
	jrs0ZmyCJSLg+7pfVi/GonnISxqVE8WsuFpKDvEXIbEW7iIoMTbI
X-Gm-Gg: ASbGnct5OGHPX54DVzwn5hh1aO4GXmoXVCZoBNmLLU+gBp4oU0BodbQQEkRRXffbtHW
	05Bo5I1NnLRN2jJyTjdJX8wVdfwycEDvKiDtPqaB5I0VUbcZvC1ASKlF8YmAkB2GgXN00eOaaaM
	5lN2sUJ69yCBLnP9aERIk0rXGIZZ2RzWAglHWQbeHO79pLOxahJyWbTd9st/qsaDd7rAdhFB4bO
	825+xtvbP+C5Az2wtXTwSb4aIVpzJS/C2EZq+y/hPYy/95KncBqOXg/FrHnqW+/6INMV8yCrRhL
	Wg34ol/YtE2/ulboAWZw4m9lx29dtnGsOkWfpghQxJJVue+ihvf7APYFuEMcJcEt7lWWyykMxJk
	6q+6BWiKboZL0O9SWP1MrgkO2D1xm8g==
X-Google-Smtp-Source: AGHT+IFLg2j6NqWasFKsMRIuMsAX6kcU4vbM8vVlA7iOsqIK1jE+GZgWt0et1u12KP0vgp5Tktg5eg==
X-Received: by 2002:a17:902:ce8a:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-2317cac7646mr19127295ad.2.1747094786386;
        Mon, 12 May 2025 17:06:26 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:26 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 5/5] Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()
Date: Mon, 12 May 2025 17:06:04 -0700
Message-Id: <20250513000604.1396-6-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250513000604.1396-1-mhklinux@outlook.com>
References: <20250513000604.1396-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

With the netvsc driver changed to use vmbus_sendpacket_mpb_desc()
instead of vmbus_sendpacket_pagebuffer(), the latter has no remaining
callers. Remove it.

Cc: <stable@vger.kernel.org> # 6.1.x
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   | 59 ------------------------------------------
 include/linux/hyperv.h |  7 -----
 2 files changed, 66 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 4ffd5eaa7817..35f26fa1ffe7 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1076,65 +1076,6 @@ int vmbus_sendpacket(struct vmbus_channel *channel, void *buffer,
 }
 EXPORT_SYMBOL(vmbus_sendpacket);
 
-/*
- * vmbus_sendpacket_pagebuffer - Send a range of single-page buffer
- * packets using a GPADL Direct packet type. This interface allows you
- * to control notifying the host. This will be useful for sending
- * batched data. Also the sender can control the send flags
- * explicitly.
- */
-int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-				struct hv_page_buffer pagebuffers[],
-				u32 pagecount, void *buffer, u32 bufferlen,
-				u64 requestid)
-{
-	int i;
-	struct vmbus_channel_packet_page_buffer desc;
-	u32 descsize;
-	u32 packetlen;
-	u32 packetlen_aligned;
-	struct kvec bufferlist[3];
-	u64 aligned_data = 0;
-
-	if (pagecount > MAX_PAGE_BUFFER_COUNT)
-		return -EINVAL;
-
-	/*
-	 * Adjust the size down since vmbus_channel_packet_page_buffer is the
-	 * largest size we support
-	 */
-	descsize = sizeof(struct vmbus_channel_packet_page_buffer) -
-			  ((MAX_PAGE_BUFFER_COUNT - pagecount) *
-			  sizeof(struct hv_page_buffer));
-	packetlen = descsize + bufferlen;
-	packetlen_aligned = ALIGN(packetlen, sizeof(u64));
-
-	/* Setup the descriptor */
-	desc.type = VM_PKT_DATA_USING_GPA_DIRECT;
-	desc.flags = VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED;
-	desc.dataoffset8 = descsize >> 3; /* in 8-bytes granularity */
-	desc.length8 = (u16)(packetlen_aligned >> 3);
-	desc.transactionid = VMBUS_RQST_ERROR; /* will be updated in hv_ringbuffer_write() */
-	desc.reserved = 0;
-	desc.rangecount = pagecount;
-
-	for (i = 0; i < pagecount; i++) {
-		desc.range[i].len = pagebuffers[i].len;
-		desc.range[i].offset = pagebuffers[i].offset;
-		desc.range[i].pfn	 = pagebuffers[i].pfn;
-	}
-
-	bufferlist[0].iov_base = &desc;
-	bufferlist[0].iov_len = descsize;
-	bufferlist[1].iov_base = buffer;
-	bufferlist[1].iov_len = bufferlen;
-	bufferlist[2].iov_base = &aligned_data;
-	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
-
-	return hv_ringbuffer_write(channel, bufferlist, 3, requestid, NULL);
-}
-EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer);
-
 /*
  * vmbus_sendpacket_mpb_desc - Send one or more multi-page buffer packets
  * using a GPADL Direct packet type.
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d6ffe01962c2..b52ac40d5830 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1167,13 +1167,6 @@ extern int vmbus_sendpacket(struct vmbus_channel *channel,
 				  enum vmbus_packet_type type,
 				  u32 flags);
 
-extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
-					    struct hv_page_buffer pagebuffers[],
-					    u32 pagecount,
-					    void *buffer,
-					    u32 bufferlen,
-					    u64 requestid);
-
 extern int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 				     struct vmbus_packet_mpb_array *mpb,
 				     u32 desc_size,
-- 
2.25.1


