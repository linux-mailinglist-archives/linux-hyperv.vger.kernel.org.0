Return-Path: <linux-hyperv+bounces-9169-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO/DOKREq2nJbgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9169-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:18:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD4F227DBD
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Mar 2026 22:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32722302A7F1
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Mar 2026 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32EC3264F9;
	Fri,  6 Mar 2026 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Rlk1VTPV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6AF1F4615;
	Fri,  6 Mar 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831906; cv=none; b=KEUe/sAlZkxMKBofeVW+7wMlFzQiZfJk2+LeH+XsN6tiPJVKchzTBHn7392/CwGED5sJnIQ7kV7eG33xZvGDTDFcxzJPGY3pgVqa/tiv8XYDppUmSL2tSYBYf+ulLmg755ti5Etyy/vTP69o1zQXBfCY4YXJ90xSUiAQ3fby4Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831906; c=relaxed/simple;
	bh=3owFiLN0CaXTZhTIGLSz57j3KKPz1bvn2pjRi3dJtR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jqTk6K+aFu+Vrp3O2GOKT7nzP/byc1VtDgxOQSYq78CwawTxjmuSL3Hh8Hg6UlUmhZtcQt81IDxsqUgxiYirHBRyKSpDhxrcjv9B9H/vhwTPxVNWysl8bBjKOxmDg79a0RateS21PIvSR8jd5gS54cZwKA+Im7qSumiyrnU3njE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Rlk1VTPV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7CBBC20B6F02; Fri,  6 Mar 2026 13:12:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CBBC20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772831566;
	bh=bF+bCk7Lg3fgVXMvUmbdXZivXajPDseHDj+9XlUsCQE=;
	h=From:To:Cc:Subject:Date:From;
	b=Rlk1VTPVzPYDFhJUTS1HuDc3geVcWFFoIb1LTmC/LCi4DaYFh7lM9efk0RL1TmCoK
	 SRKy0Ps8Y/KCQbLhI6LjXVbBNMUnZTlLl1a5529MSAXRiwV2EMXwPegXm+j00XuZf+
	 GM31cMenNQV2BFZVetK5NzysMFM0TvZMMbbKmWFk=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response
Date: Fri,  6 Mar 2026 13:12:06 -0800
Message-ID: <20260306211212.543376-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5BD4F227DBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9169-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

As a part of MANA hardening for CVM, add validation for the doorbell
ID (db_id) received from hardware in the GDMA_REGISTER_DEVICE response
to prevent out-of-bounds memory access when calculating the doorbell
page address.

In mana_gd_ring_doorbell(), the doorbell page address is calculated as:
  addr = db_page_base + db_page_size * db_index
       = (bar0_va + db_page_off) + db_page_size * db_index

A hardware could return values that cause this address to fall outside
the BAR0 MMIO region. In Confidential VM environments, hardware responses
cannot be fully trusted.

Add the following validations:
- Store the BAR0 size (bar0_size) in gdma_context during probe.
- Validate the doorbell page offset (db_page_off) read from device
  registers does not exceed bar0_size during initialization, converting
  mana_gd_init_registers() to return an error code.
- Validate db_id from GDMA_REGISTER_DEVICE response against the
  maximum number of doorbell pages that fit within BAR0.

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 60 ++++++++++++++-----
 include/net/mana/gdma.h                       |  4 +-
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef8612b73cb..ef0dbfaac8f4 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -39,49 +39,66 @@ static u64 mana_gd_r64(struct gdma_context *g, u64 offset)
 	return readq(g->bar0_va + offset);
 }
 
-static void mana_gd_init_pf_regs(struct pci_dev *pdev)
+static int mana_gd_init_pf_regs(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	void __iomem *sriov_base_va;
 	u64 sriov_base_off;
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;
-	gc->db_page_base = gc->bar0_va +
-				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
+	gc->db_page_off = mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
 
-	gc->phys_db_page_base = gc->bar0_pa +
-				mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
+	/* Validate doorbell offset is within BAR0 */
+	if (gc->db_page_off >= gc->bar0_size) {
+		dev_err(gc->dev,
+			"Doorbell offset 0x%llx exceeds BAR0 size 0x%llx\n",
+			gc->db_page_off, (u64)gc->bar0_size);
+		return -EPROTO;
+	}
+
+	gc->db_page_base = gc->bar0_va + gc->db_page_off;
+	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
 
 	sriov_base_off = mana_gd_r64(gc, GDMA_SRIOV_REG_CFG_BASE_OFF);
 
 	sriov_base_va = gc->bar0_va + sriov_base_off;
 	gc->shm_base = sriov_base_va +
 			mana_gd_r64(gc, sriov_base_off + GDMA_PF_REG_SHM_OFF);
+
+	return 0;
 }
 
-static void mana_gd_init_vf_regs(struct pci_dev *pdev)
+static int mana_gd_init_vf_regs(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_REG_DB_PAGE_SIZE) & 0xFFFF;
+	gc->db_page_off = mana_gd_r64(gc, GDMA_REG_DB_PAGE_OFFSET);
 
-	gc->db_page_base = gc->bar0_va +
-				mana_gd_r64(gc, GDMA_REG_DB_PAGE_OFFSET);
+	/* Validate doorbell offset is within BAR0 */
+	if (gc->db_page_off >= gc->bar0_size) {
+		dev_err(gc->dev,
+			"Doorbell offset 0x%llx exceeds BAR0 size 0x%llx\n",
+			gc->db_page_off, (u64)gc->bar0_size);
+		return -EPROTO;
+	}
 
-	gc->phys_db_page_base = gc->bar0_pa +
-				mana_gd_r64(gc, GDMA_REG_DB_PAGE_OFFSET);
+	gc->db_page_base = gc->bar0_va + gc->db_page_off;
+	gc->phys_db_page_base = gc->bar0_pa + gc->db_page_off;
 
 	gc->shm_base = gc->bar0_va + mana_gd_r64(gc, GDMA_REG_SHM_OFFSET);
+
+	return 0;
 }
 
-static void mana_gd_init_registers(struct pci_dev *pdev)
+static int mana_gd_init_registers(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
 	if (gc->is_pf)
-		mana_gd_init_pf_regs(pdev);
+		return mana_gd_init_pf_regs(pdev);
 	else
-		mana_gd_init_vf_regs(pdev);
+		return mana_gd_init_vf_regs(pdev);
 }
 
 /* Suppress logging when we set timeout to zero */
@@ -1256,6 +1273,17 @@ int mana_gd_register_device(struct gdma_dev *gd)
 		return err ? err : -EPROTO;
 	}
 
+	/* Validate that doorbell page for db_id is within the BAR0 region.
+	 * In mana_gd_ring_doorbell(), the address is calculated as:
+	 *   addr = db_page_base + db_page_size * db_id
+	 *        = (bar0_va + db_page_off) + (db_page_size * db_id)
+	 * So we need: db_page_off + db_page_size * (db_id + 1) <= bar0_size
+	 */
+	if (gc->db_page_off + gc->db_page_size * ((u64)resp.db_id + 1) > gc->bar0_size) {
+		dev_err(gc->dev, "Doorbell ID %u out of range\n", resp.db_id);
+		return -EPROTO;
+	}
+
 	gd->pdid = resp.pdid;
 	gd->gpa_mkey = resp.gpa_mkey;
 	gd->doorbell = resp.db_id;
@@ -1890,7 +1918,10 @@ static int mana_gd_setup(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 	int err;
 
-	mana_gd_init_registers(pdev);
+	err = mana_gd_init_registers(pdev);
+	if (err)
+		return err;
+
 	mana_smc_init(&gc->shm_channel, gc->dev, gc->shm_base);
 
 	gc->service_wq = alloc_ordered_workqueue("gdma_service_wq", 0);
@@ -1996,6 +2027,7 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mutex_init(&gc->eq_test_event_mutex);
 	pci_set_drvdata(pdev, gc);
 	gc->bar0_pa = pci_resource_start(pdev, 0);
+	gc->bar0_size = pci_resource_len(pdev, 0);
 
 	bar0_va = pci_iomap(pdev, bar, 0);
 	if (!bar0_va)
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index ec17004b10c0..7fe3a1b61b2d 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -421,10 +421,12 @@ struct gdma_context {
 
 	phys_addr_t		bar0_pa;
 	void __iomem		*bar0_va;
+	resource_size_t		bar0_size;
 	void __iomem		*shm_base;
 	void __iomem		*db_page_base;
 	phys_addr_t		phys_db_page_base;
-	u32 db_page_size;
+	u64 db_page_off;
+	u64 db_page_size;
 	int                     numa_node;
 
 	/* Shared memory chanenl (used to bootstrap HWC) */
-- 
2.34.1


