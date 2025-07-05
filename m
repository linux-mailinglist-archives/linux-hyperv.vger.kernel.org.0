Return-Path: <linux-hyperv+bounces-6109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02FAF9F7B
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E54C1BC821F
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Jul 2025 10:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45220E704;
	Sat,  5 Jul 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QryWv1ko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNYWzMQy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702242E3704;
	Sat,  5 Jul 2025 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751709737; cv=none; b=fsDmMaGCjqZt7Q4D4yPGLBcVt4R36dE4LxAzsQl+HzN4rugrOn+o9q2IwYKyW2zep+Nrk7bkSXZ5rQ7EV//dnl6eihfmjbN+rQMJhIuyMD64lG109M8zpJAz1B6K/uBcfgL8ShEmsU6kocW7kvB9xv+z3iSKqTuQNtayZgYoVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751709737; c=relaxed/simple;
	bh=M8fK8ZQeoQG2ZZneJ2DhG8Z+hpVXThcLVNcqGhy06IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb2bzFa3KOmNZsQk/T8ewK3rzHg1Mwc5ZXs4m6tcG74Y30qLoHwxIlw6WZ0YrgSEFPemDazUhCsKgBW0iz22+/ZDMpe4TYJ5sVIQW5lmpw/He4PlSkg2YM88Ejt1CLGLCB8m5xyPMg3Al0g+5wscxwxPOe3kT/1xFIse/PO5FSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QryWv1ko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNYWzMQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 5 Jul 2025 12:02:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751709733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7gL8dYOn6HntTdoNOII9WcyvTWhgCfl9lUbpV4BSls=;
	b=QryWv1kobeUtwnxLuKJ37S6P8dABaWh9TKOGc6zMPDghXt2id9g6pM+FYsMis+ZKJBTVnj
	dlnc4u4f0GfCPVtSF6CbPb8KTJ8TBAw6gTF8p7KtEjpgbZfG/Tp238Kt2oVG/JiK4Yv86d
	TmK8kxBOghlbVe7uwkQvgmpIZn1AeKVkyRDP1L1qDIwY+BB6JWJJGMCn4E86xhKLJLfqIZ
	2rHlzbD3g/DlC3hbV2SaFJ2hywtVHkcbGf7F7HvL6X4DZPT5+w7iWsEv258XUOom/m6Av1
	sDJJaJgZmk27zMD1f/rKLs3Mr2NJu0tT+SUkxrBrdJJ7iMCZz1C2qtat2oJVrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751709733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S7gL8dYOn6HntTdoNOII9WcyvTWhgCfl9lUbpV4BSls=;
	b=rNYWzMQyLXhzp3rk6oAdNJ4riQJleM33X757xJJVV0sKCPdsOXDWifHu++6mf5hqn28UWl
	IO/D0kVyNb7D4FAQ==
From: Nam Cao <namcao@linutronix.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20250705100211.8Lcszko3@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB41571145B5ECA505CDA6BD90D44DA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250705094655.sEu3KWbJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705094655.sEu3KWbJ@linutronix.de>

On Sat, Jul 05, 2025 at 11:46:59AM +0200, Nam Cao wrote:
> On Sat, Jul 05, 2025 at 03:51:48AM +0000, Michael Kelley wrote:
> > From: Nam Cao <namcao@linutronix.de> Sent: Thursday, June 26, 2025 7:48 AM
> > > 
> > > Move away from the legacy MSI domain setup, switch to use
> > > msi_create_parent_irq_domain().
> > 
> > With the additional tweak to this patch that you supplied separately,
> > everything in my testing on both x86 and arm64 seems to work OK. So
> > that's all good.
>
> Thanks so much for examining the patch,

Btw, you probably would also be interested in
https://lore.kernel.org/lkml/cover.1751277765.git.namcao@linutronix.de/

which does a similar conversion for the other hyperv driver.

Nam

