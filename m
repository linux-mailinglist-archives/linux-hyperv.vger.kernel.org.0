Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762FD260FC8
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Sep 2020 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgIHK2p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Sep 2020 06:28:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48605 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729557AbgIHK0k (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Sep 2020 06:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599560793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=mOMtXpC9w9DNODyqnAlcSJZsWHWQ8hOHZ9+OpCpEsMo=;
        b=VsPUQ/TJEY0kFx1NlbCSt6bLZMUOvGYrYfUI4odbdttPvuU3LFevrICYA4/LxIqxKVULlX
        HDbJV3ED1EOstDcHmliQSggFVfftK/tP38rqW08Hr1IlH0HPDCYM2mLPzdMKv8aGiym5ii
        W53t/ZSs4weSVJyYhxJkUs14HNEsAEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-ocpL4LifPeKj0Evr1s394g-1; Tue, 08 Sep 2020 06:26:29 -0400
X-MC-Unique: ocpL4LifPeKj0Evr1s394g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C691007467;
        Tue,  8 Sep 2020 10:26:26 +0000 (UTC)
Received: from [10.36.115.46] (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA7021002D46;
        Tue,  8 Sep 2020 10:26:21 +0000 (UTC)
Subject: Re: [PATCH v1 2/5] kernel/resource: merge_system_ram_resources() to
 merge resources after hotplug
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>, linux-hyperv@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
References: <20200821103431.13481-1-david@redhat.com>
 <20200821103431.13481-3-david@redhat.com>
 <CAM9Jb+hJ8YSB6XZi6CB3jU-LSdVhKGZw=6NESzFhY7bbU9uOSQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <93e5b25b-ff00-b6b7-eb1e-b051ea6dcbe5@redhat.com>
Date:   Tue, 8 Sep 2020 12:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAM9Jb+hJ8YSB6XZi6CB3jU-LSdVhKGZw=6NESzFhY7bbU9uOSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 31.08.20 11:35, Pankaj Gupta wrote:
>> Some add_memory*() users add memory in small, contiguous memory blocks.
>> Examples include virtio-mem, hyper-v balloon, and the XEN balloon.
>>
>> This can quickly result in a lot of memory resources, whereby the actual
>> resource boundaries are not of interest (e.g., it might be relevant for
>> DIMMs, exposed via /proc/iomem to user space). We really want to merge
>> added resources in this scenario where possible.
>>
>> Let's provide an interface to trigger merging of applicable child
>> resources. It will be, for example, used by virtio-mem to trigger
>> merging of system ram resources it added to its resource container, but
>> also by XEN and Hyper-V to trigger merging of system ram resources in
>> iomem_resource.
>>
>> Note: We really want to merge after the whole operation succeeded, not
>> directly when adding a resource to the resource tree (it would break
>> add_memory_resource() and require splitting resources again when the
>> operation failed - e.g., due to -ENOMEM).
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>> Cc: Haiyang Zhang <haiyangz@microsoft.com>
>> Cc: Stephen Hemminger <sthemmin@microsoft.com>
>> Cc: Wei Liu <wei.liu@kernel.org>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Stefano Stabellini <sstabellini@kernel.org>
>> Cc: Roger Pau Monné <roger.pau@citrix.com>
>> Cc: Julien Grall <julien@xen.org>
>> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/ioport.h |  3 +++
>>  kernel/resource.c      | 52 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 52a91f5fa1a36..3bb0020cd6ddc 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -251,6 +251,9 @@ extern void __release_region(struct resource *, resource_size_t,
>>  extern void release_mem_region_adjustable(struct resource *, resource_size_t,
>>                                           resource_size_t);
>>  #endif
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +extern void merge_system_ram_resources(struct resource *res);
>> +#endif
>>
>>  /* Wrappers for managed devices */
>>  struct device;
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index 1dcef5d53d76e..b4e0963edadd2 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -1360,6 +1360,58 @@ void release_mem_region_adjustable(struct resource *parent,
>>  }
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>>
>> +#ifdef CONFIG_MEMORY_HOTPLUG
>> +static bool system_ram_resources_mergeable(struct resource *r1,
>> +                                          struct resource *r2)
>> +{
>> +       return r1->flags == r2->flags && r1->end + 1 == r2->start &&
>> +              r1->name == r2->name && r1->desc == r2->desc &&
>> +              !r1->child && !r2->child;
>> +}
>> +
>> +/*
>> + * merge_system_ram_resources - try to merge contiguous system ram resources
>> + * @parent: parent resource descriptor
>> + *
>> + * This interface is intended for memory hotplug, whereby lots of contiguous
>> + * system ram resources are added (e.g., via add_memory*()) by a driver, and
>> + * the actual resource boundaries are not of interest (e.g., it might be
>> + * relevant for DIMMs). Only immediate child resources that are busy and
>> + * don't have any children are considered. All applicable child resources
>> + * must be immutable during the request.
>> + *
>> + * Note:
>> + * - The caller has to make sure that no pointers to resources that might
>> + *   get merged are held anymore. Callers should only trigger merging of child
>> + *   resources when they are the only one adding system ram resources to the
>> + *   parent (besides during boot).
>> + * - release_mem_region_adjustable() will split on demand on memory hotunplug
>> + */
>> +void merge_system_ram_resources(struct resource *parent)
>> +{
>> +       const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>> +       struct resource *cur, *next;
>> +
>> +       write_lock(&resource_lock);
>> +
>> +       cur = parent->child;
>> +       while (cur && cur->sibling) {
>> +               next = cur->sibling;
>> +               if ((cur->flags & flags) == flags &&
> 
> Maybe this can be changed to:
> !(cur->flags & ~flags)

That would be different I think.

(cur->flags & flags) == flags
checks that all "flags" are set (additional ones might be set).

!(cur->flags & ~flags)
checks that no other flags besides "flags" are set (and "flags" are not
required to be set).


We use the same handling in find_next_iomem_res(), e.g., called via
walk_system_ram_range also with IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY.

Thanks for having a look!

-- 
Thanks,

David / dhildenb

