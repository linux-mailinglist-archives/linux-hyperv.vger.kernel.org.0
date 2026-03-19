Return-Path: <linux-hyperv+bounces-9624-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAUzHQtevGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9624-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3242D23BC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84DEF30836FC
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6E406284;
	Thu, 19 Mar 2026 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ryd15C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A714035DB
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951975; cv=none; b=FJ42AOL6K4nVaAUTO9n6tFmpTDifUGmIsBGOaljmT/aYlJWmxAPg61rvc/LoZ83+joP7SqjmZ01U/Ny+j/DABtqSncuSLyWwEmpanHc4uRQhQkbnPxrZUyhYMozIX6KgHJHgrD5OSLgfz1rDbo8huYfJbpZzE8ugzRG0tkQy3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951975; c=relaxed/simple;
	bh=AOusT6p9367uyjTqPMakWydFQ1xoyk/26t5GlU5mVyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBv9Byt/Tv6H6StXKGQuMlC03+giiLPKImEe2yaMTMD1bpxptt/BAxWFtHb0Bsq+B+PYc6+dL/pLFMQRWGw0iNZ/9ZGMGv/zOq9KOZbhGpbHgDPWems2p1ZNKqJHRsmQqEcb7ztHXxwQgoiOektvLgX46Rm0fIMqORpO3NvnuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4ryd15C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b40003d13so878771f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951972; x=1774556772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nBvPxHuGTYxL2H7tm9LrajSUYE8m0XRxOYwCtqlQeY=;
        b=a4ryd15CxIsWb50OPCdRTFv+Doj0P+umdHRv+qN3FVSK+7o5OqA05ob6fACtCRinl9
         uyqc08p8fCb2lHX7IWQXnpu+KvCRWq0krMsV/y7O/5D+3hk5gSm1z+sSe6KmbH2RHPJF
         V7Ypoicpftnt1JW7iwoaD3CaoFVxH5bSa6toSw/CZBBQ3nlyC2g9+Qi6eybEO4Mv4JEy
         hYjUE0XcW2omT5raCk1cANJSZRz5RU4CTT+n4uljBp9FdQGd3DBeFR4psxSYqLKnJClp
         Nv3LxTisGO2APLrhGjhZPnVlHv1taSasu7uoWF1ONz8q6IxdPgiB8UqLVEPzXlxzKGUu
         +W/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951972; x=1774556772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5nBvPxHuGTYxL2H7tm9LrajSUYE8m0XRxOYwCtqlQeY=;
        b=Mv0yaj1Qh9ZsT60ualTJxP51DrzZ3H8mnySulFmhdTCef/bjL3Q+5IEum4PJj76LgR
         v1qmbUJ8h1m0jTKg2J9rFNJxKBgTl3EvahEWw6QN0oAIm9bVhACD+Lnp301SupYhPNpc
         eC7/T7DirWwihjkzlZun1H5E8DTHoQkdfToI3jfFCuqHYP42v2YiH5ggdVhDeKJrYMqJ
         XDN8yHS7Cq02PucO6lQOGHLVpoL5j7XEfvCmtjG3Em2a4FukXifJMka4yWOvqwgNTYGl
         cG0QVaWUDaoeBUILAZXzmEnI3b0v7+bx9hBoxLAQxAOrQ4sGf5gGUWQezJxxtzUDy0uO
         uEng==
X-Gm-Message-State: AOJu0Ywv+jkzt3N+MhJ1yyXgla2q7d3VEbmuhko9Rot1GNuMmJBgBR0z
	LB4QyJmH3vyekrXnbwhyDaG/nhi/lSJNUfeO5C8uQpAIJAmk8nrhWdqm/61cys4TLIo=
X-Gm-Gg: ATEYQzyuHUHr2tU9V7RJfu57jZCAE2n8X7JMtDyrFBHe5nhZpeG3ILzNDIBNkwOtxzF
	Hfjwatd00EzHbJymb6FCU36nXun1Kq21AMschKEbndds0/38A4kQlgW1g5r6JCFyddwBqRqLD1K
	tDIppFFYmcyMX4jyblu/ZnkCF+q4AmY0QjwXZgGcM2Zxgt1BX1lHDf+GoBgdCPJH8tsZVlUWAS7
	5E3Q2l8FFC1NdPUIiHpXDZIZDQmjo6QWPklXTKliThyUxDGdPQG0wjXyugXTapFXXtLsQbO49jA
	JvduQDlCGbYY7NkWfEAyUNX7EQuFT48fTyIqL+lVvB6f2G9O6M8K7KY8VF1joZ3STgDMc+C/7vt
	HfxL2+bLsHoYxPUJvaOEqlVRVRs+xz14vHA2blgkoNPd+dbuvDI9yLPboDdYWTg5hlFibTn9E8u
	v2Wu5L4RLk3CdEzJM1V0MrN/22z51qXZCql8lxQFct8NG2tvX0
X-Received: by 2002:a05:6000:2f84:b0:43b:40ef:5d1a with SMTP id ffacd0b85a97d-43b64240089mr1066767f8f.5.1773951971528;
        Thu, 19 Mar 2026 13:26:11 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:11 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 52/55] drivers: hv: dxgkrnl: Use pin_user_pages instead of get_user_pages for DMA accessible memory
Date: Thu, 19 Mar 2026 20:25:06 +0000
Message-ID: <20260319202509.63802-53-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9624-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 1E3242D23BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Pages, which are obtained by calling get_user_pages(), can be evicted from memory.
pin_user_pages() should be used for memory, which is accessed by DMA.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  2 +-
 drivers/hv/dxgkrnl/dxgvmbus.c   | 12 ++++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index cf946e476411..c94283b09fa1 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -882,7 +882,7 @@ struct dxgallocation *dxgallocation_create(struct dxgprocess *process)
 void dxgallocation_stop(struct dxgallocation *alloc)
 {
 	if (alloc->pages) {
-		release_pages(alloc->pages, alloc->num_pages);
+		unpin_user_pages(alloc->pages, alloc->num_pages);
 		vfree(alloc->pages);
 		alloc->pages = NULL;
 	}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 467e7707c8c7..abb6d2af89ac 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1457,6 +1457,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 	u64 *pfn;
 	u32 pages_to_send;
 	u32 i;
+	u32 gup_flags = FOLL_LONGTERM;
 	struct dxgglobal *dxgglobal = dxggbl();
 
 	/*
@@ -1475,12 +1476,15 @@ int create_existing_sysmem(struct dxgdevice *device,
 		ret = -ENOMEM;
 		goto cleanup;
 	}
-	ret1 = get_user_pages_fast((unsigned long)sysmem, npages, !read_only,
-				  dxgalloc->pages);
+	if (!read_only)
+		gup_flags |= FOLL_WRITE;
+	ret1 = pin_user_pages_fast((unsigned long)sysmem, npages, gup_flags,
+				   dxgalloc->pages);
 	if (ret1 != npages) {
 		DXG_ERR("get_user_pages_fast failed: %d", ret1);
-		if (ret1 > 0 && ret1 < npages)
-			release_pages(dxgalloc->pages, ret1);
+		if (ret1 > 0 && ret1 < npages) {
+			unpin_user_pages(dxgalloc->pages, ret1);
+		}
 		vfree(dxgalloc->pages);
 		dxgalloc->pages = NULL;
 		ret = -ENOMEM;

