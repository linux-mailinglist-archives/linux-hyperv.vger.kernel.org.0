Return-Path: <linux-hyperv+bounces-11830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZBLZCg3tR2rehgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11830-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Jul 2026 19:10:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFB704923
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Jul 2026 19:10:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=BJNelsAl;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11830-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11830-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D8F3020AA3
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jul 2026 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B67A30C144;
	Fri,  3 Jul 2026 17:10:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4173090C2
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Jul 2026 17:10:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098624; cv=none; b=USd1BIkp9ZI7PVj24wx+V94fqhS2RMRdagGqHxrNNdAXGBhBY1u5MYioiK9tdcUjkV2X6Jn8Tnu4IUP/Qi6DQ69Ofphf0/huPgf2Vwh5QNEUE8kBYDqGpXIfPULzIrx35wxCNLc4F2uBgSqQ4lb6x7eozfYTTAcYGMCXLwSyKSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098624; c=relaxed/simple;
	bh=JqbyUGSlLgU7xpTZ+Kst/HuDrhY2T70S9MikqXlpd+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKYZUkogewqMDQXs8GslxPm/qhCi5/N0nvAXMVLVlnea3+kBtyDpKwm1kfbHWWaH1/AsGY3L4Rd5V/tUsaVHk6dc2FZKHugvV7moRDAl80Lk85ROSK3QxNqcz9DFUxdJhIeI3RUlOqtA0OjPhkAKmjLYlTnyZzX6xxMsVQnkhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=BJNelsAl; arc=none smtp.client-ip=209.85.222.179
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e50979c71so70642085a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Jul 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783098621; x=1783703421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=BJNelsAlO6FnCo9zXD9lU+4SoRJW3Tg0r1YDSlnhVtpce/fKXpv6TZQ96ggJUP0RW3
         OhY5I4MRnhMRmVVyF5tufLWyo6PRrBE2WMLMJ/fTAu/xd93sqmuhvsCKXrIHPo0AmOMZ
         Fwvb4f4cZNrgoYyiQ9FrQoQKs5K1CQtzKoV7BZd1wh/H0/vDSidipaNbRED6rpYuaodD
         fLFSsYGJGrSr9QGerD2znfRfvnicK811K+ffhJuhXjbO4/wWWAGx5M0+zI8ucdQqk4Uf
         9bpxIv39X++mU0XhhvBHWDFMQlFmqDCzRtt6RDDyj+lTFDDkk9rCxOPK09J6QQfYMFDA
         qsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098621; x=1783703421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3oZ+zgqAAjsMiarR8e3Jw/svVLzceSmIMfYpYh96XE=;
        b=ezD4fUPoeRIuZ4QE8esqcdetWnS/kJ4GmW7K5yTdCZmeIw2aS7uoorw5KppwfqgRlZ
         AG27+ocImUF4Z1mbrldIiV591bj4JdAqj2g54kdjS1VNCnAgi5d7YhlScwdndmqnZXOJ
         Eaj2dg9/uUZOtlS+IbqM/6oyeXMEZP7ZDfxW85FqrjCbZD1l5ibd0kKNQZqE7WIBy4vY
         oRUmsUX76h3zYqQcgXs78l4q3SYXFRTRXiCuNg0VOtU6lhknjuFSnq7d8ScuTsjGxRhS
         b+LIcVKDU5q4GirO/y67k8DultRsm8BTbk4frM3LnnAoSmCbneojoiVKETeLxCZTUAOx
         oBMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Pff13EKM5wHxfZ4HAqlaewZQ/BeO0ICJ0hxKR0ZXb7NHkEIvGASfVRfYe+9Wdr1X1S6ro6984gO5c4jc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHMwf6+vA82+IQKPHJ33vFQIvgHhjwpOQEQM/Qs28zkR3XjR5
	uqvEnabPIv6ecXOIr4NCQEvKwKuQd2Tclq2tsSM/YRbqJZXbrw1zCHlcD+PPNLfugg8=
X-Gm-Gg: AfdE7ckMITZTyIN0ZTwMOJ2MWqOxI9FvV8McvhhKSil/Lm2P6Hs8W/eZNspVXSJIqXm
	Al38//KaJeC7ObSZUMVqigcSMO+gE0hW/ZoWmBiMmZqRlF0bbsMGOlYkNPR7/W3NHWka20kRdmD
	nTtgih6xY+OqxGtwmDK8T8ckljGokXcxPZhy1PsXYQSpHUBHX+sPwsoRykQ5giMtuE/ITprm8ox
	ty6MEGhuLs+cyyvTtKA13gCUgzu5ekayke/BEA6oX7qK68p/Sm3pdYJhN7KpdwyoF3u0EzOK/tG
	+oAOIxTnvjRMld6mjHQV244rH/RgeZANCQ4U3RwEE8t/4ZcjHj+uw+kUBzu7gdvv2lJpJH3yduy
	NWoTDCcPgj7HNpH+nssVM33yVQ/ZD5NKzgUr36+G3tcXDcqhzvvZjPXN3tFNSvEoldY3yLHz7WA
	D0VaAArFIDoSJICHiFJR7ovGTtWN7pa6eE3sRlYJfglhBIr5leHnOzc728LArLt3MiniA=
X-Received: by 2002:a05:620a:46a5:b0:915:5379:b511 with SMTP id af79cd13be357-92e9a48e177mr44923985a.43.1783098620659;
        Fri, 03 Jul 2026 10:10:20 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cbe3e2sm200315285a.35.2026.07.03.10.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:10:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhP8-00000008GuS-3eyQ;
	Fri, 03 Jul 2026 14:10:18 -0300
Date: Fri, 3 Jul 2026 14:10:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com
Subject: Re: [PATCH v2 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260703171018.GA1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-5-zhangyu1@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11830-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zhangyu1@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:mhklinux@outlook.com,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89AFB704923

On Fri, Jul 03, 2026 at 12:05:18AM +0800, Yu Zhang wrote:

> @@ -401,10 +402,74 @@ static void hv_iommu_flush_iotlb_all(struct iommu_domain *domain)
>  	hv_flush_device_domain(to_hv_iommu_domain(domain));
>  }
>  
> +/*
> + * Calculate the minimal power-of-two aligned range that covers [start, end]
> + * (end is inclusive). Returns a single (page_number, page_mask_shift)
> + * descriptor that may over-flush when the range is not naturally aligned.
> + */
> +static void hv_iommu_calc_flush_range(unsigned long start, unsigned long end,
> +				       union hv_iommu_flush_va *va)
> +{
> +	unsigned long start_pfn = HVPFN_DOWN(start);
> +	unsigned long last_pfn = HVPFN_UP(end + 1) - 1;

Pedantically end can be ULONG_MAX, you shouldn't be adding to it since
it will overflow.

> +	unsigned long mask_shift, aligned_pfn;
> +
> +	if (start_pfn == last_pfn) {
> +		mask_shift = 0;
> +	} else {
> +		/*
> +		 * Find the highest bit position where start_pfn and last_pfn
> +		 * differ.  A range aligned to one above that bit is the
> +		 * smallest power-of-two region that covers both endpoints.
> +		 */
> +		mask_shift = __fls(start_pfn ^ last_pfn) + 1;
> +	}
> +
> +	aligned_pfn = ALIGN_DOWN(start_pfn, 1UL << mask_shift);

I think the whole thing is simpler if it stays using bytes until the end:

	sz_lg2 = __fls(gather->start ^ gather->end);
	if (sz_lg2 < HV_PAGE_SHIFT)
		cmd.sz_lg2 = HV_PAGE_SHIFT;

	page_number = (gather->start & ~(1UL << sz_lg2)) >> HV_PAGE_SHIFT;
	page_mask_shift = sz_lg2 - HV_PAGE_SIFT;

No overflows that way either

Jason

