Return-Path: <linux-hyperv+bounces-5699-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ACCAC7EBD
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46A9A27471
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 13:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FCD22687B;
	Thu, 29 May 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U5Z9toWh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139917BA5;
	Thu, 29 May 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748525327; cv=none; b=hBGRIiPTvCzJ5rj+WStOtqxHDqIfMN9LYWhH/savQ98xKxqlH1Q4OFGlUYoxO3Bgvh0U6ubNOIsZoEWkPiyvczu1wE5oet2sRxYha46skGz0FW6bHY2BuDcTWAG5PV7F79ly98yrdCHfX+ZQMsXyV2xrGzuvCdOrS+OZWSdZGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748525327; c=relaxed/simple;
	bh=HjdeBbhhYpiTDQNeuKjppa/6OR8mdX2tAmkwgCAGDzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGwuDRZMzd0EUkeaBf5SodFuSaY21L+Z3iwjc5zjP9s9Ols8Wz19koKf2m1pKv56mXHM3/nSjac4seJ1xSfbPXUe6iVH9l8/QMrgTARU/sOqPLM7VVFzO3tc094eCpXibcrZiBC8PazbuJkgQvYYhi3i4wVkRHSZ50/cr2WLlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U5Z9toWh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 3E20D207861D; Thu, 29 May 2025 06:28:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E20D207861D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748525325;
	bh=PowdyksgFeNGxjaYVXgfZt/agyGLy3RtEinohZnn13E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U5Z9toWhiQyAo1P5uORvpzDiRyD2tsbluG5TtPDUU+lIZr434j4ewrazjfeVR6bvL
	 zBCbVW/l38UkV2MLvalZYHb4PQdNFUlG1Ze+c+LI1tFU3cgRGk/G99bYfsZ4JtA80F
	 y5dMttkHk65rX2EpVWi2yfWUprYKKhKMxk2gM7lg=
Date: Thu, 29 May 2025 06:28:45 -0700
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
Message-ID: <20250529132845.GE27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250528185508.GK1484967@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528185508.GK1484967@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, May 28, 2025 at 07:55:08PM +0100, Simon Horman wrote:
> On Tue, May 27, 2025 at 08:57:33AM -0700, Shradha Gupta wrote:
> > In this patchset we want to enable the MANA driver to be able to
> > allocate MSI-X vectors in PCI dynamically.
> > 
> > The first patch exports pci_msix_prepare_desc() in PCI to be able to
> > correctly prepare descriptors for dynamically added MSI-X vectors.
> > 
> > The second patch adds the support of dynamic vector allocation in
> > pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> > flag and using the pci_msix_prepare_desc() exported in first patch.
> > 
> > The third patch adds a detailed description of the irq_setup(), to
> > help understand the function design better.
> > 
> > The fourth patch is a preparation patch for mana changes to support
> > dynamic IRQ allocation. It contains changes in irq_setup() to allow
> > skipping first sibling CPU sets, in case certain IRQs are already
> > affinitized to them.
> > 
> > The fifth patch has the changes in MANA driver to be able to allocate
> > MSI-X vectors dynamically. If the support does not exist it defaults to
> > older behavior.
> 
> Hi Shradha,
> 
> It's unclear what the target tree for this patch-set is.
> But if it is net-next, which seems likely given the code under
> drivers/net/, then:
> 
> Please include that target in the subject of each patch in the patch-set.
> 
> 	Subject: [PATCH v5 net-next 0/5] ...
> 
> And, moreover, ...
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.16 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
> 
> Please repost when net-next reopens after June 8th.
> 
> RFC patches sent for review only are obviously welcome at any time.

Thank you Simon.

While posting this patchset I was a bit confused about what should be
the target tree. That's why in the cover letter of the V1 for this
series, I had requested more clarity on the same (since there are patches
from PCI and net-next both).

In such cases how do we decide which tree to target?

Also, noted about the next merge window for net-next :-)

Regards,
Shradha.

