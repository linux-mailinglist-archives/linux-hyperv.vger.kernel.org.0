Return-Path: <linux-hyperv+bounces-2054-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572EF8B5F81
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 19:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B828428E
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 17:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B98595F;
	Mon, 29 Apr 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMjeCDcp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CF83CBA;
	Mon, 29 Apr 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410238; cv=none; b=Z7N2k9Wwz9RRIyJkUbJEibG4Rs4eZ8TGH1y/FkKTudpkYI0XXzdLvKW3eTeO7JK7ueuj/5xzXoNFZAyW8taXnG6y8ykuJaes6GhwcraTDqk/63QBX3gJBYhW25frwhLN2pOcHSqd2Aou/QrXubhhoYTXl+F21jQUoKRJdRnqF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410238; c=relaxed/simple;
	bh=N8lmt1eTjPPMtVK/lMhpi6YmGYOP38QLWrQAMXxIhpk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pLZ5Pa/iSKULBnfkYdaseQHnjUcOHAM8684MI8l+NzZS5MPliEwWdJgPAOG3gTunhomsfKSGQB54u71EKhVle3bW1BwK36Rqn+y0LHrkbQlnRtDMv4PFQokH1cgcqpIvwdPxqthHmoJL/0nv0ZANoTToGbRS7WW47SRBT8IaZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMjeCDcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CC4C4AF14;
	Mon, 29 Apr 2024 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714410238;
	bh=N8lmt1eTjPPMtVK/lMhpi6YmGYOP38QLWrQAMXxIhpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iMjeCDcpPjvgPqcda1yz47UZoN3OK71XgRAyvTJVe+Gc0btCjFlFXoNK4hd0MTP8V
	 ShfJKTu6k6KCW/JNSEyivLMjPDWUTrtHWaUibqxCX8v6qW1n8d2tt9rfKy5qS7Mcg4
	 7wU4s43tBpofdkubrutgKq4LMJvdjlgxQT6htz8S1dVVToSTjkAwqJUa2eiB34QYmn
	 qg+RQHgI2zW1qLffpQILdRXOoxlntktfbmFj7fQSi/vTzWzRLS7utr2Rji38jtdyvJ
	 scwcgAwAyxaFHxCaV0s1h3ftELgVJWfXi5so5qF3LFU7/vcAsxwFZNfCT+Dfx24yuh
	 513WiVVFLmFdQ==
Date: Mon, 29 Apr 2024 12:03:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: bhelgaas@google.com, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun.Feng@microsoft.com,
	sunilmut@microsoft.com, ssengar@microsoft.com
Subject: Re: [PATCH] PCI: Add a mutex to protect the global list
 pci_domain_busn_res_list
Message-ID: <20240429170355.GA685838@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425225136.GA541002@bhelgaas>

On Thu, Apr 25, 2024 at 05:51:38PM -0500, Bjorn Helgaas wrote:
> On Thu, Apr 18, 2024 at 06:53:02PM -0700, Dexuan Cui wrote:
> > There has been an effort to make the pci-hyperv driver support
> > async-probing to reduce the boot time. With async-probing, multiple
> > kernel threads can be running hv_pci_probe() -> create_root_hv_pci_bus() ->
> > pci_scan_root_bus_bridge() -> pci_bus_insert_busn_res() at the same time to
> > update the global list, causing list corruption.
> > 
> > Add a mutex to protect the list.
> 
> I think it's a good idea to support probing multiple PCI root buses in
> parallel.
> 
> The problem in get_pci_domain_busn_res() is the global
> pci_domain_busn_res_list.  I'm not even sure what that list contains,
> since it's a lookup by "domain_nr".  In the hv case, you probably have
> one host bridge per domain, but in general there may be multiple root
> buses in the same domain, e.g.,
> 
>   ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
>   ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
>   ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
>   ...
> 
> We only use get_pci_domain_busn_res() for root buses, and we should
> know the bus number range for root buses when we set up the struct
> pci_host_bridge, so it seems like we should keep the bus number
> resource there instead of allocating it in this sort of random place.
> 
> Then we shouldn't need this weird pci_domain_busn_res_list at all.

Oops, sorry, I totally missed the point here.  The point is that for
each domain, we get a new 00-ff range of possible bus numbers.  This
is independent of the host bridges for that domain that may exist.
Then each host bridge will allocate a piece of the 00-ff range.

But I do still think get_pci_domain_busn_res() isn't really the best
place for this.  It seems like it should be at a higher level,
connected somehow to domain number allocation, e.g., somewhere related
to bridge->domain_nr like the pci_bus_find_domain_nr() path.

> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > ---
> >  drivers/pci/probe.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index e19b79821dd6..1327fd820b24 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -37,6 +37,7 @@ LIST_HEAD(pci_root_buses);
> >  EXPORT_SYMBOL(pci_root_buses);
> >  
> >  static LIST_HEAD(pci_domain_busn_res_list);
> > +static DEFINE_MUTEX(pci_domain_busn_res_list_lock);
> >  
> >  struct pci_domain_busn_res {
> >  	struct list_head list;
> > @@ -47,14 +48,22 @@ struct pci_domain_busn_res {
> >  static struct resource *get_pci_domain_busn_res(int domain_nr)
> >  {
> >  	struct pci_domain_busn_res *r;
> > +	struct resource *ret;
> >  
> > -	list_for_each_entry(r, &pci_domain_busn_res_list, list)
> > -		if (r->domain_nr == domain_nr)
> > -			return &r->res;
> > +	mutex_lock(&pci_domain_busn_res_list_lock);
> > +
> > +	list_for_each_entry(r, &pci_domain_busn_res_list, list) {
> > +		if (r->domain_nr == domain_nr) {
> > +			ret = &r->res;
> > +			goto out;
> > +		}
> > +	}
> >  
> >  	r = kzalloc(sizeof(*r), GFP_KERNEL);
> > -	if (!r)
> > -		return NULL;
> > +	if (!r) {
> > +		ret = NULL;
> > +		goto out;
> > +	}
> >  
> >  	r->domain_nr = domain_nr;
> >  	r->res.start = 0;
> > @@ -62,8 +71,10 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
> >  	r->res.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
> >  
> >  	list_add_tail(&r->list, &pci_domain_busn_res_list);
> > -
> > -	return &r->res;
> > +	ret = &r->res;
> > +out:
> > +	mutex_unlock(&pci_domain_busn_res_list_lock);
> > +	return ret;
> >  }
> >  
> >  /*
> > -- 
> > 2.25.1
> > 

