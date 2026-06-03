Return-Path: <linux-hyperv+bounces-11466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WcmVMFxeIGoQ2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11466-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:03:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B923963A02B
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R1ob+GOF;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11466-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11466-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF2D1304F532
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 16:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE373D905D;
	Wed,  3 Jun 2026 16:38:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A03E9595
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 16:38:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504737; cv=none; b=btS62XAu9ZGarrUxEsduKl+SSeTLyIwdoZrlQzrikbq0GiudRJoAhbfLYaMU5ZXBmExKzWamJhQrVCLRTmm+IuYNiP/9+/7vSFYox2E0aAUMT7Fo1CKKmsQVXzqCNJ3IjSRcy0rXkp7M2au+hw2rYffTpt6XNinQrAzpWD7t8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504737; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bja5zhiMJ0ZMOm1IoFItTkxNe7d74a2v41XtcjNEtuNCTHBEwLuBvNXcixZkfodddrrzJegVT8rRoej37U39sdTqlnNWXiFaL2W/d8kHFzQvz6rWcaJBDBTMJcBHyAIzQ3OtKTD1PwNtX9szNG5ikhMAS+148AZ3jZPyKMgshiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ob+GOF; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so4348270f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jun 2026 09:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780504733; x=1781109533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=R1ob+GOFGbA8grfK3rS3WPnissX1XhOAzMRICSepyUSuJdAunS4UUXyFfJwrxaMdxo
         q7x8Rz62nl3ubmIJPrSesQ4BobY0rjmj/JpJriPh5kvAyl9VPt7Xam0dN0SlIwhKApUM
         0/hBuRyfoAL1vWEcEJTvIALrWSOd0ERA+V47GQs+abXl8jkuoOfr0pezZXy2mw79Qi/A
         h0FigVtwIJ4630Bm55J/TWp9YsDEH/cbP9Tm3YPXEQQ7Kr36uceOEc+NK8Vs2BZ/83AV
         /hFPt3RtoMRLvmG2tKn8GwlE/bLACN/5v9OOe74+I/LMjtYQfazKTJXGI3GttcPX7fGf
         qxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780504733; x=1781109533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=A4huxNYX9eCKezzeMtD6gPe4Un8EWOnM//Bd7NdO07x0GiCC7E/doX8PWCEnYo+0RA
         6S52e69me0sAd/TexkK4MLWUojQV5MQoL7QwgGYVlMXu38cOn3X6pUkgaEMV3KsBidCk
         9sMsSaoL0s06abCNjeAo7dk3tjln5dlFNS6p3jYXwLeAMrAk6btKPn0Q/u1NpFRFqGZQ
         40DWUBZ4LMgiAk+TOF96LlH+Pj6I7MNoFf+L53m2ikSYWYsDQTBXwhTtWRR9ERkLaTbq
         dZwTiuwOkeuZe1TASbG0OT6h6hWX6wBlAWese0/iVnzyF4FzF5h0GLxDxsPyY6OC0/9y
         JD5g==
X-Gm-Message-State: AOJu0Yy8pNJ/QzLuFvmTiPuNTtLpCBF6DbMUdsfeos/sjis8ZII+ScDM
	s61fzslhXPCqJ+CYvFacW38sxVjWKX2Q6colJS2aB1V383kXHCmojvva
X-Gm-Gg: Acq92OHZzvKYaaIkbzInsIyi8n7QCjk7gP82zrbknXGEFI4hOApGKBBPmgS2fxvKe8f
	LmK2Zt1ZpYoday4aB7Yn1JlRDA1Wvk5ziGAUszP3ec/uW8UxpvlrSX6/nfJaR0rYtJEbX9YYWDX
	3LJ508yC9kxcz6DTUlNcYhQDsEOrD4Vwiqi/Ukfx4kpH436qzEj5zAb72XxKTnOibmj5OJ6IQVi
	4+a7ar5QxfZyL1sA/FNndzjaNIBILhL/gN+JoRjzBfyHBFop8icMn+2zwjpRSe1xnxUCe06rPyn
	boc5gr7dEcXNypQ3u959h3C7Y/DtKSepiCnKlIthQlDVPu5TzpepMIBnJGB0Y18hwY4wkbLjab4
	nx5KqDa9AGuceWyr5jy1Gaf60z20XSiyhqsxWF6xBvxzQEt631f4u874hpre18U+SRWcEGeVQRE
	srci2DHFh+uyC6R4ODAUbAJeF67IizUijcQ6bXviCVOTzJMYF16i6EG3Ycni0WGLOK/x0OgBGL4
	pJu/g==
X-Received: by 2002:a05:600c:1c1e:b0:490:b00c:8e6a with SMTP id 5b1f17b1804b1-490b5fe65a6mr69071435e9.28.1780504731298;
        Wed, 03 Jun 2026 09:38:51 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a8632sm7261405e9.8.2026.06.03.09.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 09:38:50 -0700 (PDT)
From: Anton Leontev <leontyevantony@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net v2] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Wed,  3 Jun 2026 19:38:51 +0300
Message-ID: <20260603163851.18058-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602155210.90987-1-leontyevanton1995@gmail.com>
References: <20260602155210.90987-1-leontyevanton1995@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11466-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leontyevantony@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B923963A02B

netvsc_copy_to_send_buf() copies skb fragment pages into the shared
VMBus send buffer using phys_to_virt() on the fragment PFN. On 32-bit
x86 with CONFIG_HIGHMEM=y, phys_to_virt() (i.e. __va()) is only valid
for LOWMEM addresses below 896 MiB. For a HIGHMEM page it returns an
address that has no kernel page table entry and lies outside the
kernel direct map, so the subsequent memcpy() faults. As this happens
on the transmit softirq path, the fault is fatal.

A HIGHMEM fragment reaches this path whenever the page backing an skb
fragment lives above the LOWMEM boundary, which is common on a 32-bit
guest with several GiB of RAM (for example when the in-kernel NFS
server splices page cache pages directly into the reply skb).

pb[i].pfn is a Hyper-V PFN at HV_HYP_PAGE_SIZE (4K) granularity. The
physical address is reconstructed first and phys_to_page() is used to
obtain the native struct page, with offset_in_page() added so the
in-page offset stays correct where PAGE_SIZE > HV_HYP_PAGE_SIZE (e.g.
arm64 with 64K pages). The page is then mapped on demand with
kmap_local_page()/kunmap_local(). On !CONFIG_HIGHMEM configs
kmap_local_page() reduces to page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
v2:
 - Reconstruct the physical address from the Hyper-V PFN and use
   phys_to_page() + offset_in_page() instead of pfn_to_page() on the
   raw PFN, correct where PAGE_SIZE > 4K (e.g. arm64 64K pages).
   Reported by Haiyang Zhang.
 - Built for i386 (CONFIG_HIGHMEM) and arm64 (64K pages).
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..2038d9f5c9f9 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -965,11 +966,14 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
-		u32 offset = pb[i].offset;
+		phys_addr_t paddr = pb[i].pfn << HV_HYP_PAGE_SHIFT;
+		struct page *page = phys_to_page(paddr);
+		u32 offset = offset_in_page(paddr) + pb[i].offset;
 		u32 len = pb[i].len;
+		char *src = kmap_local_page(page);
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0


