Return-Path: <linux-hyperv+bounces-4303-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2700FA581D6
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 09:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F156D3AC127
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722901922C0;
	Sun,  9 Mar 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBH7BdEa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d0VKlGQh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9267C19259F;
	Sun,  9 Mar 2025 08:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741509705; cv=none; b=dv6iJX/ju+3PffxJkaNEp+FYfYJ1u1alXsdp35fgp/KTMyjU5MhEb5Nmq6cljruq5DcpL0q+VLQe2DQ2kxwummulxK9zMSM2j2YPKrb5kkqbdHQvOBZDOG2K36d3yoXh1RGvkk64gqHFpwzA1VQYoAh7oJMWvl0u4nhkCCluxGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741509705; c=relaxed/simple;
	bh=B7+wvS0H5Tvvbay210on/RmW5K13iUUkmeu0bzFYdQI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=r+eGYUBMcJMTpZXCvD/cZNEp+7tjoevzRCDiGD1/MQuxsrcg6psHOFRf1BxmcFHdfZX/glXJyJBFGZDAIR7Z21RJAf54FFQPtKzERLZ7ZaGVWK3EC8bSUKmRQxgFD2RfVIcdqTedzQwUGzcKHb3DmDJetCw8myQG7zrpBKeZaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBH7BdEa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d0VKlGQh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250309083453.900516105@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741509701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=+BtvOTDxBKSrzfBN8JRYzd8QwUvKCz/sSeTWqfumMcc=;
	b=UBH7BdEatX6U06QJDJ5oIL+exz/sHBhh1LojixzYjnJInS81ZZexp3980CsIDefb4Hlqi3
	FXPHJj0w7J2tlpnFLAzYqB6pnVcAOKAU9ipjGRV99REq0Hy6qypLcHsV403sgyu4UL+Bge
	dpUpd2iL6v/tLcfPwUREG+FzDd4LggV+98D6iGRSk29W7UJ6q2F5SU6JMNbdrL9vuZi0i0
	JSKkK1jYuzL7OjvtAKVExp2e8CSV04EKhQv6pJBVHYvTNLegrBFtQ+Qp6TfvM+MwcyTbJY
	OpCk+NKsf4CJ6Wq24l9hcB0PL88+F2gZEoSpDWVhAPhAjCbmiPIreI5ZT5BFMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741509701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=+BtvOTDxBKSrzfBN8JRYzd8QwUvKCz/sSeTWqfumMcc=;
	b=d0VKlGQhUDI3jtQPcnQ8cGChLsE8rPBlXgPgqoHOA/+FRv3BnOb+KiPrIOyx7qVUTq25vZ
	8pXTHLJJ1mwj/RAA==
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
Subject: [patch 00/10] genirq/msi: Spring cleaning
Date: Sun,  9 Mar 2025 09:41:40 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

While converting the MSI descriptor locking to a lock guard() I stumbled
over various abuse of MSI descriptors (again).

The following series cleans up the offending code and converts the MSI
descriptor locking over to lock guard().

The series applies on Linus tree and is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi

Thanks,

	tglx
---
 drivers/ntb/msi.c                   |   22 +----
 drivers/pci/controller/pci-hyperv.c |   14 ---
 drivers/pci/msi/api.c               |    6 -
 drivers/pci/msi/msi.c               |   77 ++++++++++++++----
 drivers/pci/pci.h                   |    9 ++
 drivers/pci/tph.c                   |   44 ----------
 drivers/soc/ti/ti_sci_inta_msi.c    |   10 --
 drivers/ufs/host/ufs-qcom.c         |   75 +++++++++---------
 include/linux/msi.h                 |   12 +-
 kernel/irq/msi.c                    |  150 ++++++++++++------------------------
 10 files changed, 181 insertions(+), 238 deletions(-)



