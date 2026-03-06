Return-Path: <linux-hyperv+bounces-9165-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBHoHZDXqmnmXgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9165-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:33:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB42221B35
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 14:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88FED300E588
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E22F8BC3;
	Fri,  6 Mar 2026 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qun5vPRK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ACC298CC7;
	Fri,  6 Mar 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772803981; cv=none; b=JaFjhsLEibejh4KnIHLCPTpYM8nd2VLxhmbp6oCOHOw5kM4JO4E3pu6b9TW5Vc5s2nTXyZOvQ7VFsjEM1Zm12mNAUcX3Y4GISXm3qt3mJz6jtMjcNCVYPLMeJQOtTsrNieLtQRJWMGWls7K0NVqQ4dqTQ4sQZFpfISopI5KN5z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772803981; c=relaxed/simple;
	bh=xDHk9gyIMzxUIan8Ors9/osNjl4oyoyWkhyDW6Ig6gQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lKEjs2wDHebpNpL6V5SKr3yZ/YNcQ6DqxlyoMNCEBUkP2Rf3+ZA315QCdNl7Csp6Lw625LNWZYFakiyIZ2Ke3YOU+lV5c2+N+Q6Pz3KDlPxzu4zlgn4bQQeJFbZ1slugiq4qQaFZBXpzizHuqFJKL+y6H/GMilTMzHsX1Y8TWJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qun5vPRK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 333AC20B6F02; Fri,  6 Mar 2026 05:33:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 333AC20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772803980;
	bh=0/RwB8HxbocbJWW5WYvYRd83Bki+l/g5eLecLNI+0O4=;
	h=Date:From:To:Subject:From;
	b=qun5vPRKpQdaL6UaojjiKAPQivVUffvTP78miiOe4MQQeMPqGTkhQIub3Q8c/WJuO
	 M1cab4wH8A4ZuGc+/r3VPzCdGGZ/u2+BkmX66Fn3yInbJDGuyi/9P1jDCmvaj2fSg1
	 6GedbsCBvH+0+oajsR9kjA76JeWPsvHelR5FBJjo=
Date: Fri, 6 Mar 2026 05:33:00 -0800
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
Subject: [PATCH net-next, v2] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
Message-ID: <aarXjJ+n2EoX2JvB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 1AB42221B35
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9165-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Action: no action

On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
fragments for RX buffers results in a significant throughput regression.
Profiling reveals that this regression correlates with high overhead in the
fragment allocation and reference counting paths on these specific
platforms, rendering the multi-buffer-per-page strategy counterproductive.

To mitigate this, bypass the page_pool fragment path and force a single RX
packet per page allocation when all the following conditions are met:
  1. The system is configured with a 4K PAGE_SIZE.
  2. A processor-specific quirk is detected via SMBIOS Type 4 data.

This approach restores expected line-rate performance by ensuring
predictable RX refill behavior on affected hardware.

There is no behavioral change for systems using larger page sizes
(16K/64K), or platforms where this processor-specific quirk do not
apply.

Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
---
Changes in v2:
  - separate reading string index and the string, remove inline.
---
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 133 ++++++++++++++++++
 drivers/net/ethernet/microsoft/mana/mana_en.c |  23 ++-
 include/net/mana/gdma.h                       |   9 ++
 3 files changed, 163 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef8612b73cb..05fecc00a90c 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -9,6 +9,7 @@
 #include <linux/msi.h>
 #include <linux/irqdomain.h>
 #include <linux/export.h>
+#include <linux/dmi.h>
 
 #include <net/mana/mana.h>
 #include <net/mana/hw_channel.h>
@@ -1959,6 +1960,128 @@ static bool mana_is_pf(unsigned short dev_id)
 	return dev_id == MANA_PF_DEVICE_ID;
 }
 
+/*
+ * Table for Processor Version strings found from SMBIOS Type 4 information,
+ * for processors that needs to force single RX buffer per page quirk for
+ * meeting line rate performance with ARM64 + 4K pages.
+ * Note: These strings are exactly matched with version fetched from SMBIOS.
+ */
+static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
+	"Cobalt 200",
+};
+
+/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
+ * trigger a throughput regression. Hence identify those processors
+ * from the extracted SMBIOS table and apply the quirk to forces one
+ * RX buffer per page to avoid the fragment allocation/refcounting
+ * overhead in the RX refill path for those processors only.
+ */
+static bool mana_needs_single_rxbuf_per_page(struct gdma_context *gc)
+{
+	int i = 0;
+	const char *ver = gc->processor_version;
+
+	if (!ver)
+		return false;
+
+	if (PAGE_SIZE != SZ_4K)
+		return false;
+
+	while (i < ARRAY_SIZE(mana_single_rxbuf_per_page_quirk_tbl)) {
+		if (!strcmp(ver, mana_single_rxbuf_per_page_quirk_tbl[i]))
+			return true;
+		i++;
+	}
+
+	return false;
+}
+
+static void mana_get_proc_ver_strno(const struct dmi_header *hdr, void *data)
+{
+	struct gdma_context *gc = data;
+	const u8 *d = (const u8 *)hdr;
+
+	/* We are only looking for Type 4: Processor Information */
+	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
+		return;
+
+	/* Ensure the record is long enough to contain the Processor Version
+	 * field
+	 */
+	if (hdr->length <= SMBIOS_TYPE4_PROC_VERSION_OFFSET)
+		return;
+
+	/* The 'Processor Version' string is located at index pointed by
+	 * SMBIOS_TYPE4_PROC_VERSION_OFFSET.  Make a copy of the index.
+	 * There could be multiple Type 4 tables so read and store the
+	 * processor version index found the first time.
+	 */
+	if (gc->proc_ver_strno)
+		return;
+
+	gc->proc_ver_strno = d[SMBIOS_TYPE4_PROC_VERSION_OFFSET];
+}
+
+static const char *mana_dmi_string_nosave(const struct dmi_header *hdr, u8 s)
+{
+	const char *bp = (const char *)hdr + hdr->length;
+
+	if (!s)
+		return NULL;
+
+	/* String numbers start at 1 */
+	while (--s > 0 && *bp)
+		bp += strlen(bp) + 1;
+
+	if (!*bp)
+		return NULL;
+
+	return bp;
+}
+
+static void mana_fetch_proc_ver_string(const struct dmi_header *hdr,
+				       void *data)
+{
+	struct gdma_context *gc = data;
+	const char *ver;
+
+	/* We are only looking for Type 4: Processor Information */
+	if (hdr->type != SMBIOS_TYPE_4_PROCESSOR_INFO)
+		return;
+
+	/* Extract proc version found the first time only */
+	if (!gc->proc_ver_strno || gc->processor_version)
+		return;
+
+	ver = mana_dmi_string_nosave(hdr, gc->proc_ver_strno);
+	if (ver)
+		gc->processor_version = kstrdup(ver, GFP_KERNEL);
+}
+
+/* Check and initialize all processor optimizations/quirks here */
+static bool mana_init_processor_optimization(struct gdma_context *gc)
+{
+	bool opt_initialized = false;
+
+	gc->proc_ver_strno = 0;
+	gc->processor_version = NULL;
+
+	dmi_walk(mana_get_proc_ver_strno, gc);
+	if (!gc->proc_ver_strno)
+		return false;
+
+	dmi_walk(mana_fetch_proc_ver_string, gc);
+	if (!gc->processor_version)
+		return false;
+
+	if (mana_needs_single_rxbuf_per_page(gc)) {
+		gc->force_full_page_rx_buffer = true;
+		opt_initialized = true;
+	}
+
+	return opt_initialized;
+}
+
 static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct gdma_context *gc;
@@ -2013,6 +2136,11 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
 							  mana_debugfs_root);
 
+	if (mana_init_processor_optimization(gc))
+		dev_info(&pdev->dev,
+			 "Processor specific optimization initialized on: %s\n",
+			gc->processor_version);
+
 	err = mana_gd_setup(pdev);
 	if (err)
 		goto unmap_bar;
@@ -2055,6 +2183,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_iounmap(pdev, bar0_va);
 free_gc:
 	pci_set_drvdata(pdev, NULL);
+	kfree(gc->processor_version);
+	gc->processor_version = NULL;
 	vfree(gc);
 release_region:
 	pci_release_regions(pdev);
@@ -2110,6 +2240,9 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	pci_iounmap(pdev, gc->bar0_va);
 
+	kfree(gc->processor_version);
+	gc->processor_version = NULL;
+
 	vfree(gc);
 
 	pci_release_regions(pdev);
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index a868c28c8280..38f94f7619ad 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -744,6 +744,26 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
 	return va;
 }
 
+static bool
+mana_use_single_rxbuf_per_page(struct mana_port_context *apc, u32 mtu)
+{
+	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
+
+	/* On some systems with 4K PAGE_SIZE, page_pool RX fragments can
+	 * trigger a throughput regression. Hence forces one RX buffer per page
+	 * to avoid the fragment allocation/refcounting overhead in the RX
+	 * refill path for those processors only.
+	 */
+	if (gc->force_full_page_rx_buffer)
+		return true;
+
+	/* For xdp and jumbo frames make sure only one packet fits per page. */
+	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc))
+		return true;
+
+	return false;
+}
+
 /* Get RX buffer's data size, alloc size, XDP headroom based on MTU */
 static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 			       int mtu, u32 *datasize, u32 *alloc_size,
@@ -754,8 +774,7 @@ static void mana_get_rxbuf_cfg(struct mana_port_context *apc,
 	/* Calculate datasize first (consistent across all cases) */
 	*datasize = mtu + ETH_HLEN;
 
-	/* For xdp and jumbo frames make sure only one packet fits per page */
-	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 || mana_xdp_get(apc)) {
+	if (mana_use_single_rxbuf_per_page(apc, mtu)) {
 		if (mana_xdp_get(apc)) {
 			*headroom = XDP_PACKET_HEADROOM;
 			*alloc_size = PAGE_SIZE;
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index ec17004b10c0..be56b347f3f6 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -9,6 +9,12 @@
 
 #include "shm_channel.h"
 
+/* SMBIOS Type 4: Processor Information table */
+#define SMBIOS_TYPE_4_PROCESSOR_INFO 4
+
+/* Byte offset containing the Processor Version string number.*/
+#define SMBIOS_TYPE4_PROC_VERSION_OFFSET 0x10
+
 #define GDMA_STATUS_MORE_ENTRIES	0x00000105
 #define GDMA_STATUS_CMD_UNSUPPORTED	0xffffffff
 
@@ -444,6 +450,9 @@ struct gdma_context {
 	struct workqueue_struct *service_wq;
 
 	unsigned long		flags;
+	u8			*processor_version;
+	u8			proc_ver_strno;
+	bool			force_full_page_rx_buffer;
 };
 
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
-- 
2.34.1


