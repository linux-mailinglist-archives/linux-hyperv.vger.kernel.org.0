Return-Path: <linux-hyperv+bounces-9184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPl5AdqDq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9184-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:48:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDF229739
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 443AC3052AC7
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374F3290BC;
	Sat,  7 Mar 2026 01:47:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D6326D5E;
	Sat,  7 Mar 2026 01:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848055; cv=none; b=s2GeOtIr69e/3yFHbHuSMZT7PwlZAGmOoJeZ1cOFzFD9OB2rRi8kt7lAYyCcFAAgn7c4Ppgdiw+vt7O7XDA+1d6T3h9/dOpVKLYgKkWodYu21V7dLAqlPFfOM5vDrnmF4r49Nhtlf7rSEFmG4kBy74sp83zKZbhzmePLpFGcUSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848055; c=relaxed/simple;
	bh=aYTEd3CmO8Tw/gVgrDcwvd9TdGAkXQIZw/u3qNWEaW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG+wHr6H4nsYN9jDIfpG3BaNpI06n8OLr33eeC7nWoEniZ6hS4URoOFtD9K1jiXbEethdVhNPrL3R15ruDAk71MybyBGd+2vnzMjObuERN6rqWEXDscd0+I9OXBGdCsFnGzrIyn/G8ogonCYGwTYnKQeN+L8iDbensn8FkmqsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 2FB3A20B6F0A; Fri,  6 Mar 2026 17:47:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2FB3A20B6F0A
From: Long Li <longli@microsoft.com>
To: Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 2/8] RDMA/mana_ib: Track PD per ucontext
Date: Fri,  6 Mar 2026 17:47:16 -0800
Message-ID: <20260307014723.556523-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260307014723.556523-1-longli@microsoft.com>
References: <20260307014723.556523-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DBDF229739
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9184-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.686];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-ucontext list tracking for PD objects. Each PD is added to
the ucontext's pd_list on creation and removed on destruction. This
enables iterating over all PDs belonging to a ucontext, which will
be needed for service reset cleanup.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c    | 21 +++++++++++++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index fc28bdafcfd6..62d89ca06ba1 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -72,6 +72,7 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	struct ib_device *ibdev = ibpd->device;
 	struct gdma_create_pd_resp resp = {};
 	struct gdma_create_pd_req req = {};
+	struct mana_ib_ucontext *mana_ucontext;
 	enum gdma_pd_flags flags = 0;
 	struct mana_ib_dev *dev;
 	struct gdma_context *gc;
@@ -107,6 +108,16 @@ int mana_ib_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	mutex_init(&pd->vport_mutex);
 	pd->vport_use_count = 0;
+
+	INIT_LIST_HEAD(&pd->ucontext_list);
+	if (udata) {
+		mana_ucontext = rdma_udata_to_drv_context(udata,
+					struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_add_tail(&pd->ucontext_list, &mana_ucontext->pd_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	return 0;
 }
 
@@ -123,6 +134,15 @@ int mana_ib_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	dev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(dev);
 
+	if (udata) {
+		struct mana_ib_ucontext *mana_ucontext =
+			rdma_udata_to_drv_context(udata,
+				struct mana_ib_ucontext, ibucontext);
+		mutex_lock(&mana_ucontext->lock);
+		list_del_init(&pd->ucontext_list);
+		mutex_unlock(&mana_ucontext->lock);
+	}
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_DESTROY_PD, sizeof(req),
 			     sizeof(resp));
 
@@ -222,6 +242,7 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 	ucontext->doorbell = doorbell_page;
 
 	mutex_init(&ucontext->lock);
+	INIT_LIST_HEAD(&ucontext->pd_list);
 
 	mutex_lock(&mdev->ucontext_lock);
 	list_add_tail(&ucontext->dev_list, &mdev->ucontext_list);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index c7e333d3e9d8..6dba08bccc18 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -107,6 +107,7 @@ struct mana_ib_pd {
 
 	bool tx_shortform_allowed;
 	u32 tx_vp_offset;
+	struct list_head ucontext_list;
 };
 
 struct mana_ib_av {
@@ -203,6 +204,7 @@ struct mana_ib_ucontext {
 	struct list_head dev_list;
 	/* Protects resource lists below */
 	struct mutex lock;
+	struct list_head pd_list;
 };
 
 struct mana_ib_rwq_ind_table {
-- 
2.43.0


