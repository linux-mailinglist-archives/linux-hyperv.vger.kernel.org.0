Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4D42626AB
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Sep 2020 07:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIIFSu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Sep 2020 01:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIFSs (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Sep 2020 01:18:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31CECAC4C;
        Wed,  9 Sep 2020 05:18:46 +0000 (UTC)
Subject: Re: [PATCH v2 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Liu <wei.liu@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Libor Pechacek <lpechacek@suse.cz>,
        Anton Blanchard <anton@ozlabs.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20200908201012.44168-1-david@redhat.com>
 <20200908201012.44168-4-david@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <edfe936b-1178-d2c7-8427-caa7253d516b@suse.com>
Date:   Wed, 9 Sep 2020 07:18:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200908201012.44168-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 08.09.20 22:10, David Hildenbrand wrote:
> We soon want to pass flags, e.g., to mark added System RAM resources.
> mergeable. Prepare for that.
> 
> This patch is based on a similar patch by Oscar Salvador:
> 
> https://lkml.kernel.org/r/20190625075227.15193-3-osalvador@suse.de
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Libor Pechacek <lpechacek@suse.cz>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Leonardo Bras <leobras.c@gmail.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-hyperv@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: virtualization@lists.linux-foundation.org
> Cc: xen-devel@lists.xenproject.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com> (Xen related part)


Juergen

> ---
>   arch/powerpc/platforms/powernv/memtrace.c       |  2 +-
>   arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +-
>   drivers/acpi/acpi_memhotplug.c                  |  2 +-
>   drivers/base/memory.c                           |  2 +-
>   drivers/dax/kmem.c                              |  2 +-
>   drivers/hv/hv_balloon.c                         |  2 +-
>   drivers/s390/char/sclp_cmd.c                    |  2 +-
>   drivers/virtio/virtio_mem.c                     |  2 +-
>   drivers/xen/balloon.c                           |  2 +-
>   include/linux/memory_hotplug.h                  | 10 ++++++----
>   mm/memory_hotplug.c                             | 15 ++++++++-------
>   11 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
> index 13b369d2cc454..a7475d18c671c 100644
> --- a/arch/powerpc/platforms/powernv/memtrace.c
> +++ b/arch/powerpc/platforms/powernv/memtrace.c
> @@ -224,7 +224,7 @@ static int memtrace_online(void)
>   			ent->mem = 0;
>   		}
>   
> -		if (add_memory(ent->nid, ent->start, ent->size)) {
> +		if (add_memory(ent->nid, ent->start, ent->size, 0)) {
>   			pr_err("Failed to add trace memory to node %d\n",
>   				ent->nid);
>   			ret += 1;
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 5d545b78111f9..54a888ea7f751 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -606,7 +606,7 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
>   	block_sz = memory_block_size_bytes();
>   
>   	/* Add the memory */
> -	rc = __add_memory(lmb->nid, lmb->base_addr, block_sz);
> +	rc = __add_memory(lmb->nid, lmb->base_addr, block_sz, 0);
>   	if (rc) {
>   		invalidate_lmb_associativity_index(lmb);
>   		return rc;
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index e294f44a78504..d91b3584d4b2b 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -207,7 +207,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>   		if (node < 0)
>   			node = memory_add_physaddr_to_nid(info->start_addr);
>   
> -		result = __add_memory(node, info->start_addr, info->length);
> +		result = __add_memory(node, info->start_addr, info->length, 0);
>   
>   		/*
>   		 * If the memory block has been used by the kernel, add_memory()
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 4db3c660de831..2287bcf86480e 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -432,7 +432,7 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>   
>   	nid = memory_add_physaddr_to_nid(phys_addr);
>   	ret = __add_memory(nid, phys_addr,
> -			   MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> +			   MIN_MEMORY_BLOCK_SIZE * sections_per_block, 0);
>   
>   	if (ret)
>   		goto out;
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7dcb2902e9b1b..8e66b28ef5bc6 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -95,7 +95,7 @@ int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   		 * this as RAM automatically.
>   		 */
>   		rc = add_memory_driver_managed(numa_node, range.start,
> -				range_len(&range), kmem_name);
> +				range_len(&range), kmem_name, 0);
>   
>   		res->flags |= IORESOURCE_BUSY;
>   		if (rc) {
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 32e3bc0aa665a..0194bed1a5736 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -726,7 +726,7 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>   
>   		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>   		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT));
> +				(HA_CHUNK << PAGE_SHIFT), 0);
>   
>   		if (ret) {
>   			pr_err("hot_add memory failed error is %d\n", ret);
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index a864b21af602a..a6a908244c742 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -406,7 +406,7 @@ static void __init add_memory_merged(u16 rn)
>   	if (!size)
>   		goto skip_add;
>   	for (addr = start; addr < start + size; addr += block_size)
> -		add_memory(0, addr, block_size);
> +		add_memory(0, addr, block_size, 0);
>   skip_add:
>   	first_rn = rn;
>   	num = 1;
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index 834b7c13ef3dc..314ab753139d1 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -424,7 +424,7 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>   
>   	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
>   	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
> -					 vm->resource_name);
> +					 vm->resource_name, 0);
>   }
>   
>   /*
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 51427c752b37b..7bac38764513d 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -331,7 +331,7 @@ static enum bp_state reserve_additional_memory(void)
>   	mutex_unlock(&balloon_mutex);
>   	/* add_memory_resource() requires the device_hotplug lock */
>   	lock_device_hotplug();
> -	rc = add_memory_resource(nid, resource);
> +	rc = add_memory_resource(nid, resource, 0);
>   	unlock_device_hotplug();
>   	mutex_lock(&balloon_mutex);
>   
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 51a877fec8da8..5cd48332ce119 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -345,11 +345,13 @@ extern void set_zone_contiguous(struct zone *zone);
>   extern void clear_zone_contiguous(struct zone *zone);
>   
>   extern void __ref free_area_init_core_hotplug(int nid);
> -extern int __add_memory(int nid, u64 start, u64 size);
> -extern int add_memory(int nid, u64 start, u64 size);
> -extern int add_memory_resource(int nid, struct resource *resource);
> +extern int __add_memory(int nid, u64 start, u64 size, unsigned long flags);
> +extern int add_memory(int nid, u64 start, u64 size, unsigned long flags);
> +extern int add_memory_resource(int nid, struct resource *resource,
> +			       unsigned long flags);
>   extern int add_memory_driver_managed(int nid, u64 start, u64 size,
> -				     const char *resource_name);
> +				     const char *resource_name,
> +				     unsigned long flags);
>   extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>   				   unsigned long nr_pages,
>   				   struct vmem_altmap *altmap, int migratetype);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e1cd18b5cf14..64b07f006bc10 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1039,7 +1039,8 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>    *
>    * we are OK calling __meminit stuff here - we have CONFIG_MEMORY_HOTPLUG
>    */
> -int __ref add_memory_resource(int nid, struct resource *res)
> +int __ref add_memory_resource(int nid, struct resource *res,
> +			      unsigned long flags)
>   {
>   	struct mhp_params params = { .pgprot = PAGE_KERNEL };
>   	u64 start, size;
> @@ -1118,7 +1119,7 @@ int __ref add_memory_resource(int nid, struct resource *res)
>   }
>   
>   /* requires device_hotplug_lock, see add_memory_resource() */
> -int __ref __add_memory(int nid, u64 start, u64 size)
> +int __ref __add_memory(int nid, u64 start, u64 size, unsigned long flags)
>   {
>   	struct resource *res;
>   	int ret;
> @@ -1127,18 +1128,18 @@ int __ref __add_memory(int nid, u64 start, u64 size)
>   	if (IS_ERR(res))
>   		return PTR_ERR(res);
>   
> -	ret = add_memory_resource(nid, res);
> +	ret = add_memory_resource(nid, res, flags);
>   	if (ret < 0)
>   		release_memory_resource(res);
>   	return ret;
>   }
>   
> -int add_memory(int nid, u64 start, u64 size)
> +int add_memory(int nid, u64 start, u64 size, unsigned long flags)
>   {
>   	int rc;
>   
>   	lock_device_hotplug();
> -	rc = __add_memory(nid, start, size);
> +	rc = __add_memory(nid, start, size, flags);
>   	unlock_device_hotplug();
>   
>   	return rc;
> @@ -1167,7 +1168,7 @@ EXPORT_SYMBOL_GPL(add_memory);
>    * "System RAM ($DRIVER)".
>    */
>   int add_memory_driver_managed(int nid, u64 start, u64 size,
> -			      const char *resource_name)
> +			      const char *resource_name, unsigned long flags)
>   {
>   	struct resource *res;
>   	int rc;
> @@ -1185,7 +1186,7 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>   		goto out_unlock;
>   	}
>   
> -	rc = add_memory_resource(nid, res);
> +	rc = add_memory_resource(nid, res, flags);
>   	if (rc < 0)
>   		release_memory_resource(res);
>   
> 

