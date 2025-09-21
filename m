Return-Path: <linux-hyperv+bounces-6969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A0B8E185
	for <lists+linux-hyperv@lfdr.de>; Sun, 21 Sep 2025 19:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9286A3BF37A
	for <lists+linux-hyperv@lfdr.de>; Sun, 21 Sep 2025 17:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9041D261595;
	Sun, 21 Sep 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4/7Svp6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7819F11E;
	Sun, 21 Sep 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475190; cv=none; b=d8j8iXYud6S6Q/JHt0xwDRHPgxAnpEGomEgPtXaR0aMs025JU1fgHel8kvaCw9ceELC5N4PN22fIzqbtop9usRmF3AMpfS/FJ8w2mSqJXSsGQsOqFszKhBcV+6Y6QdSLsaEC46orvCIfXQC+HyFCmbFZ8T2FYFVvE0JYNS/9Z+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475190; c=relaxed/simple;
	bh=rxiF7+0X+E1DwELu2yV6ORqUEuJ5BQYtLtP8zWsIpaI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs4JlfU2CVWDdwtPpVTmDiDnK9ypU+IhyrUO3A0FwbhmlH3lElmSXwx3Wzn5JnNw0DzU85pXAJVfs8ddKRxjMQH3ZcD8vPT8VwYntY/DI1ePYThNVEDArPlzEzw2RI+DHPoZbCJ1CbVSLolcyobQrt9PuVBOnXTVvjkmuD6ccG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4/7Svp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58E4C4CEE7;
	Sun, 21 Sep 2025 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758475190;
	bh=rxiF7+0X+E1DwELu2yV6ORqUEuJ5BQYtLtP8zWsIpaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4/7Svp6AnZCeOKbjsm5eSg8NQKXGqzgGhzt1oHC2Jaw2wkJqRR/Lx77QBE/qh7c3
	 tlWvTiszBm2dAbpbNBuNdlAfPf2ZVOZQCyQ9wrFCjom3tnv6mBVuf+aPHZoZ6VRVBw
	 IPXwvAe0UIYT0VfxkFlwDh02s9o7A2R+BZXlB9ogV4yC4FsiZ7vmS0F9SRSTupxy8v
	 eUmTvjfRQhom1jH1wSFN6j49GD2osRCotFGsMjNLAGJPeh0/XJPS1ehi8N5cotcwUj
	 awvcjovcHP77qzG9dNH8B/L6svBqwaP++ul63wxVNEud6cw6+I0No9ua9nzQTKg9m6
	 k+b0AK3XAZn1Q==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v0Nj1-00000008Ctq-0grY;
	Sun, 21 Sep 2025 17:19:47 +0000
Date: Sun, 21 Sep 2025 18:19:46 +0100
Message-ID: <87ms6nyb7x.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: thomas.petazzoni@bootlin.com,
	pali@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	joyce.ooi@intel.com,
	alyssa@rosenzweig.io,
	jim2101024@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	shawn.lin@rock-chips.com,
	heiko@sntech.de,
	michal.simek@amd.com,
	bharat.kumar.gogada@amd.com,
	will@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linus.walleij@linaro.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	rric@kernel.org,
	nirmal.patel@linux.intel.com,
	toan@os.amperecomputing.com,
	jonathan.derrick@linux.dev,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH RFC] PCI: Convert devm_pci_alloc_host_bridge() users to error-pointer returns
In-Reply-To: <20250921161434.1561770-1-alok.a.tiwari@oracle.com>
References: <20250921161434.1561770-1-alok.a.tiwari@oracle.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: alok.a.tiwari@oracle.com, thomas.petazzoni@bootlin.com, pali@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org, bhelgaas@google.com, joyce.ooi@intel.com, alyssa@rosenzweig.io, jim2101024@gmail.com, florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, ryder.lee@mediatek.com, jianjun.wang@mediatek.com, sergio.paracuellos@gmail.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be, magnus.damm@gmail.com, shawn.lin@rock-chips.com, heiko@sntech.de, michal.simek@amd.com, bharat.kumar.gogada@amd.com, will@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, linus.walleij@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, rric@kernel.org, nirmal.patel@linux.intel.com, toan@os.amperecomputing.com, jonathan.derrick@linux.
 dev, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sun, 21 Sep 2025 17:14:07 +0100,
Alok Tiwari <alok.a.tiwari@oracle.com> wrote:
> 
> devm_pci_alloc_host_bridge() and pci_alloc_host_bridge() previously
> returned NULL on failure, forcing callers to special-case NULL handling
> and often hardcode -ENOMEM as the error.
> 
> This series updates devm_pci_alloc_host_bridge() to consistently return
> error pointers (ERR_PTR) with the actual error code, instead of NULL.
> All callers across PCI host controller drivers are updated to use
> IS_ERR_OR_NULL()/PTR_ERR() instead of NULL checks and hardcoded -ENOMEM.
> 
> Benefits:
>   - Standardizes error handling with Linux kernel ERR_PTR()/PTR_ERR()
>     conventions.
>   - Ensures that the actual error code from lower-level helpers is
>     propagated back to the caller.
>   - Removes ambiguity between NULL and error pointer returns.
>
> Touched drivers include:
>  cadence (J721E, cadence-plat)
>  dwc (designware, qcom)
>  mobiveil (layerscape-gen4, mobiveil-plat)
>  aardvark, ftpci100, ixp4xx, loongson, mvebu, rcar, tegra, v3-semi,
>  versatile, xgene, altera, brcmstb, iproc, mediatek, mt7621, xilinx,
>  plda, and others
> 
> This patch updates error handling across these host controller drivers
>  so that callers consistently receive ERR_PTR() instead of NULL.

Not quite.

> diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
> index e00c38620d14..c2c8ed8ecac1 100644
> --- a/arch/mips/pci/pci-xtalk-bridge.c
> +++ b/arch/mips/pci/pci-xtalk-bridge.c
> @@ -636,8 +636,8 @@ static int bridge_probe(struct platform_device *pdev)
>  	pci_set_flags(PCI_PROBE_ONLY);
>  
>  	host = devm_pci_alloc_host_bridge(dev, sizeof(*bc));
> -	if (!host) {
> -		err = -ENOMEM;
> +	if (IS_ERR_OR_NULL(host)) {
> +		err = PTR_ERR(host);

Under which circumstances can NULL still be returned? Because applying
PTR_ERR() to a NULL pointer looks like a pretty bad idea.

>  		goto err_remove_domain;
>  	}
>  

[...]

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f41128f91ca7..e627f36b7683 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -686,18 +686,18 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  
>  	bridge = pci_alloc_host_bridge(priv);
>  	if (!bridge)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	bridge->dev.parent = dev;
>  
>  	ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
>  				       bridge);
>  	if (ret)
> -		return NULL;
> +		return ERR_PTR(ret);
>  
>  	ret = devm_of_pci_bridge_init(dev, bridge);
>  	if (ret)
> -		return NULL;
> +		return ERR_PTR(ret);
>  
>  	return bridge;
>  }
> @@ -3198,7 +3198,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  
>  	bridge = pci_alloc_host_bridge(0);
>  	if (!bridge)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	bridge->dev.parent = parent;
>  

And what about the code that comes after that if we fail to register
the bus? The remaining "return NULL", which will then be interpreted
as 0 in any user of this function, leading to a worse situation than
what we have now.

Also, things like pci_scan_root_bus() have the following pattern:

	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
	if (!b)
		return NULL;

which will end with prejudice given what you have introduced.

If you are going to touch this sort of things, at least make it
consistent, analyse *all* code paths, and provide documentation.

	M.

-- 
Jazz isn't dead. It just smells funny.

