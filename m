Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58ECF3135
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2019 15:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKGOTf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 Nov 2019 09:19:35 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:33890 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbfKGOTe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 Nov 2019 09:19:34 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iSidE-0006pE-M7; Thu, 07 Nov 2019 15:19:28 +0100
To:     Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 3/8] arm64: hyperv: Add memory alloc/free functions  for Hyper-V size pages
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Nov 2019 15:28:49 +0109
From:   Marc Zyngier <maz@kernel.org>
Cc:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, <devel@linuxdriverproject.org>,
        <olaf@aepfle.de>, <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>, <jasowang@redhat.com>,
        <marcelo.cerri@canonical.com>, KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng" <boqun.feng@gmail.com>
In-Reply-To: <1570129355-16005-4-git-send-email-mikelley@microsoft.com>
References: <1570129355-16005-1-git-send-email-mikelley@microsoft.com>
 <1570129355-16005-4-git-send-email-mikelley@microsoft.com>
Message-ID: <43d53ebd2637bd9106137103028a4f0e@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: mikelley@microsoft.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com, jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com, sunilmut@microsoft.com, boqun.feng@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2019-10-03 20:12, Michael Kelley wrote:
> Add ARM64-specific code to allocate memory with HV_HYP_PAGE_SIZE
> size and alignment. These are for use when pages need to be shared
> with Hyper-V. Separate functions are needed as the page size used
> by Hyper-V may not be the same as the guest page size.  Free
> operations are rarely done, so no attempt is made to combine
> freed pages into larger chunks.
>
> This code is built only when CONFIG_HYPERV is enabled.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  arch/arm64/hyperv/hv_init.c    | 68
> ++++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h |  5 ++++
>  2 files changed, 73 insertions(+)
>
> diff --git a/arch/arm64/hyperv/hv_init.c 
> b/arch/arm64/hyperv/hv_init.c
> index 6808bc8..9c294f6 100644
> --- a/arch/arm64/hyperv/hv_init.c
> +++ b/arch/arm64/hyperv/hv_init.c
> @@ -15,10 +15,78 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/hyperv.h>
> +#include <linux/spinlock.h>
> +#include <linux/list.h>
> +#include <linux/string.h>
>  #include <asm-generic/bug.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>
> +
> +/*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. And while kalloc() could allocate the memory, it does not
> + * guarantee the required alignment. So a separate small memory
> + * allocator is needed.  The free function is rarely used, so it
> + * does not try to combine freed pages into larger chunks.

Is this still needed now that kmalloc has alignment guarantees
(see 59bb47985c1d)?

         M.
-- 
Jazz is not dead. It just smells funny...
