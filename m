Return-Path: <linux-hyperv+bounces-4469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB8A5F522
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E741681CE
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A802676F1;
	Thu, 13 Mar 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xu9B6jX0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmm9pipc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81C1754B;
	Thu, 13 Mar 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871020; cv=none; b=tjhpvw3M12+WS2LdYCkfL0As8LWFGIHaIdUpvNZJhxfwQPAgsGj3ZkZqFCkOpMRMp8yJ7XGr+KFdNG2swk16Bw+/2kHs9HLUomO2qzv7JeSTXBAKpd/40zmd0Ehau378KoX70hzwpJDZWncW1FCxbOrDSoLJVA/PxZ0Zdo6Ttg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871020; c=relaxed/simple;
	bh=itf7yPjVu4MDdvOWYPG+ta0dwjJEz7i5UcsuklyablM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=hgAOza3XL5qUC48687S9ggWi3gKkxVFCnpTOu+NxhHtUQ2iUxi04fQ2kHBvazg7hQDp8LW5Jy0nP+pdP8vaxjrys73HKNsafbVbFkwQL4Ylq1fSVlnZUNQKE/sced/i4gIrgYFYyFIktUO4fmeF1xglOOsADTEt3SnT4ZJqXUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xu9B6jX0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmm9pipc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313130212.450198939@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=xPY90hzZgcytKWwY72qh7D+Sw/TVwHNJaHMkC6cM7Tk=;
	b=xu9B6jX0BitUNzaISeFeThEJnp7Seq4R6IOnTZdLDeCbyqddtCIJZ6mZF4NEFznX8REBDg
	klHluoz+jf3dHBAG1uhG6aU1xKomYyz4oznZnY8I/ppEYJBo4NqALgVg8LtqAzLV53VJ6m
	Rbbg5wwxU1049pFZfESGAGzaI5EPCw6fWFMSvi9RqCNUVBCodu+oI7icNaRj59Oas8V8rs
	of/HpIIjdzWftq62usw2x2Pzuj0K7pwMXMgVHcJ6LzHHx4Nrp/93CrD8ytIDMk+J/78weE
	cR7oJxhjgfWWugEG96AiyfW6JhgPNDJCZzfw+Y2ehCb/uyscj1TAHAe6/7xIBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=xPY90hzZgcytKWwY72qh7D+Sw/TVwHNJaHMkC6cM7Tk=;
	b=dmm9pipcXb6n8F9sdeZ6O1motxtWkyA4tc/Ln7g9jEpLmDYQUomQgAPMieHs1PDkordDEK
	LtZ/GMy3hhl6RtCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
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
Subject: [patch V2 00/10] genirq/msi: Spring cleaning
Date: Thu, 13 Mar 2025 14:03:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This is version 2 of the cleanup work. The previous version can be found
here:

   https://lore.kernel.org/all/20250309083453.900516105@linutronix.de

While converting the MSI descriptor locking to a lock guard() I stumbled
over various abuse of MSI descriptors (again).

The following series cleans up the offending code and converts the MSI
descriptor locking over to lock guards.

Changes vs. V1:

   - Introduce retain_ptr() to allow using __free() when the allocation is
     consumed by a called function (on success) and therefore no_free_ptr()
     can't be used.

   - Rework the PCI/MSI changes to avoid gotos in guard sections

   - Drop patch 1 as it's already applied

   - Collect Reviewed/Tested/Acked-by tags where appropriate

Patches 3,4,6-10 are unmodifed.

The series applies on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi

and is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi

Thanks,

	tglx
---
 drivers/ntb/msi.c                   |   22 +---
 drivers/pci/controller/pci-hyperv.c |   14 ---
 drivers/pci/msi/api.c               |    6 -
 drivers/pci/msi/msi.c               |  168 ++++++++++++++++++++++--------------
 drivers/pci/pci.h                   |    9 +
 drivers/pci/tph.c                   |   44 ---------
 drivers/soc/ti/ti_sci_inta_msi.c    |   10 --
 drivers/ufs/host/ufs-qcom.c         |   75 ++++++++--------
 include/linux/cleanup.h             |   17 +++
 include/linux/irqdomain.h           |    2 
 include/linux/msi.h                 |    7 +
 kernel/irq/msi.c                    |  125 ++++++++++----------------
 12 files changed, 247 insertions(+), 252 deletions(-)



