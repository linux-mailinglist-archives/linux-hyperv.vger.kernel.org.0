Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C426C159
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Sep 2020 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIPKCb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Sep 2020 06:02:31 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38575 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIPKC2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Sep 2020 06:02:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0U97.XS1_1600250543;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U97.XS1_1600250543)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Sep 2020 18:02:24 +0800
Date:   Wed, 16 Sep 2020 18:02:23 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel/resource: make iomem_resource implicit in
 release_mem_region_adjustable()
Message-ID: <20200916100223.GA46154@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200911103459.10306-1-david@redhat.com>
 <20200916073041.10355-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916073041.10355-1-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Sep 16, 2020 at 09:30:41AM +0200, David Hildenbrand wrote:
>"mem" in the name already indicates the root, similar to
>release_mem_region() and devm_request_mem_region(). Make it implicit.
>The only single caller always passes iomem_resource, other parents are
>not applicable.
>

Looks good to me.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>Suggested-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Dan Williams <dan.j.williams@intel.com>
>Cc: Jason Gunthorpe <jgg@ziepe.ca>
>Cc: Kees Cook <keescook@chromium.org>
>Cc: Ard Biesheuvel <ardb@kernel.org>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Baoquan He <bhe@redhat.com>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
>
>Based on next-20200915. Follow up on
>	"[PATCH v4 0/8] selective merging of system ram resources" [1]
>That's in next-20200915. As noted during review of v2 by Wei [2].
>
>[1] https://lkml.kernel.org/r/20200911103459.10306-1-david@redhat.com
>[2] https://lkml.kernel.org/r/20200915021012.GC2007@L-31X9LVDL-1304.local
>
>---
> include/linux/ioport.h | 3 +--
> kernel/resource.c      | 5 ++---
> mm/memory_hotplug.c    | 2 +-
> 3 files changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>index 7e61389dcb01..5135d4b86cd6 100644
>--- a/include/linux/ioport.h
>+++ b/include/linux/ioport.h
>@@ -251,8 +251,7 @@ extern struct resource * __request_region(struct resource *,
> extern void __release_region(struct resource *, resource_size_t,
> 				resource_size_t);
> #ifdef CONFIG_MEMORY_HOTREMOVE
>-extern void release_mem_region_adjustable(struct resource *, resource_size_t,
>-					  resource_size_t);
>+extern void release_mem_region_adjustable(resource_size_t, resource_size_t);
> #endif
> #ifdef CONFIG_MEMORY_HOTPLUG
> extern void merge_system_ram_resource(struct resource *res);
>diff --git a/kernel/resource.c b/kernel/resource.c
>index 7a91b935f4c2..ca2a666e4317 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1240,7 +1240,6 @@ EXPORT_SYMBOL(__release_region);
> #ifdef CONFIG_MEMORY_HOTREMOVE
> /**
>  * release_mem_region_adjustable - release a previously reserved memory region
>- * @parent: parent resource descriptor
>  * @start: resource start address
>  * @size: resource region size
>  *
>@@ -1258,9 +1257,9 @@ EXPORT_SYMBOL(__release_region);
>  *   assumes that all children remain in the lower address entry for
>  *   simplicity.  Enhance this logic when necessary.
>  */
>-void release_mem_region_adjustable(struct resource *parent,
>-				   resource_size_t start, resource_size_t size)
>+void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> {
>+	struct resource *parent = &iomem_resource;
> 	struct resource *new_res = NULL;
> 	bool alloc_nofail = false;
> 	struct resource **p;
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 553c718226b3..7c5e4744ac51 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -1764,7 +1764,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
> 		memblock_remove(start, size);
> 	}
> 
>-	release_mem_region_adjustable(&iomem_resource, start, size);
>+	release_mem_region_adjustable(start, size);
> 
> 	try_offline_node(nid);
> 
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
