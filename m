Return-Path: <linux-hyperv+bounces-2046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756ED8B2D46
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Apr 2024 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDDF1C2115D
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Apr 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA16155385;
	Thu, 25 Apr 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH8PCaKH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981EE1514D8;
	Thu, 25 Apr 2024 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085498; cv=none; b=hjOkdjEgtic83w30OFfLBmir4L+t3jtQ68PWfcBKxhwqq948Od+hImabJhXgijaLPBTOyoLwmGN9IewrLm4dALLumuHoJI8k6jP7bquZqoohgxUpTGcjazy6AxESBsu+DZkYtKkeG72c+ETMO9b7kCzJkby2bh8MCpvgtB3i8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085498; c=relaxed/simple;
	bh=fzTC02Z3yZ/JFXO4P23uwv3PJvwKXpoAsaKRDxN2nV8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eySZgL7r8XSli460JnmTP0yMortCrM3EF8B/jqdYn9JoiONa6IMeNpIoC4j4n3LjYy8LbnzV3kwqdGWSSyh61E8xvuMvcyJNdEIgAyFzBwxpOC/ZNrYlW12FA+Ji4jx+gLNwrzbGroOkge6g99IdWGaywFwoDCShtsH4LnQBjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH8PCaKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88C3C113CC;
	Thu, 25 Apr 2024 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085498;
	bh=fzTC02Z3yZ/JFXO4P23uwv3PJvwKXpoAsaKRDxN2nV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XH8PCaKHDj2VlrO3+tQ4N5m+Zj+HMflo7xhyvM66QQhHmWud2EJxBiXA9velLX0F7
	 3E19W3YjaGb2EACJzZbYs9RqmfFy3P/F/TkIr/kfxKbfkjv48UpKOfQyUX/avvEg+8
	 j3E2l++Y2o9VddjCtV/mHsDQMh+I0Rmv6/eSbGXQ67Npzrj5NTXe50o84xbXNR7C5w
	 WOStueHC6niyJVk5Q8DexzUJDlZzvEpSf9RRmWrJn7h7F2I+JP+uEFY6N28lWDBNjB
	 aWQZ/t0uvX5nnRu07qNRwAagQLbrwDpo9tvQYC6lzPSkxmsfQAUecs1lKUJs+p5V6V
	 jzxywseduiefQ==
Date: Thu, 25 Apr 2024 17:51:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: bhelgaas@google.com, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Boqun.Feng@microsoft.com,
	sunilmut@microsoft.com, ssengar@microsoft.com
Subject: Re: [PATCH] PCI: Add a mutex to protect the global list
 pci_domain_busn_res_list
Message-ID: <20240425225136.GA541002@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419015302.13871-1-decui@microsoft.com>

On Thu, Apr 18, 2024 at 06:53:02PM -0700, Dexuan Cui wrote:
> There has been an effort to make the pci-hyperv driver support
> async-probing to reduce the boot time. With async-probing, multiple
> kernel threads can be running hv_pci_probe() -> create_root_hv_pci_bus() ->
> pci_scan_root_bus_bridge() -> pci_bus_insert_busn_res() at the same time to
> update the global list, causing list corruption.
> 
> Add a mutex to protect the list.

I think it's a good idea to support probing multiple PCI root buses in
parallel.

The problem in get_pci_domain_busn_res() is the global
pci_domain_busn_res_list.  I'm not even sure what that list contains,
since it's a lookup by "domain_nr".  In the hv case, you probably have
one host bridge per domain, but in general there may be multiple root
buses in the same domain, e.g.,

  ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
  ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 17-39])
  ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 3a-5c])
  ...

We only use get_pci_domain_busn_res() for root buses, and we should
know the bus number range for root buses when we set up the struct
pci_host_bridge, so it seems like we should keep the bus number
resource there instead of allocating it in this sort of random place.

Then we shouldn't need this weird pci_domain_busn_res_list at all.

> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/pci/probe.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e19b79821dd6..1327fd820b24 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -37,6 +37,7 @@ LIST_HEAD(pci_root_buses);
>  EXPORT_SYMBOL(pci_root_buses);
>  
>  static LIST_HEAD(pci_domain_busn_res_list);
> +static DEFINE_MUTEX(pci_domain_busn_res_list_lock);
>  
>  struct pci_domain_busn_res {
>  	struct list_head list;
> @@ -47,14 +48,22 @@ struct pci_domain_busn_res {
>  static struct resource *get_pci_domain_busn_res(int domain_nr)
>  {
>  	struct pci_domain_busn_res *r;
> +	struct resource *ret;
>  
> -	list_for_each_entry(r, &pci_domain_busn_res_list, list)
> -		if (r->domain_nr == domain_nr)
> -			return &r->res;
> +	mutex_lock(&pci_domain_busn_res_list_lock);
> +
> +	list_for_each_entry(r, &pci_domain_busn_res_list, list) {
> +		if (r->domain_nr == domain_nr) {
> +			ret = &r->res;
> +			goto out;
> +		}
> +	}
>  
>  	r = kzalloc(sizeof(*r), GFP_KERNEL);
> -	if (!r)
> -		return NULL;
> +	if (!r) {
> +		ret = NULL;
> +		goto out;
> +	}
>  
>  	r->domain_nr = domain_nr;
>  	r->res.start = 0;
> @@ -62,8 +71,10 @@ static struct resource *get_pci_domain_busn_res(int domain_nr)
>  	r->res.flags = IORESOURCE_BUS | IORESOURCE_PCI_FIXED;
>  
>  	list_add_tail(&r->list, &pci_domain_busn_res_list);
> -
> -	return &r->res;
> +	ret = &r->res;
> +out:
> +	mutex_unlock(&pci_domain_busn_res_list_lock);
> +	return ret;
>  }
>  
>  /*
> -- 
> 2.25.1
> 

