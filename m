Return-Path: <linux-hyperv+bounces-5915-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6911FAD97F9
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Jun 2025 00:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F234A2C2E
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 22:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1784928D8D5;
	Fri, 13 Jun 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOc1nIcb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696724BD0C;
	Fri, 13 Jun 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749852224; cv=none; b=beZa4gMEzYCN8M5ulcK5COBRatqDCtVFNEUnIjbhptHJdYtTnjIt9j+dHTbRHTiyUDoMuHoC1yinQBiTYtQURMbTGVIiF5O2aektuSpx86JeWGXhxtVem5MlXY9YBzkc8GNTG5Nut19Uv35Xtuj4FTDNxJUfVQ73+DwidqsDEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749852224; c=relaxed/simple;
	bh=plNoLDchHYVqta2q1kYAd9oobMIsKBI7Bo0/KNmnkno=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BuMN3GSFVoh41VxJ3RuVGQ8KHFao0hFGZ8CI8k87tHXvNXnnoR+U/DSjZgHB7nF77Dt2BM4o/C4DDLFTCB2sAFqyZYUl+Q8zHuhj3dUN+kh5PxSkrG5gwH3axhHjcFJqcrmQ+XcrdUk6EpOJHBVBikmtsENjOFCbiyxBb5o9RYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOc1nIcb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361EDC4CEE3;
	Fri, 13 Jun 2025 22:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749852222;
	bh=plNoLDchHYVqta2q1kYAd9oobMIsKBI7Bo0/KNmnkno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SOc1nIcb6nvOucwE3pr3QMwxCUti1b9SBGa0JjRrN4EWS/nsrD7X7nkuhru9BlUzs
	 fLaSWmSm/eeT/DVi94n2hpnHvGDgjdPcc79g22b+w4/z60mlMbLbReImoSX0wWT/EE
	 /Dbfjw1TWLC32Ak3RfqmsvCfLVYqNBiiJE+r/3s+FTYxNNBVEorEFYRsoXMUVWzzpf
	 Ty+OIRSf0aLvjzhr2dttB7vcrF+56Zd1XNeC4NI/7nHakCNjYqLgsQbd6PzqYb+213
	 6tOdjg8Ea7JCtVQgJWtRCLEAISa/Dfc/1mtaQpoXg2DPQmwx7QSBaiO/J+Sj62lATz
	 inuL6G3NOLl8Q==
Date: Fri, 13 Jun 2025 17:03:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v6 2/5] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <20250613220341.GA986823@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Jun 11, 2025 at 07:10:15AM -0700, Shradha Gupta wrote:
> Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> pci_msix_prepare_desc() to prepare the MSI-X descriptors.
> 
> Feature support added for both x86 and ARM64
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Again, if you need it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ef5d655a0052..86ca041bf74a 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -2119,6 +2119,7 @@ static struct irq_chip hv_msi_irq_chip = {
>  static struct msi_domain_ops hv_msi_ops = {
>  	.msi_prepare	= hv_msi_prepare,
>  	.msi_free	= hv_msi_free,
> +	.prepare_desc	= pci_msix_prepare_desc,
>  };
>  
>  /**
> @@ -2140,7 +2141,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
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

