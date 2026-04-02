Return-Path: <linux-hyperv+bounces-9939-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHeQItX6zmn7sAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9939-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 01:25:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075038F322
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 01:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 650613015478
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C162356A0D;
	Thu,  2 Apr 2026 23:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bIvA7cIN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B537D1624C0;
	Thu,  2 Apr 2026 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172307; cv=none; b=gHHRwMBivQnB3kFhGPw352vF5Zlopys74GCecAxcMzLaM1Bi1CihUYB4syOuib3x5xzjGKEls9GJQre7a2EUrIYcInugWpjGuKk3hkc4Ql4/At9K5Q0ZA3ZKaiGnFw+dbi+PhbgVo4eBzCaQCbHS6iKJKRDSc43RE7WgEJf+4RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172307; c=relaxed/simple;
	bh=Jj/qlKrDE37i4Egb8aB+83FAGROOSarXGmVA7kED1w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOEEC3jPmwamPhQYQIJpLYKS+Plp9J0uH9LfJz2nZ1cJ/N8NQJgz6Xtrhd6DHkrLImdyYVJtnSEk9tCyhpIGWOGo3+WVPNw6LeKXGlGfhjsJNEE4ArgOq51ltUk7SiIwkwUVHpjx91lxfJ95VUFIfvYM9y/nn8kzgwc13mghzYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bIvA7cIN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id BA31C20B710C;
	Thu,  2 Apr 2026 16:25:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BA31C20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775172305;
	bh=d74H7bhvDl14asuMwS8JoOWVseVVoxBjLt5KKiaQFGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIvA7cINuRnp22oIk+NmqE7te+DmrJN78J5G7134abZpgfeOfN4FLsDxqve7xiqpb
	 rH6fpH3tdCnXN0s+JYScgIaC8tnALVTbarhJ+lUIdCJpWuH1/7uVZAfNmPS1fYm29Q
	 iPqUU/vbvUx4oUXsK6OPI7uSL1QNJJw7qAr0wWZE=
Date: Thu, 2 Apr 2026 16:25:02 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Muminul Islam <muislam@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Jinank Jain <jinankjain@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Roman Kisel <romank@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Message-ID: <ac76zlXjXhPVkA6f@skinsburskii.localdomain>
References: <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SYBPR01MB788138A30BC69B0F5C3316E5AF54A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9939-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 2075038F322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 05:18:45PM +0800, Junrui Luo wrote:
> mshv_partition_create_region() computes mem->guest_pfn + nr_pages to
> check for overlapping regions without verifying u64 wraparound. A
> sufficiently large guest_pfn can cause the addition to overflow,
> bypassing the overlap check and allowing creation of regions that wrap
> around the address space.
> 
> Fix by using check_add_overflow() to reject such regions early, and
> validate that the region end does not exceed MAX_PHYSMEM_BITS. These
> checks also protect downstream callers that compute start_gfn +
> nr_pages on stored regions without overflow guards.
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Suggested-by: Roman Kisel <romank@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> Changes in v2:
> - Add a maximum check suggested by Roman Kisel
> - Link to v1: https://lore.kernel.org/all/SYBPR01MB7881689C0F58149DD986A6D1AF49A@SYBPR01MB7881.ausprd01.prod.outlook.com/
> ---
>  drivers/hv/mshv_root_main.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 6f42423f7faa..32826247dbce 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1174,11 +1174,20 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>  {
>  	struct mshv_mem_region *rg;
>  	u64 nr_pages = HVPFN_DOWN(mem->size);
> +	u64 new_region_end;
> +
> +	/* Reject regions whose end address would wrap around */
> +	if (check_add_overflow(mem->guest_pfn, nr_pages, &new_region_end))
> +		return -EOVERFLOW;
> +
> +	/* Reject regions beyond the maximum physical address */

nit: both comments are redundant - the meaning is clear from the code
itself.

> +	if (new_region_end > HVPFN_DOWN(1ULL << MAX_PHYSMEM_BITS))

This maximum value check bugs me a bit.

First of all, why does it matter what is the region end? Potentially, there can be
regions not backed by host address space (leave alone host RAM), so why
intropducing this limitation?

Second, this check takes a host-specific constant (MAX_PHYSMEM_BITS) and rounds it down
to hypervisor-specific units which may not be aligned with the host page
size. Should this be host pages instead?

Thanks,
Stanislav

> +		return -EINVAL;
>  
>  	/* Reject overlapping regions */
>  	spin_lock(&partition->pt_mem_regions_lock);
>  	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> -		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
> +		if (new_region_end <= rg->start_gfn ||
>  		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
>  			continue;
>  		spin_unlock(&partition->pt_mem_regions_lock);
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260328-fixes-0296eb3dbb52
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>

