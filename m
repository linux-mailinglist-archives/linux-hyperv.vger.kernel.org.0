Return-Path: <linux-hyperv+bounces-5192-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D1A9F08C
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EB6189DE95
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D9268699;
	Mon, 28 Apr 2025 12:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pkhNkodw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFq8vrNV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D69263F49;
	Mon, 28 Apr 2025 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745842982; cv=none; b=erwAzm0dI0OCtgk7/4a/7cu1Tdv+vQMA4K8N2mfjoM4rLeHf1vFOkybAzY6LpAKcgpsgaKaFlmf4vq+MBHZeRG9ZwEI2MxnLtv2zYs+NvVojg2Psi+HYeWH/EY+bkGraycBswMKoUW/wZX+C4hYbELsK6vN7imbwURrq+0a+2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745842982; c=relaxed/simple;
	bh=qu645lgNZlFFzG0htqALVnBK1i71+x8/vctlUfK0K+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KEV5rDtGylNZadt3kTzkz+JJ/tHEO6LKH4vpa1+ftqIvgAS0XTlpSxIfMTHKSVK9ib8YDzTYiS5UDfh5AzgaesCSky/rvlwhazD55b6wmV/v9ePWBUNPPQihbmT2pxxyET8nH4eCDswiiN1wwwU0EKpuYOg9HolaFztTnmXZjm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pkhNkodw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFq8vrNV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745842978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eqbeYenCoXA19FMuRWvc/t4gtyyENrf27sMY4k0b4s=;
	b=pkhNkodwO4KW67rRMrgKHj8goQcEjLfSkdCc5rgJ+k/ImFFmmRMDNJEZ3fG2y/3RgjJAG8
	A5IX/fR4cVAZmRogZ1ZH+O+vTWtRJcxBBsHVk8Kd3GrgFndTXJagY9PJsbDoJxNVAOgEpm
	yXeq4NSQ2euBkVK/y44Gefnsd1LozszWF1YDpok/kKW5+sbejD/Bof/FVk5YAN4nKknOEr
	1RP0cTuahcxrFMijTXukp7M2R6pDrO4zco/0B6GtpxoxBjE220VdpEBg8rTKiTpvARujQm
	0aDDIpBbal5EMqSzNvWLWukfGCJ/pfW2muskJQhZhvvRMEgTFg2YZbxY92M5Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745842978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9eqbeYenCoXA19FMuRWvc/t4gtyyENrf27sMY4k0b4s=;
	b=NFq8vrNVQP+PQ/rGE0c7BJnVMM38KGRo7gMhYmSerEMU6XlRBeoXKuwgnzHdckRs5fHmGR
	ol0CKgEM1LjXlTAQ==
To: Bjorn Helgaas <helgaas@kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury
 Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan
 Cameron <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long Li
 <longli@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring
 <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Leon
 Romanovsky <leon@kernel.org>, Maxim Levitsky <mlevitsk@redhat.com>, Erni
 Sri Satya Vennela <ernis@linux.microsoft.com>, Peter Zijlstra
 <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 1/3] PCI: Export pci_msix_prepare_desc() for dynamic
 MSI-X alloc
In-Reply-To: <20250425163748.GA546623@bhelgaas>
References: <20250425163748.GA546623@bhelgaas>
Date: Mon, 28 Apr 2025 14:22:57 +0200
Message-ID: <87ldrkqxum.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 25 2025 at 11:37, Bjorn Helgaas wrote:

Subject prefix wants to be PCI/MSI

  git log --format=oneline path/to/file

gives you a pretty decent hint



> On Fri, Apr 25, 2025 at 03:53:57AM -0700, Shradha Gupta wrote:
>> For supporting dynamic MSI-X vector allocation by PCI controllers, enabling
>> the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN is not enough, msix_prepare_msi_desc()
>> to prepare the desc is also needed.

Please write things out: ... to prepare the MSI descriptor ....

This is not twitter.

>> Export pci_msix_prepare_desc() to allow PCI controllers to support dynamic
>> MSI-X vector allocation.
>> 
>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

> Thanks for the update and for splitting this from the hv driver
> update.  Will watch for Thomas's ack here.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

