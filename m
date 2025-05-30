Return-Path: <linux-hyperv+bounces-5704-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF63AC9578
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 May 2025 20:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EE0166826
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 May 2025 18:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58255265CAB;
	Fri, 30 May 2025 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHUthBaI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA6D230D1E;
	Fri, 30 May 2025 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748628461; cv=none; b=uupDSYOih4IjaCyeZl3YPviADCdKHIV0BkgEHLaxeOKSMbz7BYA72AxaHul2vxayhIHosowHw4twd8aCvW8NbkPhKkZdjrW1Aa0u52+2xAUSExw/im0qfw/Kb38oVIyBLeTkNGJSR9fmS+wwYIBbI23kO7cXZVRNn0xW45/uz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748628461; c=relaxed/simple;
	bh=J8XMf0vUFlBtb0P+eOBHmln++KcIOG7Tsc+hBZYxgdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHSg/+ukN4pEAE3A8vP6j3I5iNJgZhBq1sFaXNEV8O2pwJbtXApXeqgtsMz5XgTrOKSSjfoLSpYToE7yPSwYgq5Ne2FgSyAfAQdSmBRuEnYDhu3dZ7uyUujFsFgo3Ef92c5bLUcXYCTFvKrg0tFR9AxYq4RUBVfwxNRhxlC6B6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHUthBaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E41C4CEE9;
	Fri, 30 May 2025 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748628460;
	bh=J8XMf0vUFlBtb0P+eOBHmln++KcIOG7Tsc+hBZYxgdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHUthBaI2V1BxM8csIfknNXieTWV8RxUPyHCOIKqiG15pf/ErTqbSTFk5veJxT51j
	 qqmNXkupTdmOnJhgg/65Pb8J+fKNLcJFJbWO1edYqwflKHLebh016uufcjEBF7GdW0
	 LnZv6f4xN2zZEv1IN20Na3U5gDvBek8QwqvmBzASM8x6i7TTHpkpQph5JnFM7JK9B2
	 cxB8RNk/VdfAK8KqTq6Zf97V44CcCSre8lC+mvy7si7oKxY3nZPK4eQv4oy4w1F8QV
	 pMIob6qRgBnmFW4u+eYyFpkQ20rVVQPc9NQAtwuQTd4+eWX8elC8uqNTERpg+JUkNT
	 OSMFhbEt8AQZQ==
Date: Fri, 30 May 2025 19:07:32 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
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
Message-ID: <20250530180732.GS1484967@horms.kernel.org>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20250528185508.GK1484967@horms.kernel.org>
 <20250529132845.GE27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529132845.GE27681@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Thu, May 29, 2025 at 06:28:45AM -0700, Shradha Gupta wrote:
> On Wed, May 28, 2025 at 07:55:08PM +0100, Simon Horman wrote:
> > On Tue, May 27, 2025 at 08:57:33AM -0700, Shradha Gupta wrote:
> > > In this patchset we want to enable the MANA driver to be able to
> > > allocate MSI-X vectors in PCI dynamically.
> > > 
> > > The first patch exports pci_msix_prepare_desc() in PCI to be able to
> > > correctly prepare descriptors for dynamically added MSI-X vectors.
> > > 
> > > The second patch adds the support of dynamic vector allocation in
> > > pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> > > flag and using the pci_msix_prepare_desc() exported in first patch.
> > > 
> > > The third patch adds a detailed description of the irq_setup(), to
> > > help understand the function design better.
> > > 
> > > The fourth patch is a preparation patch for mana changes to support
> > > dynamic IRQ allocation. It contains changes in irq_setup() to allow
> > > skipping first sibling CPU sets, in case certain IRQs are already
> > > affinitized to them.
> > > 
> > > The fifth patch has the changes in MANA driver to be able to allocate
> > > MSI-X vectors dynamically. If the support does not exist it defaults to
> > > older behavior.
> > 
> > Hi Shradha,
> > 
> > It's unclear what the target tree for this patch-set is.
> > But if it is net-next, which seems likely given the code under
> > drivers/net/, then:
> > 
> > Please include that target in the subject of each patch in the patch-set.
> > 
> > 	Subject: [PATCH v5 net-next 0/5] ...
> > 
> > And, moreover, ...
> > 
> > ## Form letter - net-next-closed
> > 
> > The merge window for v6.16 has begun and therefore net-next is closed
> > for new drivers, features, code refactoring and optimizations. We are
> > currently accepting bug fixes only.
> > 
> > Please repost when net-next reopens after June 8th.
> > 
> > RFC patches sent for review only are obviously welcome at any time.
> 
> Thank you Simon.
> 
> While posting this patchset I was a bit confused about what should be
> the target tree. That's why in the cover letter of the V1 for this
> series, I had requested more clarity on the same (since there are patches
> from PCI and net-next both).
> 
> In such cases how do we decide which tree to target?

Yes, that isn't entirely clear to me either.
Hopefully the maintainers can negotiate this.

> 
> Also, noted about the next merge window for net-next :-)
> 
> Regards,
> Shradha.
> 

