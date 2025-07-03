Return-Path: <linux-hyperv+bounces-6082-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFEBAF75AD
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BEE54381F
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4010A2E2EF7;
	Thu,  3 Jul 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2B5McK0S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZziIAgfs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3BC2E2EE0;
	Thu,  3 Jul 2025 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549390; cv=none; b=Q2LWEhGk3ioIFiEQnRIthtfSzwjgMSYyQFiyIjGW6z2yaeENQJdfTcl6TZLZrq8JoeYL4r2pO3vFqgHxsAjTaHp1YTHMPQ8kZoSpPG++KlsrNjT02e1seke5EtLP5A3hTfGd7bKYxTkR1oUxIXe4s77XRIAf960ATjZO6Z1xadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549390; c=relaxed/simple;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GS3qBmU9jTt00/oNiwMcdJusyxPR8KOhPOSa4UxyHTl2c2l2c4qpNQiwylozIH6hSpBAjZUq2VEFPg69SCHiKZ4HOFU+52vRqsUj/yK/aKRWpWx/H7obgpbhdhEhaA2st3LVk2yhYKF8z3nxv/qbBawbeyvfSbKJpoBm5bumH8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2B5McK0S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZziIAgfs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751549387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	b=2B5McK0SKryyStR4OnxLzCMH9jmj6Uica4T0tpF2J9MRZJcRGUqodK1yhhydxLQ0eJdN6R
	00I/D3U21EFmTbfIdOdcK6eoZPauuTP6bcK8GLOUxQDNqVNMpW973xf+XeNuoATSgoXJSJ
	w4bCKVd0oXueFYiRooEc8yHNO4KfoMmfsO8sW6yaLXQ0kneo1T30wpLLcXYgxRLfIh24Ij
	hIYgtI4LC6N0LtKsQafre4s5O6OJ4BpC6JNIYkRqs7Jjv3gCmI5tT8dKHTgA0H8jYD06WC
	p38rHYZx5kCh7+AYBeI/zXT4Ci3KoLtOCPqIcSqsuABO4CHensISTYqzZhGeVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751549387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	b=ZziIAgfs4UH5dxXIOzWwmn1b6pdrIANkYDUK2xrQq52h7jllLfRTup5qqWWCfnei2A21CS
	AzKefBZrq01jCnDg==
To: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Karthikeyan
 Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang
 <Zhiqiang.Hou@nxp.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>, "K . Y . Srinivasan"
 <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Joyce Ooi <joyce.ooi@intel.com>, Jim
 Quinlan <jim2101024@gmail.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Jianjun Wang <jianjun.wang@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Michal Simek <michal.simek@amd.com>,
 Daire McNamara <daire.mcnamara@microchip.com>, Nirmal Patel
 <nirmal.patel@linux.intel.com>, Jonathan Derrick
 <jonathan.derrick@linux.dev>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 12/16] PCI: xilinx: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <b1353c797ce53714c22823de3bd2ae3d09fcd84f.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <b1353c797ce53714c22823de3bd2ae3d09fcd84f.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:29:46 +0200
Message-ID: <87frfdv1v9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:48, Nam Cao wrote:

> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

