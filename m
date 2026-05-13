Return-Path: <linux-hyperv+bounces-10874-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKf/Hon3BGoMRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10874-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:13:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D12553B511
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1B3F3064669
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DE53CB8F4;
	Wed, 13 May 2026 22:10:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4C3CAE95;
	Wed, 13 May 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778710209; cv=none; b=FuOlcRzFCF+5/ProTnUhjCz5/L+QqUIzFN/V7lOLOZxw12YW+pYpXlRGKV2biW38NWBR4yuhQnBajVOvkvW2b1doU45Q7I6Xp/qfags8z0N5WV4ebkFJFxyMeBz3SPAfqjc4EbUwS0sObTob6vyfZGrbDMuGdxDvTJfPjxCNf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778710209; c=relaxed/simple;
	bh=3McB6fs6Bh4jKYjvUbfQ8y1iVs2ZDKhkymVpBsRRdec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5Ncp9DRV+/hLg0xONm0e9KZune/GOXYOuXxdMhp4uxIB3FUjG+cu2aIEaJPMjblaK3Wr5PKHwo2H+FHuv1sd8Yeox05RM3OWq439ZtVqsP78yj1HJovQCFRNSzAQpfmx94SL2Ni4zS/uH3DkLYBn14c/aK7KFSrCK5X/JPQs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 0B71E20B7168; Wed, 13 May 2026 15:10:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B71E20B7168
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
	Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Wed, 13 May 2026 15:09:52 -0700
Message-ID: <20260513220956.402058-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260513220956.402058-1-longli@microsoft.com>
References: <20260513220956.402058-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D12553B511
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
	TAGGED_FROM(0.00)[bounces-10874-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.763];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When querying the device, adjust the max number of queues to allow
dedicated MSI-X vectors for each vPort. The per-vPort queue count is
clamped towards MANA_DEF_NUM_QUEUES but will not exceed the hardware
maximum reported by the device.

MSI-X sharing among vPorts is enabled when there are not enough MSI-X
vectors for dedicated allocation, or when the platform does not support
dynamic MSI-X allocation (in which case all vectors are pre-allocated
at probe time and sharing is always used). The msi_sharing flag is
reset at the top of mana_gd_query_max_resources() so it is recomputed
from current hardware state on each probe or resume cycle.

A device reporting zero ports now results in a fatal probe error since
the per-vPort MSI-X math requires at least one port.

Rename mana_query_device_cfg() to mana_gd_query_device_cfg() as it is
used at GDMA device probe time for querying device capabilities.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 66 ++++++++++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 40 ++++++-----
 include/net/mana/gdma.h                       | 13 +++-
 3 files changed, 100 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3bc3fff55999..bbd055849e36 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -179,8 +179,18 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_query_max_resources_resp resp = {};
 	struct gdma_general_req req = {};
+	unsigned int max_num_queues;
+	u8 bm_hostmode;
+	u16 num_ports;
 	int err;
 
+	/* Reset msi_sharing so it is recomputed from current hardware
+	 * state. On resume, num_online_cpus() or num_msix_usable may
+	 * have changed, making dedicated MSI-X feasible where it was
+	 * not before.
+	 */
+	gc->msi_sharing = false;
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
 			     sizeof(req), sizeof(resp));
 
@@ -227,6 +237,43 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues == 0)
 		return -ENOSPC;
 
+	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION,
+				       MANA_MINOR_VERSION,
+				       MANA_MICRO_VERSION,
+				       &num_ports, &bm_hostmode);
+	if (err)
+		return err;
+
+	if (!num_ports)
+		return -EINVAL;
+
+	/*
+	 * Adjust the per-vPort max queue count to allow dedicated
+	 * MSIx for each vPort. Clamp to no less than MANA_DEF_NUM_QUEUES.
+	 */
+	max_num_queues = (gc->num_msix_usable - 1) / num_ports;
+	max_num_queues = rounddown_pow_of_two(max(max_num_queues, 1U));
+	if (max_num_queues < MANA_DEF_NUM_QUEUES)
+		max_num_queues = MANA_DEF_NUM_QUEUES;
+
+	/*
+	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
+	 * Ethernet EQs when (max_num_queues * num_ports > num_msix_usable - 1).
+	 */
+	max_num_queues = min(gc->max_num_queues, max_num_queues);
+	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
+		gc->msi_sharing = true;
+
+	/* If MSI is shared, use max allowed value */
+	if (gc->msi_sharing)
+		gc->max_num_queues_vport = min(gc->num_msix_usable - 1,
+					       gc->max_num_queues);
+	else
+		gc->max_num_queues_vport = max_num_queues;
+
+	dev_info(gc->dev, "MSI sharing mode %d max queues %d\n",
+		 gc->msi_sharing, gc->max_num_queues);
+
 	return 0;
 }
 
@@ -1889,6 +1936,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
 		/* Need 1 interrupt for HWC */
 		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
 		min_irqs = 2;
+		gc->msi_sharing = true;
 	}
 
 	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
@@ -1967,6 +2015,8 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 
 	pci_free_irq_vectors(pdev);
 
+	bitmap_free(gc->msi_bitmap);
+	gc->msi_bitmap = NULL;
 	gc->max_num_msix = 0;
 	gc->num_msix_usable = 0;
 }
@@ -2001,6 +2051,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
+	err = mana_gd_detect_devices(pdev);
+	if (err)
+		goto destroy_hwc;
+
 	err = mana_gd_query_max_resources(pdev);
 	if (err)
 		goto destroy_hwc;
@@ -2011,9 +2065,15 @@ static int mana_gd_setup(struct pci_dev *pdev)
 		goto destroy_hwc;
 	}
 
-	err = mana_gd_detect_devices(pdev);
-	if (err)
-		goto destroy_hwc;
+	if (!gc->msi_sharing) {
+		gc->msi_bitmap = bitmap_zalloc(gc->num_msix_usable, GFP_KERNEL);
+		if (!gc->msi_bitmap) {
+			err = -ENOMEM;
+			goto destroy_hwc;
+		}
+		/* Set bit for HWC */
+		set_bit(0, gc->msi_bitmap);
+	}
 
 	dev_dbg(&pdev->dev, "mana gdma setup successful\n");
 	return 0;
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index f1f6f7940b61..3ee74e7e300c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1007,10 +1007,9 @@ static int mana_init_port_context(struct mana_port_context *apc)
 	return !apc->rxqs ? -ENOMEM : 0;
 }
 
-static int mana_send_request(struct mana_context *ac, void *in_buf,
-			     u32 in_len, void *out_buf, u32 out_len)
+static int gdma_mana_send_request(struct gdma_context *gc, void *in_buf,
+				  u32 in_len, void *out_buf, u32 out_len)
 {
-	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct gdma_resp_hdr *resp = out_buf;
 	struct gdma_req_hdr *req = in_buf;
 	struct device *dev = gc->dev;
@@ -1044,6 +1043,14 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
 	return 0;
 }
 
+static int mana_send_request(struct mana_context *ac, void *in_buf,
+			     u32 in_len, void *out_buf, u32 out_len)
+{
+	struct gdma_context *gc = ac->gdma_dev->gdma_context;
+
+	return gdma_mana_send_request(gc, in_buf, in_len, out_buf, out_len);
+}
+
 static int mana_verify_resp_hdr(const struct gdma_resp_hdr *resp_hdr,
 				const enum mana_command_code expected_code,
 				const u32 min_size)
@@ -1177,11 +1184,10 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
 			   err, resp.hdr.status);
 }
 
-static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
-				 u32 proto_minor_ver, u32 proto_micro_ver,
-				 u16 *max_num_vports, u8 *bm_hostmode)
+int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
+			     u32 proto_minor_ver, u32 proto_micro_ver,
+			     u16 *max_num_vports, u8 *bm_hostmode)
 {
-	struct gdma_context *gc = ac->gdma_dev->gdma_context;
 	struct mana_query_device_cfg_resp resp = {};
 	struct mana_query_device_cfg_req req = {};
 	struct device *dev = gc->dev;
@@ -1196,7 +1202,8 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	req.proto_minor_ver = proto_minor_ver;
 	req.proto_micro_ver = proto_micro_ver;
 
-	err = mana_send_request(ac, &req, sizeof(req), &resp, sizeof(resp));
+	err = gdma_mana_send_request(gc, &req, sizeof(req),
+				     &resp, sizeof(resp));
 	if (err) {
 		dev_err(dev, "Failed to query config: %d", err);
 		return err;
@@ -1230,8 +1237,6 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		*bm_hostmode = 0;
 
-	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
-
 	return 0;
 }
 
@@ -3416,7 +3421,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	int err;
 
 	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
-				 gc->max_num_queues);
+				 gc->max_num_queues_vport);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -3425,9 +3430,9 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc = netdev_priv(ndev);
 	apc->ac = ac;
 	apc->ndev = ndev;
-	apc->max_queues = gc->max_num_queues;
+	apc->max_queues = gc->max_num_queues_vport;
 	/* Use MANA_DEF_NUM_QUEUES as default, still honoring the HW limit */
-	apc->num_queues = min(gc->max_num_queues, MANA_DEF_NUM_QUEUES);
+	apc->num_queues = min(gc->max_num_queues_vport, MANA_DEF_NUM_QUEUES);
 	apc->tx_queue_size = DEF_TX_BUFFERS_PER_QUEUE;
 	apc->rx_queue_size = DEF_RX_BUFFERS_PER_QUEUE;
 	apc->port_handle = INVALID_MANA_HANDLE;
@@ -3691,13 +3696,18 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
 
-	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
-				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
+	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION,
+				       MANA_MINOR_VERSION,
+				       MANA_MICRO_VERSION,
+				       &num_ports, &bm_hostmode);
 	if (err)
 		goto out;
 
 	ac->bm_hostmode = bm_hostmode;
 
+	debugfs_create_u16("adapter-MTU", 0400,
+			   gc->mana_pci_debugfs, &gc->adapter_mtu);
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 	} else {
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 6d836060976a..9c05b1e15c3e 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -399,8 +399,10 @@ struct gdma_context {
 	struct device		*dev;
 	struct dentry		*mana_pci_debugfs;
 
-	/* Per-vPort max number of queues */
+	/* Hardware max number of queues */
 	unsigned int		max_num_queues;
+	/* Per-vPort max number of queues */
+	unsigned int		max_num_queues_vport;
 	unsigned int		max_num_msix;
 	unsigned int		num_msix_usable;
 	struct xarray		irq_contexts;
@@ -446,6 +448,12 @@ struct gdma_context {
 	struct workqueue_struct *service_wq;
 
 	unsigned long		flags;
+
+	/* Indicate if this device is sharing MSI for EQs on MANA */
+	bool msi_sharing;
+
+	/* Bitmap tracks where MSI is allocated when it is not shared for EQs */
+	unsigned long *msi_bitmap;
 };
 
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
@@ -1018,4 +1026,7 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
+			     u32 proto_minor_ver, u32 proto_micro_ver,
+			     u16 *max_num_vports, u8 *bm_hostmode);
 #endif /* _GDMA_H */
-- 
2.43.0


