Return-Path: <linux-hyperv+bounces-6078-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD6AF757C
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA8D3B0B12
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFA142E7C;
	Thu,  3 Jul 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCLjHwrj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fcdfq4q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD113B284;
	Thu,  3 Jul 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549122; cv=none; b=bhQvIKC0b48grt58RbM0g97ImbtMLDt8vWaKPaQzgfAByXo3s3rEi7F9GZAwkouujVIStVY6MjFVwS/W4BhubbCnnC4oSwySGcK1Cygfd7otvsaWkYnkjXHmP3uXHFIaWXrGv9e+jIWzVPdAfw76xnyZlNT6N7ILoYtzTgRvS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549122; c=relaxed/simple;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IQOyv+ciCDZWj/d7i47K/gnntJG2iACnEbVOS26LjIcnYJCOeY8uXqTzeNAX9h9KPf9xSFTNjmeSk29wLcgjX7lNmXLDSt/oJQJdHqEgeHTtBrlCpVBQMsFrDB8AGDNACAB95dQfV4XXFF40TbxoJbS/fJOmrmKdpte9k2eRJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCLjHwrj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fcdfq4q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751549120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=KCLjHwrjyZDoBJLK4wwpBJ7d3GQ0k+wmP1IXbJO006m8SOinO/JYWnTT6bbHl/0wBVktKF
	BSYrU2GF0U8155pIgX2Ci2Se5IOqlO/FrTGCxNMAlUKt+Jna/UIZwBPULUmjAi03WBmERI
	2l3bFiDIpz7z51I8FAansP1cp/qpPmKExq2KJ/CpTDTpc05vLJgGuy84RcYbo0Ex+V01I6
	d/8wPCNHOEJ+WTS3L/K5VVL7W0JZNTFpbIzIR/xeFjK/gSkkLB6n7Ur7IfNP1QCgv79DzS
	1bHp7qWmZhFSRfemAzPrBDgQMTjn1BmfUCEs94KUoaQ88X6lZp44lynYY+s2xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751549120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=1fcdfq4qRK4kGs9A/7sYXXanNbEI3CxvaTy5Q19bLgwOy+2K2yTQCiTXf+GTSLIQlDUnTo
	PeWrQdQArXVL14Dg==
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
Subject: Re: [PATCH 08/16] PCI: mediatek: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <76f6e6ce6021607cd0fdfd79fef7d2eb69d9f361.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <76f6e6ce6021607cd0fdfd79fef7d2eb69d9f361.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:25:19 +0200
Message-ID: <87qzyxv22o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:47, Nam Cao wrote:

> Move away from the legacy MSI domain setup, switch to use
> msi_create_parent_irq_domain().
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

