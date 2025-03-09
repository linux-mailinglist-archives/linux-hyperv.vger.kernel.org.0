Return-Path: <linux-hyperv+bounces-4312-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA82A58210
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6856216790F
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1871AF0A6;
	Sun,  9 Mar 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qILzZitV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZVKjvpH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED81194A44;
	Sun,  9 Mar 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509720; cv=none; b=kXmpnrLtiptgK58HXwqmQita7h1RBRkjjqnYNsf0bEH0T+mdInvJoF97LeFswWWG0MxHxcyiXHA0K2kDfPLy4GOhQhF0laEGA9Kh8fMtA28n8t9aI+Vy7ZQwY2dVDdabRK6cOLyefY6HIpSF7RuLngYVCpB7ataFpu6Cd0bostE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509720; c=relaxed/simple;
	bh=opPu9VYnWue7EKlbtVjtKUat1AsEJ+ILNMXtzRwyk3M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KredIde5iQBth6zQFSI20oPqFYpQFEDmjF7BbTvaK+xnDCBvvTyol9MKAyRkGSw76cpBlKvb/uSVBBwAWSu7xWsXtaIgwers27yUuokWYsAf9n3V12NU2iI8tv4r5hF4SzAz5a730Y+WANG9FLK/7+M7+cwDkoVRc6iqGYEX+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qILzZitV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZVKjvpH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.713285420@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qU6MLzFjPGyQ6J2nYIjhCB3n+cLTvszu11O5Zgu5RwQ=;
	b=qILzZitVRVMjRLFWfp+1nfr9F8c45d/IxAirAH7NLQA5b6sfpGeYvxg+auFQFMG0sd37D7
	WlV4WgBGRlIeSz4QZZlcfiWgtMf/YE66C3cb/qppQEFWarSoHatKB5NT/IYBO6Nwpa2tZp
	Gk+mZSBZK0v/Pf+4VXyH/SHvILzDbWpqEUpKEwt9V4A3VuvRFBxbjO7KX8zdmbgBi3+xdn
	CEc+kPkE9RTqhI6Si6sO3fsmnkCyfQ2oJuSiHHo3ozzzDt0RXz4CVqjCkqWic03Y4S68nh
	J1zvlcj+vLKz3FVQ7QQ/e/U/Up5wJncTOZ7s7ZG5MeDLdgWwisBxSpb3whYXCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qU6MLzFjPGyQ6J2nYIjhCB3n+cLTvszu11O5Zgu5RwQ=;
	b=IZVKjvpHbi6myLlb9hiROMhpSewOeVPq+BMTgJ1PIuJfrtPhng/ZMgdVf12zTbCTXap7QV
	GwoW6oe9homIyhCQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>
Subject: [patch 09/10] scsi: ufs: qcom: Remove the MSI descriptor abuse
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:56 +0100 (CET)

The driver abuses the MSI descriptors for internal purposes. Aside of core
code and MSI providers nothing has to care about their existence. They have
been encapsulated with a lot of effort because this kind of abuse caused
all sorts of issues including a maintainability nightmare.

Rewrite the code so it uses dedicated storage to hand the required
information to the interrupt handler.

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/ufs/host/ufs-qcom.c |   77 ++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1782,15 +1782,19 @@ static void ufs_qcom_write_msi_msg(struc
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
@@ -1799,8 +1803,7 @@ static irqreturn_t ufs_qcom_mcq_esi_hand
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc = NULL;
+	struct ufs_qcom_irq *qi;
 	int nr_irqs, ret;
 
 	if (host->esi_enabled)
@@ -1811,47 +1814,47 @@ static int ufs_qcom_config_esi(struct uf
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	qi = devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
+	if (qi)
+		return -ENOMEM;
+
 	ret = platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
 						      ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
-		return ret;
+		goto cleanup;
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
+			goto cleanup;
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
+	if (host->hw_ver.major == 6 && host->hw_ver.minor == 0 &&
+	    host->hw_ver.step == 0) {
+		ufshcd_rmwl(hba, ESI_VEC_MASK,
+			    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+			    REG_UFS_CFG3);
 	}
-
+	ufshcd_mcq_enable_esi(hba);
+	host->esi_enabled = true;
+	return 0;
+
+cleanup:
+	for (int idx = 0; qi[idx].irq; idx++)
+		devm_free_irq(hba->dev, qi[idx].irq, hba);
+	platform_device_msi_free_irqs_all(hba->dev);
+	devm_kfree(hba->dev, qi);
 	return ret;
 }
 


