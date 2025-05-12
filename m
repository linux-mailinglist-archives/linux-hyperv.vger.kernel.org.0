Return-Path: <linux-hyperv+bounces-5463-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72033AB30AB
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17971677A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 12 May 2025 07:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FF12561DC;
	Mon, 12 May 2025 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HlC68Ufk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7E37DA82;
	Mon, 12 May 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747035537; cv=none; b=WleEzmAdqW+GXSnvwj82g76pqw73Aj/BLZ+ca5Q2h1TDyIeTHBeu8cPMBX7EUew7OkU7UbKnlI8h1nmH5jBzIm2GSH9vJgqTtddyLERDkEyZe8PqKsFBETOrtBZHssD0cSQzfa18lE/GYSoBR1lB1wKR8Y52KddLEkGZNAHeRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747035537; c=relaxed/simple;
	bh=KNKMctxAxmRTyPlLDhq3kAG6uesIsQg9Qnqn3OmcROA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpU00I1B1lujBYc0SIvrn3QsK4wZpng9Uj9HoUxodZx8d9yNtm9MW3wofEEQy2+5AlSqzBm3NZHKnkTHBfAqoTRzREmmEQghBs6rlMPOcogi3lChr9wb/5YK2QuYEJAAch6eR28G6vQWgNr18MJzvXlD8WPZXwM9nsyqvBN7wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HlC68Ufk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D9C09211D8A9; Mon, 12 May 2025 00:38:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9C09211D8A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747035534;
	bh=iCzTBbpF34iqkrSJNQgb27YnZ03WEMtHWiX6C1C7y7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HlC68UfkHiW5i7tFfqIlUH2OLMYsAlzaWhoQuFG+G//YihxYb786pWYAaLzFsnU+b
	 Rl2wNOVjtzjrX7ifZDwXSWSGbqhDZOYVCCnY4MNyqRObJ2gbk5MuU0xSRZKpmBhZIx
	 s45E2Zoc/QNT05qBIQnkWg21hglbabyNeWdMBeYs=
Date: Mon, 12 May 2025 00:38:54 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
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
Subject: Re: [PATCH v3 2/4] PCI: hv: Allow dynamic MSI-X vector allocation
Message-ID: <20250512073854.GB23493@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1746785566-4337-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1746785602-4600-1-git-send-email-shradhagupta@linux.microsoft.com>
 <plrpscito5e76t4dvtukgqm724stsfxim3zv3xqwnjewenee53@72dipu3yunlr>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <plrpscito5e76t4dvtukgqm724stsfxim3zv3xqwnjewenee53@72dipu3yunlr>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, May 12, 2025 at 12:30:04PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 09, 2025 at 03:13:22AM -0700, Shradha Gupta wrote:
> > Allow dynamic MSI-X vector allocation for pci_hyperv PCI controller
> > by adding support for the flag MSI_FLAG_PCI_MSIX_ALLOC_DYN and using
> > pci_msix_prepare_desc() to prepare the MSI-X descriptors.
> > 
> > Feature support added for both x86 and ARM64
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > ---
> >  Changes in v3:
> >  * Add arm64 support
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
> > index ac27bda5ba26..8c8882cb0ad2 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -598,7 +598,8 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
> >  	return cfg->vector;
> >  }
> >  
> > -#define hv_msi_prepare		pci_msi_prepare
> > +#define hv_msi_prepare			pci_msi_prepare
> > +#define hv_msix_prepare_desc		pci_msix_prepare_desc
> 
> Please do not use custom macro unless its defintion changes based on some
> conditional. In this case, you should use pci_msix_prepare_desc directly for
> prepare_desc() callback.
> 
> - Mani
> 
> --
> ??????????????????????????? ????????????????????????

Thanks for catching this Mani, I agree. I will fix this.

regards,
Shradha.

