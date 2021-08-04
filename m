Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8413DFB87
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Aug 2021 08:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhHDGoB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Aug 2021 02:44:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhHDGoA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Aug 2021 02:44:00 -0400
Received: from [192.168.1.87] (unknown [223.178.56.171])
        by linux.microsoft.com (Postfix) with ESMTPSA id DADCE209DD4A;
        Tue,  3 Aug 2021 23:43:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DADCE209DD4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1628059428;
        bh=V/XYsXsYVsA5Pb1ntrRBOWS6XD7DTF+fjpdIcug4aCw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cj5PvOhjHeKFOHz1X1tSzo8ZfZqL0lX6n3/1G8fOiix2DXh/xdkddfTDhgC8RMhHF
         TmcseRM1Soe4Rl5V4AwJe3G+VYxGCWd+m1OGKZE0eu9IuOOMnhjHFjyw8iJh8rv0ZE
         oey+Badv593cyQMjtl0kxCnP/vyJ2Cb6aAGXneHo=
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
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
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
 <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
 <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
From:   Praveen Kumar <kumarpraveen@linux.microsoft.com>
Message-ID: <562f4c31-1ea5-ea56-ac0a-6bd80b61c3df@linux.microsoft.com>
Date:   Wed, 4 Aug 2021 12:13:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 04-08-2021 03:17, Wei Liu wrote:
>>> +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
>>> +			   size_t size, struct iommu_iotlb_gather *gather)
>>> +{
>>> +	size_t unmapped;
>>> +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
>>> +	unsigned long flags, npages;
>>> +	struct hv_input_unmap_device_gpa_pages *input;
>>> +	u64 status;
>>> +
>>> +	unmapped = hv_iommu_del_mappings(domain, iova, size);
>>> +	if (unmapped < size)
>>> +		return 0;
>> Is there a case where unmapped > 0 && unmapped < size ?
>>
> There could be such a case -- hv_iommu_del_mappings' return value is >= 0.
> Is there a problem with this predicate?

What I understand, if we are unmapping and return 0, means nothing was unmapped, and will that not cause any corruption or illegal access of unmapped memory later?
From __iommu_unmap
...
    13         while (unmapped < size) {
    12                 size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
    11
    10                 unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
     9                 if (!unmapped_page)
     8                         break;		<<< we just break here, thinking there is nothing unmapped, but actually hv_iommu_del_mappings has removed some pages.
     7
     6                 pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
     5                         ¦iova, unmapped_page);
     4
     3                 iova += unmapped_page;
     2                 unmapped += unmapped_page;
     1         }
...

Am I missing something ?

Regards,

~Praveen.
