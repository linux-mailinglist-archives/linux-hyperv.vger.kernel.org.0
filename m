Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE46926A24F
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 11:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIOJdx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 05:33:53 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:40910 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgIOJdt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 05:33:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U90t1fN_1600162424;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U90t1fN_1600162424)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 17:33:45 +0800
Date:   Tue, 15 Sep 2020 17:33:44 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 1/7] kernel/resource: make
 release_mem_region_adjustable() never fail
Message-ID: <20200915093344.GA7324@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-2-david@redhat.com>
 <20200915021012.GC2007@L-31X9LVDL-1304.local>
 <927904b1-1909-f11f-483e-8012bda8ad0c@redhat.com>
 <20200915090612.GA6936@L-31X9LVDL-1304.local>
 <bc324c26-3638-ffa6-ee01-68a659183adf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc324c26-3638-ffa6-ee01-68a659183adf@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Sep 15, 2020 at 11:15:53AM +0200, David Hildenbrand wrote:
>On 15.09.20 11:06, Wei Yang wrote:
>> On Tue, Sep 15, 2020 at 09:35:30AM +0200, David Hildenbrand wrote:
>>>
>>>>> static int __ref try_remove_memory(int nid, u64 start, u64 size)
>>>>> {
>>>>> 	int rc = 0;
>>>>> @@ -1777,7 +1757,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
>>>>> 		memblock_remove(start, size);
>>>>> 	}
>>>>>
>>>>> -	__release_memory_resource(start, size);
>>>>> +	release_mem_region_adjustable(&iomem_resource, start, size);
>>>>>
>>>>
>>>> Seems the only user of release_mem_region_adjustable() is here, can we move
>>>> iomem_resource into the function body? Actually, we don't iterate the resource
>>>> tree from any level. We always start from the root.
>>>
>>> You mean, making iomem_resource implicit? I can spot that something
>>> similar was done for
>>>
>>> #define devm_release_mem_region(dev, start, n) \
>>> 	__devm_release_region(dev, &iomem_resource, (start), (n))
>>>
>> 
>> What I prefer is remove iomem_resource from the parameter list. Just use is in
>> the function body.
>> 
>> For the example you listed, __release_region() would have varies of *parent*,
>> which looks reasonable to keep it here.
>
>Yeah I got that ("making iomem_resource implicit"), as I said:
>

Thanks

>>> I'll send an addon patch for that, ok? - thanks.
>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
