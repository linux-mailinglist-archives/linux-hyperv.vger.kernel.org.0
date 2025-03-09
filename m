Return-Path: <linux-hyperv+bounces-4306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A11A581E9
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D5D188BDDF
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2DF1A83F4;
	Sun,  9 Mar 2025 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BrtQOnIK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0g6rJL9x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA719259F;
	Sun,  9 Mar 2025 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509709; cv=none; b=rYNaQZ7WZq5OYmMNbuYf0avko51dYvhQsdp375+I8UiKHN2hwLhi+dzS5MRjHLPs14bg1fPH/Cq8D3kPQUCH5q5ipWdd6p9QRSjCSQ4xj9qUiAanPpGYpFWK9//PBCMexNbsuLt8N+1szn4up/Exzk6BY6ggiYkicuhQ9G6pUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509709; c=relaxed/simple;
	bh=9tEtHFlJqE1o/MEINhiPD+GOmg1b1ALbpAOx4KFy+Sc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=aXHs1u+9136L0beIvr79i11d9830YDqXJZxLDWFH8sZxjiU6ZY5sAWi3ZNKKgXYdn4ZG3njofp2X6i/FBno2Kay8NIhk8piihD2P0j71QxoLf6a31g03ENu1OPncB+rrRdSmbSMyFoyXuj9jCuYvukH5j7SRG07ExKvf/bdmVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BrtQOnIK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0g6rJL9x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309084110.330984023@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IiWbXtUeXooyeuJFwLf7yOIiWovf7ZPuVakAtiZcres=;
	b=BrtQOnIKYAJunATsXri4JzRzur6rakZw2kbALlr6ENNZp0zIxRgb5VWBvusyJE5JNrz0MM
	TudKe9G4/rZbycUNV1p65bSLEtPvACDRRgADscQznczRaXvas5LJtRSDZrN/5+kqnK6wW6
	4wLY1ekEC4DWY4PnDt4CIrb08dE2P2t0XL+DfArlEsbgabGiwsTaT5IkjQXTUHF7C8X8gF
	+c3Wx+px9wssYP3HGBhVKCoJ24p7x6aTfFky41t7+aaPaNIfz14xgqFlP1/huyjfXZcZQG
	/Y4OpbdyLJ76pgSq9NKe2BkEHogPR7nJirrJ3nuukPjb8gbL3IzHNHPv5Jv1gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IiWbXtUeXooyeuJFwLf7yOIiWovf7ZPuVakAtiZcres=;
	b=0g6rJL9xuERtADBm6475N2QyTn187OBtIxEGr6ib8mm4NkN7c+xU5SQo6EYiyGRkwsWPxB
	BkKdNL8YCXipvrAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
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
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: [patch 03/10] soc: ti: ti_sci_inta_msi: Switch MSI descriptor locking
 to guard()
References: <20250309083453.900516105@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  9 Mar 2025 09:41:46 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>
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


