Return-Path: <linux-hyperv+bounces-11497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +vEwLXwfImreSgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11497-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:59:40 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A9644301
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Jun 2026 02:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11497-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11497-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=microsoft.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C3E304E6E4
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2026 00:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819FE257ACF;
	Fri,  5 Jun 2026 00:57:40 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DFE24A076;
	Fri,  5 Jun 2026 00:57:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621060; cv=none; b=ruET6nhs4m8zKgGisGxelAiorK1w9zRqlHnYQXqRX2i+NPNo3XXnvTwqIcVyoP+MdgYh0hlIYZn9S3Yz8KHePxrG9ax4prnUqMRO99uv+AAZPe+CjaetlpTLwUosoYvxHAFy2rNp8MF55AgwyiyxA97oQ+Qo3PrWda8Sk2jy24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621060; c=relaxed/simple;
	bh=4sfAK9TIcQUN17kqynjYaQpFa0avRyhteNDPM6rE2rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra+qLFxQowzmChMdGqV+mYkjyxxQhsjxi/FHxcuzoNkIGxf40iplzHekCWN6U5GABDVlvNPiQXubRkM2X9/SQDYgAGJslfGe5JRe4Pcks/0zYkuPWT+DG+zPcRKuBMaHVxo3la+eSm4dFwz3zboGfUxVJee+w2e8gOO4lyil8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id EEB1520B716B; Thu,  4 Jun 2026 17:57:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EEB1520B716B
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
Subject: [PATCH net-next v12 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Thu,  4 Jun 2026 17:57:11 -0700
Message-ID: <20260605005717.2059954-3-longli@microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260605005717.2059954-1-longli@microsoft.com>
References: <20260605005717.2059954-1-longli@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	FORGED_SENDER(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:longli@microsoft.com,m:kotaranov@microsoft.com,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:jgg@ziepe.ca,m:leon@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:shradhagupta@linux.microsoft.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11497-lists,linux-hyperv=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B9A9644301

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
 .../net/ethernet/microsoft/mana/gdma_main.c   | 78 ++++++++++++++++++-
 drivers/net/ethernet/microsoft/mana/mana_en.c | 45 ++++++-----
 include/net/mana/gdma.h                       | 13 +++-
 3 files changed, 114 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 712a0881d720..786e1d4cd4fe 100644
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
 
@@ -232,6 +245,52 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
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
+	/* Cap to the same limit used by mana_probe() for port instantiation,
+	 * so MSI-X and queue budgeting matches the actual port count.
+	 */
+	if (num_ports > MAX_PORTS_IN_MANA_DEV)
+		num_ports = MAX_PORTS_IN_MANA_DEV;
+
+	/*
+	 * Adjust the per-vPort max queue count to allow dedicated
+	 * MSIx for each vPort. Prefer at least MANA_DEF_NUM_QUEUES,
+	 * but the hardware max (gc->max_num_queues) takes precedence.
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
+	dev_info(gc->dev, "MSI sharing mode %u max queues %u\n",
+		 gc->msi_sharing, gc->max_num_queues_vport);
+
 	return 0;
 }
 
@@ -1901,6 +1960,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
 		/* Need 1 interrupt for HWC */
 		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
 		min_irqs = 2;
+		gc->msi_sharing = true;
 	}
 
 	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
@@ -1979,6 +2039,8 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 
 	pci_free_irq_vectors(pdev);
 
+	bitmap_free(gc->msi_bitmap);
+	gc->msi_bitmap = NULL;
 	gc->max_num_msix = 0;
 	gc->num_msix_usable = 0;
 }
@@ -2018,6 +2080,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
+	err = mana_gd_detect_devices(pdev);
+	if (err)
+		goto destroy_hwc;
+
 	err = mana_gd_query_max_resources(pdev);
 	if (err)
 		goto destroy_hwc;
@@ -2028,9 +2094,15 @@ static int mana_gd_setup(struct pci_dev *pdev)
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
index ed60cc15fe78..3ec8e94e7c17 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1018,10 +1018,9 @@ static int mana_init_port_context(struct mana_port_context *apc)
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
@@ -1055,6 +1054,14 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
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
@@ -1188,11 +1195,10 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
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
@@ -1207,7 +1213,8 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	req.proto_minor_ver = proto_minor_ver;
 	req.proto_micro_ver = proto_micro_ver;
 
-	err = mana_send_request(ac, &req, sizeof(req), &resp, sizeof(resp));
+	err = gdma_mana_send_request(gc, &req, sizeof(req),
+				     &resp, sizeof(resp));
 	if (err) {
 		dev_err(dev, "Failed to query config: %d", err);
 		return err;
@@ -1241,8 +1248,6 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		*bm_hostmode = 0;
 
-	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
-
 	return 0;
 }
 
@@ -3208,6 +3213,8 @@ static int mana_init_port(struct net_device *ndev)
 	max_queues = min_t(u32, max_txq, max_rxq);
 	if (apc->max_queues > max_queues)
 		apc->max_queues = max_queues;
+	if (apc->max_queues > gc->max_num_queues_vport)
+		apc->max_queues = gc->max_num_queues_vport;
 
 	if (apc->num_queues > apc->max_queues)
 		apc->num_queues = apc->max_queues;
@@ -3478,7 +3485,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	int err;
 
 	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
-				 gc->max_num_queues);
+				 gc->max_num_queues_vport);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -3487,9 +3494,9 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
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
@@ -3753,13 +3760,18 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
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
@@ -3773,9 +3785,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
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


