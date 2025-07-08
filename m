Return-Path: <linux-hyperv+bounces-6154-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A889AFD029
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 18:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B350D3A8993
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306C72E540C;
	Tue,  8 Jul 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6xpfxxH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052472E540B;
	Tue,  8 Jul 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990899; cv=none; b=UCZ+bZCoE56YtTj+HpzDT0aNv1waGJDJXbkhb3ecI/IJzpMZvMu95SF3EL6cmIRYoS7naZ69JQiaSl/v9sSvSlxTz1tILdnA6kfB0k9uuNZVOlbxzZ6m/34+PtiTx1o3YCl0c3oPeoSiu3ciPOIKO3kAExs0Axplahli0j+/qAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990899; c=relaxed/simple;
	bh=7S1pgMXKj33TaIWn1KrVdoTD3pD9CWUGWtyQcBDqO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TrTm4qZKWqLC9Scn7uaGjJSxAnVM5g6/I1P9V+p/VAsIqxlO5pV87emQneA9KoCgDTgSVU2Wf0YyEbfygYVZUxRabAAZXM5kFxjzuT3rQfysGRlGM0UWWYmskEITuJdm6iwQJHzqN6KOd7v/w0PvCTGaziMq1GSHMGEVBfWJuDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6xpfxxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77911C4CEEF;
	Tue,  8 Jul 2025 16:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990898;
	bh=7S1pgMXKj33TaIWn1KrVdoTD3pD9CWUGWtyQcBDqO/U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k6xpfxxHLdqU6QC9FhEZ8RDOo9q5dvKZcFVsZKRkFVM7rEiWvMnU3f5HolWtZ8y8m
	 pwCej/MZeYpx64S7HDOfEMbZD1eakPkcB0iIPIOU0T/B8WETiWpaCgfFhalx4svBi/
	 w0o1z8YZfQpWu4+LEc5erqDKO6ufkMkh02+ExBrOQnYkSDzsDKDr2F+3t5nkwsMjHk
	 9E/On/OuqKqeTNFnOjuy+d/IuiZqBvOfg2CnbNnQ1nTTNG367hJy/q7LCV+qTX8zPP
	 25skyYykuIc25iXJvV2QRqCcIvxdIpGD/cFnx36bovN//Q+mxH7tcQKcAfAzvkwi5u
	 KSajehN0JRB5w==
Date: Tue, 8 Jul 2025 11:08:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>
Subject: Re: [PATCH] PCI/MSI: Initialize the prepare descriptor by default
Message-ID: <20250708160817.GA2148355@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e589da81-ed8d-4fbd-8a29-687eb271d1fe@linux.microsoft.com>

On Tue, Jul 08, 2025 at 03:45:05PM +0530, Naman Jain wrote:
> On 7/8/2025 3:32 PM, Shradha Gupta wrote:
> > On Tue, Jul 08, 2025 at 10:48:48AM +0530, Naman Jain wrote:
> > > Plug the default MSI-X prepare descriptor for non-implemented ops by
> > > default to workaround the inability of Hyper-V vPCI module to setup
> > > the MSI-X descriptors properly; especially for dynamically allocated
> > > MSI-X.
> > > 
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > ---
> > >   drivers/pci/msi/irqdomain.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> > > index 765312c92d9b..655e99b9c8cc 100644
> > > --- a/drivers/pci/msi/irqdomain.c
> > > +++ b/drivers/pci/msi/irqdomain.c
> > > @@ -84,6 +84,8 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
> > >   	} else {
> > >   		if (ops->set_desc == NULL)
> > >   			ops->set_desc = pci_msi_domain_set_desc;
> > > +		if (ops->prepare_desc == NULL)
> > > +			ops->prepare_desc = pci_msix_prepare_desc;
> > >   	}
> > >   }
> > > 
> > > base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Hey Naman,
> > 
> > can you please try your tests with this patch:
> > https://lore.kernel.org/all/1749651015-9668-1-git-send-email-shradhagupta@linux.microsoft.com/
> > I think this should help your use case
> 
> Hey,
> Thanks for sharing this, this works for me.
> 
> Closing this thread.

I guess this means we should ignore this patch?  If it turns out that
we do need this patch, I'd like to add some details in the commit log
about what this problem looks like to users.

Bjorn

