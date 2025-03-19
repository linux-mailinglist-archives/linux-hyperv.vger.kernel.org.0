Return-Path: <linux-hyperv+bounces-4615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5AA68A60
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 12:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EAC8829FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02411258CE3;
	Wed, 19 Mar 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t76/HqZa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rRrUV8bf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E62586CE;
	Wed, 19 Mar 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381823; cv=none; b=lS/T8eQ0WmRSxcqhRCYLA4IxWxdTOqmZVjVHaosRmuDhCS8QWYFKVQwlgJrRMPruDcxv6e9bVeauJ8rqKR/DWZ9T2SqG19gdBrG7Ynti69DdLDCzqukxju2ASvjW0+Ps4x2r92pC0r4wTbt8KR07cY0rTtkvvjl5/mXBYF4klOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381823; c=relaxed/simple;
	bh=dNfcM8PpvFdc9/dBbg5dWxwPwXOwU8ZviHU26rWUaVw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bl+4CgkidDHI9TcQYTAKASv42Om81z2sC2Ejl0GcOObWUqpCG1K8/bDgPdYqittD6d1vkRH1tgJ/mZzEptbmIOr8iJbMfzqIElS1uQM4et5KBCiFeEudr8vuA8Ya25gXw8wOv1762k+5Vc8S5Y2dguFHg7AC5dqIZaJYiqNAONg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t76/HqZa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rRrUV8bf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.805529593@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DT9Y4McgdSXWRdQEhAdRPvaJ55/Pj75U/vwMpJXDRBg=;
	b=t76/HqZa8NXhYd25BbUl0A9/9Zd0n7Bxi8x+rCMoHckA3uJCuobvsb5nMXxIqOkEpzceEK
	/cc5GCeSKEM/DaOBCsibjjyrGmbCnBQ8GIAv5n7r3dE2/RQjnyUvKCVC3zED+7aIVQSe/6
	oF97uYv5k41T+b/2jKz7LATv+u1f3dk7iCvFkW9ch9T0TGHWryU9fG+0pjjtrMSzSP7G7O
	KGYTvk8ogmSPYCKLqu+t5E+eiaPjMIqLRF77FpJqKkiDTw6aClzchgSxbXqqT3CwjFelwf
	PZOC+xroddCkygwGAdCjQDqPDVp8/MilfQql1p+5cdQPSRDm2bIuk0BKJhJ8Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DT9Y4McgdSXWRdQEhAdRPvaJ55/Pj75U/vwMpJXDRBg=;
	b=rRrUV8bf8FBDzZXnOqUF2I8BggTG5p90ClpFET9GrQiFAg0OMVizxS+gHH3Xoeyf2r+217
	tk4dt/kO0dT6s1CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 13/14] scsi: ufs: qcom: Remove the MSI descriptor abuse
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:57:00 +0100 (CET)

The driver abuses the MSI descriptors for internal purposes. Aside of core
code and MSI providers nothing has to care about their existence. They have
been encapsulated with a lot of effort because this kind of abuse caused
all sorts of issues including a maintainability nightmare.

Rewrite the code so it uses dedicated storage to hand the required
information to the interrupt handler and use a custom cleanup function to
simplify the error path.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
V4: Fix inverse NULL pointer check and use __free() for error paths - James
---
 drivers/ufs/host/ufs-qcom.c |   85 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1782,25 +1782,38 @@ static void ufs_qcom_write_msi_msg(struc
 	ufshcd_mcq_config_esi(hba, msg);
 }
 
+struct ufs_qcom_irq {
+	unsigned int		irq;
+	unsigned int		idx;
+	struct ufs_hba		*hba;
+};
+
 static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
-	struct msi_desc *desc = data;
-	struct device *dev = msi_desc_to_dev(desc);
-	struct ufs_hba *hba = dev_get_drvdata(dev);
-	u32 id = desc->msi_index;
-	struct ufs_hw_queue *hwq = &hba->uhq[id];
+	struct ufs_qcom_irq *qi = data;
+	struct ufs_hba *hba = qi->hba;
+	struct ufs_hw_queue *hwq = &hba->uhq[qi->idx];
 
-	ufshcd_mcq_write_cqis(hba, 0x1, id);
+	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
 	ufshcd_mcq_poll_cqe_lock(hba, hwq);
 
 	return IRQ_HANDLED;
 }
 
+static void ufs_qcom_irq_free(struct ufs_qcom_irq *uqi)
+{
+	for (struct ufs_qcom_irq *q = uqi; q->irq; q++)
+		devm_free_irq(q->hba->dev, q->irq, q->hba);
+
+	platform_device_msi_free_irqs_all(uqi->hba->dev);
+	devm_kfree(uqi->hba->dev, uqi);
+}
+
+DEFINE_FREE(ufs_qcom_irq, struct ufs_qcom_irq *, if (_T) ufs_qcom_irq_free(_T))
+
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc = NULL;
 	int nr_irqs, ret;
 
 	if (host->esi_enabled)
@@ -1811,6 +1824,14 @@ static int ufs_qcom_config_esi(struct uf
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+
+	struct ufs_qcom_irq *qi __free(ufs_qcom_irq) =
+		devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
+	if (!qi)
+		return -ENOMEM;
+	/* Preset so __free() has a pointer to hba in all error paths */
+	qi[0].hba = hba;
+
 	ret = platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
 						      ufs_qcom_write_msi_msg);
 	if (ret) {
@@ -1818,41 +1839,31 @@ static int ufs_qcom_config_esi(struct uf
 		return ret;
 	}
 
-	msi_lock_descs(hba->dev);
-	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-		ret = devm_request_irq(hba->dev, desc->irq,
-				       ufs_qcom_mcq_esi_handler,
-				       IRQF_SHARED, "qcom-mcq-esi", desc);
+	for (int idx = 0; idx < nr_irqs; idx++) {
+		qi[idx].irq = msi_get_virq(hba->dev, idx);
+		qi[idx].idx = idx;
+		qi[idx].hba = hba;
+
+		ret = devm_request_irq(hba->dev, qi[idx].irq, ufs_qcom_mcq_esi_handler,
+				       IRQF_SHARED, "qcom-mcq-esi", qi + idx);
 		if (ret) {
 			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err = %d\n",
-				__func__, desc->irq, ret);
-			failed_desc = desc;
-			break;
+				__func__, qi[idx].irq, ret);
+			qi[idx].irq = 0;
+			return ret;
 		}
 	}
-	msi_unlock_descs(hba->dev);
 
-	if (ret) {
-		/* Rewind */
-		msi_lock_descs(hba->dev);
-		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-			if (desc == failed_desc)
-				break;
-			devm_free_irq(hba->dev, desc->irq, hba);
-		}
-		msi_unlock_descs(hba->dev);
-		platform_device_msi_free_irqs_all(hba->dev);
-	} else {
-		if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
-		    host->hw_ver.step == 0)
-			ufshcd_rmwl(hba, ESI_VEC_MASK,
-				    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
-				    REG_UFS_CFG3);
-		ufshcd_mcq_enable_esi(hba);
-		host->esi_enabled = true;
-	}
+	retain_ptr(qi);
 
-	return ret;
+	if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+	    host->hw_ver.step == 0) {
+		ufshcd_rmwl(hba, ESI_VEC_MASK, FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+			    REG_UFS_CFG3);
+	}
+	ufshcd_mcq_enable_esi(hba);
+	host->esi_enabled = true;
+	return 0;
 }
 
 /*


