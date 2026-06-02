Return-Path: <linux-hyperv+bounces-11451-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tK3MNdj9Hmr6bwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11451-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 17:59:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3617E630085
	for <lists+linux-hyperv@lfdr.de>; Tue, 02 Jun 2026 17:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=D0wZVm+y;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11451-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11451-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD0EB309E548
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Jun 2026 15:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0ED3F1ACE;
	Tue,  2 Jun 2026 15:52:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BB3E5A2E
	for <linux-hyperv@vger.kernel.org>; Tue,  2 Jun 2026 15:52:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415534; cv=none; b=hzv9LcSZGmXBTX9jh3KqwQF0Rnz/KIBgbyYbWW/bJ2rYwOLfvvKBicBX54CDfJy/Zvl2iXd2oEGfpxhvwsnYghiZpIpSA46s4csJ0O9gnQSTlGjCI/whlD+9l/8CcehXkAkQRsAQHjw2LRWstXZ7WG8RtpTF7WZFQRAVo79pmIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415534; c=relaxed/simple;
	bh=RAL3ZX7gX3Qwt4a6LoAFqg4/b9gWA2A+ezozkGYu5v4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fEZZZmSBbTHenFySDbrXi3z726I5/wgatE44j1pYfTc64w4ogHavh9NSTr8pYi79AAQneCSGEPnuMmEqvMVhvDz5GQTrI7m2VNigMAIVd7ZTg+c5hdMm/lBHmtP7CaKE/khrF1DwlglZKYBUV4GyzTETRxegX+g3cGtQ8jSWJL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wZVm+y; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso2216495e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Jun 2026 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415532; x=1781020332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=D0wZVm+yPCQCUkDlqARJFBllvw1zfPTP3YXy460qUBOs+SkuKaLPX0+4G2Fhj3UIE9
         +GVh0dZmh6tY0zokqQFa8q8y06ssjwhSTJQ5Xpf2rfMB5/EDHv2MnCg3EDg3grmEj01Q
         DU37Re78vyEQLlfePfrySp0K89hJ3JIekz2yXvBdsXsMsQ5EuTsnS2Z2kZtZrpiL3aQc
         0/S4/CHuNf93ZE/uEcP/aOLM4rpmKDkgVa+ueHsihYHhX8xLEr5NY10bG9MfrJwaQb9J
         DGbgiph62Mf48FlLvlYm8OFWqF2pSzVA6FmNglM5FLcs2mFMyP9r1fHY3Gh+MTVZCa7u
         MIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415532; x=1781020332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcSYq5CNRe914+kh+MhUoX6E3CbZbAlZ8MDYAoh0zI0=;
        b=CYU+KUHK6ifmPRL7b7dwjqacorJA3OzYJp3wo+qMStIzlQOFN31ELU8BNXQ6bp+BH8
         Vm2ywMwmT0Xkcs1mZU1jf47maHuH8XhKs9W/Z/36LyeXNt1v5K8T/uebZb6h7icp0R4r
         YXtzwwgRjmOWZJIO/CXWQo4dSU043tuDrfh74KyVM0PwVFfHKUIkOmqeqxsbZwRShK3e
         C5lPKiL1BV/7iU9kp3q0f6YDSMmO7TzyQAfG5YkyLz0VmCQqIrT2+o2xGNo9rw0Tvfwu
         DthT5ewxYUcM0R0gZDbv6ed3oz9rqc/Qe8dnnjw6NPtNxwkJlxfkITWeMAcnK8ZS70Lh
         ohqg==
X-Gm-Message-State: AOJu0YzcYRV+FzWm+x4C8Rtg3aDnyqmFeFM6zo+VA372vnGI68PE1d/4
	RlD+qWnq5dgpEv8z/wMvgvEBeBfZE4hg1x1ZNVxEqI+FgMuRt6jUcSqD
X-Gm-Gg: Acq92OFOPa0zkVOw7FqtkoDciYh1BPATJe7FHjLBysSY+69oqpbC7HD4t09XWLWQKLJ
	9sTKYN+SEs/n0WAH1XPgCoDtkTMaS8PWgI9nFf7dx+/tWrOBtHyUPjzwHWl+SiKG6S5PtJxeSPZ
	DfHO4Vs0LTHxIWCuXg2eQEy9gDCGeafipXm7TNWytDmanwLhKc5GkZOyr8BuE420R87s2ATdbtr
	/+7mhSz19lkAE05/iCKRSqGCOf9SwflSo40wa56Lk9kPWG4sJ0RGkwsVlJ7lb684BGxK2WJLOAl
	MaduDCtZi+7hDpIuTt0VSR6PqrSRrRWq4tRy/jbbIjnUPyOrPViMfoOniH6IYNoLVqRP+rtscX0
	qmq6+lLY6imzwReW6TUXQco434UR+MI34uXElijCaHmm169nf4VlJ7geMa3hLLLgjCA+aYabnkI
	nmGuk/6lL39zVpvy/leJtDASA3kgvM8Cn5pvEDc5a2LoiL1lqTrzl6Q8hRooytSNMxBg==
X-Received: by 2002:a05:600c:8b2e:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490b50c634cmr4713175e9.26.1780415531774;
        Tue, 02 Jun 2026 08:52:11 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b55fda1dsm108445e9.1.2026.06.02.08.52.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jun 2026 08:52:10 -0700 (PDT)
From: LeantionX <leontyevantony@gmail.com>
X-Google-Original-From: LeantionX <leontyevanton1995@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anton Leontev <leontyevantony@gmail.com>
Subject: [PATCH net] hv_netvsc: use kmap_local_page in netvsc_copy_to_send_buf
Date: Tue,  2 Jun 2026 18:52:10 +0300
Message-ID: <20260602155210.90987-1-leontyevanton1995@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11451-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:leontyevantony@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,lunn.ch,redhat.com,google.com,davemloft.net,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leontyevantony@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3617E630085

From: Anton Leontev <leontyevantony@gmail.com>

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

Map the fragment page on demand with kmap_local_page()/kunmap_local()
instead. Using pfn_to_page() on pb[i].pfn maps exactly the page
described by the page buffer entry. On configurations without HIGHMEM
(amd64, i386 without CONFIG_HIGHMEM) kmap_local_page() reduces to
page_address(), so this is a no-op there.

Fixes: c25aaf814a63 ("hyperv: Enable sendbuf mechanism on the send path")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Leontev <leontyevantony@gmail.com>
---
 drivers/net/hyperv/netvsc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 59e95341f9b1..6984f6c97257 100644
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
@@ -965,11 +966,13 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
 	}
 
 	for (i = 0; i < page_count; i++) {
-		char *src = phys_to_virt(pb[i].pfn << HV_HYP_PAGE_SHIFT);
+		struct page *page = pfn_to_page(pb[i].pfn);
+		char *src = kmap_local_page(page);
 		u32 offset = pb[i].offset;
 		u32 len = pb[i].len;
 
 		memcpy(dest, (src + offset), len);
+		kunmap_local(src);
 		dest += len;
 	}
 
-- 
2.43.0


