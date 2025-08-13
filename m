Return-Path: <linux-hyperv+bounces-6525-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F4B24C4A
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 16:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD33189A296
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 14:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AF1CAA6C;
	Wed, 13 Aug 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn3ZmcwL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9BE157493;
	Wed, 13 Aug 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095992; cv=none; b=OSizzk/OE+1fUhpm+U2m84MSTEugrhvcLrnG9RXVykQ9ZyIHH6lK66d9enyld2akV+lDLBf2Ff3vktDURtK4LzKP2rRpppUoTPRGUFxIFLEZHnTpH1jjbe1JkQgH4YJNlQMkJKVWPxZfKbz1NkcVDjV8NMYD+f9932D5GNiCAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095992; c=relaxed/simple;
	bh=sKtxvRLZlfNykdA1sXixrsDKjg9EgHaPHu6i+WxZogk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8g/pyJxLjJnHZT9/ir/YNGYOyzrS7a4/7CZTlIBVctsOP3ZMnrl5SKBigmdXAjCX8Atxm8f7fZVozBW/U4Hrjw7zE2+8E77aXnHTZ5rZ0p7h/Zgdq6+FG+mLIo2TKlMVeS9ksLgx2v3SwLOeDk4IrqqEJBgdmFFg3hiTIkfMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn3ZmcwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F8C4CEEB;
	Wed, 13 Aug 2025 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755095992;
	bh=sKtxvRLZlfNykdA1sXixrsDKjg9EgHaPHu6i+WxZogk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sn3ZmcwLvpi+0nTqSMR3ClCS0YudIhve68GxcRTs/LNz99NzYDg1x3vHc6EcuY0cX
	 ZD91WxzeFL1QyVpp0V6fyNOf/XPBYrnuAHQe5xPaRX3dY2dozqYAbB0Kxk6QQsCASw
	 fm7Bu9MP6cOxtIGMKwhXYQ9soJf0Gqs1+A/3msQv1d2A2bLqd6qSQZatt/3JKMqEOi
	 kBnCzusc31hdJNGX+R9r020mQvAPeE0U428jNws8znPLz2sXdxkbbiOgJoCCXyVvBT
	 gIX924EceE9/Md5jGecABxkHqDtTisFonN0SDHPECwBQD+esTAnn6BTMry8O0BtcJE
	 fu+ICP9YBVGWg==
Date: Wed, 13 Aug 2025 14:39:50 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Remove unused parameter of hv_msi_free()
Message-ID: <aJyjtvNabuXc1xhX@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250813055350.1670245-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813055350.1670245-1-namcao@linutronix.de>

On Wed, Aug 13, 2025 at 07:53:50AM +0200, Nam Cao wrote:
> The 'info' parameter of hv_msi_free() is unused. Delete it.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Acked-by: Wei Liu <wei.liu@kernel.org>

I assume this will go through the PCI tree.

> ---
>  drivers/pci/controller/pci-hyperv.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index d2b7e8ea710b..146b43981b27 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1680,7 +1680,6 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
>  /**
>   * hv_msi_free() - Free the MSI.
>   * @domain:	The interrupt domain pointer
> - * @info:	Extra MSI-related context
>   * @irq:	Identifies the IRQ.
>   *
>   * The Hyper-V parent partition and hypervisor are tracking the
> @@ -1688,8 +1687,7 @@ static void hv_int_desc_free(struct hv_pci_dev *hpdev,
>   * table up to date.  This callback sends a message that frees
>   * the IRT entry and related tracking nonsense.
>   */
> -static void hv_msi_free(struct irq_domain *domain, struct msi_domain_info *info,
> -			unsigned int irq)
> +static void hv_msi_free(struct irq_domain *domain, unsigned int irq)
>  {
>  	struct hv_pcibus_device *hbus;
>  	struct hv_pci_dev *hpdev;
> @@ -2181,10 +2179,8 @@ static int hv_pcie_domain_alloc(struct irq_domain *d, unsigned int virq, unsigne
>  
>  static void hv_pcie_domain_free(struct irq_domain *d, unsigned int virq, unsigned int nr_irqs)
>  {
> -	struct msi_domain_info *info = d->host_data;
> -
>  	for (int i = 0; i < nr_irqs; i++)
> -		hv_msi_free(d, info, virq + i);
> +		hv_msi_free(d, virq + i);
>  
>  	irq_domain_free_irqs_top(d, virq, nr_irqs);
>  }
> -- 
> 2.39.5
> 

