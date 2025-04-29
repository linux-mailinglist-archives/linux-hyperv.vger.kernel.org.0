Return-Path: <linux-hyperv+bounces-5217-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30C8AA0615
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F38C1A837B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Apr 2025 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EA92820DD;
	Tue, 29 Apr 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SGBPKF/R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86341F416A;
	Tue, 29 Apr 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916418; cv=none; b=Dtq0T3fPVk4X4qqEISNYbrz1ls835+hZqOx/hPT6TlIejBLe2pMAouLKcMw7hxXXQdupuE1ODOaoyqMlddHpgyY7G0yHpW1tQYoKegFNxGnsYOMFzUxdfpzafK1iW9F3LUJ2Lgelwj5QIDsD+N6NynxnVaYhVIKD2Rj9VeK5+OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916418; c=relaxed/simple;
	bh=UNitg54Epewp5F6DsBNIsbZbwddaYYtUAT6YamLBV94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4A8UfelScEGHUBCKlHVFqrKJ3LNi0tTBhOtnM6i5Dnzk4dBeee0C4+FCcMar2bq1PBSgngzuwp7/3iQHTa5HGm1pc1e0zQNoIv1eXTlgXBOD4wJRs8VJI88Wqdi86d9xhLwkbLbRyiI7YfRR65kC/OHcAFSq5XTHIgpKdLzu84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SGBPKF/R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 5A9FE211AD21; Tue, 29 Apr 2025 01:46:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A9FE211AD21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745916416;
	bh=ZfQFEuUtCAkptnrkU/fwKhAsteqWi3CM4ufAPRrX/Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGBPKF/RPUtPPZPBsYJjjazCDbgUKLuz2WuMm8D+zpiSP4HrFDDW8vwYaSPvCeFwa
	 feANh3G2UNyLJRcWldQreUT8biephCIW2pk5bQH4s9GUpZ1902b9vbTf1N3zZ8Vlwn
	 PIAgJQEa7AFbnQZSUm+s0zaOdrdSTN1e1W/3ZAxE=
Date: Tue, 29 Apr 2025 01:46:56 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy?ski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2 2/3] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <20250429084656.GB10839@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1745578407-14689-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1745578459-15084-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SN6PR02MB4157247E1BCF02CEED0B23BCD4812@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157247E1BCF02CEED0B23BCD4812@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 28, 2025 at 01:47:22PM +0000, Michael Kelley wrote:
> From: Shradha Gupta <shradhagupta@linux.microsoft.com> Sent: Friday, April 25, 2025 3:54 AM
> > 
> > Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> > by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> > pci_msix_prepare_desc() to prepare the descriptors.
> 
> I'm unclear from the code below whether the intent is to support dynamic
> allocation only x86, or on both x86 and arm64. On arm64, you've defined
> hv_msi_prepare_desc as NULL, but hv_msi_prepare is also defined as NULL
> on arm64, so I'm not sure what to conclude. MSI_FLAG_PCI_MSIX_ALLOC_DYN
> is being set for both architectures.
> 
> In any case, please be explicit about your intent in the commit message.
> If the intent is to not support arm64, why is that?
> 
> Michael

Thank you for the comments Michael, in my recent testing on arm64, turns
out this function is indeed needed for the complete support.
I will test this out more thoroughly on arm64 and include the arm64 support
in next version.

Regards,
Shradha.
> 
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  Changes in v2:
> >  * split the patch to keep changes in PCI and pci_hyperv controller
> >    seperate
> >  * replace strings "pci vectors" by "MSI-X vectors"
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index ac27bda5ba26..f2fa6bdb6bb8 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> >  	return cfg->vector;
> >  }
> > 
> > -#define hv_msi_prepare		pci_msi_prepare
> > +#define hv_msi_prepare			pci_msi_prepare
> > +#define hv_msix_prepare_desc		pci_msix_prepare_desc
> > 
> >  /**
> >   * hv_arch_irq_unmask() - "Unmask" the IRQ by setting its current
> > @@ -727,6 +728,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
> >  #define FLOW_HANDLER		NULL
> >  #define FLOW_NAME		NULL
> >  #define hv_msi_prepare		NULL
> > +#define hv_msix_prepare_desc	NULL
> > 
> >  struct hv_pci_chip_data {
> >  	DECLARE_BITMAP(spi_map, HV_PCI_MSI_SPI_NR);
> > @@ -2063,6 +2065,7 @@ static struct irq_chip hv_msi_irq_chip = {
> >  static struct msi_domain_ops hv_msi_ops = {
> >  	.msi_prepare	= hv_msi_prepare,
> >  	.msi_free	= hv_msi_free,
> > +	.prepare_desc	= hv_msix_prepare_desc,
> >  };
> > 
> >  /**
> > @@ -2084,7 +2087,7 @@ static int hv_pcie_init_irq_domain(struct hv_pcibus_device *hbus)
> >  	hbus->msi_info.ops = &hv_msi_ops;
> >  	hbus->msi_info.flags = (MSI_FLAG_USE_DEF_DOM_OPS |
> >  		MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI |
> > -		MSI_FLAG_PCI_MSIX);
> > +		MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN);
> >  	hbus->msi_info.handler = FLOW_HANDLER;
> >  	hbus->msi_info.handler_name = FLOW_NAME;
> >  	hbus->msi_info.data = hbus;
> > --
> > 2.34.1
> > 

