Return-Path: <linux-hyperv+bounces-10508-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKukHTuR8mlAsgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10508-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 01:16:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1149B46A
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 01:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A19D6301286B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 23:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67423A5432;
	Wed, 29 Apr 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GX8Z+WrN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6239DBCD;
	Wed, 29 Apr 2026 23:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504545; cv=none; b=pxLlWLul40qsB4+8aoZl4uqMGm5F/w2R3xnamt1VbVWhU+zCnVWFM5Xl6znzKfxvlAvq5ZLjkUMGbFGYi0DhzWnzBSufFL0QqFtU1hws1Sxv/nIpUsEZVBg4xK3dNHThGnmTC2itbXoCaD9NrjFmGd+vzKmy4584Vz4uzSDKe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504545; c=relaxed/simple;
	bh=IgxUH/+zU92g1+j5BSaxspdGUgX53/MsjEiv8Uo5rBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHUaja/5Gjby4vUy4yxdpJrWQzhIij4ezlhBdyVDOgOdFnR/nRTXR3V8LSy3w3w6FEmOBw3Ct1jZqnd9XgZvIvJv9Gnmv2p6id4GMwT9ftBNSGAB8P6Ml+/9Ao69MHp3EhkuDbrOq3Z/9mcDcX+Caf65EFKpRQGNDgFGpgV6HmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GX8Z+WrN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (unknown [13.88.17.9])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5087720B716F;
	Wed, 29 Apr 2026 16:15:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5087720B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777504544;
	bh=o49tx8/3sSJgdzeUhZ6VLlQM8CX6XRmt7QR4EGSON+Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=GX8Z+WrNd9Fk5OD5jqTO60O02pBd7t+vJvn7ACJSDbaW14L9un4ltVMoUslkBB/Cl
	 51eZlHaYgb34tYNCbaXlvttVmQvE1QrMbpt5tW35nN99ZivDLf//g7BoFo5nkDaYNe
	 HyVnXWXEJ/wa/HrK+a/GXfw5C/Qw/q0NP2wHIwJ8=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v0 3/3] mshv: Implement guest irq migration for passthru'd devices
Date: Wed, 29 Apr 2026 16:15:19 -0700
Message-ID: <20260429231519.2569088-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260429231519.2569088-1-mrathor@linux.microsoft.com>
References: <20260429231519.2569088-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1FF1149B46A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10508-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

Ask the hypervisor to retarget interrupts to new guest cpu or vector
upon guest irq migration. This happens in the irqfd update path.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c | 78 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 666e28f4a4b5..0d0f1229f500 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -192,6 +192,77 @@ static int mshv_map_device_interrupt(u64 ptid, union hv_device_id hv_devid,
 
 }
 
+/* NOTE: caller does spin_lock_irq on pt_irqfds_lock, hence no disable here */
+static void mshv_do_guest_irq_retarget(u64 partid, struct mshv_irqfd *irqfd)
+{
+	int rc, var_size;
+	u64 status;
+	union hv_device_id hv_devid;
+	struct hv_input_get_vp_set_from_mda *mda_input;
+	union hv_output_get_vp_set_from_mda *mda_output;
+	struct hv_retarget_device_interrupt *remap_inp;
+	struct pci_dev *pdev;
+	struct irq_data *irqdata;
+	struct mshv_lapic_irq *lapic_irq = &irqfd->irqfd_lapic_irq;
+	struct hv_interrupt_entry *inte = NULL;
+
+	if (!irqfd->irqfd_girq_ent.girq_entry_valid ||
+	    irqfd->irqfd_bypass_prod == NULL)
+		return;
+
+	rc = mshv_parse_mshv_irqfd(irqfd, &pdev, &irqdata);
+	if (rc)
+		return;
+
+	inte = irqdata->chip_data;
+	if (inte == NULL)
+		return;
+
+	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
+
+
+	mda_input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	mda_output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	rc = hv_vpset_from_hyp_disabled(mda_input, mda_output, lapic_irq,
+					partid);
+	if (rc)
+		return;
+
+	remap_inp = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(remap_inp, 0, sizeof(*remap_inp));
+
+	rc = hv_copy_vpset(&remap_inp->int_target.vp_set,
+			   &mda_output->target_vpset);
+	if (rc <= 0) {
+		pr_err("Hyper-V: ptid %lld - vpset copy failed (%d)\n",
+		       partid, rc);
+		return;
+	}
+
+	/*
+	 * var-sized hcall: var-size starts after vp_mask (thus vp_set.format
+	 * does not count, but vp_set.valid_bank_mask does).
+	 */
+	var_size = rc + 1;
+
+	remap_inp->partition_id = partid;
+	remap_inp->device_id = hv_devid.as_uint64;
+	remap_inp->int_target.vector = lapic_irq->lapic_vector;
+	remap_inp->int_target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
+
+	remap_inp->int_entry.source = inte->source;
+	remap_inp->int_entry.msi_entry.as_uint64 = inte->msi_entry.as_uint64;
+
+	status = hv_do_rep_hypercall(HVCALL_RETARGET_INTERRUPT, 0, var_size,
+				     remap_inp, NULL);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "pt:%lld vec:%d lapic-id:%lld\n",
+			      partid, lapic_irq->lapic_vector,
+			      lapic_irq->lapic_apic_id);
+}
+
 static int mshv_unmap_device_interrupt(union hv_device_id hv_devid,
 				       struct hv_interrupt_entry *irq_entry)
 {
@@ -728,9 +799,12 @@ static void mshv_irqfd_update(struct mshv_partition *pt,
 			      struct mshv_irqfd *irqfd)
 {
 	write_seqcount_begin(&irqfd->irqfd_irqe_sc);
-	irqfd->irqfd_girq_ent = mshv_ret_girq_entry(pt,
-						    irqfd->irqfd_irqnum);
+	irqfd->irqfd_girq_ent = mshv_ret_girq_entry(pt, irqfd->irqfd_irqnum);
 	mshv_copy_girq_info(&irqfd->irqfd_girq_ent, &irqfd->irqfd_lapic_irq);
+
+#if IS_ENABLED(CONFIG_X86_64)
+	mshv_do_guest_irq_retarget(pt->pt_id, irqfd);
+#endif
 	write_seqcount_end(&irqfd->irqfd_irqe_sc);
 }
 
-- 
2.51.2.vfs.0.1


