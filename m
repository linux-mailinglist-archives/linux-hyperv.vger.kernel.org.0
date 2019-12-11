Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C097A11AA75
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Dec 2019 13:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKMHk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Dec 2019 07:07:40 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727365AbfLKMHj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Dec 2019 07:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576066057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=E9JAWT7IGWHEcd/WlfE+7KxAF6KcvMxIfi/mtHIiMZY=;
        b=HbovaqiHA0AjkGpkXbeeiuKdTeUyVlXlnsBMQKMivR/wpFRNglSMzqF4OTynVxawFmKR4K
        YkxNrTSux41svDJfKZQ1Hs8jIvXfYpdIQRlV5t/g9uAHv4BIAV7r1rxV9bN3DP2onlCvX7
        bUupLxgPGTzImzayzkuvXsf7eZ6NcTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-rAXCa65cO06Lllj2RyUgBg-1; Wed, 11 Dec 2019 07:07:34 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB609DB32;
        Wed, 11 Dec 2019 12:07:32 +0000 (UTC)
Received: from [10.36.117.148] (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECE0B5DA70;
        Wed, 11 Dec 2019 12:07:29 +0000 (UTC)
Subject: Re: [RFC PATCH 2/4] mm/hotplug: Expose is_mem_section_removable() and
 offline_pages()
To:     lantianyu1986@gmail.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org,
        akpm@linux-foundation.org, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
References: <20191210154611.10958-1-Tianyu.Lan@microsoft.com>
 <20191210154611.10958-3-Tianyu.Lan@microsoft.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6f2d8968-b08d-b659-85fd-aa381e9a0f58@redhat.com>
Date:   Wed, 11 Dec 2019 13:07:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210154611.10958-3-Tianyu.Lan@microsoft.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: rAXCa65cO06Lllj2RyUgBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 10.12.19 16:46, lantianyu1986@gmail.com wrote:
> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>=20
> Hyper-V driver adds memory hot remove function and will use
> these interfaces in Hyper-V balloon driver which may be built
> as a module. Expose these function.

This patches misses a detailed description how these interfaces will be
used. Also, you should CC people on the actual magic where it will be used.

I found it via https://lkml.org/lkml/2019/12/10/767

If I am not wrong (un)lock_device_hotplug() is not exposed to kernel
modules for a good reason - your patch seems to ignore that if I am not
wrong.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  mm/memory_hotplug.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 07e5c67f48a8..4b358ebcc3d7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1191,6 +1191,7 @@ bool is_mem_section_removable(unsigned long start_p=
fn, unsigned long nr_pages)
>  =09/* All pageblocks in the memory block are likely to be hot-removable =
*/
>  =09return true;
>  }
> +EXPORT_SYMBOL_GPL(is_mem_section_removable);
> =20
>  /*
>   * Confirm all pages in a range [start, end) belong to the same zone.
> @@ -1612,6 +1613,7 @@ int offline_pages(unsigned long start_pfn, unsigned=
 long nr_pages)
>  {
>  =09return __offline_pages(start_pfn, start_pfn + nr_pages);
>  }
> +EXPORT_SYMBOL_GPL(offline_pages);
> =20
>  static int check_memblock_offlined_cb(struct memory_block *mem, void *ar=
g)
>  {
>=20

No, I don't think exposing the latter is desired. We already have one
other in-tree user that I _really_ want to get rid of. Memory should be
offlined in memory block granularity via the core only. Memory offlining
can be triggered in a clean way via device_offline(&mem->dev).

a) It conflicts with activity from user space. Especially, this "manual
fixup" of the memory block state is just nasty.
b) Locking issues: Memory offlining requires the device hotplug lock.
This lock is not exposed and we don't want to expose it.
c) There are still cases where offline_pages() will loop for all
eternity and only signals can kick it out.

E.g., have a look at how I with virtio-mem want to achieve that:
https://lkml.org/lkml/2019/9/19/476

I think something like that would be *much* cleaner. What could be even
better for your use case is doing it similarly to virtio-mem:

1. Try to alloc_contig_range() the memory block you want to remove. This
will not loop forever but fail in a nice way early. See
https://lkml.org/lkml/2019/9/19/467

2. Allow to offline that memory block by marking the memory
PageOffline() and dropping the refcount. See
https://lkml.org/lkml/2019/9/19/470, I will send a new RFC v4 soon that
includes the suggestion from Michal.

3. Offline+remove the memory block using a clean interface. See
https://lkml.org/lkml/2019/9/19/476

No looping forever, no races with user space, no messing with memory
block states.

NACK on exporting offline_pages(), but I am not a Maintainer, so ... :)

--=20
Thanks,

David / dhildenb

