Return-Path: <linux-hyperv+bounces-5716-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A042ACBF26
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 06:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1E918900EA
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 04:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB661EFFA6;
	Tue,  3 Jun 2025 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BqSpttGb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ACB1AA786;
	Tue,  3 Jun 2025 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748924257; cv=none; b=b4LELm8xKIq9zXyMeJFVY8InJGpeuTmugGHne/sBlH5J8IHApy6U4jw5UmCL6t2gXPFvAXmsH67K5DQdn399gPnrklXhco6Aq16cyTaj3aQUow7bV1bnCnGyvRG5zMF3OLfcUxj3PMBSxc2jjdV8QsFeh4qE8cjHEqaRslLC9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748924257; c=relaxed/simple;
	bh=ycGo7RzzC7vhYYPN9z63/zrBeE40PUT+akrPoMnS4fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2v4ePWfPIRy70fI75ln1qYOjza9Xlhg7zc13k3ysqdfUieJEStwHEhCjtIXXok2CySwBQdPSF+T8BbVfz107160+5FLMWOncf3q1+CgtgW+H4eJDhMbmjmW2nos3xufD8o0wMr/gHdQfe+Ffn7FCRlaCk2SPt4iqbA+hCA4Gno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BqSpttGb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 4DC7C203EE28; Mon,  2 Jun 2025 21:17:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DC7C203EE28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748924255;
	bh=wpy1isVRElmxhOZ0MSIsbH5dkq0/w80DUem5S1do/2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqSpttGbtUI0KwodL1lXJxMJXFmNqPo/CS3ICqASbqfgHxAFD8UJ280KY6kCJ3FUs
	 pwI5KPD4DRJkVemJkvdn7PYvN5CdswE12aCR3OdEiwosFQDP+mokl9Pyb3DHhpWHdL
	 dzMoGZzXcg/+YgtfpqaD5M9TxuusLg8/DprV616c=
Date: Mon, 2 Jun 2025 21:17:35 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
	Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v4 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250603041735.GA8300@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1748361453-25096-1-git-send-email-shradhagupta@linux.microsoft.com>
 <83244641-8fab-4f05-9d31-c5881fa1660c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83244641-8fab-4f05-9d31-c5881fa1660c@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Jun 01, 2025 at 04:53:31PM +0200, Zhu Yanjun wrote:
> ??? 2025/5/27 17:57, Shradha Gupta ??????:
> >In this patchset we want to enable the MANA driver to be able to
> >allocate MSI-X vectors in PCI dynamically.
> >
> >The first patch exports pci_msix_prepare_desc() in PCI to be able to
> >correctly prepare descriptors for dynamically added MSI-X vectors.
> >
> >The second patch adds the support of dynamic vector allocation in
> >pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> >flag and using the pci_msix_prepare_desc() exported in first patch.
> >
> >The third patch adds a detailed description of the irq_setup(), to
> >help understand the function design better.
> >
> >The fourth patch is a preparation patch for mana changes to support
> >dynamic IRQ allocation. It contains changes in irq_setup() to allow
> >skipping first sibling CPU sets, in case certain IRQs are already
> >affinitized to them.
> >
> >The fifth patch has the changes in MANA driver to be able to allocate
> >MSI-X vectors dynamically. If the support does not exist it defaults to
> >older behavior.
> >---
> >  Change in v4
> >  * add a patch describing the functionality of irq_setup() through a
> >    comment
> >  * In irq_setup(), avoid using a label next_cpumask:
> >  * modify the changes in MANA patch about restructuring the error
> >    handling path in mana_gd_setup_dyn_irqs()
> >  * modify the mana_gd_setup_irqs() to simplify handling around
> >    start_irq_index
> >  * add warning if an invalid gic is returned
> >  * place the xa_destroy() cleanup in mana_gd_remove
> >---
> >  Changes in v3
> >  * split the 3rd patch into preparation patch around irq_setup() and
> >    changes in mana driver to allow dynamic IRQ allocation
> >  * Add arm64 support for dynamic MSI-X allocation in pci_hyperv
> >    controller
> >---
> >  Changes in v2
> >  * split the first patch into two(exporting the preapre_desc
> >    func and using the function and flag in pci-hyperv)
> >  * replace 'pci vectors' by 'MSI-X vectors'
> >  * Change the cover letter description to align with changes made
> >---
> >
> >Shradha Gupta (5):
> >   PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
> >   PCI: hv: Allow dynamic MSI-X vector allocation
> >   net: mana: explain irq_setup() algorithm
> >   net: mana: Allow irq_setup() to skip cpus for affinity
> >   net: mana: Allocate MSI-X vectors dynamically
> 
> In this patchset, base-commit seems missing.
> 
> Please see this link:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.15#n868
> 
> "
> When you open ``outgoing/0000-cover-letter.patch`` for editing, you will
> notice that it will have the ``base-commit:`` trailer at the very
> bottom, which provides the reviewer and the CI tools enough information
> to properly perform ``git am`` without worrying about conflicts::
> "
> 
> When creating patches:
> "
> git format-patch --base=main origin/main
> "
> 
> This will include a base-commit: line in each patch file:
> 
> "
> base-commit: abcdef1234567890...
> "
> 
> This is useful when submitting patches to mailing lists or other tooling.
> 
> Please follow the submitting-patches.rst to add base-commit.
> 
> Best Regards,
> Zhu Yanjun
>

Thank you, I will make the necessary changes in the next version.

Regards,
Shradha. 
> >
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 356 ++++++++++++++----
> >  drivers/pci/controller/pci-hyperv.c           |   5 +-
> >  drivers/pci/msi/irqdomain.c                   |   5 +-
> >  include/linux/msi.h                           |   2 +
> >  include/net/mana/gdma.h                       |   8 +-
> >  5 files changed, 293 insertions(+), 83 deletions(-)
> >

