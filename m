Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA662885E8
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Oct 2020 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbgJIJYj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Oct 2020 05:24:39 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:59963 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731262AbgJIJYi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Oct 2020 05:24:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0UBQ5Qni_1602235473;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UBQ5Qni_1602235473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Oct 2020 17:24:34 +0800
Date:   Fri, 9 Oct 2020 17:24:33 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     david@redhat.com, akpm@linux-foundation.org, ardb@kernel.org,
        bhe@redhat.com, dan.j.williams@intel.com, jgg@ziepe.ca,
        keescook@chromium.org, linux-acpi@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nvdimm@lists.01.org,
        linux-s390@vger.kernel.org, mhocko@suse.com,
        pankaj.gupta.linux@gmail.com, richardw.yang@linux.intel.com,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kernel/resource: Fix use of ternary condition in
 release_mem_region_adjustable
Message-ID: <20201009092433.GA56924@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200911103459.10306-2-david@redhat.com>
 <20200922060748.2452056-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922060748.2452056-1-natechancellor@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 21, 2020 at 11:07:48PM -0700, Nathan Chancellor wrote:
>Clang warns:
>
>kernel/resource.c:1281:53: warning: operator '?:' has lower precedence
>than '|'; '|' will be evaluated first
>[-Wbitwise-conditional-parentheses]
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>kernel/resource.c:1281:53: note: place parentheses around the '|'
>expression to silence this warning
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                 ~~~~~~~~~~~~~~~~~~~~~~~~~ ^
>kernel/resource.c:1281:53: note: place parentheses around the '?:'
>expression to evaluate it first
>        new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>                                                           ^
>                                              (                              )
>1 warning generated.
>
>Add the parentheses as it was clearly intended for the ternary condition
>to be evaluated first.
>
>Fixes: 5fd23bd0d739 ("kernel/resource: make release_mem_region_adjustable() never fail")
>Link: https://github.com/ClangBuiltLinux/linux/issues/1159
>Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
>
>Presumably, this will be squashed but I included a fixes tag
>nonetheless. Apologies if this has already been noticed and fixed
>already, I did not find anything on LKML.
>
> kernel/resource.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/kernel/resource.c b/kernel/resource.c
>index ca2a666e4317..3ae2f56cc79d 100644
>--- a/kernel/resource.c
>+++ b/kernel/resource.c
>@@ -1278,7 +1278,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
> 	 * similarly).
> 	 */
> retry:
>-	new_res = alloc_resource(GFP_KERNEL | alloc_nofail ? __GFP_NOFAIL : 0);
>+	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
> 
> 	p = &parent->child;
> 	write_lock(&resource_lock);
>
>base-commit: 40ee82f47bf297e31d0c47547cd8f24ede52415a
>-- 
>2.28.0

-- 
Wei Yang
Help you, Help me
