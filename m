Return-Path: <linux-hyperv+bounces-6089-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C3FAF81AC
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 21:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE3D3B6A0D
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5062FBFEB;
	Thu,  3 Jul 2025 19:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FEw4D24y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gcOi8Aam"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965FB25228C;
	Thu,  3 Jul 2025 19:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751572779; cv=none; b=YV6WVT0a2B9eDenLNn89E07eH8KNNWKVpQNhNmkmerjbtbdd14yomh+8xk57H5ksI2eiA5RtJlGB5utEqeAgq6glcp++lywp6GzmVZuY03ieBJfO2jhQY7h3NKrY87FFvEsWw8D5YvFJ3xuJm/kS2GJ34c95SXi0CHPkjyWjBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751572779; c=relaxed/simple;
	bh=lY55ECqDsxZNqp15zYLwy9T/g7qWxH7wryMpr3+Xu8A=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umdomSU5dX1M9McU7Z2iHH0EvftDowNngl+Mech7ZSi0goYQ3znusofEFoe7pLG/PaAP/JQEii8X1Y7eYx0ni3L9iWSfk7zOjMNzXuXb9YLTgEkUh5wi22FR0TTEobQ4XEBYkN5J5CGbuZKogcou3gFmNi5JLIDSRjSNnvszkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FEw4D24y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gcOi8Aam; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751572775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgxsuIMDDXARhsRWgLrILUs/XsyS+TZEtoBBb/RsYm0=;
	b=FEw4D24yX86GGy1rTWJ6zgH6Tlp5yOHO2h19VrQVJd4soMjXNtcLFhCIhBmDcIfo3afyMj
	GH127yUbXDNuBwtaRHEi3ZdZq1EtVgrFX538bhU2DxEWijBcrYdtsbcPrHNXmmJo9oigK2
	p8tlXD9sQkkbAEVYgixGuE4g/C1C8SERxleQFZ6JK4QAYdSnvoCipiRlj9XG1+zgC+PcYi
	P1+WPyUM/DcSNaeacoqIXzqO0l/JuCUlWJVgJtqJD9sBqQW82ryw/C9BjBZLTQ2Ex85h76
	JpECmRlt2nY9d/HdGO8XKDQWVUSZHBMUUcyw4iSOA9qF3eLPWuCRcbf7lfETnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751572775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgxsuIMDDXARhsRWgLrILUs/XsyS+TZEtoBBb/RsYm0=;
	b=gcOi8AamD60gBuSLM6+XBj7cc6BNGHuWvnQ0nejzuIxbahpVhbP1ZuQex8HvkFndFkmXZR
	hOi5o2qE1taW8LDw==
To: Michael Kelley <mhklinux@outlook.com>, Nam Cao <namcao@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Karthikeyan Mitran
 <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?Q?Roh=C3=A1r?=
 <pali@kernel.org>, "K
 . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan
 <jim2101024@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-rpi-kernel@lists.infradead.org"
 <linux-rpi-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
In-Reply-To: <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 03 Jul 2025 21:59:34 +0200
Message-ID: <87cyaht595.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03 2025 at 17:41, Michael Kelley wrote:
> From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
>> 
>> Move away from the legacy MSI domain setup, switch to use
>> msi_create_parent_irq_domain().
>
> From a build standpoint, this patch does not apply cleanly to
> linux-next20250630. See also an issue below where a needed irq
> function isn't exported.

Does it conflict against the PCI tree?

> At runtime, I've done basic smoke testing on an x86 VM in the Azure
> cloud that has a Mellanox NIC VF and two NVMe devices as PCI devices.
> So far everything looks good. But I'm still doing additional testing, and
> I want to also test on an ARM64 VM. Please give me another day or two
> to be completely satisfied.

Sure.
>> +static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
>> +{
>> +	struct msi_domain_info *info = d->host_data;
>> +
>> +	for (int i = 0; i < nr_irqs; i++)
>> +		hv_msi_free(d, info, virq + i);
>> +
>> +	irq_domain_free_irqs_top(d, virq, nr_irqs);
>
> This code can be built as a module, so irq_domain_free_irqs_top() needs to be
> exported, which it currently is not.

Nam, can you please create a seperate patch, which exports this and take
care of the conflict?

Thanks,

        tglx

