Return-Path: <linux-hyperv+bounces-6080-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47444AF7589
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 15:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADA91895407
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 13:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A47013B284;
	Thu,  3 Jul 2025 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uMJoD7xy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMsmDlmo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261381E;
	Thu,  3 Jul 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549228; cv=none; b=lkk//vA4QIjmdeqgj3EMgGXDeep20gcIKMnB0XfWVTdiDeym/TbZJ0NuswPlip+vkWIMcVXFy8XCvRcBHEhugolKLxiFJja2hlS4X0fvB3S9Zrx2P2BnqHM4TbKFRFlLoR2weuY2hF9ijIYkLu5LgAQKx2pKIqlXTH9sx4icsyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549228; c=relaxed/simple;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGTir5AJN26tUQA/xJGLCHN8QI4b736jJ/BAEhWZd69Kkk2kCaqSqHz40Xo2ExLZxw82lPbgcSUw0xIjKoapFnOIsfF7+DeTzF4c714wAOt8zRUXb+zi7SqqHOy94BBjhulqjatV57LynvZR45zW5lMvaV/VMrx13vi3HXovpa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uMJoD7xy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMsmDlmo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751549225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	b=uMJoD7xyJM4mpWpwx8uMkF61D3OSN7oknYYGpiM0XpxjAGlSQvf0htdfvIiG4r3WneeMP7
	Iwx1xMt5aW5GeNFBIL0350ThYSJ5LQM/YLRnBt48879KJ2A37O82tISh6pIK8BLjtnamr/
	rD94AjqQGVuFCVR2tJkO8l7Q/B0kt2v0fYdEV+lEx7VkqnVpIycWHJu6bE0M/ZHrjWOQIn
	m/sf/quPagJMSw0dZVkdD47v/DqaTXVg71kmM2kQbiOw13Zmgc6UvLAOJFCVPGASfpyoX+
	3Fohow0L/hJmKlIo/c5A9GOoaqoJAWjEHx8tO55Nkv/4O9hFvtb943kFp3zjkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751549225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81HmvwHeiUSGmL4dZb3PXIm6QmppJrUMFGfEmXnv22o=;
	b=UMsmDlmo/89Km8xvhCIeKLe46rLrXMtkmUwJpQ03b0vjvL81Vo7JWNr+Fqtj9RRiktPFYy
	vOYoRbBu4vYfvyAQ==
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
Subject: Re: [PATCH 10/16] PCI: xilinx-xdma: Switch to
 msi_create_parent_irq_domain()
In-Reply-To: <b4620dc1808f217a69d0ae50700ffa12ffd657eb.1750858083.git.namcao@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <b4620dc1808f217a69d0ae50700ffa12ffd657eb.1750858083.git.namcao@linutronix.de>
Date: Thu, 03 Jul 2025 15:27:04 +0200
Message-ID: <87ldp5v1zr.ffs@tglx>
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

