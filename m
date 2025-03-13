Return-Path: <linux-hyperv+bounces-4472-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E5A5F53B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D0016E52B
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F71267B71;
	Thu, 13 Mar 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBCOqsEs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tjt6d8fp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7F267AF2;
	Thu, 13 Mar 2025 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871025; cv=none; b=M21eff7Y8O1NpCylBBlbwq44y2TwxPhEecp1lzopW/RD+rcAQXEYzvy60j3uwKcf6vQ0SRpkjuxj+w/Ive64eflSo+urY7nHU/gpi7/bhl/BKY9Dz7QH+4CvjGx9MSuQwuTscZJasYECw0W/ypI75PZRpjdcUW5FE6ci2Sgky2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871025; c=relaxed/simple;
	bh=YA+xRKQ1bCPwCGf288P1mFx8wbPz0YHxLW7XpjZA9Ts=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lAt4zYhpM2Mt9w/CIAh6H4bar81lnaYG5lnCkBFUYZrrZ7MoWNvWIBQpJ8luKr2Of/gTT3b4o0vlRECpQ4dYvdju9OrFiraHe6IPCKml9+oX8vu31+zBZk7A3+35o7gJNXpEf+z+65Uf3c9DnNnahu8TWTFApGZ3uMzQXW3flIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBCOqsEs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tjt6d8fp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313130321.568379110@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JAGxU1SGJ7l/lZ3n/Ga0dDjuWkVfIFFiS2EUui8rZ10=;
	b=jBCOqsEsxbelusapNiCzQLbiVnibMNRVP4P0m03xXCnNAGcxhfGotGn/oKERzj+BT4sLeT
	PcCaYx7mTe1jPEoz0KiN9644Gn1wfg4bKWQVx6ZmsAb9Tcy+Iv6pjJZKhGF8jrtdZaVlaV
	eVfbEtv125ieSf5if20k/mlXOndg7Y8tf+2FQHsM7F6yYdsS3IZYmnPJjiNo8huhPBSDDt
	OtHRMsXE3fQi4ncmOHWhjCHo17b81+gMRGUqQ5WDtIO24iROQ2Om0ZReORUmRyWCXFhOp/
	osAlJDaoKta/Z84RkgbOs1hiY5SEpg03QIxaFuELBLtMGhs1lRmjJdrsbfcWTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=JAGxU1SGJ7l/lZ3n/Ga0dDjuWkVfIFFiS2EUui8rZ10=;
	b=Tjt6d8fpY/80LWp3IWDxeLCOK/2i0mfgvBm22dduGxRY3Cj8Ppf02XfF5NlP4O5Jl9kPYS
	Kb+NbJsIpsmP6YBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V2 03/10] soc: ti: ti_sci_inta_msi: Switch MSI descriptor
 locking to guard()
References: <20250313130212.450198939@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 14:03:41 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Cc: Tero Kristo <kristo@kernel.org>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
---
 drivers/soc/ti/ti_sci_inta_msi.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -103,19 +103,15 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 	if (ret)
 		return ret;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <= 0) {
-		ret = nvec;
-		goto unlock;
-	}
+	if (nvec <= 0)
+		return nvec;
 
 	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
 	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-unlock:
-	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);




