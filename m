Return-Path: <linux-hyperv+bounces-6094-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3EAF82DB
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 23:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DE2D1C81B7A
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 21:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7DC238C34;
	Thu,  3 Jul 2025 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l+1wDbtm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dWJYNReI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BA42DE701;
	Thu,  3 Jul 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751579568; cv=none; b=K82lnVBhfCnINRUoOM9/qbKcoWhITuy0OQaFKb8U25TsaCVFJjItYPeDjuQ/46XlOFGxZy3G88kg6VAZaIC/zHuLy/IDJYnjSRNJdV7PJ0Hj6HVx3JFs6exseTinbhKD/Blz841Yho7l1fNu4bx+8v9akjXGoeJ22/rwFvvUFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751579568; c=relaxed/simple;
	bh=ZfBlx6Su5IrNrWTwuvKm1AACwg1ryPnRlXyNWRIQY6o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PxKkfEStBw3oxJ5xGc2/g4LI5JmDj7L8NLQaifUA9CcKdiqIAmWEpzSMT4AJdq+hdYGS5nIrrGeY4EDY6phFYaTRD2CqPpOz+2TXQTFWT3rJWeVIuujomlBLpy76FGSRS+z7Su0O7S4ltvrwMeli+n//75HoZOTmx0rMk8S5v/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l+1wDbtm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dWJYNReI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751579565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfBlx6Su5IrNrWTwuvKm1AACwg1ryPnRlXyNWRIQY6o=;
	b=l+1wDbtmX5AiOOWEeigcXFhl+t2sTg0fHkUt5qJoqkmSBNRCXEXQXzn4U5Tm2LI/yu7c+U
	XexkvkxZYhwEUaXRifilsiQeAjeM2ZcyBFPslBQh/AV+WCSzGorg9LkFwMExhRslqoeJp8
	O3dT3G9x99c0XqaiDsAIS5SCBB3zcBoQ4ZtaDMeBh+GO2sdqsONGleQB7K5wJUK2ix2SdA
	pRNnB0TQhRJN1mxyeb26CSM92iZW/xIh8UNMII619fFwRx60DDGvjqTEba9PaRXgLHtKm+
	n4fqWlSrHoXXxoPVXsBoDFJrYc0cdF1A8M9zD2YEUQhO1GtDiAu1hYXdx1ojSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751579565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfBlx6Su5IrNrWTwuvKm1AACwg1ryPnRlXyNWRIQY6o=;
	b=dWJYNReIOQ2eB8r/KfLfgDmz4t7V9E3h7DMRPjyZluvj3HLgsHSM3z8I7W5OY/BD31GY2L
	+Lnnu56yF4QvHoDA==
To: Nam Cao <namcao@linutronix.de>, Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Karthikeyan Mitran
 <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?Q?Roh=C3=A1?=
 =?utf-8?Q?r?=
 <pali@kernel.org>, "K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan
 <jim2101024@gmail.com>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel
 review list <bcm-kernel-feedback-list@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Jianjun Wang <jianjun.wang@mediatek.com>, Marek
 Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
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
Subject: Re: [PATCH 14/16] PCI: hv: Switch to msi_create_parent_irq_domain()
In-Reply-To: <20250703210056.sDzAytHT@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyaht595.ffs@tglx>
 <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250703210056.sDzAytHT@linutronix.de>
Date: Thu, 03 Jul 2025 23:52:44 +0200
Message-ID: <87qzyxrlg3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03 2025 at 23:00, Nam Cao wrote:
> On Thu, Jul 03, 2025 at 08:15:07PM +0000, Michael Kelley wrote:
>> which is in netdev/net-next.
>
> I need some guidance here. If I make it apply cleanly to linux-next, it
> won't apply to pci tree.
>
> I saw this type of conflict being resolved during merging to Linus's tree.
> Shouldn't we do the same for this case?

There are many ways to skin a cat. See my other reply.

