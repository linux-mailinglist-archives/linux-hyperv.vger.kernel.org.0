Return-Path: <linux-hyperv+bounces-4544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D779A650F7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 14:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C8A3A6CD4
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Mar 2025 13:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747EC241662;
	Mon, 17 Mar 2025 13:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A0fuhMpQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPutzsMP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646423F41D;
	Mon, 17 Mar 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218169; cv=none; b=WqHTHXxufBAuEfLuImVzsTw/ak/eaFhLSzfo46jPtK4PtP35/EiJQRuJhBkioo3L02eThgUrOTG7kUs4h38FwUHy61HXgEQwSiUXjUbVYtwBjIr8lUkP7WmUGL3CAMZA8iRESH1U6UqrDzOPDhYYSk6PB8PngiijuCvw+4tnGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218169; c=relaxed/simple;
	bh=3FyrNeDeo6PuudCPLtSK1Wvo8s/2uyQqMBBJ+Hz0upU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=mbjCumfAnSR1Mtm0XLJFpSlDhWHef+pnNHMaqgyrk1a8qqEquFziWbV/crOAboatmEaWBAXxP+/N07hYYWnQv0lRR4Xt9hn0w9nc1FEPkVt7kW215OPXtyT0tDE8XWM1Yn4QV9RMf5NFStu+E9nS12n/uHexKaIhL+Q72OT5Kdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A0fuhMpQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPutzsMP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250317092945.953189553@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742218166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=j38ae1J786gvtJe/THvWhwBIOiRP6lJqXx4r70BjdWE=;
	b=A0fuhMpQc4rT72k4I3p9aWAwouOb045M4R4kxN1HcvFY3aA04PoVnFyJQ6qCHka6Z7NpSm
	4rl4dhHcAO0DqsoHKs33Y2P64ZRbz8IC6S09ym3CMqk9yQ62NC8TKXcsCN5RF4M2isVgPp
	FVbQ2FsOcS2iHEwp2UOtNsqXXJddARazMO+Hdu2134rKpJeuSIeX2MXOCkxiZLfx5nAQln
	TQuxZB+MRZ+n7/NEtg0C6WSRYMfL6h+tj/nxzdBFIOjFzJNfgpO+WsXJJFSt5gDLqXs/QP
	zhvyfjNNgVaE+pHLz75g8gA7vCX/PYxF/U6I1n2p5TIe5EpcpLB3/hwQHHJhHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742218166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=j38ae1J786gvtJe/THvWhwBIOiRP6lJqXx4r70BjdWE=;
	b=JPutzsMPXYyTRbsOtw/zuQsFh12RMgm7HrdsKssaS/80A9owsje+/jMUa1UjCWTgNvToXf
	qrrWloOn508zQyAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
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
Subject: [patch V3 04/10] NTB/msi: Switch MSI descriptor locking to lock
 guard()
References: <20250317092919.008573387@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Mar 2025 14:29:26 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev


---
 drivers/ntb/msi.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -106,10 +106,10 @@ int ntb_msi_setup_mws(struct ntb_dev *nt
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(&ntb->pdev->dev);
-	desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
-	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
-	msi_unlock_descs(&ntb->pdev->dev);
+	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
+		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
+		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	}
 
 	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
@@ -289,7 +289,7 @@ int ntbm_msi_request_threaded_irq(struct
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
@@ -307,17 +307,11 @@ int ntbm_msi_request_threaded_irq(struct
 		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			goto unlock;
+			return ret;
 		}
-
-		ret = entry->irq;
-		goto unlock;
+		return entry->irq;
 	}
-	ret = -ENODEV;
-
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
 






