Return-Path: <linux-hyperv+bounces-11633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QNZnA31xM2p/BgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11633-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:18:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3BE69D796
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 06:18:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V2voVSjV;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11633-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11633-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794AA303183C
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2026 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941143749FF;
	Thu, 18 Jun 2026 04:18:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677D135C19D
	for <linux-hyperv@vger.kernel.org>; Thu, 18 Jun 2026 04:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756280; cv=none; b=c8wtd6r8wIJYbPxNjjtq/551Z1vni7LiCsaSqVeL2HsT7wCG+YQjB1rS3lHoCeBYfaPnYtFYIxMc6EREUllvBTYPyP8XxVZox/xlv+U8oi4n21zqnIONYzie3EwDaUOS4qVChZy5Ddx8eOWkADf4e6trkeTy7t3bal+G4j2PeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756280; c=relaxed/simple;
	bh=6u7Foak+HYm4YNvp1NSRBYj8EWhdk24OG4yFL6eNabw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPfdCcXoOb1mMnNrlAf5+LJZrpaTBErqzNItV8CxNnAcd2312V8AykGf2Qc0bcnoS555Ntlu2mxIl7G9vSmf2P4HD/mY7Zb+lxm8GPxcW+EBUOsbQymU1SOphAdNWrdqQe2rjVmnamsQK3SWIWDTKFxDCixRFq6/1WEvCi+R5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2voVSjV; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso3018925ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Jun 2026 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781756279; x=1782361079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9+4F23nRXmvcstAl7PKXowIyLqfAAv72bfzi1AI54M=;
        b=V2voVSjVhcJsGM1w7okvlUvaRkQ7ZDnGNsT/x4sH6xvGLt02Eb5WCfof7XEOB7uRpR
         KPggH+wC8UwcN3LpqZRdEAOhXH77QMOHdOxGVFuhRjxiBIKU8ZnGYEjDalB0RouwWBaX
         qBQ1eKq8Axs7V1dnb9hfG+0dIBsS7X+gu74hncFa+GXL3m16kMwSDnUlAJmRrRKgy4hj
         czC1LiDGbnJ9+Qnjxvl0Q34VYuz6e1KqZglwVl+OPcXRvJNbMekzNafHYQkwceJg2kCK
         xBvEER1joSNQUbRAe6T7a+n/Swyr7lcChop7CS9szrucXsALHLOdI9hc2W+WtsRJFh/z
         ZrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781756279; x=1782361079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+4F23nRXmvcstAl7PKXowIyLqfAAv72bfzi1AI54M=;
        b=DEsIvH34wB25IRcR7hwGa47k4SlgyQQ5VOcBBOXBjExKHF1vALhd97fnNUle6eTBa5
         lzhAxQTKcDxFpfO1LHM1PD+rV3TyKAyFdexqDF1xmQonTwFHQ8l33/Z1tbNn/Sx8aMys
         8U0PKnnvYOhlQ5Or1eWd5HpeWJEz8SDeor4g8lxWRoHzm2Ki92IxB7XXSnKM3AGjcxdf
         hZGfAQ+9c+phxzNVaF7rSzsvZda4Wab9tBxtDKPiZQeqNu2KGRHEwQYVsbeXJWjxfjyO
         pdTZoRuuzJ71qmm0FrPe0/O/RMyhcNZjQ3Z+ZI2dnZa7WUlGjerR362qoZm44d+f80Ok
         numQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DsHnST0uaw58RtDbG0a0rdxaYdIs0ubMAc16xZdBuauuUwOw5UF8ckZrTod2NvrjmK1t1Z0toecSos9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7NdxtcdDzYfv2qB891MM27tidohzinJcTAzbgjT0zmGGxrpv
	4XtzJiz1WING/8wai6kLwwu7u0w9FBAitC3hXkVRHKU8q/y+NLA1dTyL
X-Gm-Gg: AfdE7ckxgkKljU+aTh5Oh9RPOPS9QEHFkY5AuxD2aakjs0uj76c9gNWnPtI53M/wWG2
	cGko+Dr6T9al/7RPDc8jGpSPSb91m2MPkSBT1uHzwmLEph7+MsEHGk7R4kneWuSvGcM/GztKxrP
	Shw+mwDujfAtWglHyHSDm/vbR6FkFRhs7sIrz/RsdEtuSTVMYcIo7+zFFnbyxfhSTmm4G//iXwP
	hCYBCx2c06nJOTTb+LaHd/yQTdBIeKxMWyWTvrzS1qWC9t6KF6ko8yT+ZXvfOl0eevQGx5l3fB+
	03mKg+yx0cChnh/CNkooY51xKLSNemMdU3G7nyrH+CtjJ/MrxH6JuqMDTIqc2xs2zd9njNgyRaT
	x32AHZ/TvwsC01LXNDdVUuECkOd/JJesYpJTnNTSUoIbcieIxYocdDBfjH/uwpoQrM1Q9x2HUza
	UdUEL3cR1mPB5cgWbqUO0jDV7CMEeH57+ygj8/LwF0stc=
X-Received: by 2002:a17:902:e54a:b0:2c2:2a8a:af69 with SMTP id d9443c01a7336-2c6bc0c4a66mr66215135ad.9.1781756278676;
        Wed, 17 Jun 2026 21:17:58 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:c19d:3f9a:e9ce:93d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6c4689ccfsm34516645ad.66.2026.06.17.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:17:58 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2 1/2] RDMA/erdma: initialize ret for empty receive WR lists
Date: Thu, 18 Jun 2026 12:17:51 +0800
Message-ID: <20260618041752.481193-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,microsoft.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11633-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C3BE69D796

erdma_post_recv() returns ret after walking the receive work request list.
If the caller passes an empty list, the loop is skipped and ret is not
assigned.

Initialize ret to 0 so an empty receive work request list returns success
instead of stack data.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Split the erdma and mana_ib changes into separate patches.
- Add a driver-specific Fixes tag.

 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 25f6c49aec779..e002343832f74 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 	const struct ib_recv_wr *wr = recv_wr;
 	struct erdma_qp *qp = to_eqp(ibqp);
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&qp->lock, flags);
 
-- 
2.51.0

