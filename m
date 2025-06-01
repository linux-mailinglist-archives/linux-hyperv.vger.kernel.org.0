Return-Path: <linux-hyperv+bounces-5707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE6AC9EEE
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Jun 2025 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F801893C65
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Jun 2025 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6FC1D54EE;
	Sun,  1 Jun 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c5w1BAxt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD341E260C;
	Sun,  1 Jun 2025 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748789669; cv=none; b=axi+ojZFbL1h4OHC8GBYR0+XkISmWlF3BlDUEUCQRV1mxhTIvvaQttpOVqFELGR/hoYsJfmvng6Meh2lT4lNmZM8TDHc/hnj9KT3Qah+zWpx5iPBjFnSU49F+8hYOue5Xi0M/GN65wL1DvQwdrKHat6g06HXTEe2Q5ddktswU88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748789669; c=relaxed/simple;
	bh=pAsAKxToGmEVd3RIVnzdeeufEYuTCSyv5WEoqg6uhl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZtQm3IBNUGD+G5xJODGfID39haANHHt25n5Y4tHOBs33TGpS4gJBrqmvb06EZWOAEAiKV6rEPC+IyJDOQmDiQ4iZizVY53dONwizPzUcTsZA4nleyLBgyuDfYnXPcNum4eFLnmiqGHy1MZkQjODB4xzBrePGJjTUwmROzBZyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c5w1BAxt; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <83244641-8fab-4f05-9d31-c5881fa1660c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748789653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lOAhBl1Qhlq6wH2PH80gzRHGRgdy1O7aBgxLtbf1Yvc=;
	b=c5w1BAxtYORCvEZoUtLIKVfUN0MKQgkVrFsOrwv0Zm73CWxGdO/mJV3n1432IKIxiIh2KN
	yBIDnMbDLwSonNWt0ItBnisw9me9S+Oz0nYupaVp09WJN3kzH1k7nn0QDRrkWk3YpHnDBz
	Si22yGpyvte1D9UyxJX3dg/Nux+Kq4M=
Date: Sun, 1 Jun 2025 16:53:31 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] Allow dyn MSI-X vector allocation of MANA
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>,
 Yury Norov <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Kevin Tian <kevin.tian@intel.com>, Long Li <longli@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Rob Herring <robh@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=EF=BF=BD=7EDski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/5/27 17:57, Shradha Gupta 写道:
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
> ---
>   Change in v4
>   * add a patch describing the functionality of irq_setup() through a
>     comment
>   * In irq_setup(), avoid using a label next_cpumask:
>   * modify the changes in MANA patch about restructuring the error
>     handling path in mana_gd_setup_dyn_irqs()
>   * modify the mana_gd_setup_irqs() to simplify handling around
>     start_irq_index
>   * add warning if an invalid gic is returned
>   * place the xa_destroy() cleanup in mana_gd_remove
> ---
>   Changes in v3
>   * split the 3rd patch into preparation patch around irq_setup() and
>     changes in mana driver to allow dynamic IRQ allocation
>   * Add arm64 support for dynamic MSI-X allocation in pci_hyperv
>     controller
> ---
>   Changes in v2
>   * split the first patch into two(exporting the preapre_desc
>     func and using the function and flag in pci-hyperv)
>   * replace 'pci vectors' by 'MSI-X vectors'
>   * Change the cover letter description to align with changes made
> ---
> 
> Shradha Gupta (5):
>    PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
>    PCI: hv: Allow dynamic MSI-X vector allocation
>    net: mana: explain irq_setup() algorithm
>    net: mana: Allow irq_setup() to skip cpus for affinity
>    net: mana: Allocate MSI-X vectors dynamically

In this patchset, base-commit seems missing.

Please see this link:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15#n868

"
When you open ``outgoing/0000-cover-letter.patch`` for editing, you will
notice that it will have the ``base-commit:`` trailer at the very
bottom, which provides the reviewer and the CI tools enough information
to properly perform ``git am`` without worrying about conflicts::
"

When creating patches:
"
git format-patch --base=main origin/main
"

This will include a base-commit: line in each patch file:

"
base-commit: abcdef1234567890...
"

This is useful when submitting patches to mailing lists or other tooling.

Please follow the submitting-patches.rst to add base-commit.

Best Regards,
Zhu Yanjun

> 
>   .../net/ethernet/microsoft/mana/gdma_main.c   | 356 ++++++++++++++----
>   drivers/pci/controller/pci-hyperv.c           |   5 +-
>   drivers/pci/msi/irqdomain.c                   |   5 +-
>   include/linux/msi.h                           |   2 +
>   include/net/mana/gdma.h                       |   8 +-
>   5 files changed, 293 insertions(+), 83 deletions(-)
> 


