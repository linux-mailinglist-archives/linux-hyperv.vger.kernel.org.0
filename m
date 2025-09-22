Return-Path: <linux-hyperv+bounces-6970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BABB90493
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Sep 2025 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCB987A5D11
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Sep 2025 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434022FB96C;
	Mon, 22 Sep 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QbK+hulz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414C42AA9;
	Mon, 22 Sep 2025 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538521; cv=none; b=tywFj8wsyk4+j06p1PsOWWgCdMB3NCU0+nkaGMqWDnxSVKbJZ2lvfPdoQDhDqq7gNszYO62uu5q6H+kMhAxiKu73AfnznWoKT2YuR+CX/K7HautZ2PVbyzOCGk1tbVSqMd44r+j6uPkTqmvijzoJdEnGoZR/otN7wK8ZGDM4S/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538521; c=relaxed/simple;
	bh=cq7Y4UZHdRw2ECiLZbveDiF74dbYePvi+a4phlHnPtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMVH3pam9zl0BgexD/DuhYOkeUEe5Tiq7LaXMPtKj0djaMwZPCFYK0aymcLV3byIj0Pyz49MwORuuT/0LG0eldaJTDjGmubE7rug3x5QTZyIww8pemfWqzZZOI4KRCk0OMs/VuT3xHJathc0abQLFHhbhiFOdoKPVpreHX+W1WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QbK+hulz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758538516;
	bh=cq7Y4UZHdRw2ECiLZbveDiF74dbYePvi+a4phlHnPtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QbK+hulz3cRofs2gz2imTo35BmAq9oyHgdicO4p3aKWCfae83ng/JF1phynRpMfzb
	 EuVXef5tc+M3MEHd287xeKzfT9mVt+1oAR7fUJfVgx3+3R0NuK5/fiasc4TYWglNvE
	 93XlbxP8cERhUsWnHpPuns5AJ8/QRPVLbopOIrgFwyY6Et63A3RawnM1zn/1JF+fnc
	 KfwXMYeSwHpTu7EX1CFTguGhgeeT/Ub6QMEXC+71X8tNYwhdS7THjVwrCyEtsrgZ6w
	 kjrT1HVp3qoNlFHshhrf4KdjEaeexDd1LhSZPWVvZMcV7eqIhhUj3xxB6GEuCySHiH
	 kS8wrgJKWbdVw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AC9417E10F3;
	Mon, 22 Sep 2025 12:55:15 +0200 (CEST)
Message-ID: <e700cea3-cbe7-4ab5-94d8-a211051e2472@collabora.com>
Date: Mon, 22 Sep 2025 12:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] PCI: Convert devm_pci_alloc_host_bridge() users to
 error-pointer returns
To: Alok Tiwari <alok.a.tiwari@oracle.com>, thomas.petazzoni@bootlin.com,
 pali@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, joyce.ooi@intel.com,
 alyssa@rosenzweig.io, maz@kernel.org, jim2101024@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 rjui@broadcom.com, sbranden@broadcom.com, ryder.lee@mediatek.com,
 jianjun.wang@mediatek.com, sergio.paracuellos@gmail.com,
 matthias.bgg@gmail.com, marek.vasut+renesas@gmail.com,
 yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
 magnus.damm@gmail.com, shawn.lin@rock-chips.com, heiko@sntech.de,
 michal.simek@amd.com, bharat.kumar.gogada@amd.com, will@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linus.walleij@linaro.org, thierry.reding@gmail.com,
 jonathanh@nvidia.com, rric@kernel.org, nirmal.patel@linux.intel.com,
 toan@os.amperecomputing.com, jonathan.derrick@linux.dev,
 linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20250921161434.1561770-1-alok.a.tiwari@oracle.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250921161434.1561770-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/09/25 18:14, Alok Tiwari ha scritto:
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
>    - Standardizes error handling with Linux kernel ERR_PTR()/PTR_ERR()
>      conventions.
>    - Ensures that the actual error code from lower-level helpers is
>      propagated back to the caller.
>    - Removes ambiguity between NULL and error pointer returns.
> 
> Touched drivers include:
>   cadence (J721E, cadence-plat)
>   dwc (designware, qcom)
>   mobiveil (layerscape-gen4, mobiveil-plat)
>   aardvark, ftpci100, ixp4xx, loongson, mvebu, rcar, tegra, v3-semi,
>   versatile, xgene, altera, brcmstb, iproc, mediatek, mt7621, xilinx,
>   plda, and others
> 
> This patch updates error handling across these host controller drivers
>   so that callers consistently receive ERR_PTR() instead of NULL.
> 

I think that's a nice improvement - propagating the right error code looks good.

The only thing is - you have to make sure that it never returns NULL, so that
in the controller drivers you always check for `if (IS_ERR(x))` - otherwise with
the current IS_ERR_OR_NULL(x) most of the error paths are wrong.

Cheers,
Angelo

> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   arch/mips/pci/pci-xtalk-bridge.c                       | 4 ++--
>   drivers/pci/controller/cadence/pci-j721e.c             | 4 ++--
>   drivers/pci/controller/cadence/pcie-cadence-plat.c     | 4 ++--
>   drivers/pci/controller/dwc/pcie-designware-host.c      | 4 ++--
>   drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
>   drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 4 ++--
>   drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c   | 4 ++--
>   drivers/pci/controller/pci-aardvark.c                  | 4 ++--
>   drivers/pci/controller/pci-ftpci100.c                  | 4 ++--
>   drivers/pci/controller/pci-host-common.c               | 4 ++--
>   drivers/pci/controller/pci-hyperv.c                    | 4 ++--
>   drivers/pci/controller/pci-ixp4xx.c                    | 4 ++--
>   drivers/pci/controller/pci-loongson.c                  | 4 ++--
>   drivers/pci/controller/pci-mvebu.c                     | 4 ++--
>   drivers/pci/controller/pci-rcar-gen2.c                 | 4 ++--
>   drivers/pci/controller/pci-tegra.c                     | 4 ++--
>   drivers/pci/controller/pci-v3-semi.c                   | 4 ++--
>   drivers/pci/controller/pci-versatile.c                 | 4 ++--
>   drivers/pci/controller/pci-xgene.c                     | 4 ++--
>   drivers/pci/controller/pcie-altera.c                   | 4 ++--
>   drivers/pci/controller/pcie-brcmstb.c                  | 4 ++--
>   drivers/pci/controller/pcie-iproc-bcma.c               | 4 ++--
>   drivers/pci/controller/pcie-iproc-platform.c           | 4 ++--
>   drivers/pci/controller/pcie-mediatek-gen3.c            | 4 ++--
>   drivers/pci/controller/pcie-mediatek.c                 | 4 ++--
>   drivers/pci/controller/pcie-mt7621.c                   | 4 ++--
>   drivers/pci/controller/pcie-rcar-host.c                | 4 ++--
>   drivers/pci/controller/pcie-rockchip-host.c            | 4 ++--
>   drivers/pci/controller/pcie-xilinx-cpm.c               | 4 ++--
>   drivers/pci/controller/pcie-xilinx-dma-pl.c            | 4 ++--
>   drivers/pci/controller/pcie-xilinx-nwl.c               | 4 ++--
>   drivers/pci/controller/pcie-xilinx.c                   | 4 ++--
>   drivers/pci/controller/plda/pcie-plda-host.c           | 4 ++--
>   drivers/pci/probe.c                                    | 8 ++++----
>   34 files changed, 70 insertions(+), 70 deletions(-)
> 

