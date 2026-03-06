Return-Path: <linux-hyperv+bounces-9176-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LFnHbJIq2lcbwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9176-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:35:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F8228087
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D65306F946
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D848C8AF;
	Fri,  6 Mar 2026 21:33:32 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A5481FA0;
	Fri,  6 Mar 2026 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832811; cv=none; b=cqawdU2bo1nrJfVXAKBE8Jy3pYuy+dz2TGx7dmdHjskdv0TbFUKYOx+OdlLBDU/ubfRSfsi9BRSmNLnHQRMI3OX3xZx3hLvVeeWhVw/5Ekpf0ksuPnQx6t5qARVi7wyH98QovRj9YKjl6+M0jJ62wlB5+U2ObRLPZOJ9pFoK7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832811; c=relaxed/simple;
	bh=NHuaQiTzSmO3g4EAar1A6/M/PbC/7TvQgP1OBcPdmcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gddwgaS6Ubv7ti4U1UYL8AypMFbycw9b2BKxR91Rmrg5sIaTI2zVjfBPdzxhc2HCFQZG0NNyX/zr/gl97/kTKXfktykT8hXudhgi8Qpyge7FezIoJW9EBc8E4JJ8O/GcICX+dJajvE5sN/3ZmkHRAFJV5uuUO1xngEYxtH2ciVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 3489220B6F04; Fri,  6 Mar 2026 13:33:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3489220B6F04
From: Long Li <longli@microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH net-next v3 6/6] RDMA/mana_ib: Allocate interrupt contexts on EQs
Date: Fri,  6 Mar 2026 13:33:02 -0800
Message-ID: <20260306213302.544681-7-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260306213302.544681-1-longli@microsoft.com>
References: <20260306213302.544681-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E65F8228087
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-9176-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.405];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Use the GIC functions to allocate interrupt contexts for RDMA EQs. These
interrupt contexts may be shared with Ethernet EQs when MSI-X vectors
are limited.

The driver now supports allocating dedicated MSI-X for each EQ. Indicate
this capability through driver capability bits.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/infiniband/hw/mana/main.c | 33 ++++++++++++++++++++++++++-----
 include/net/mana/gdma.h           |  7 +++++--
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
index d51dd0ee85f4..0b74dd093b41 100644
--- a/drivers/infiniband/hw/mana/main.c
+++ b/drivers/infiniband/hw/mana/main.c
@@ -787,6 +787,7 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
 	struct gdma_queue_spec spec = {};
+	struct gdma_irq_context *gic;
 	int err, i;
 
 	spec.type = GDMA_EQ;
@@ -797,9 +798,15 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.log2_throttle_limit = LOG2_EQ_THROTTLE;
 	spec.eq.msix_index = 0;
 
+	gic = mana_gd_get_gic(gc, false, &spec.eq.msix_index);
+	if (!gic)
+		return -ENOMEM;
+
 	err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->fatal_err_eq);
-	if (err)
+	if (err) {
+		mana_gd_put_gic(gc, false, 0);
 		return err;
+	}
 
 	mdev->eqs = kzalloc_objs(struct gdma_queue *,
 				 mdev->ib_dev.num_comp_vectors);
@@ -810,31 +817,47 @@ int mana_ib_create_eqs(struct mana_ib_dev *mdev)
 	spec.eq.callback = NULL;
 	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		spec.eq.msix_index = (i + 1) % gc->num_msix_usable;
+
+		gic = mana_gd_get_gic(gc, false, &spec.eq.msix_index);
+		if (!gic) {
+			err = -ENOMEM;
+			goto destroy_eqs;
+		}
+
 		err = mana_gd_create_mana_eq(mdev->gdma_dev, &spec, &mdev->eqs[i]);
-		if (err)
+		if (err) {
+			mana_gd_put_gic(gc, false, spec.eq.msix_index);
 			goto destroy_eqs;
+		}
 	}
 
 	return 0;
 
 destroy_eqs:
-	while (i-- > 0)
+	while (i-- > 0) {
 		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+		mana_gd_put_gic(gc, false, (i + 1) % gc->num_msix_usable);
+	}
 	kfree(mdev->eqs);
 destroy_fatal_eq:
 	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+	mana_gd_put_gic(gc, false, 0);
 	return err;
 }
 
 void mana_ib_destroy_eqs(struct mana_ib_dev *mdev)
 {
 	struct gdma_context *gc = mdev_to_gc(mdev);
-	int i;
+	int i, msi;
 
 	mana_gd_destroy_queue(gc, mdev->fatal_err_eq);
+	mana_gd_put_gic(gc, false, 0);
 
-	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++)
+	for (i = 0; i < mdev->ib_dev.num_comp_vectors; i++) {
 		mana_gd_destroy_queue(gc, mdev->eqs[i]);
+		msi = (i + 1) % gc->num_msix_usable;
+		mana_gd_put_gic(gc, false, msi);
+	}
 
 	kfree(mdev->eqs);
 }
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 4e0278b00bbb..662e58f51e87 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -612,6 +612,7 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_GDMA_PAGES_4MB_1GB_2GB BIT(4)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
+#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
 
 /* Driver can handle holes (zeros) in the device list */
 #define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
@@ -628,7 +629,8 @@ enum {
 /* Driver detects stalled send queues and recovers them */
 #define GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY BIT(18)
 
-#define GDMA_DRV_CAP_FLAG_1_HW_VPORT_LINK_AWARE BIT(6)
+/* Driver supports separate EQ/MSIs for each vPort */
+#define GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT BIT(19)
 
 /* Driver supports linearizing the skb when num_sge exceeds hardware limit */
 #define GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE BIT(20)
@@ -656,7 +658,8 @@ enum {
 	 GDMA_DRV_CAP_FLAG_1_SKB_LINEARIZE | \
 	 GDMA_DRV_CAP_FLAG_1_PROBE_RECOVERY | \
 	 GDMA_DRV_CAP_FLAG_1_HANDLE_STALL_SQ_RECOVERY | \
-	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY)
+	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECOVERY | \
+	 GDMA_DRV_CAP_FLAG_1_EQ_MSI_UNSHARE_MULTI_VPORT)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
-- 
2.43.0


