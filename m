Return-Path: <linux-hyperv+bounces-11467-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9t6gHadlIGq62gAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11467-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:34:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6263A2FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Jun 2026 19:34:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=asVgDDIE;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11467-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11467-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D8E1300981D
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jun 2026 17:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30644A71C;
	Wed,  3 Jun 2026 17:25:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FBB3E5A12
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jun 2026 17:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507543; cv=none; b=ECYByL+KYB6T/uo2V7zx7V+GY2U/auIMmwYXvxqSULxaBdOFSQA5SKog32fjjcZuJx7SlwyYRD7VfCbN5kXEyXrA8ieDfdDoZClE6t9ByxPTA98mBYmmONBOGprdAky4hsh9ZfoulV7Bz8nEXAt9sDxWvkvZnKnz6FCjbF8rQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507543; c=relaxed/simple;
	bh=K/YVSy3Jio3EDLqXiV7+CBIoj59O3grDjIPmiQ+k2Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+vJpnvfptuaC6Iy+NuiUnfDRoq4x4POrOoIKH4TciFyVhBgOmVSgZfl9NLNSwJGPb9psueUW+lkE8J+jtS1bYM0RtbDK6nh+8lg+uUQ/7wY9Bcqa44XsYISqqWr/9xOw2pEFbDy5ok5Aq8AyW4Gognqh9zwlaXlg5Nge9findM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asVgDDIE; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46015dc517aso2769861f8f.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jun 2026 10:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780507540; x=1781112340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=asVgDDIEl/hUus8pyxQZJv54iYTduyujs1d8MjDzV4ySec94yjEROB7Xu2yukq+iYG
         FhsyScXHft/XuY4mw/OxxYdhFcO02RJojJi6wi8dpRn5bAx7wFSCbm0zOGsvMBh+RPlG
         nVpPcCdmMw7Au1hnRXiux6fquozCE/+MxxHGL5c94zmLvq3Ja22mNOn7n4Lpo7AGUZzB
         g7OB1vcibCoVqS97d+TO58mcsujD46ExP5pyq1M9ZqRHxW1PP0c8FU5nTZfGWkOvICh1
         CzjqAPQMMrD+aLLCmyyVlI08xp4ofePza/iiDlw3z3fPKjBZrAf9LAJDJz713a/DOCKC
         5cgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507540; x=1781112340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=259LrnAOdGfiedRDzKiXBqB7ciLo61uHaIr6D3LBW08=;
        b=nte36ZwzcrNoDMBDxdE41ZKJv5NhFlXlh1KjI3mTnhd/l7fQroXEA8R/CnLiPlpwtN
         6ZZgd9OuOISK9u10eYJkZOwuQxLrnBwP5tQ8KPo7F2kpHrcwR4JgXh8Rinsc2tLx4jMu
         ewzw+R6ALaJHAUIovYiszi3m8EMXQopOW/Cyxv+QZs7TS4WuhG36mjIDHaBzy3tkM4Gh
         NrvsOaiKaSMUGk0JGCt2fTDEz9ZxDecp7WwH1ijDd4DCTkmMm5WAVPqln/gG6EPBsPEa
         6AESawj8V94ke96vuT+RfXHolzs5najVJPv5nFh2QPG1JbhYsyjelNzTpkBUwcI7yYfY
         wB1A==
X-Gm-Message-State: AOJu0YyvG09IXh2vYi7KOolLbbNVxoUk6txffKOP9Y0vTfpx3/LBZHH+
	3pvyyfqWuDHT7txqUE0lZqR+TTLgQP19ngbycLMJ4JIjKJilFqAU+sKr
X-Gm-Gg: Acq92OEWIb8iYUXDLRF+Ii7Aiz4j7l4kvY9bWcLESXAp72dfXnpPVuWfLkPIeLUkccm
	7cOpWlGRtdDyCxJ2MkZD3AlzHuYeokr85IYSLcREtyQVooDLwLHc02woGiF37us+QwHP0r7cxOw
	a28Qg/0I0o4PtNSLayfBjhk3+eCmPZNjsj4vI7uk5tkjGCxA8uuDcOb0U2+kZtAMUDEuFMaolYD
	fnwoMHe5mHzm+2jq4aHjiwD95vpkKScHbw66nLBRcqHY09Me1h6aV7GrPZ6tL4Y6k6bMQYgVc8P
	sbxXXw6DVFcO0IQATFWOTe2GOvvBGL5UzJAqcpU1aslvtLHb9UZXl9LOrYxJRVvO+OD2wyufUkR
	OERgBgL22hYtZbPTptWev6eX8C4g8Bphpn+O+lvce3m3jvfQg54jr9ejpggvBmxO1p+9J4qzY1D
	MR83mpYyc5PMmW1OkLC9MkAXOgvbMgi8cuTtbAWUFvhohM4TTroTV+LV7o/SPCBQ==
X-Received: by 2002:adf:f8ca:0:b0:45e:ea46:ce13 with SMTP id ffacd0b85a97d-460217a5a76mr4654078f8f.10.1780507540027;
        Wed, 03 Jun 2026 10:25:40 -0700 (PDT)
Received: from localhost.localdomain ([5.165.242.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d40sm9071573f8f.26.2026.06.03.10.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Jun 2026 10:25:39 -0700 (PDT)
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
Date: Wed,  3 Jun 2026 20:25:43 +0300
Message-ID: <20260603172543.19230-1-leontyevantony@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11467-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADF6263A2FA

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


