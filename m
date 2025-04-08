Return-Path: <linux-hyperv+bounces-4829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1755A81716
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FE78A3D28
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 20:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CFB3214813;
	Tue,  8 Apr 2025 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N3Lf5SWX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8KIlSZQZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0413CFB6;
	Tue,  8 Apr 2025 20:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145177; cv=none; b=pqcbAqyltqqYpeS54oLV6MSN2SetRZHoSjTR0pa7HvWNSttnXmRYiqj+xveY3sc3E7pswBOozb96rObjVeKxKjw1JJqrV5rQuipCOs6AGbh888Aq3Fe0isV0GRvuaKwtPj39wCToi8jPSWjv+4gpfBldHp3pi248r4rc6iWJipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145177; c=relaxed/simple;
	bh=u39T35B34fYXsBnCwvMFidu0oqxlNOBHbamzZN8WIpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLRK5mPct3TX0+Nuspbz+brjwp96SB9rEVf5fycHmGBfEOC4r7fSveK+J23LVGeXkpZTt1G0Wbs9zkRZgzcIrrL97e6OWTHOK25uIs9VoZbUZOEoMJLuCNITa9YkmtML2s1MRV5c8D/VxahrAm04UzKCWqAb0Z0DGXNDhjeflOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N3Lf5SWX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8KIlSZQZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744145172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHO1UWAx+rQVZhZ6xiO8xRwG9UO76flaCcgfv2XvOAw=;
	b=N3Lf5SWXqan5qexbq5HkKtyCja0aTFOm5S58qHEzNYUeMbm2sikAKQqIJ4bpzVCLN+3n33
	Q7B1hJ5ER2NuFwPOkbu6odJLxj3gcjd4zGEAuG+dcvlyxd6l8wrsZTdhnUXq+MtA38Ibie
	1KwAtdVFa1QP0PlTH5TLVbyxZnbd/QXeZaPTYlrZC4bNWn5fZ46HcZW9Mjqbnw8PBYxYVh
	Gk/VMeg6knYgowR5cgbOUilosA8zwX4AzvzEQ7e14h5iiqnFkh2vj73PeYDxfuS5jl+YTk
	Cshcj1DRBmP9jBeor+N5BuIxfQDOve4RIM4KiSFr7iCO4yk633Tv0gocDtYSrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744145172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LHO1UWAx+rQVZhZ6xiO8xRwG9UO76flaCcgfv2XvOAw=;
	b=8KIlSZQZy1zxpwG55jbCCbtoV6tIGVFf8OSjMqluR9YwqbSREVUDUY5uVZl1UjsFZAl5Fk
	rczOqaqWKfGersBQ==
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 James.Bottomley@HansenPartnership.com, Jonathan.Cameron@huawei.com,
 allenbh@gmail.com, d-gole@ti.com, dave.jiang@intel.com,
 haiyangz@microsoft.com, jdmason@kudzu.us, kristo@kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, logang@deltatee.com,
 manivannan.sadhasivam@linaro.org, martin.petersen@oracle.com,
 maz@kernel.org, mhklinux@outlook.com, nm@ti.com, ntb@lists.linux.dev,
 peterz@infradead.org, ssantosh@kernel.org, wei.huang2@amd.com,
 wei.liu@kernel.org, spasswolf@web.de
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
In-Reply-To: <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
References: <20250408120446.3128-1-spasswolf@web.de> <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx>
 <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
Date: Tue, 08 Apr 2025 22:46:12 +0200
Message-ID: <87a58qv0tn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 08 2025 at 18:20, Bert Karwatzki wrote:
> Am Dienstag, dem 08.04.2025 um 17:29 +0200 schrieb Thomas Gleixner:
>> > Can you please decode the lines please via:
>> >
>> >     scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
>> >     scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
>>
>
> I had to recompile with CONFIG_DEBUG_INFO=Y, and reran the test, the calltrace
> is identical.
>
> $ scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
> msi_domain_first_desc+0x4/0x30:
> msi_domain_first_desc at kernel/irq/msi.c:400
>
> So it seems msi_domain_first_desc() is called with dev = NULL.

Yup

> $ scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
> msix_setup_interrupts+0x23b/0x280:
> msix_update_entries at drivers/pci/msi/msi.c:647 (discriminator 1)

Aaarg. The patch below should fix that.

Thanks,

        tglx
---
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 4027abcafe7a..77cc27e45b66 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -680,8 +680,8 @@ static int __msix_setup_interrupts(struct pci_dev *__dev, struct msix_entry *ent
 	if (ret)
 		return ret;
 
-	retain_ptr(dev);
 	msix_update_entries(dev, entries);
+	retain_ptr(dev);
 	return 0;
 }
 

