Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA83E588C
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Aug 2021 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhHJKrX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Aug 2021 06:47:23 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39644 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbhHJKrX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Aug 2021 06:47:23 -0400
Received: by mail-wr1-f41.google.com with SMTP id b11so9482805wrx.6;
        Tue, 10 Aug 2021 03:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P7tG0VICffIvt3SyEoitjgLNgYWI+9vAdgdbLXyUgnA=;
        b=TGpXId4+nZHv0HTZLL5FmGqAJylZLE4+yaJfuotmpEuNdDkEdfXU9FsuhCrQirL5Bu
         Uio3j4zXQc5uLutGMI77ZsAgjeaw5ancfJ3zYvC4up9y2a0OUwWlJ926tWuAwWXNIqf+
         ww+ot+Ex1aAzne+sj99V870bBPK2way756WqDJxudkhDOOG/Wgoj7fe9oMPy0h36rJZX
         b1LD9zeC4KAgxrUV1trG9o0NP8HlOvzJQQeGCz7K+zlArRLXtm73Fw/De0lmEvsGWiHJ
         O9kCgAsxqxMZctsePHjGq25KRawjr1/WyiingPXgvK7QYQN0h6YPLwCKho6foh+0WQua
         eEaw==
X-Gm-Message-State: AOAM531Kq7KmLY+ZNkSQ0PoLCx9aiP2DtUIHF5BBWfg6kvjDL/1SR2Bb
        IYO2U1l++U9k6Uvg9R0sFzo=
X-Google-Smtp-Source: ABdhPJyDKXzP8lYVFrOox2qWqjvBfpvQiZ3S0ftoHgefJvAa1EpMTslpm9umKEz0v5yx8wvyyBexAA==
X-Received: by 2002:a5d:4852:: with SMTP id n18mr6810873wrs.10.1628592420511;
        Tue, 10 Aug 2021 03:47:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r8sm899528wmn.0.2021.08.10.03.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:47:00 -0700 (PDT)
Date:   Tue, 10 Aug 2021 10:46:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
Message-ID: <20210810104658.5ir7cibalhy3roun@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
 <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
 <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
 <562f4c31-1ea5-ea56-ac0a-6bd80b61c3df@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <562f4c31-1ea5-ea56-ac0a-6bd80b61c3df@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:13:42PM +0530, Praveen Kumar wrote:
> On 04-08-2021 03:17, Wei Liu wrote:
> >>> +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
> >>> +			   size_t size, struct iommu_iotlb_gather *gather)
> >>> +{
> >>> +	size_t unmapped;
> >>> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> >>> +	unsigned long flags, npages;
> >>> +	struct hv_input_unmap_device_gpa_pages *input;
> >>> +	u64 status;
> >>> +
> >>> +	unmapped = hv_iommu_del_mappings(domain, iova, size);
> >>> +	if (unmapped < size)
> >>> +		return 0;
> >> Is there a case where unmapped > 0 && unmapped < size ?
> >>
> > There could be such a case -- hv_iommu_del_mappings' return value is >= 0.
> > Is there a problem with this predicate?
> 
> What I understand, if we are unmapping and return 0, means nothing was
> unmapped, and will that not cause any corruption or illegal access of
> unmapped memory later?  From __iommu_unmap

Those pages are not really unmapped. The hypercall is skipped.

> ...
>     13         while (unmapped < size) {
>     12                 size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
>     11
>     10                 unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
>      9                 if (!unmapped_page)
>      8                         break;		<<< we just break here, thinking there is nothing unmapped, but actually hv_iommu_del_mappings has removed some pages.
>      7
>      6                 pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
>      5                         ¦iova, unmapped_page);
>      4
>      3                 iova += unmapped_page;
>      2                 unmapped += unmapped_page;
>      1         }
> ...
> 
> Am I missing something ?
> 
> Regards,
> 
> ~Praveen.
