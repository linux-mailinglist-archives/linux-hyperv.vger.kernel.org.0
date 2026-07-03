Return-Path: <linux-hyperv+bounces-11831-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zJBIMknyR2rMhwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11831-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Jul 2026 19:32:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8672704A7B
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Jul 2026 19:32:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=mF1sVXMO;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11831-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11831-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6BC8D300603A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jul 2026 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B67306B31;
	Fri,  3 Jul 2026 17:32:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C31D5160
	for <linux-hyperv@vger.kernel.org>; Fri,  3 Jul 2026 17:32:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099971; cv=none; b=PjAOT3dmbN6AFx1xJRsAv5ILx1MiSKxoTRXWdAlchJ8k9fSophVbR1tiGB9WMnNUkS4as9IxaY7/L3GlCA6mQwRmVFIPFzpYEP/TF/c6fkgOllg6ucLjbOsk91YQZlm7YTQTe8ZhmHZuA2UzVHcSb3emFSOHx9WjJi/nVs8gPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099971; c=relaxed/simple;
	bh=Wcpl1M8C6rbl+gWtOZA3jLQB6f728HV5z3+kNftSXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukTTcWJu+Irz/kJYpkAmKb90iV9PfvxcFag/Gvu5yvBDVr2jO/3F4stNXGvtavKwN4qySNCkQBIalINu5NutZBZLd0GgAw574xSxoZmSYgZh/VhObGz4Xy1J+szjZZgvFkUD1itUAHlTBNpYLykvbMBykD2uq/8ShJ1Xg6iAzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mF1sVXMO; arc=none smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c21495722so4381251cf.3
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783099969; x=1783704769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=mF1sVXMOMvgQrEnwIMqB4rY7uKNNPHHW+R+o0znH9WS0jEM7MZIf+ecJ0/qLq8jPvN
         vzRc3UN8Gq9LdcPJla0jj0lihaWdydDDuPiknHRO1irv6GcFJHK/0GbmBuW+y9xeAJ3N
         WlGbcSggJ6kW+KZntqyr4HnCXCPlQiwTIrz77E1tIT/bB30Z0ObKmrW4i1AgRJXGwmdJ
         X9kuKH4lUeBuRXn6m5GQSzvvgCQtvqCkFdTigKl9qByon+KreNc+XXE536/tmda5hU82
         cXr+0NYMK1I4qXU1MNlA7nOCUgYeI8Na0eN1sBCIgycVP5FNlehXzx3rvvWxqxOHWUFM
         WdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099969; x=1783704769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiTtUHYVC+sBH8N9u4bqwWOXo++BMfy79AiAKwhU9io=;
        b=g52xNUC1FbzQKNItTum+qRKWhvV+sFdWABbS6eKSuKeJefvWRl39kaclEPMG8EDlbO
         1K6pnmv7pkK4tAAlOve0BHjjep2uRGToDTT/Jg+g6ABwEvy6kFeDVc7+wcKxaKd7Lfzv
         QdYOad+pCwLz9CJ25iteOIdgJj+c9qghPqtsUviBpu9PK6NwSw9F8vSXyL05yBBmk5Tq
         XQI0FM3Bm/XYH4MuxioaogFCuE2+c6L/IfWvWJHbkJ1qaawFx4jctPjNZ2ZGsV8tgUcJ
         842auW/cxQgj8k99opyOIT4oXB7U61qb5W6S+KHvPjjSCUQKu3ZsrvmlRGfyZ0rVuFQu
         5VuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6mb1VUZFbC2BL5U5fal/fw546nb/tGGcLJ8IhI1IRvfyrvJPcmj45Ped3C7eNWznlP2OKakUS+qg57S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOKVpcJqmWr4IRNZ6VY1LLNAytO+eUVVazJu3h77PC6bAKN+s
	CUUuZd7QpKpMV1F+P6xjrB2oMK6xXZIemDcEgTcY32sbJc3m/KKaglZwMLiRSz5aVIo=
X-Gm-Gg: AfdE7cmsEk06sAwYc9bmnKAVZ2x+ZqoP4US7QV6JzmfJqO7wWRfv97hJbaFdU/ys9yg
	aHEVayIbL6LpOXFVklpxiYvQw+T9FyW37JspmfAET7D7BGeRGWuIkjMXT8QWFfzI3edy5HK/Re8
	SqB537VjYfuIfXW/EDrEvA0Xr8q+xNnSQyMXxmzNZ4r/j56xMHDNPOa0+nfDPrBscTfHBCNjwh8
	Ykw6y1haMyfiSyiGhjMrVdfmTWvZQXuZwImFUQaHlixZSMhp4Y0geV6MCZp5phci3PKi38F6AUa
	ufsEncUqKfMf0Huadd6i4Ihp5bLhhPPdZrrtDFSzSXmN9vQoF25tPYX5M1EtqdR9Pr+olVxY1eo
	VIRWgEeiBTHv3vS/Nn3Xz6NnGP9YLau8sOuxuwbnvDNAYaRGUKn/JtWQkfdxW0mlvg8mByDSQ2p
	a39jQGLbWeB/YcZGGVB+HfZJs3sI+zRnhaZe2jQkW7d5hJrsCgLJ7tuV/f/dtxQcgUREk=
X-Received: by 2002:a05:622a:290:b0:51c:e14:87a7 with SMTP id d75a77b69052e-51c4c214c01mr7650981cf.28.1783099969076;
        Fri, 03 Jul 2026 10:32:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9ad1fsm58402856d6.47.2026.07.03.10.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:32:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfhku-00000008Ink-0GPL;
	Fri, 03 Jul 2026 14:32:48 -0300
Date: Fri, 3 Jul 2026 14:32:48 -0300
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
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260703173248.GB1968184@ziepe.ca>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11831-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8672704A7B

On Fri, Jul 03, 2026 at 12:05:17AM +0800, Yu Zhang wrote:

> +static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
> +{
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
> +		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;

This CAP isn't necessary anymore

> +static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> +{
> +	struct pci_dev *pdev;
> +	struct hv_iommu_endpoint *vdev;
> +	struct hv_output_get_logical_device_property device_iommu_property = {0};
> +
> +	if (!dev_is_pci(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	pdev = to_pci_dev(dev);
> +
> +	if (hv_iommu_get_logical_device_property(dev,
> +						 HV_LOGICAL_DEVICE_PROPERTY_PVIOMMU,
> +						 &device_iommu_property) ||
> +	    !(device_iommu_property.device_iommu & HV_DEVICE_IOMMU_ENABLED))
> +		return ERR_PTR(-ENODEV);
> +
> +	vdev = kzalloc_obj(*vdev, GFP_KERNEL);
> +	if (!vdev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	vdev->dev = dev;
> +	vdev->hv_iommu = hv_iommu_device;
> +	dev_iommu_priv_set(dev, vdev);
> +
> +	if (hv_iommu_ats_supported(hv_iommu_device->cap) &&
> +	    pci_ats_supported(pdev))
> +		pci_enable_ats(pdev, __ffs(hv_iommu_device->pgsize_bitmap));

This can probably just be PAGE_SHIFT

Also ATS shouldn't be enabled until a translation is installed,
otherwise the driver cannot participate in the ATS error handling
Nicolin is working on.

> +static void hv_iommu_release_device(struct device *dev)
> +{
> +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->ats_enabled)
> +		pci_disable_ats(pdev);
> +
> +	dev_iommu_priv_set(dev, NULL);

No necessary, the caller does it

> +static struct iommu_group *hv_iommu_device_group(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_device_group(dev);
> +
> +	WARN_ON_ONCE(1);
> +	return generic_device_group(dev);

I think you can just return failure here instead of WARN_ON ?

> +static int __init hv_initialize_static_domains(void)
> +{
> +	int ret;
> +	struct hv_iommu_domain *hv_domain;
> +
> +	/* Default stage-1 identity domain */
> +	hv_domain = &hv_identity_domain;
> +
> +	ret = hv_create_device_domain(hv_domain, HV_DEVICE_DOMAIN_TYPE_S1);
> +	if (ret)
> +		return ret;
> +
> +	ret = hv_configure_device_domain(hv_domain, IOMMU_DOMAIN_IDENTITY);
> +	if (ret)
> +		goto delete_identity_domain;

IMHO I would change this around to have a single function that accepts
a struct hv_input_configure_device_domain as input and does both of
the hypercalls inside. Then here it is easy to directly construct the
hv_input_configure_device_domain for blocking and identity.

I'd be happy if this never touched domain_type, drivers shouldn't be
touching that.

> +static void __init hv_init_iommu_device(struct hv_iommu_dev *hv_iommu,
> +			struct hv_output_get_iommu_capabilities *hv_iommu_cap)
> +{
> +	ida_init(&hv_iommu->domain_ids);
> +
> +	hv_iommu->cap = hv_iommu_cap->iommu_cap;
> +	hv_iommu->max_iova_width = hv_iommu_cap->max_iova_width;
> +	if (!hv_iommu_5lvl_supported(hv_iommu->cap) &&
> +	    hv_iommu->max_iova_width > 48) {
> +		pr_info("5-level paging not supported, limiting iova width to 48.\n");
> +		hv_iommu->max_iova_width = 48;
> +	}
> +
> +	hv_iommu->geometry = (struct iommu_domain_geometry) {
> +		.aperture_start = 0,
> +		.aperture_end = (((u64)1) << hv_iommu->max_iova_width) - 1,
> +		.force_aperture = true,
> +	};

I don't see anything reading this, I don't expect this to be used?

The max_iova_width has to be passed into the iommupt creation, which
it does:

 +	cfg.common.hw_max_vasz_lg2 = hv_iommu_device->max_iova_width;
 +	cfg.common.hw_max_oasz_lg2 = 52;
 +	cfg.top_level = (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
 +	ret = pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KERNEL);
 +	if (ret)

So just delete hv->iommu->geometry.

Also, VT-D has weirdness where the HW can require a 4 level table but
only a 3 level worth of IOVA width is being used. This was a
real-world bug we hit when converting to iommupt. This interaction
with the HV doesn't seem able to represent that.

> +	/*
> +	 * The page table code only maps x86 page sizes (4K/2M/1G); require the
> +	 * hypervisor to advertise a non-empty subset of exactly those.
> +	 */
> +	if (!hv_iommu_cap.pgsize_bitmap ||
> +	    (hv_iommu_cap.pgsize_bitmap & ~(u64)(SZ_4K | SZ_2M | SZ_1G))) {
> +		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
> +		       hv_iommu_cap.pgsize_bitmap);
> +		return -ENODEV;
> +	}

This can just be

if (!(hv_iommu_cap.pgsize_bitmap & PAGE_SHIFT)) {
		pr_err("unsupported page sizes: pgsize_bitmap=0x%llx\n",
		       hv_iommu_cap.pgsize_bitmap);
}		return -ENODEV;

Which is all you really need. If the HV doesn't support 1G it is
perfectly fine, the iommupt page bitmap is already masked by this. 

> +	ret = iommu_device_register(&hv_iommu->iommu, &hv_iommu_ops, NULL);
> +	if (ret) {
> +		pr_err("iommu_device_register failed: %d\n", ret);
> +		goto err_sysfs_remove;
> +	}
> +
> +	pr_info("successfully initialized\n");

Don't log someting so vauge?

Jason

