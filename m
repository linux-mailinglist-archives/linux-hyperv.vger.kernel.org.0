Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F69234426
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Jul 2020 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbgGaKkg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 31 Jul 2020 06:40:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46467 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732487AbgGaKke (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 31 Jul 2020 06:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596192031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=BL1oMIwxlQ+A/Gl0cpYp9Jl1YEPXaJY/V5WmDVexMn8=;
        b=JyhU3UmSTKJp5gIBVWYqI8zF+VRy5RyZlEhxyZ1HtE0LbYGXI0oGjeFiOUx+gg3c/Lbqal
        qEBD9IbNFEbtkCMWWJ/yNRm4AwRgcG8dMqJmPOAI4IbG1+Yp7zNB1lho+PmHPamJjs892e
        tkiSgqNTJ4GDYQVGOMzmNJxmlpv4+Nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-dsjHfKRiNW-Oaap_X3aKdQ-1; Fri, 31 Jul 2020 06:40:29 -0400
X-MC-Unique: dsjHfKRiNW-Oaap_X3aKdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52150E918;
        Fri, 31 Jul 2020 10:40:28 +0000 (UTC)
Received: from [10.36.113.22] (ovpn-113-22.ams2.redhat.com [10.36.113.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8E0360BE2;
        Fri, 31 Jul 2020 10:40:20 +0000 (UTC)
Subject: Re: [PATCH RFCv1 3/5] virtio-mem: try to merge "System RAM
 (virtio_mem)" resources
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Jason Wang <jasowang@redhat.com>
References: <20200731091838.7490-1-david@redhat.com>
 <20200731091838.7490-4-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <f79c78d7-3231-d33d-8814-4c5b8c966c50@redhat.com>
Date:   Fri, 31 Jul 2020 12:40:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731091838.7490-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 31.07.20 11:18, David Hildenbrand wrote:

Grml, forgot to add cc: list for this patch, ccing the right people.

> virtio-mem adds memory in memory block granularity, to be able to
> remove it in the same granularity again later, and to grow slowly on
> demand. This, however, results in quite a lot of resources when
> adding a lot of memory. Resources are effectively stored in a list-based
> tree. Having a lot of resources not only wastes memory, it also makes
> traversing that tree more expensive, and makes /proc/iomem explode in
> size (e.g., requiring kexec-tools to manually merge resources later
> when e.g., trying to create a kdump header).
> 
> Before this patch, we get (/proc/iomem) when hotplugging 2G via virtio-mem
> on x86-64:
>         [...]
>         100000000-13fffffff : System RAM
>         140000000-33fffffff : virtio0
>           140000000-147ffffff : System RAM (virtio_mem)
>           148000000-14fffffff : System RAM (virtio_mem)
>           150000000-157ffffff : System RAM (virtio_mem)
>           158000000-15fffffff : System RAM (virtio_mem)
>           160000000-167ffffff : System RAM (virtio_mem)
>           168000000-16fffffff : System RAM (virtio_mem)
>           170000000-177ffffff : System RAM (virtio_mem)
>           178000000-17fffffff : System RAM (virtio_mem)
>           180000000-187ffffff : System RAM (virtio_mem)
>           188000000-18fffffff : System RAM (virtio_mem)
>           190000000-197ffffff : System RAM (virtio_mem)
>           198000000-19fffffff : System RAM (virtio_mem)
>           1a0000000-1a7ffffff : System RAM (virtio_mem)
>           1a8000000-1afffffff : System RAM (virtio_mem)
>           1b0000000-1b7ffffff : System RAM (virtio_mem)
>           1b8000000-1bfffffff : System RAM (virtio_mem)
>         3280000000-32ffffffff : PCI Bus 0000:00
> 
> With this patch, we get (/proc/iomem):
>         [...]
>         fffc0000-ffffffff : Reserved
>         100000000-13fffffff : System RAM
>         140000000-33fffffff : virtio0
>           140000000-1bfffffff : System RAM (virtio_mem)
>         3280000000-32ffffffff : PCI Bus 0000:00
> 
> Of course, with more hotplugged memory, it gets worse. When unplugging
> memory blocks again, try_remove_memory() (via
> offline_and_remove_memory()) will properly split the resource up again.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index f26f5f64ae822..2396a8d67875e 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -415,6 +415,7 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  {
>  	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>  	int nid = vm->nid;
> +	int rc;
>  
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(addr);
> @@ -431,8 +432,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>  	}
>  
>  	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
> -	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> -					 vm->resource_name);
> +	rc = add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> +				       vm->resource_name);
> +	if (!rc) {
> +		/*
> +		 * Try to reduce the number of resources by merging them. The
> +		 * memory removal path will properly split them up again.
> +		 */
> +		merge_child_mem_resources(vm->parent_resource,
> +					  vm->resource_name);
> +	}
> +	return rc;
>  }
>  
>  /*
> 


-- 
Thanks,

David / dhildenb

