Return-Path: <linux-hyperv+bounces-6271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5EB07E3E
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D8C7AC0F6
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0332D9EC9;
	Wed, 16 Jul 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvKHdPMO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40B26AD9;
	Wed, 16 Jul 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694870; cv=none; b=pxK9JbuAlJgGQmsiwl8Ud1oOBbouwUN/zbCB1YktMT9JdSlWMavTyBfVk+XF2Muy0qeMVhoeinH6FR8Ypis3zlhxoeXIAoDsSBypJGcGn8c9/K8Cf4SzDV+JknOdLyvWVML4Wmr3qJMjBWEyW0AlSMxsNmmcJ5R1L9iaoHcDOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694870; c=relaxed/simple;
	bh=GeJXBYx5qreogy5Ib1b/M+uzTrVK0WNP7q/uKYx+wC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V/BRXIUwJ2hCBFkNFEGy53vILy/IaZwWcHM8cqDsm6IRd2gSVP8Yhxyf4Ri0a/QCSml5FwxpcnEGKf0B/Q0a8vPLYfXT3ck2PgeW06R9WtZrsy/RzCO77NvcmpZkxUVZ9ATQaG2oykgMdKQVAwFCcfuDKcwHXJ7GL6RfiwMsgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvKHdPMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2291C4CEF1;
	Wed, 16 Jul 2025 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694869;
	bh=GeJXBYx5qreogy5Ib1b/M+uzTrVK0WNP7q/uKYx+wC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mvKHdPMOuiYnkaLaqsb3FXWodVA3TMXDKgD3HpGfpcNITyHhK+1ZV2+s/s1yjR5bZ
	 wApnXjCZX4+zQ3PIT4L35IPisNDX68Q2WmdUrEN2cMFVmSmp+OJnrLQdZwh6gUT0Uk
	 JKF7nKO2y/dXZX2lpbAs3ppOqgB8AA9fOt60N8srWS475NkyMwFqG8BbMnYHOLP8ox
	 lWhgOVV5pDi/IpvkEehROFwQdf3Gv0ewt/vba5cxM2rJJ6WL/H2kGFGViMFx2Vhcgq
	 v+Y+7BkWHMSYa5GymoXLrMwbNtnvynIaM07xSSYdQhPaHUBygv5m7ayKNTwJsaaVpr
	 WgSOK6tOERjtA==
Date: Wed, 16 Jul 2025 14:41:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
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
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 16/16] PCI: vmd: Switch to msi_create_parent_irq_domain()
Message-ID: <20250716194108.GA2552070@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716111009.000022ff@linux.intel.com>

On Wed, Jul 16, 2025 at 11:10:09AM -0700, Nirmal Patel wrote:
> On Thu, 26 Jun 2025 16:48:06 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> 
> > Move away from the legacy MSI domain setup, switch to use
> > msi_create_parent_irq_domain().

> > -			unsigned int virq, irq_hw_number_t hwirq,
> > -			msi_alloc_info_t *arg)
> > +static void vmd_msi_free(struct irq_domain *domain, unsigned int
> > virq, unsigned int nr_irqs); +
> > +static int vmd_msi_alloc(struct irq_domain *domain, unsigned int
> > virq, unsigned int nr_irqs,
> > +			 void *arg)
> 
> Is this wrapped in 80 columns? I can see few lines are more than 80.
> Disregard this if it is wrapped and it can be my claws mail client
> issue.

Wrapped locally, thanks Nirmal.

Bjorn

