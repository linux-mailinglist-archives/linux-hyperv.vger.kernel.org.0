Return-Path: <linux-hyperv+bounces-6091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D343AAF8263
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 23:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39530171E84
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC41277C9E;
	Thu,  3 Jul 2025 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTn5r753";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mcFlxZK5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCD19F43A;
	Thu,  3 Jul 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751576462; cv=none; b=X2pheJaBeR/lGnzopqXELZvuy5t3LMcAKmYRIMvoHzpiwlPPq8B3oUB5ZXAfuNkZ6UuXLcCqtA26ophgXwHEPY1iX9FJJrbhAk7wjNK5UayAD2sTz2zdiG+UnjEH01qqzuXH6r/PjPgMc6bongtH69/mb1dZ25KCQLW7zTRfvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751576462; c=relaxed/simple;
	bh=LMkJSyY9cv/+8k8DnkC/yiglcrPiZ8K5h/C1h6vibYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MB1h95BEY+x5QixKa3VdozpVb8Z8h6mdP8KbYuEebRd0zJnV1+Qu7LAUEmMCKrlDVXnBT/azCm44kku6XSuHIChOm7Rqka+NhQFPKa3+ghstRGT7tDAH46MjpftCp6K61fNffjKL8tf5x+jw8K7NvT0MkMDQmaxyQMlvdItiuj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTn5r753; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mcFlxZK5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 3 Jul 2025 23:00:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751576458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTXvd5Uvp6Q4AKEPN0WQMwq/tMxtiUVrV4mMQxECWg4=;
	b=dTn5r7531nUAApuRrJVEdSU1yHQgN8OqgV/tVp18i0lXAnb6BkUZgnHlf7StaSFIv0Jz9M
	BNNct7Wcf3Poy9tY7EAT9Iv0/Znzi3/8d4/cCyrLJ+jswLaS3RHVFrD2HuVu8VHATIkPvO
	XQTJ9RS88X/x7KoggIeL5yOlHBDZ3b+BN42a8aWclYymUVLxZ1arwKhzpODAoDqgufFswo
	8UNzyNBkAaC/orKnvXhYvUMZGfJCQsiuDsvGprxUEc9UZHIGlhDHp19N2pX5+0YgB04iQw
	uPk2PRvtk4WZCK2bI5q+tmxx3ytZUeE2DMLnQjzoCEl2sh5+gpYGBiLSlHMbNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751576458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DTXvd5Uvp6Q4AKEPN0WQMwq/tMxtiUVrV4mMQxECWg4=;
	b=mcFlxZK5m7AaTULHDD29cnWKaEO4XCMTydboJXdrQ9VKl2m7LlecU8z5SM+r0xOGESw1hx
	APh3s/XqB5ssTKAA==
From: Nam Cao <namcao@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
Message-ID: <20250703210056.sDzAytHT@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyaht595.ffs@tglx>
 <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jul 03, 2025 at 08:15:07PM +0000, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, July 3, 2025 1:00 PM
> > 
> > On Thu, Jul 03 2025 at 17:41, Michael Kelley wrote:
> > > From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
> > >>
> > >> Move away from the legacy MSI domain setup, switch to use
> > >> msi_create_parent_irq_domain().
> > >
> > > From a build standpoint, this patch does not apply cleanly to
> > > linux-next20250630. See also an issue below where a needed irq
> > > function isn't exported.
> > 
> > Does it conflict against the PCI tree?
> 
> There's no conflict in the "next" or "for-linus" tags in
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/.
> 
> The conflict is with Patch 2 of this series:
> 
> https://lore.kernel.org/linux-hyperv/1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com/
> 
> which is in netdev/net-next.

I need some guidance here. If I make it apply cleanly to linux-next, it
won't apply to pci tree.

I saw this type of conflict being resolved during merging to Linus's tree.
Shouldn't we do the same for this case?

> Michael
> 
> > 
> > > At runtime, I've done basic smoke testing on an x86 VM in the Azure
> > > cloud that has a Mellanox NIC VF and two NVMe devices as PCI devices.
> > > So far everything looks good. But I'm still doing additional testing, and
> > > I want to also test on an ARM64 VM. Please give me another day or two
> > > to be completely satisfied.

Good to hear, thanks!

> > Sure.
> > >> +static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
> > >> +{
> > >> +	struct msi_domain_info *info = d->host_data;
> > >> +
> > >> +	for (int i = 0; i < nr_irqs; i++)
> > >> +		hv_msi_free(d, info, virq + i);
> > >> +
> > >> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
> > >
> > > This code can be built as a module, so irq_domain_free_irqs_top() needs to be
> > > exported, which it currently is not.
> > 
> > Nam, can you please create a seperate patch, which exports this and take
> > care of the conflict?

Will do.

Best regards,
Nam

