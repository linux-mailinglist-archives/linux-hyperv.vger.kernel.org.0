Return-Path: <linux-hyperv+bounces-6093-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFFAF828A
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 23:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85C1856843C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 21:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9186B2135C5;
	Thu,  3 Jul 2025 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYFrFYQO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bWaXK53c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934B2AF19;
	Thu,  3 Jul 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577708; cv=none; b=cWiWSYSJ+XBcpwBhB2QRpOgOJ9BH3MoadP+TFkZD5vw6d8FqSaVmn7SpmW2L9IkZPZFe+ZYYJ/Kwr9sloCfPtWiektHXtlA7785tLrrJrunWkVqVnAo42DyQdqdFwnOTKWw7/dBQ9fUFLGCJF49YOb7razQOV4Vm5q2KyShhQKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577708; c=relaxed/simple;
	bh=doF1JUusy9fYnF34jAg32ZbtCJcXq0q2b/EreVr4l1w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWrB6ZYPXT/Rhh/7ruB2Y1n9gfzrfhqgUVCI5kS4s0TKio5x7PE395Bbo0gbieRpY1vVtzoblhlu0mPGhr22XQ0+tfPl0E6FJlJmsG4OHH2HuEV66J3Z9Cc6mBeVyNfu3aDPRVhA5JbCTc9cvmpT/suhhVRM6Vn7U/VIP3N0b/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYFrFYQO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bWaXK53c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751577705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuSfHDCBdrHLll9p6MJyRsE2HoBAkIn29Et99Ze6jio=;
	b=IYFrFYQO1tfIhbWjskMeQI3itoJRVBQPFIp4KWK/W9o2gLiFMGY1NsFToYDsjlvCKSiKHo
	H2S4Qu1mRNSIt3K3en8Fh1k0EUCNuiIQJaqguEEqYDN0eXSMkVU4zsEn5aS0o20XQrSoUf
	VVyJfxNZz6//D3xUnzWPRP/Dp/prbUDboTms9jp+MIO+uSt89tu1tJp9LJtuC14NEgOaQN
	1yGyOAagwpTVosMu3JunoyyswO9/WeIV2NloYE8HhIgb3bCR/Fimti4aZo4pCwA3LLOMjb
	hZ4JjzeQKhS3AD3KbXyzmYIuJREaDa0ph/YnxVF60rigy3hMwNijBHtxkTXxoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751577705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuSfHDCBdrHLll9p6MJyRsE2HoBAkIn29Et99Ze6jio=;
	b=bWaXK53cGighMH1SvpiRBNIK5QAIv7RA0O/M2RZwhs34n1vzCdNAXb5cYJ922PNXjSOsGq
	qbgroTxaCeSOdKCQ==
To: Michael Kelley <mhklinux@outlook.com>, Nam Cao <namcao@linutronix.de>,
 Marc
 Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
In-Reply-To: <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <cover.1750858083.git.namcao@linutronix.de>
 <024f0122314198fe0a42fef01af53e8953a687ec.1750858083.git.namcao@linutronix.de>
 <SN6PR02MB4157A6F9B2ABD3C69CE5B521D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cyaht595.ffs@tglx>
 <SN6PR02MB41576745C28D8F49081B8E77D443A@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Thu, 03 Jul 2025 23:21:44 +0200
Message-ID: <87zfdlrmvr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03 2025 at 20:15, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@linutronix.de> Sent: Thursday, July 3, 2025 1:00 PM
>> Does it conflict against the PCI tree?
>
> There's no conflict in the "next" or "for-linus" tags in
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/.
>
> The conflict is with Patch 2 of this series:
>
> https://lore.kernel.org/linux-hyperv/1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com/
>
> which is in netdev/net-next.

That's a trivial one. There are two ways to handle it:

  1) Take it through the PCI tree and provide a conflict resolution for
     linux-next and later for Linus as reference.

  2) Route it through the net-next tree with an updated patch.

As there are no further dependencies (aside of the missing export which
is needed anyway) it's obvious to pick #2 as it creates the least
headaches. Assumed that the PCI folks have no objections.

Michael, as you have resolved the conflict already, can you please
either take care of it yourself or provide the resolution here as
reference for Nam?

Thanks,

        tglx

