Return-Path: <linux-hyperv+bounces-9172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vJ44IkhIq2mSbwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9172-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:34:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC86227FDC
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E67E301E9BA
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF4E48124D;
	Fri,  6 Mar 2026 21:33:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCE34321A;
	Fri,  6 Mar 2026 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832805; cv=none; b=qJIzqMnWRyZNUQ/fpGictnv8zcwYK1oYitWsawTTyn09a9eZLKGJn1/b+vDgJ5FDwreXxAgTOTOmcyS6rpYI68LwfMO2i+ai3lt4PEf11sICL5ykN8q5a+NxPepjhVgPnaXl6DWZwGn5z/nN/H4NJtSnij6YO856S56m7AcTkro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832805; c=relaxed/simple;
	bh=hzaFmrHsP+JyCxT4s7QWdRkMB79x6tWS/bdgInZFzFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XMPrDhU1AwJKIStElfo5AdJItsdaR7wCq9BPy6veW2UwuLokP4VdsfeGKCEcgN95B+3LQEBsP4KKNwLkHg+rTQiNZ2C1uDp15iES34VQ1AfFTJ3CKth/VuZonv9I7iDLFgbjtoT6h5PJoUhrI+ClyjrdnrqwC0IpA96L3qGUY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id D828A20B6F09; Fri,  6 Mar 2026 13:33:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D828A20B6F09
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
Subject: [PATCH net-next v3 2/6] net: mana: Query device capabilities and configure MSI-X sharing for EQs
Date: Fri,  6 Mar 2026 13:32:58 -0800
Message-ID: <20260306213302.544681-3-longli@microsoft.com>
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
X-Rspamd-Queue-Id: 6AC86227FDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[microsoft.com : SPF not aligned (relaxed), No valid DKIM,reject];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9172-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.370];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[]
X-Rspamd-Action: no action

When querying the device, adjust the max number of queues to allow
dedicated MSI-X vectors for each vPort. The number of queues per vPort
is clamped to no less than 16. MSI-X sharing among vPorts is disabled
by default and is only enabled when there are not enough MSI-X vectors
for dedicated allocation.

Rename mana_query_device_cfg() to mana_gd_query_device_cfg() as it is
used at GDMA device probe time for querying device capabilities.

Signed-off-by: Long Li <longli@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 66 ++++++++++++++++---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 36 +++++-----
 include/net/mana/gdma.h                       | 13 +++-
 3 files changed, 91 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef8612b73cb..a6ab2f053fe9 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -107,6 +107,9 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	struct gdma_query_max_resources_resp resp = {};
 	struct gdma_general_req req = {};
+	unsigned int max_num_queues;
+	u8 bm_hostmode;
+	u16 num_ports;
 	int err;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_QUERY_MAX_RESOURCES,
@@ -152,6 +155,40 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
 	if (gc->max_num_queues > gc->num_msix_usable - 1)
 		gc->max_num_queues = gc->num_msix_usable - 1;
 
+	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
+				       MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
+	if (err)
+		return err;
+
+	if (!num_ports)
+		return -EINVAL;
+
+	/*
+	 * Adjust gc->max_num_queues returned from the SOC to allow dedicated MSIx
+	 * for each vPort. Reduce max_num_queues to no less than 16 if necessary
+	 */
+	max_num_queues = (gc->num_msix_usable - 1) / num_ports;
+	max_num_queues = roundup_pow_of_two(max(max_num_queues, 1U));
+	if (max_num_queues < 16)
+		max_num_queues = 16;
+
+	/*
+	 * Use dedicated MSIx for EQs whenever possible, use MSIx sharing for
+	 * Ethernet EQs when (max_num_queues * num_ports > num_msix_usable - 1)
+	 */
+	max_num_queues = min(gc->max_num_queues, max_num_queues);
+	if (max_num_queues * num_ports > gc->num_msix_usable - 1)
+		gc->msi_sharing = true;
+
+	/* If MSI is shared, use max allowed value */
+	if (gc->msi_sharing)
+		gc->max_num_queues_vport = min(gc->num_msix_usable - 1, gc->max_num_queues);
+	else
+		gc->max_num_queues_vport = max_num_queues;
+
+	dev_info(gc->dev, "MSI sharing mode %d max queues %d\n",
+		 gc->msi_sharing, gc->max_num_queues);
+
 	return 0;
 }
 
@@ -1803,6 +1840,7 @@ static int mana_gd_setup_hwc_irqs(struct pci_dev *pdev)
 		/* Need 1 interrupt for HWC */
 		max_irqs = min(num_online_cpus(), MANA_MAX_NUM_QUEUES) + 1;
 		min_irqs = 2;
+		gc->msi_sharing = true;
 	}
 
 	nvec = pci_alloc_irq_vectors(pdev, min_irqs, max_irqs, PCI_IRQ_MSIX);
@@ -1881,6 +1919,8 @@ static void mana_gd_remove_irqs(struct pci_dev *pdev)
 
 	pci_free_irq_vectors(pdev);
 
+	bitmap_free(gc->msi_bitmap);
+	gc->msi_bitmap = NULL;
 	gc->max_num_msix = 0;
 	gc->num_msix_usable = 0;
 }
@@ -1912,20 +1952,30 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	if (err)
 		goto destroy_hwc;
 
-	err = mana_gd_query_max_resources(pdev);
+	err = mana_gd_detect_devices(pdev);
 	if (err)
 		goto destroy_hwc;
 
-	err = mana_gd_setup_remaining_irqs(pdev);
-	if (err) {
-		dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
-		goto destroy_hwc;
-	}
-
-	err = mana_gd_detect_devices(pdev);
+	err = mana_gd_query_max_resources(pdev);
 	if (err)
 		goto destroy_hwc;
 
+	if (!gc->msi_sharing) {
+		gc->msi_bitmap = bitmap_zalloc(gc->num_msix_usable, GFP_KERNEL);
+		if (!gc->msi_bitmap) {
+			err = -ENOMEM;
+			goto destroy_hwc;
+		}
+		/* Set bit for HWC */
+		set_bit(0, gc->msi_bitmap);
+	} else {
+		err = mana_gd_setup_remaining_irqs(pdev);
+		if (err) {
+			dev_err(gc->dev, "Failed to setup remaining IRQs: %d", err);
+			goto destroy_hwc;
+		}
+	}
+
 	dev_dbg(&pdev->dev, "mana gdma setup successful\n");
 	return 0;
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 428dafaf315b..bfa0f354355d 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1000,10 +1000,9 @@ static int mana_init_port_context(struct mana_port_context *apc)
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
@@ -1037,6 +1036,14 @@ static int mana_send_request(struct mana_context *ac, void *in_buf,
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
@@ -1170,11 +1177,10 @@ static void mana_pf_deregister_filter(struct mana_port_context *apc)
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
@@ -1189,7 +1195,7 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	req.proto_minor_ver = proto_minor_ver;
 	req.proto_micro_ver = proto_micro_ver;
 
-	err = mana_send_request(ac, &req, sizeof(req), &resp, sizeof(resp));
+	err = gdma_mana_send_request(gc, &req, sizeof(req), &resp, sizeof(resp));
 	if (err) {
 		dev_err(dev, "Failed to query config: %d", err);
 		return err;
@@ -1217,8 +1223,6 @@ static int mana_query_device_cfg(struct mana_context *ac, u32 proto_major_ver,
 	else
 		*bm_hostmode = 0;
 
-	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
-
 	return 0;
 }
 
@@ -3329,7 +3333,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	int err;
 
 	ndev = alloc_etherdev_mq(sizeof(struct mana_port_context),
-				 gc->max_num_queues);
+				 gc->max_num_queues_vport);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -3338,8 +3342,8 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 	apc = netdev_priv(ndev);
 	apc->ac = ac;
 	apc->ndev = ndev;
-	apc->max_queues = gc->max_num_queues;
-	apc->num_queues = gc->max_num_queues;
+	apc->max_queues = gc->max_num_queues_vport;
+	apc->num_queues = gc->max_num_queues_vport;
 	apc->tx_queue_size = DEF_TX_BUFFERS_PER_QUEUE;
 	apc->rx_queue_size = DEF_RX_BUFFERS_PER_QUEUE;
 	apc->port_handle = INVALID_MANA_HANDLE;
@@ -3598,13 +3602,15 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		gd->driver_data = ac;
 	}
 
-	err = mana_query_device_cfg(ac, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
-				    MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
+	err = mana_gd_query_device_cfg(gc, MANA_MAJOR_VERSION, MANA_MINOR_VERSION,
+				       MANA_MICRO_VERSION, &num_ports, &bm_hostmode);
 	if (err)
 		goto out;
 
 	ac->bm_hostmode = bm_hostmode;
 
+	debugfs_create_u16("adapter-MTU", 0400, gc->mana_pci_debugfs, &gc->adapter_mtu);
+
 	if (!resuming) {
 		ac->num_ports = num_ports;
 
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index ec17004b10c0..b744253b44e8 100644
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
@@ -444,6 +446,12 @@ struct gdma_context {
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
@@ -1011,4 +1019,7 @@ int mana_gd_resume(struct pci_dev *pdev);
 
 bool mana_need_log(struct gdma_context *gc, int err);
 
+int mana_gd_query_device_cfg(struct gdma_context *gc, u32 proto_major_ver,
+			     u32 proto_minor_ver, u32 proto_micro_ver,
+			     u16 *max_num_vports, u8 *bm_hostmode);
 #endif /* _GDMA_H */
-- 
2.43.0


