Return-Path: <linux-hyperv+bounces-10983-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF/aG+efB2rP/QIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10983-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:36:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81A558F25
	for <lists+linux-hyperv@lfdr.de>; Sat, 16 May 2026 00:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E577A300638E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 May 2026 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9510C3EFFDB;
	Fri, 15 May 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XsX7GuAu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B8370D72
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 22:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884548; cv=none; b=TK5gT94ciA6CGoJydZ3fzytXcSszaCfvSljjh+q9FH0fJT4+mge2kVVpnVw4GFQBKTBosQ6HlSwbKGhd2k4P/iAJIx+RwYNFPI7NgQuCWS1Pg5JNu8aET0DFyUJCQQRjQCo1s4M3sRZfWHRntOCTsqQgUAN1xVVAW0OBtipFdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884548; c=relaxed/simple;
	bh=43M0QEo0eyyWPrbH4y4RCOZ7Hh/aYFkSTUf2UUibSrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shJEuUtW+WxVIBkefbAd9EWKFhGwV19yJytp0E1uyYWjnceu9lZwnqp9GDAlh5N2VQTJjkA35l9TdAh38zzbqOmyZNZH02RsjZipt30Rqw2jq3auxXt1BnIejNKk3nlcEGGwiIRO8zgrl3udWxSPtq5oXUz/BqbqqxSsYCj7hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XsX7GuAu; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-912475287a5so50345385a.2
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 15:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778884546; x=1779489346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=XsX7GuAusaCW2LmT6u8ew3/AzUb4Xjxt9X3vjamS4IL1RmGAU3MR67ypmronfRfXyW
         E9y5QRxboLE3xsIS0gaVfI4K3BugHkAT4V3ABCEecxlDiB8tZ2L6mCeSHIEyTMjh9DoB
         BDhQJ8n1dGTTMDwbS8pH5Fga+FyizW0/5r4gbRmPlKm5rmI12FMQKJGg+6owsc2Dyr8i
         7d79LfafVPeV9yJyPzmy73OCqQI70UuUFRGgRFYtCCmcandMKqZA7Svkot47DBtDpU1D
         Z08l7bL2P5uO59hLhWP1kcSDSkmRqvWVnC7RLV3yeWeThxRbNW68z2gmfu4Bz4ER7HCg
         Pr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778884546; x=1779489346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TNcmCN882Y+/mpDinGleLsVSa4beLL8jNPnufICq5xU=;
        b=jKWAJcu1yev0ywSHgXA1fAvRTswumxob2FNqLVKfo+tRreHU9aIcIfhp9LDZ5cyX/w
         5xFuit29cCLErI3Uxc+0CncWwB1TTKkncTt70tfaOW547kW5YZ1f0VVf32+epvA7PfL/
         VE0jDmzHYyLcis3pgtuGXhsRyn2OswZFzzDuR5buTssqfEOkvDmXkPCn2cHIf/kz18Oo
         88dWyLXv4Eo106LXYfAAi+tn8NCA3iYjsnnenfAHKue/aFgk0bjoICfFAU8md1oJnvbn
         qkz8G7wDUfEjSbXZjwjVQn+tos99zbx4s4/mEfCgPADtIWjb4A4LjJ/KpgBVvj17g0by
         JdEw==
X-Forwarded-Encrypted: i=1; AFNElJ8QBAgKDQQPjhIu+8r7I75m1EjHeHvhBIdA86ka/jeWzqEhCVU2yxAO7+6iARMOKLwuVTOPGPF2/deeIZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45x/e+2rsYHwfcTfYEEKEOMQub87+vk6zPNTtwjLL0jxWeHmy
	3fbvgS6hlFUjNFV+z3itYmSRpM4z9D1mnBhkRJs7+IJYDFNxdnrvTWZFe2mfGNN23kM=
X-Gm-Gg: Acq92OEbv87JmDNC93sXyw3Yy3esQU/yZcRCjASq+UBvDIdzT91K8/REalzTo4ZD+U5
	pAm241oln554PfQmWV4vkNzGq7purIo8r5GyuLrPoHl2YCBK/PadtvVw5sAN/aU/bGguJW8Y+P4
	OaogfFubCYCUu+C8kDDDW7UgnWi8CX1pku851izbrGyPK08chOjG/D0kMg6Z+g/7wmQeydzx2oI
	oPYlUX/nO2Jvd2EA3Fc2OQRWk9FTsy08mM6HzzDgOFreKdzuLo3nhjoBQGYChXz/o/ZW8p2T8ns
	05oJrtlzWPoE/JGP5NZOO/yXKjew20lzKuaLzUljo6rvzIsH6kq10NZgaotRKDx26CSv3yYilCc
	+XjpZ0ZBUONtd61BY10m00am+9M9Agco5gn5CoZE98H0PEch1jcanl6vaxa2xKs9h6UTZQ643MH
	4uaZNPZTQytlXWxquHOL3utf8oBTmBlYlp+IaSY8rOgXVkI9vI7nRdeN5E9qmDgBAWe/tQXaHGs
	keBxFKLqw04o/PB
X-Received: by 2002:a05:620a:4406:b0:8ef:ed0b:c235 with SMTP id af79cd13be357-911d087dccamr952694285a.56.1778884546078;
        Fri, 15 May 2026 15:35:46 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baa3c045sm682967285a.13.2026.05.15.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 15:35:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wO18D-00000008EMQ-0W2r;
	Fri, 15 May 2026 19:35:45 -0300
Date: Fri, 15 May 2026 19:35:45 -0300
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
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260515223545.GL7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
X-Rspamd-Queue-Id: CA81A558F25
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10983-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,outlook.com,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote:
> +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iova_list,
> +					  unsigned long start,
> +					  unsigned long end)
> +{
> +	unsigned long start_pfn = start >> PAGE_SHIFT;
> +	unsigned long end_pfn = PAGE_ALIGN(end) >> PAGE_SHIFT;
> +	unsigned long nr_pages = end_pfn - start_pfn;
> +	u16 count = 0;
> +
> +	while (nr_pages > 0) {
> +		unsigned long flush_pages;
> +		int order;
> +		unsigned long pfn_align;
> +		unsigned long size_align;
> +
> +		if (count >= HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> +			count = HV_IOMMU_FLUSH_VA_OVERFLOW;
> +			break;
> +		}
> +
> +		if (start_pfn)
> +			pfn_align = __ffs(start_pfn);
> +		else
> +			pfn_align = BITS_PER_LONG - 1;
> +
> +		size_align = __fls(nr_pages);
> +		order = min(pfn_align, size_align);
> +		iova_list[count].page_mask_shift = order;
> +		iova_list[count].page_number = start_pfn;
> +
> +		flush_pages = 1UL << order;
> +		start_pfn += flush_pages;
> +		nr_pages -= flush_pages;
> +		count++;
> +	}

This seems like a really silly hypervisor interface. Why doesn't it
just accept a normal range? Splitting it into power of two aligned
ranges is very inefficient.

Jason

