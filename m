Return-Path: <linux-hyperv+bounces-5715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044AACBF1F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 06:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9747A8075
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 04:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A254C1F0E20;
	Tue,  3 Jun 2025 04:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Oj6zAqAm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCC885626;
	Tue,  3 Jun 2025 04:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924158; cv=none; b=mQLyRnWlfCvG7MObHrfWDNpsuT8fRe2/JTUOsDlUyl3gCXEaFyuXFNnoWzLcEwHBn55Jqhd+6HoKjfwmRs+ILAjrZE5pFbP4LIXEa/PC1xSuydzN5LPG8LaZkJeuFNAh1d4+hbMz0O1mOXt2/UOHZ0vSaLZwku8+IELc05h3t0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924158; c=relaxed/simple;
	bh=MlvvGTpdzSKTap3TlPhsvcx+1M0T4uoo2j8237yeDO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeSMiwx5nFDcppOH55IHXAhh2y50dqqYYFrFm5bmwzzQAwrniKEtn/p5A/8esobiNOKB4JU4MsdmwmEIg9CdBrSOqu3tNx37N1iiuVeAB5jzvmj3BGs1noiMbqNvmVhJT1bhwjffd+0742qVEEUb/cpoDqHglQKKm97o5T7lT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Oj6zAqAm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 601172113A6F; Mon,  2 Jun 2025 21:15:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 601172113A6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748924156;
	bh=sCEuSoHnaBxencTvRdXH37MacmVEDhNuJiuJCs23a8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oj6zAqAmiLKz00j9lZzHmKwI7rMl1QTY/LTfV0lL0UJLFuQ5jwKJ4MFMqJ/jre5mH
	 Mq3GVtYkXESB7XkTIfE1U+koP+QrXp9dcUwgs8FlAr8AwyK2E9QOI8kpnr/ipOeK8Z
	 kk9FxAblfeHtNqyEeP2KJly2d2fqHfWIBxYAm88w=
Date: Mon, 2 Jun 2025 21:15:56 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
	Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Wilczy???~Dski <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250603041556.GA7800@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250528185508.GK1484967@horms.kernel.org>
 <20250529132845.GE27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250530180732.GS1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530180732.GS1484967@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 30, 2025 at 07:07:32PM +0100, Simon Horman wrote:
> On Thu, May 29, 2025 at 06:28:45AM -0700, Shradha Gupta wrote:
> > On Wed, May 28, 2025 at 07:55:08PM +0100, Simon Horman wrote:
> > > On Tue, May 27, 2025 at 08:57:33AM -0700, Shradha Gupta wrote:
> > > > In this patchset we want to enable the MANA driver to be able to
> > > > allocate MSI-X vectors in PCI dynamically.
> > > > 
> > > > The first patch exports pci_msix_prepare_desc() in PCI to be able to
> > > > correctly prepare descriptors for dynamically added MSI-X vectors.
> > > > 
> > > > The second patch adds the support of dynamic vector allocation in
> > > > pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> > > > flag and using the pci_msix_prepare_desc() exported in first patch.
> > > > 
> > > > The third patch adds a detailed description of the irq_setup(), to
> > > > help understand the function design better.
> > > > 
> > > > The fourth patch is a preparation patch for mana changes to support
> > > > dynamic IRQ allocation. It contains changes in irq_setup() to allow
> > > > skipping first sibling CPU sets, in case certain IRQs are already
> > > > affinitized to them.
> > > > 
> > > > The fifth patch has the changes in MANA driver to be able to allocate
> > > > MSI-X vectors dynamically. If the support does not exist it defaults to
> > > > older behavior.
> > > 
> > > Hi Shradha,
> > > 
> > > It's unclear what the target tree for this patch-set is.
> > > But if it is net-next, which seems likely given the code under
> > > drivers/net/, then:
> > > 
> > > Please include that target in the subject of each patch in the patch-set.
> > > 
> > > 	Subject: [PATCH v5 net-next 0/5] ...
> > > 
> > > And, moreover, ...
> > > 
> > > ## Form letter - net-next-closed
> > > 
> > > The merge window for v6.16 has begun and therefore net-next is closed
> > > for new drivers, features, code refactoring and optimizations. We are
> > > currently accepting bug fixes only.
> > > 
> > > Please repost when net-next reopens after June 8th.
> > > 
> > > RFC patches sent for review only are obviously welcome at any time.
> > 
> > Thank you Simon.
> > 
> > While posting this patchset I was a bit confused about what should be
> > the target tree. That's why in the cover letter of the V1 for this
> > series, I had requested more clarity on the same (since there are patches
> > from PCI and net-next both).
> > 
> > In such cases how do we decide which tree to target?
> 
> Yes, that isn't entirely clear to me either.
> Hopefully the maintainers can negotiate this.
>

Thanks Simon. also since teh target tree is not entirely clear, can I
still send out an updated version with suggested changes?
 
> > 
> > Also, noted about the next merge window for net-next :-)
> > 
> > Regards,
> > Shradha.
> > 

