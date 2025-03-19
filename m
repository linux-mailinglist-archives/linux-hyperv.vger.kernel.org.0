Return-Path: <linux-hyperv+bounces-4602-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B8BA68A1A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4FD3BFCE3
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD73254856;
	Wed, 19 Mar 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2qjPf66V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="its2kKCz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9C5253B71;
	Wed, 19 Mar 2025 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381800; cv=none; b=p5muNNVNxzvdzj7aZk6/5OfovlGtPd6NSPdAB5YBrBgSo3pWrT620rlGkZbMkbhwCbLyfLtzwmDrVen7809HlFvLgQ8Qcevdy7onWz/92sScFmdJ3D9eHokUBXXiOyiCoe1j/KN4X+HI00dDzoQRe32HZsV60kcxoP0+brgLr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381800; c=relaxed/simple;
	bh=TSXJeh6lToTyUWnZ10Xlm1kbEBJPq3T6mzJPtjIVpFU=;
	h=Message-ID:From:To:Cc:Subject:Date; b=agWwIClG0X1ySku/VKHQBvyCd3FKIOPJN3ScoRxvZ3he5TqtJVx+MoOGntKSWbj1ZON/ERpspTfoof7QUX/IDaYGarsNbxa2a+U/up93A21usDdl57oq4mwZhwAqv8/0mzgl+gmqXuy6wbltyABMfOwCPkXllYIdnpr/Q5wZQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2qjPf66V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=its2kKCz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319104921.201434198@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=hI5ASAvqP7HQ5wUUQMxPxE817aLVip2yZ4lnn4su2NA=;
	b=2qjPf66VuCmToAga2AFc00RaTfnpp19zp3KaXsTOgO8Y7qfafqHAKIbk37PO6hGQdHIkm3
	F2jxxF2ksS9UEHRKr3Pm1xmWDimVur4UNQduAWg8ozMPtnvNLvfylVQSFaBQqFSbPvHpMf
	yewYxa7VECWvsnuXavFr5YtRaf0W1C810iEihhqKSHQf6wubFZEUvBEepvq6uPiM5L3zIH
	cQWFV4VyimwXr4KZOzasTS3QkJE0azQotMbGVgJ0shB4I+2KmveDjZMPVa3YbK/KIhDs9x
	VyLfcS072EqlXYmmCtSGa/CTF1BtHpiswenRjZOz1q6EpkJfTDC2AV0fIhzexA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=hI5ASAvqP7HQ5wUUQMxPxE817aLVip2yZ4lnn4su2NA=;
	b=its2kKCzh5FnnQFlZeSQzlxKwTTriHj6srsTlBCi6UbEwARuObLTxwFSU4PuKuny4+fSbC
	BF8k7CcoIuVJFmCA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 00/14] genirq/msi: Spring cleaning
Date: Wed, 19 Mar 2025 11:56:36 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This is version 4 of the cleanup work. The previous version can be found
here:

   https://lore.kernel.org/all/20250317092919.008573387@linutronix.de

While converting the MSI descriptor locking to a lock guard() I stumbled
over various abuse of MSI descriptors (again).

The following series cleans up the offending code and converts the MSI
descriptor locking over to lock guards.

Changes vs. V3:

   - Cast retain_ptr() to void so it can't be used instead of return_ptr()
     - James

   - Split up the PCI/MSI changes

   - Move setting of pci_dev::msi_enabled to the success path

   - Fix a logic inversion in the UFS change and use a cleanup function to
     simplify the error path - James

   - Collect Reviewed/Tested/Acked-by tags where appropriate

The series applies on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi

and is available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi

Thanks,

	tglx
---
 drivers/ntb/msi.c                   |   22 +---
 drivers/pci/controller/pci-hyperv.c |   14 --
 drivers/pci/msi/api.c               |    6 -
 drivers/pci/msi/msi.c               |  175 ++++++++++++++++++++++--------------
 drivers/pci/pci.h                   |    9 +
 drivers/pci/tph.c                   |   44 ---------
 drivers/soc/ti/ti_sci_inta_msi.c    |   10 --
 drivers/ufs/host/ufs-qcom.c         |   85 +++++++++--------
 include/linux/cleanup.h             |   16 +++
 include/linux/irqdomain.h           |    2 
 include/linux/msi.h                 |    7 +
 kernel/irq/msi.c                    |  125 ++++++++++---------------
 12 files changed, 258 insertions(+), 257 deletions(-)


