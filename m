Return-Path: <linux-hyperv+bounces-10734-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONILKzBMAWqnUAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10734-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:25:36 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B9D507992
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 05:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A409930078E3
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 May 2026 03:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F177A37C0F6;
	Mon, 11 May 2026 03:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="gpCqsNiW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401B376BC5;
	Mon, 11 May 2026 03:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778469880; cv=pass; b=q0OFoNiGr91sQTELmZbqG4to8moE/UYqOZC+6B4d8rPIaePmPZYkaSfSekRMEDCeP9z5xgimAKhAa9INIq7gdhdGIC8G3I+ixbjJXFPnIkrehaqopbIVmomt9CjdoH2aXE5GcVPvYTk4A+EA9+GnB43VERd38FADM5jdClXyrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778469880; c=relaxed/simple;
	bh=DPoZWLyAxOayHA3ig+7fKaBAhd8hfnqSLSDCpdxpCkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWVpKq9p6R8S5jfzUk/sOiUHEw2CMkOCjemAD9gjsX+jfMnAofy/qH/2jNrRUh0ZEbffvCvaPJOZUWKtQ7mXoNnawDgYWVjceJzVM45pt2MaCfBahtlMZ6TV6Z7tc0AGseKtfSdhjFONzf9sEzosPg+UBNQhvCMISCz0PrVrL9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=gpCqsNiW; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1778469867; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FfeknDqIumbgx0dI6K+tmko3tZ8y2RpbigBWw7oVCgy6s8uCsnNJ4tCw28FyNJeVS8Gy7lApjIbsw4IrJ18kwhDyIaafN7PjMXOheLgIwvacj5cnClM0QOq1IXkqtPx/QI7Ty8f9afU0KKKTcO5VLiO96pwPMonq/NDckaDgQh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778469867; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cTC/X3yzPsEUBg6++NK/H3F8K08Nxvt1j9DM8XqtDoc=; 
	b=bJSEjcFhMIlxcKfR6qK4FcPU/1q1BqrSCNwjieDZ/hHtjdyRNzyKuKus/oqRQdVqtnimZeLq+93Z3zj3+A8hVtp0r/K07NiafIhO9/E3ucXN+cUp51EljWPB3ZMpQLV9fXbfnTpbjLFFsrfdjoUspxIyLIhfnNayVTBizHSLHFU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778469866;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=cTC/X3yzPsEUBg6++NK/H3F8K08Nxvt1j9DM8XqtDoc=;
	b=gpCqsNiWQ2yOn0O7zc3p1b88/oDSNQAN4gU4N6gb+HWS69/fn4wMSkCVYjC0UVcb
	pdi3LTMtteN4ztIPGMTpheX9PbkVHxH2yfTUsTaTDuzaNxGSUYDYLULZG+WAkZcOT4O
	s0XN8y90z1U3eubaODo9pnil8zvw8FV2IuyhRNGM=
Received: by mx.zohomail.com with SMTPS id 1778469862666596.6440001134566;
	Sun, 10 May 2026 20:24:22 -0700 (PDT)
Date: Mon, 11 May 2026 03:24:15 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/18] mshv: Add NULL check for vp in
 mshv_try_assert_irq_fast
Message-ID: <20260511-hilarious-futuristic-seriema-3e5aee@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816860118.21765.7481864545928795603.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816860118.21765.7481864545928795603.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 33B9D507992
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10734-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:43:21PM +0000, Stanislav Kinsburskii wrote:
> mshv_try_assert_irq_fast() dereferences the vp pointer obtained from
> pt_vp_array[lapic_apic_id] without checking for NULL or validating that
> lapic_apic_id is within bounds. A spurious interrupt from the hypervisor
> targeting a non-existent VP (or one not yet created) causes a NULL
> pointer dereference and crashes the host.
> 
> Add a bounds check on lapic_apic_id against MSHV_MAX_VPS and a NULL
> check on the vp pointer before dereferencing.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_eventfd.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 5995a62aff8d8..b398e58411dd7 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -169,7 +169,12 @@ static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
>  		return -EOPNOTSUPP;
>  #endif
>  
> +	if (irq->lapic_apic_id >= MSHV_MAX_VPS)
> +		return -EINVAL;
> +
>  	vp = partition->pt_vp_array[irq->lapic_apic_id];
> +	if (!vp)
> +		return -EINVAL;
>  
>  	if (!vp->vp_register_page)
>  		return -EOPNOTSUPP;
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


