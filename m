Return-Path: <linux-hyperv+bounces-5689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D5AC76AB
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 05:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B794E0F89
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 03:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBB9247DE1;
	Thu, 29 May 2025 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SX+/U1Kp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69EE78F45;
	Thu, 29 May 2025 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490416; cv=none; b=L95FibFCiv2KoomM9+hBdnOVkBKCz4bl6PrjJnoIoFAinJgQRyVvBvPzF/sbjco8Wijna4C3+j9L7vafU+q6KtxbfHqvbqsW7iOrb3VYaC4dZnPPFIw51ANMxQ+E6dBmWWO5Sni1YtKK3H1b2j//4lv1eQIOOKkRP0yq+jYSKdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490416; c=relaxed/simple;
	bh=BOH9ro/i4Jazdsq4ykTl12BVdO2Hl3sLhWE8rC+KpLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLubrIHs41a5n+hhQamUL5leAeB4SNVUucUwQAgIN+Kan0DbtXfN9Gz3cgg31/aRb4/EEKQiiquXtyza9/aKJhE58rYoY/nzrpLPntPqcceC8pJyQox9xBo0bkGt3+A1fhAxvyt1EYIlwJZ2zB2c100YTfA2+W4ZWy/SlDB5T+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SX+/U1Kp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 807F42078616; Wed, 28 May 2025 20:46:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 807F42078616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748490413;
	bh=KZja5k5L3ur3vtVbs5PT1Z6497SawORCGKvmts6G3z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX+/U1KpgNBuYq9Sz02DcuK96Fpf6mj0KLms6zg+XHGrOpC6aGSsRV4jsLbc/9qRE
	 hPDTwcqHrzLrwXa04GlcUK4uDe0AUunvtcNYDRADdTHqt0wBe6qi066BPnG/Cx05Zd
	 +TN6247sdpdu5LLuwSSoSA0RuJSSewJ3yIBSTYh4=
Date: Wed, 28 May 2025 20:46:53 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 2/5] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <20250529034653.GC5898@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1748361489-25415-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748361489-25415-1-git-send-email-shradhagupta@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 27, 2025 at 08:58:09AM -0700, Shradha Gupta wrote:
> Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> pci_msix_prepare_desc() to prepare the MSI-X descriptors.
> 
> Feature support added for both x86 and ARM64
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  Changes in v4:
>  * use the same prepare_desc() callback for arm and x86
> ---
>  Changes in v3:
>  * Add arm64 support
> ---
>  Changes in v2:
>  * split the patch to keep changes in PCI and pci_hyperv controller
>    seperate
>  * replace strings "pci vectors" by "MSI-X vectors"
> ---
>  drivers/pci/controller/pci-hyperv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ac27bda5ba26..0c790f35ad0e 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2063,6 +2063,7 @@ static struct irq_chip hv_msi_irq_chip = {
>  static struct msi_domain_ops hv_msi_ops = {
>  	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
> +	.prepare_desc	= pci_msix_prepare_desc,
>  };
>  
>  /**
> @@ -2084,7 +2085,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
>  	hbus->msi_info.ops = &hv_msi_ops;
>  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
>  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> -		MSI_FLAG_PCI_MSIX);
> +		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
>  	hbus->msi_info.handler = FLOW_HANDLER;
>  	hbus->msi_info.handler_name = FLOW_NAME;
>  	hbus->msi_info.data = hbus;
> -- 
> 2.34.1
> 

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

