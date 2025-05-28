Return-Path: <linux-hyperv+bounces-5684-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30CAC7135
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 20:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0FF17136F
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 May 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223FC2147F5;
	Wed, 28 May 2025 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iymk3p3q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49B74BE1;
	Wed, 28 May 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748458520; cv=none; b=tRCa3qJWtPMgvXr34etPhYsYQ/zv2aoiOQdJT5unY4KqEOC7Apf5HRKNW1NMZcrRGcak6r6FZpY6A6cTjOCJd/Oi4f/Trjrh4L5rMAxoX8Owl7joFD+PpPhv9LBmk1r0JSD+m8qyelCv+lJp/+pUz7TMPKTlmcdb2xIJDGmK/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748458520; c=relaxed/simple;
	bh=HPXyaBEtLP4rxgNlcKWVIBnWfTrSOpit78Uj4rkTXY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dw8bKR5+378LkZPiPHg3zjKxn5r4bngcDBJBQb1HiAt1LfWjOXUjZjyXgNNfLJPKamOPL0B8irFJczXWJtz6uSaAUT5tvYakfGmnn+Y97yCd1QsMOBDh8CbceyUcyOCCccEjPdBTe+v+42FlkVj92WAgqKXuvnsENxispbIiVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iymk3p3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B485C4CEE3;
	Wed, 28 May 2025 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748458519;
	bh=HPXyaBEtLP4rxgNlcKWVIBnWfTrSOpit78Uj4rkTXY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iymk3p3qurAJxmEFyt4xikozpFvS6K2PsBr+wTDcEbMAZGS6WX6FNTJ+aUuh+dmdv
	 bARe1NiR7jmFMTdtSgD6Ksesge5RPAZovOtY/P+kB6+fV3bi6tzQaLCvJeeyLh5VMS
	 JoYJ2Vv5wyPbfKESQm1/EUAv4ELsKQO+qMnIi6Y6LlpdbJ70UJYcSfDBIqYzZpIpxh
	 GigV1Mz4Qmw4rKievHayPHUIB1/+7ygJcqh05xUEsdUC3Lc40nlr+Lh4PcE21iJ6Xp
	 XGX1Jxf4Ug8C0dh2uURttHV1kd9aYS8/hf++KkJ72QR3fkv7vnj7Lz84hB8iFyHzWT
	 VgeV8/foOnIeQ==
Date: Wed, 28 May 2025 19:55:08 +0100
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
	Krzysztof =?utf-8?Q?Wilczy=EF=BF=BD~Dski?= <kw@linux.com>,
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
Message-ID: <20250528185508.GK1484967@horms.kernel.org>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>

On Tue, May 27, 2025 at 08:57:33AM -0700, Shradha Gupta wrote:
> In this patchset we want to enable the MANA driver to be able to
> allocate MSI-X vectors in PCI dynamically.
> 
> The first patch exports pci_msix_prepare_desc() in PCI to be able to
> correctly prepare descriptors for dynamically added MSI-X vectors.
> 
> The second patch adds the support of dynamic vector allocation in
> pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> flag and using the pci_msix_prepare_desc() exported in first patch.
> 
> The third patch adds a detailed description of the irq_setup(), to
> help understand the function design better.
> 
> The fourth patch is a preparation patch for mana changes to support
> dynamic IRQ allocation. It contains changes in irq_setup() to allow
> skipping first sibling CPU sets, in case certain IRQs are already
> affinitized to them.
> 
> The fifth patch has the changes in MANA driver to be able to allocate
> MSI-X vectors dynamically. If the support does not exist it defaults to
> older behavior.

Hi Shradha,

It's unclear what the target tree for this patch-set is.
But if it is net-next, which seems likely given the code under
drivers/net/, then:

Please include that target in the subject of each patch in the patch-set.

	Subject: [PATCH v5 net-next 0/5] ...

And, moreover, ...

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.

