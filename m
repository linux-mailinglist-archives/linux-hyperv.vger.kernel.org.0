Return-Path: <linux-hyperv+bounces-11167-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFieDEYLEWohgwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11167-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:04:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1E5BC752
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 04:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 835BF301CCE9
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 May 2026 02:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96727BF79;
	Sat, 23 May 2026 02:03:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E1230BEC;
	Sat, 23 May 2026 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501796; cv=none; b=YRTBBQPOyrSE8+lpxFbloK2/fmpH15D/SJPgD9r/bWEo7bjnVcnnzQT92MC6pE+7VoJ6i/j7HiA139ZGNueQrqp+DJR5mi9711d+UjBTlNlb/87J8vxCvu+S8MsIcny7EVCBpk0F6vvYe1XD8sybHSus1+dyPeCdesMkcaahhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501796; c=relaxed/simple;
	bh=GH3t7Poja0Yvnu9tzPHLKtImggbUlduMiW3pBEJzcPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgAjX2L20fxZKnnoQjtsznyuJY/cOePM5Fk3WArPT6GsUe2MAu3YMlycf1xaxSdIfjKLklevJpAzMFCb5izn5U+iaoPWG8C3kLyaAqPvBkoVRKgzV57Y6KUrgr5E9n+BI5tdSKy3niE/rorKa0TlV2auA7d3YAcZTyaV5mJVDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id ADF2E20B7169; Fri, 22 May 2026 19:03:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADF2E20B7169
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
Subject: [PATCH net-next v11 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Fri, 22 May 2026 19:02:52 -0700
Message-ID: <20260523020258.1107742-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260523020258.1107742-1-longli@microsoft.com>
References: <20260523020258.1107742-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	TAGGED_FROM(0.00)[bounces-11167-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.564];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: C2F1E5BC752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Clamp apc->max_queues to gc->max_num_queues_vport in mana_init_port()
so that on resume, if max_num_queues_vport has decreased due to fewer
MSI-X vectors, num_queues is reduced accordingly before EQ allocation.

A device reporting zero ports now results in a fatal probe error since
the per-vPort MSI-X math requires at least one port.

Rename mana_query_device_cfg() to mana_gd_query_device_cfg() as it is
used at GDMA device probe time for querying device capabilities.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 71 ++++++++++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 45 +++++++-----
 include/net/mana/gdma.h                       | 13 +++-
 3 files changed, 107 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 712a0881d720..e31eeca3563d 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -179,8 +179,21 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
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
+	 * not before. Only reset on platforms that support dynamic
+	 * MSI-X allocation; on non-dyn platforms msi_sharing is
+	 * unconditionally true (set in mana_gd_setup_hwc_irqs).
+	 */
+	if (pci_msix_can_alloc_dyn(to_pci_dev(gc->dev)))
+		gc->msi_sharing = false;
+
 	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
 			     sizeof(req), sizeof(resp));
 
@@ -232,6 +245,45 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	debugfs_create_u32("max_num_queues", 0400, gc->mana_pci_debugfs,
 			   &gc->max_num_queues);
 
+	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION,
+				       MANA_MINOR_VERSION,
+				       MANA_MICRO_VERSION,
+				       &num_ports, &bm_hostmode);
+	if (err)
+		return err;
+
+	if (!num_ports) {
+		dev_err(gc->dev, "Failed to detect any vPort\n");
+		return -EINVAL;
+	}
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
 
@@ -1901,6 +1953,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
 		/* Need 1 interrupt for HWC */
 		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
 		min_irqs = 2;
+		gc->msi_sharing = true;
 	}
 
 	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
@@ -1979,6 +2032,8 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 
 	pci_free_irq_vectors(pdev);
 
+	bitmap_free(gc->msi_bitmap);
+	gc->msi_bitmap = NULL;
 	gc->max_num_msix = 0;
 	gc->num_msix_usable = 0;
 }
@@ -2018,6 +2073,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
+	err = mana_gd_detect_devices(pdev);
+	if (err)
+		goto destroy_hwc;
+
 	err = mana_gd_query_max_resources(pdev);
 	if (err)
 		goto destroy_hwc;
@@ -2028,9 +2087,15 @@ static int mana_gd_setup(struct pci_dev *pdev)
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
index 7c776f115f5a..571648007378 100644
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
 
@@ -3184,6 +3189,8 @@ static int mana_init_port(struct net_device *ndev)
 	max_queues = min_t(u32, max_txq, max_rxq);
 	if (apc->max_queues > max_queues)
 		apc->max_queues = max_queues;
+	if (apc->max_queues > gc->max_num_queues_vport)
+		apc->max_queues = gc->max_num_queues_vport;
 
 	if (apc->num_queues > apc->max_queues)
 		apc->num_queues = apc->max_queues;
@@ -3442,7 +3449,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	int err;
 
 	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
-				 gc->max_num_queues);
+				 gc->max_num_queues_vport);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -3451,9 +3458,9 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
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
@@ -3717,13 +3724,18 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
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
@@ -3737,9 +3749,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		enable_work(&ac->link_change_work);
 	}
 
-	if (ac->num_ports == 0)
-		dev_err(dev, "Failed to detect any vPort\n");
-
 	if (ac->num_ports > MAX_PORTS_IN_MANA_DEV)
 		ac->num_ports = MAX_PORTS_IN_MANA_DEV;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 70d62bc32837..145cc59dfc19 100644
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
@@ -447,6 +449,12 @@ struct gdma_context {
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
@@ -1019,4 +1027,7 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
+			     u32 proto_minor_ver, u32 proto_micro_ver,
+			     u16 *max_num_vports, u8 *bm_hostmode);
 #endif /* _GDMA_H */
-- 
2.43.0


