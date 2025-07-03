Return-Path: <linux-hyperv+bounces-6073-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5D8AF7559
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797B53A514A
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0F1DDD1;
	Thu,  3 Jul 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poK89coj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbYvE02C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9752934CF9;
	Thu,  3 Jul 2025 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548898; cv=none; b=hmimtRcytBoI/j+AdDoRoEmo4Sl/KQCMQezxzRMf2xkL7RBtYGd0Rpp0BgcprWdH3gXhwh57npK6k0qp8dE259TRZGL57rHiExadEuWFWgpOh8sitX+aj83tQmEWPNGqA5DmDM5IVBm/u7Fvc8bzEhVmjT7oijUWKEMSt+DqKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548898; c=relaxed/simple;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJPvj5oy+cgujEAhMewDmMx9+EHTtjL+7hcKmKbzupiolC0agsmAJnRwrAjnqJqHdSvRPMM5AvvSI1JYak2v6UJc1miup5a1IQ3+3smURYhZ6Fqkyhy971ZyLaSzkcE/OnaNr2NhQb/LopmrSeJ+lWd1slGmwi0f4h6N+45pnhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poK89coj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbYvE02C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751548895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=poK89cojJLljpS4cgoWnZb6taDP6yW5SHdznqNdBryXosLz2ulgnRyyZhCQ3LPmC9p+k2+
	pG8XA++PgQ6zK3IJRPgN8n9zSkK4bhM5YVaZUoy9HXU0inABUpIpauPdIYBJ4tw/SnVrgi
	SjJp5+/UCHRlY3TSEBwnSOSKOW78Z2rmj8DoZGZAOTtMkJQKi/lF4nB8KgXcHpw9jRVp11
	jVvqS9SCXKEtzsCLaF025y0exYbM0tRDUc7upJ41CLq89TZ1NjJ7PGDqFprz/sskMZkdr0
	y2JxW4WyE3cvUXXPl5MqnSLFrnnigMZ/tw3lxoabfHU7fNoWMrAAlJ1eVY36Zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751548895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4kcJobrOnoamaBnANOlfQkU1M63AHPCa2YelSe1E0P8=;
	b=jbYvE02CmDuIdsfrKfu+PXz2pz8LcW3w3IUS2XXybC2X9UaYyEGLCboJeA0CPkfBebwuMJ
	OLYEZ12P7cMhlwAA==
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
Subject: Re: [PATCH 03/16] PCI: aardvark: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <68b2f9387bbe4f08bcd428bfab83ad1219fb8d80.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <68b2f9387bbe4f08bcd428bfab83ad1219fb8d80.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:21:34 +0200
Message-ID: <875xg9wgtd.ffs@tglx>
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

