Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584EF269C0A
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 04:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgIOCn6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Sep 2020 22:43:58 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35045 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbgIOCn4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Sep 2020 22:43:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0U9.4qNm_1600137829;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9.4qNm_1600137829)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Sep 2020 10:43:49 +0800
Date:   Tue, 15 Sep 2020 10:43:48 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
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
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v4 5/8] mm/memory_hotplug: MEMHP_MERGE_RESOURCE to
 specify merging of System RAM resources
Message-ID: <20200915024348.GA2685@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200911103459.10306-1-david@redhat.com>
 <20200911103459.10306-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200911103459.10306-6-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 11, 2020 at 12:34:56PM +0200, David Hildenbrand wrote:
>Some add_memory*() users add memory in small, contiguous memory blocks.
>Examples include virtio-mem, hyper-v balloon, and the XEN balloon.
>
>This can quickly result in a lot of memory resources, whereby the actual
>resource boundaries are not of interest (e.g., it might be relevant for
>DIMMs, exposed via /proc/iomem to user space). We really want to merge
>added resources in this scenario where possible.
>
>Let's provide a flag (MEMHP_MERGE_RESOURCE) to specify that a resource
>either created within add_memory*() or passed via add_memory_resource()
>shall be marked mergeable and merged with applicable siblings.
>
>To implement that, we need a kernel/resource interface to mark selected
>System RAM resources mergeable (IORESOURCE_SYSRAM_MERGEABLE) and trigger
>merging.
>
>Note: We really want to merge after the whole operation succeeded, not
>directly when adding a resource to the resource tree (it would break
>add_memory_resource() and require splitting resources again when the
>operation failed - e.g., due to -ENOMEM).

Oops, the latest version is here.

BTW, I don't see patch 4. Not sure it is junked by my mail system?

>
>Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Ard Biesheuvel <ardb@kernel.org>
>Cc: Thomas Gleixner <tglx@linutronix.de>
>Cc: "K. Y. Srinivasan" <kys@microsoft.com>
>Cc: Haiyang Zhang <haiyangz@microsoft.com>
>Cc: Stephen Hemminger <sthemmin@microsoft.com>
>Cc: Wei Liu <wei.liu@kernel.org>
>Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>Cc: Juergen Gross <jgross@suse.com>
>Cc: Stefano Stabellini <sstabellini@kernel.org>
>Cc: Roger Pau Monné <roger.pau@citrix.com>
>Cc: Julien Grall <julien@xen.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richardw.yang@linux.intel.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> include/linux/ioport.h         |  4 +++
> include/linux/memory_hotplug.h |  7 ++++
> kernel/resource.c              | 60 ++++++++++++++++++++++++++++++++++
> mm/memory_hotplug.c            |  7 ++++
> 4 files changed, 78 insertions(+)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index d7620d7c941a0..7e61389dcb017 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -60,6 +60,7 @@ struct resource {
> 
> /* IORESOURCE_SYSRAM specific bits. */
> #define IORESOURCE_SYSRAM_DRIVER_MANAGED	0x02000000 /* Always detected via a driver. */
>+#define IORESOURCE_SYSRAM_MERGEABLE		0x04000000 /* Resource can be merged. */
> 
> #define IORESOURCE_EXCLUSIVE	0x08000000	/* Userland may not map this resource */
> 
>@@ -253,6 +254,9 @@ extern void __release_region(struct resource *, resource_size_t,
> extern void release_mem_region_adjustable(struct resource *, resource_size_t,
> 					  resource_size_t);
> #endif
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+extern void merge_system_ram_resource(struct resource *res);
>+#endif
> 
> /* Wrappers for managed devices */
> struct device;
>diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
>index 33eb80fdba22f..d65c6fdc5cfc3 100644
>--- a/include/linux/memory_hotplug.h
>+++ b/include/linux/memory_hotplug.h
>@@ -62,6 +62,13 @@ typedef int __bitwise mhp_t;
> 
> /* No special request */
> #define MHP_NONE		((__force mhp_t)0)
>+/*
>+ * Allow merging of the added System RAM resource with adjacent,
>+ * mergeable resources. After a successful call to add_memory_resource()
>+ * with this flag set, the resource pointer must no longer be used as it
>+ * might be stale, or the resource might have changed.
>+ */
>+#define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
> 
> /*
>  * Extended parameters for memory hotplug:
>diff --git a/kernel/resource.c b/kernel/resource.c
>index 36b3552210120..7a91b935f4c20 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1363,6 +1363,66 @@ void release_mem_region_adjustable(struct resource *parent,
> }
> #endif	/* CONFIG_MEMORY_HOTREMOVE */
> 
>+#ifdef CONFIG_MEMORY_HOTPLUG
>+static bool system_ram_resources_mergeable(struct resource *r1,
>+					   struct resource *r2)
>+{
>+	/* We assume either r1 or r2 is IORESOURCE_SYSRAM_MERGEABLE. */
>+	return r1->flags == r2->flags && r1->end + 1 == r2->start &&
>+	       r1->name == r2->name && r1->desc == r2->desc &&
>+	       !r1->child && !r2->child;
>+}
>+
>+/*
>+ * merge_system_ram_resource - mark the System RAM resource mergeable and try to
>+ * merge it with adjacent, mergeable resources
>+ * @res: resource descriptor
>+ *
>+ * This interface is intended for memory hotplug, whereby lots of contiguous
>+ * system ram resources are added (e.g., via add_memory*()) by a driver, and
>+ * the actual resource boundaries are not of interest (e.g., it might be
>+ * relevant for DIMMs). Only resources that are marked mergeable, that have the
>+ * same parent, and that don't have any children are considered. All mergeable
>+ * resources must be immutable during the request.
>+ *
>+ * Note:
>+ * - The caller has to make sure that no pointers to resources that are
>+ *   marked mergeable are used anymore after this call - the resource might
>+ *   be freed and the pointer might be stale!
>+ * - release_mem_region_adjustable() will split on demand on memory hotunplug
>+ */
>+void merge_system_ram_resource(struct resource *res)
>+{
>+	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>+	struct resource *cur;
>+
>+	if (WARN_ON_ONCE((res->flags & flags) != flags))
>+		return;
>+
>+	write_lock(&resource_lock);
>+	res->flags |= IORESOURCE_SYSRAM_MERGEABLE;
>+
>+	/* Try to merge with next item in the list. */
>+	cur = res->sibling;
>+	if (cur && system_ram_resources_mergeable(res, cur)) {
>+		res->end = cur->end;
>+		res->sibling = cur->sibling;
>+		free_resource(cur);
>+	}
>+
>+	/* Try to merge with previous item in the list. */
>+	cur = res->parent->child;
>+	while (cur && cur->sibling != res)
>+		cur = cur->sibling;
>+	if (cur && system_ram_resources_mergeable(cur, res)) {
>+		cur->end = res->end;
>+		cur->sibling = res->sibling;
>+		free_resource(res);
>+	}
>+	write_unlock(&resource_lock);
>+}
>+#endif	/* CONFIG_MEMORY_HOTPLUG */
>+
> /*
>  * Managed region resource
>  */
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 8f0bd7c9a63a5..553c718226b3e 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1102,6 +1102,13 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
> 	/* device_online() will take the lock when calling online_pages() */
> 	mem_hotplug_done();
> 
>+	/*
>+	 * In case we're allowed to merge the resource, flag it and trigger
>+	 * merging now that adding succeeded.
>+	 */
>+	if (mhp_flags & MEMHP_MERGE_RESOURCE)
>+		merge_system_ram_resource(res);
>+
> 	/* online pages if requested */
> 	if (memhp_default_online_type != MMOP_OFFLINE)
> 		walk_memory_blocks(start, size, NULL, online_memory_block);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
