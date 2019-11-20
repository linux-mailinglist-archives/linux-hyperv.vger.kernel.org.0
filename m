Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD91041CD
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Nov 2019 18:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbfKTRMR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 20 Nov 2019 12:12:17 -0500
Received: from foss.arm.com ([217.140.110.172]:43184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbfKTRMR (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 20 Nov 2019 12:12:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1695F1FB;
        Wed, 20 Nov 2019 09:12:16 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D6743F703;
        Wed, 20 Nov 2019 09:12:14 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:12:12 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v2 4/4] PCI: hv: kmemleak: Track the page allocations for
 struct hv_pcibus_device
Message-ID: <20191120171212.GD3279@e121166-lin.cambridge.arm.com>
References: <1574234218-49195-1-git-send-email-decui@microsoft.com>
 <1574234218-49195-5-git-send-email-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574234218-49195-5-git-send-email-decui@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Nov 19, 2019 at 11:16:58PM -0800, Dexuan Cui wrote:
> The page allocated for struct hv_pcibus_device contains pointers to other
> slab allocations in new_pcichild_device(). Since kmemleak does not track
> and scan page allocations, the slab objects will be reported as leaks
> (false positives). Use the kmemleak APIs to allow tracking of such pages.
> 
> Reported-by: Lili Deng <v-lide@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> This is actually v1. I use "v2" in the Subject just to be consistent with
> the other patches in the patchset.

That's a mistake, you should have posted patches separately. I need
hyper-V ACKs on this series to get it through.

Thanks,
Lorenzo

> Without the patch, we can see the below warning in dmesg, if kmemleak is
> enabled: 
> 
> kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
> and "cat /sys/kernel/debug/kmemleak" shows:
> 
> unreferenced object 0xffff9217d1f2bec0 (size 192):
>   comm "kworker/u256:7", pid 100821, jiffies 4501481057 (age 61409.997s)
>   hex dump (first 32 bytes):
>     a8 60 b1 63 17 92 ff ff a8 60 b1 63 17 92 ff ff  .`.c.....`.c....
>     02 00 00 00 00 00 00 00 80 92 cd 61 17 92 ff ff  ...........a....
>   backtrace:
>     [<0000000006f7ae93>] pci_devices_present_work+0x326/0x5e0 [pci_hyperv]
>     [<00000000278eb88a>] process_one_work+0x15f/0x360
>     [<00000000c59501e6>] worker_thread+0x49/0x3c0
>     [<000000000a0a7a94>] kthread+0xf8/0x130
> [<000000007075c2e7>] ret_from_fork+0x35/0x40
> 
>  drivers/pci/controller/pci-hyperv.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index d7e05d436b5e..cc73f49c9e03 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -46,6 +46,7 @@
>  #include <asm/irqdomain.h>
>  #include <asm/apic.h>
>  #include <linux/irq.h>
> +#include <linux/kmemleak.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
>  #include <linux/refcount.h>
> @@ -2907,6 +2908,16 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hbus = (struct hv_pcibus_device *)get_zeroed_page(GFP_KERNEL);
>  	if (!hbus)
>  		return -ENOMEM;
> +
> +	/*
> +	 * kmemleak doesn't track page allocations as they are not commonly
> +	 * used for kernel data structures, but here hbus->children indeed
> +	 * contains pointers to hv_pci_dev structs, which are dynamically
> +	 * created in new_pcichild_device(). Allow kmemleak to scan the page
> +	 * so we don't get a false warning of memory leak.
> +	 */
> +	kmemleak_alloc(hbus, PAGE_SIZE, 1, GFP_KERNEL);
> +
>  	hbus->state = hv_pcibus_init;
>  
>  	/*
> @@ -3133,6 +3144,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>  
>  	hv_put_dom_num(hbus->sysdata.domain);
>  
> +	/* Remove kmemleak object previously allocated in hv_pci_probe() */
> +	kmemleak_free(hbus);
>  	free_page((unsigned long)hbus);
>  	return ret;
>  }
> -- 
> 2.19.1
> 
