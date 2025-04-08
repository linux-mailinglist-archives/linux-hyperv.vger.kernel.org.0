Return-Path: <linux-hyperv+bounces-4819-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27CA80F75
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 17:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89981B61413
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7008522A81E;
	Tue,  8 Apr 2025 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vQ0SxnBR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A7yhWpVz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13DC1E8348;
	Tue,  8 Apr 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124962; cv=none; b=iCM7pBfIbdQc6+9sDGxlYTuPEm49DUbuTW1bnhObRqcqqlcYXbsI175hQL6b8FpBOZv+TC0OvT7KvRew3cOj6RZp0PGERW09KhEbdnocSZfYQhaKu8frNkHwJ/5jUEsy5Nd007LdxwZ0+czjQR8oVOz6ZyENCy/qye+qYPgOB6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124962; c=relaxed/simple;
	bh=KfZp5sOMLhUjS958RvECX1/aPL/JVAyn8rQO3+gzo4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nPDdgUCFqaXebx2kWPJ85S0b9l+mAoJwlmjI4OLH5Vjuy5yCJTYoqC80bAjYJkmsv3wEiOp+NWYIkOtbgAevdwLruikLrZDdIVNih99PH8xuGe7ub0vYNdEtCjv6qOi1WVeMNRP27khdakNvjYLBP4gW8YnEX+wyQWnEXebSlho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vQ0SxnBR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A7yhWpVz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744124953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLZRLH/712vh97T+Cj7EHgs1xlJmlFXKT4+PuzmWYVE=;
	b=vQ0SxnBRBFif4SBTr1JHxo86wY2TiqcahO4BLbwviSFg+TxUs/TqpUAzI+A9H+qrecT47n
	uaAZLehOFtO2cS0aMrwyMratDAIFf3LRdXSs8D5ksrr1jao2lYsSHb4HkT/JHgrJcIkGdQ
	P4c0n5scFjUFKChtVVKksGBoSDjOw4zExsifB73w509bnSCEGJK3cAQ021jvWZwKP9rKuM
	uUEFOakfJB5C21bGfOEMv883Bh0RTGrbDbr/6m2kmycVI1NK0Z/n7OlVCPHgEbYyQMTg1X
	ZurYgDqxO0tkBqaMG3AavucoBcutqttybAB/qrhs+ZKPM59FkSxfm/pE1rzflw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744124953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CLZRLH/712vh97T+Cj7EHgs1xlJmlFXKT4+PuzmWYVE=;
	b=A7yhWpVzxzZ7h8xWz+gWEdgrzFDb3axJw4JoyUoRRn5JJG4ybMGxSjrN/VqG3a6AE6v1FQ
	3r2s0FKn/eRUvAAA==
To: Bert Karwatzki <spasswolf@web.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 Jonathan.Cameron@huawei.com, allenbh@gmail.com, d-gole@ti.com,
 dave.jiang@intel.com, haiyangz@microsoft.com, jdmason@kudzu.us,
 kristo@kernel.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
 logang@deltatee.com, manivannan.sadhasivam@linaro.org,
 martin.petersen@oracle.com, maz@kernel.org, mhklinux@outlook.com,
 nm@ti.com, ntb@lists.linux.dev, peterz@infradead.org, ssantosh@kernel.org,
 wei.huang2@amd.com, wei.liu@kernel.org
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
In-Reply-To: <20250408120446.3128-1-spasswolf@web.de>
References: <20250408120446.3128-1-spasswolf@web.de>
Date: Tue, 08 Apr 2025 17:09:12 +0200
Message-ID: <87iknevgfb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 08 2025 at 14:04, Bert Karwatzki wrote:
> Since linux-next-20250408 I get a NULL pointer dereference when booting:
>
> [  T669] BUG: kernel NULL pointer dereference, address: 0000000000000330
> [  T669] #PF: supervisor read access in kernel mode
> [  T669] #PF: error_code(0x0000) - not-present page
> [  T669] PGD 0 P4D 0
> [  T669] Oops: Oops: 0000 [#1] SMP NOPTI
> [  T669] CPU: 2 UID: 0 PID: 669 Comm: (udev-worker) Not tainted 6.15.0-rc1-next-20250408-master #788 PREEMPT_{RT,(lazy)}
> [  T669] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
> [  T669] RIP: 0010:msi_domain_first_desc+0x4/0x30
> [  T669] Code: e9 21 ff ff ff 0f 0b 31 c0 e9 f3 8c da ff 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b bf 68 02 00 00 48 85 ff 74 13 85 f6 75 0f 48 c7 47 60 00 00
> [  T669] RSP: 0018:ffffcec6c25cfa78 EFLAGS: 00010246
> [  T669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000008
> [  T669] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000c8
> [  T669] RBP: ffff8d26cb419aec R08: 0000000000000228 R09: 0000000000000000
> [  T669] R10: ffff8d26c516fdc0 R11: ffff8d26ca5a4aa0 R12: ffff8d26c1aed0c8
> [  T669] R13: 0000000000000002 R14: ffffcec6c25cfa90 R15: ffff8d26c1aed000
> [  T669] FS:  00007f690f71a980(0000) GS:ffff8d35e83fa000(0000) knlGS:0000000000000000
> [  T669] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  T669] CR2: 0000000000000330 CR3: 0000000121b64000 CR4: 0000000000750ef0
> [  T669] PKRU: 55555554
> [  T669] Call Trace:
> [  T669]  <TASK>
> [  T669]  msix_setup_interrupts+0x23b/0x280

Can you please decode the lines please via:

    scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
    scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280

Thanks,

        tglx

