Return-Path: <linux-hyperv+bounces-9183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCIUJ92Dq2n/dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9183-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:48:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE2229749
	for <lists+linux-hyperv@lfdr.de>; Sat, 07 Mar 2026 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07FA3079C76
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Mar 2026 01:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EFD328273;
	Sat,  7 Mar 2026 01:47:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5550B3254B2;
	Sat,  7 Mar 2026 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772848054; cv=none; b=WZrbRfHAq0LkMLeZ12mqMMWRJEolX/0RuuWy40q368ewtC1HcHNslOtKAwPj6XxbRLmjIQW/9pwbn0iRFnxIdEwdE658bx3151IDGXGi5rdzUa+wI0d1xIeb8w0g/bNkvo8O0kR8ad/xUpJ8jzCV5mwdorpxTCg6j9UCSFZKjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772848054; c=relaxed/simple;
	bh=G5JUmQnoDfSaDwdB0ooqXdCrFcaPKNLXU+xVMpdoZEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CayPe1Faiq6o8cyFeZrojmEx5UTpXfrSrW8U2NggaiYp5zU1/GRn9fH0RkOQV9NQoIoDgXVusuXji+HRq8yPfEV6bqaZ4E2132eDf2ov2m+Pu35EE6ps+JUYNe60/2IGXW423R3Z+UrCVNywOWwW9SK+ZunDsC9H+luwMPcSf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 526C620B6F02; Fri,  6 Mar 2026 17:47:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 526C620B6F02
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
Subject: [PATCH rdma-next 1/8] RDMA/mana_ib: Track ucontext per device
Date: Fri,  6 Mar 2026 17:47:15 -0800
Message-ID: <20260307014723.556523-2-longli@microsoft.com>
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
X-Rspamd-Queue-Id: 36BE2229749
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9183-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.699];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add per-device tracking of ucontext objects. Each ucontext is added
to the device's ucontext_list on allocation and removed on deallocation.
A mutex protects the list and a per-ucontext lock protects resource
lists that will be added in subsequent patches.

This enables iterating over all active ucontexts during service reset
cleanup.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/device.c  |  2 ++
 drivers/infiniband/hw/mana/main.c    | 10 ++++++++++
 drivers/infiniband/hw/mana/mana_ib.h |  6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/mana/device.c b/drivers/infiniband/hw/mana/device.c
index ccc2279ca63c..149e8d4d5b8e 100644
--- a/drivers/infiniband/hw/mana/device.c
+++ b/drivers/infiniband/hw/mana/device.c
@@ -132,6 +132,8 @@ static int mana_ib_probe(struct auxiliary_device *adev,
 	dev->ib_dev.dev.parent = gc->dev;
 	dev->gdma_dev = mdev;
 	xa_init_flags(&dev->qp_table_wq, XA_FLAGS_LOCK_IRQ);
+	mutex_init(&dev->ucontext_lock);
+	INIT_LIST_HEAD(&dev->ucontext_list);
 
 	if (mana_ib_is_rnic(dev)) {
 		dev->ib_dev.phys_port_cnt = 1;
diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index 8d99cd00f002..fc28bdafcfd6 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -221,6 +221,12 @@ int mana_ib_alloc_ucontext(struct ib_ucontext *ibcontext,
 
 	ucontext->doorbell = doorbell_page;
 
+	mutex_init(&ucontext->lock);
+
+	mutex_lock(&mdev->ucontext_lock);
+	list_add_tail(&ucontext->dev_list, &mdev->ucontext_list);
+	mutex_unlock(&mdev->ucontext_lock);
+
 	return 0;
 }
 
@@ -236,6 +242,10 @@ void mana_ib_dealloc_ucontext(struct ib_ucontext *ibcontext)
 	mdev = container_of(ibdev, struct mana_ib_dev, ib_dev);
 	gc = mdev_to_gc(mdev);
 
+	mutex_lock(&mdev->ucontext_lock);
+	list_del_init(&mana_ucontext->dev_list);
+	mutex_unlock(&mdev->ucontext_lock);
+
 	ret = mana_gd_destroy_doorbell_page(gc, mana_ucontext->doorbell);
 	if (ret)
 		ibdev_dbg(ibdev, "Failed to destroy doorbell page %d\n", ret);
diff --git a/drivers/infiniband/hw/mana/mana_ib.h b/drivers/infiniband/hw/mana/mana_ib.h
index a7c8c0fd7019..c7e333d3e9d8 100644
--- a/drivers/infiniband/hw/mana/mana_ib.h
+++ b/drivers/infiniband/hw/mana/mana_ib.h
@@ -83,6 +83,9 @@ struct mana_ib_dev {
 	struct dma_pool *av_pool;
 	netdevice_tracker dev_tracker;
 	struct notifier_block nb;
+	/* Protects ucontext_list */
+	struct mutex ucontext_lock;
+	struct list_head ucontext_list;
 };
 
 struct mana_ib_wq {
@@ -197,6 +200,9 @@ struct mana_ib_qp {
 struct mana_ib_ucontext {
 	struct ib_ucontext ibucontext;
 	u32 doorbell;
+	struct list_head dev_list;
+	/* Protects resource lists below */
+	struct mutex lock;
 };
 
 struct mana_ib_rwq_ind_table {
-- 
2.43.0


