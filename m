Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621E02B08B2
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Nov 2020 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgKLPor (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 12 Nov 2020 10:44:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbgKLPor (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 12 Nov 2020 10:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605195885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qxjTdSqsz6xIg1WvznsPF+RZUGZ5GXFMr8Y82HN6228=;
        b=I0SZ/ntCb+D9zfYo+shM2A6nh7iDqy89a16ox4QkwhYplApxBMuhRbBEZEAYDgb2ElDPLe
        JV9lBT8eesqQPS3zBrjkiI0dmsl7ReTgkoW+bo3GQmAGKOi+5tqhPcaDxvLXLMrWpEb8kq
        OsEIAd2kkbnRVCDVFcOjNjw11oOg6vc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-A_OgmZQFPROb7TSoPN9uxg-1; Thu, 12 Nov 2020 10:44:44 -0500
X-MC-Unique: A_OgmZQFPROb7TSoPN9uxg-1
Received: by mail-wr1-f72.google.com with SMTP id e18so2093910wrs.23
        for <linux-hyperv@vger.kernel.org>; Thu, 12 Nov 2020 07:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qxjTdSqsz6xIg1WvznsPF+RZUGZ5GXFMr8Y82HN6228=;
        b=BFD0JmqC07ms1dK+h4LDV1W9dqgqOMpAzppQvNbf/bioUxXt2zxjkLnMu5ylC7KSnZ
         bj83itHzw9A9v2XRXfUOHp9ixuawLrncvzMFzIbSvHNDSfPAZeqL6azDB/SogU+SeciS
         MnHkveuZcYjLX2yYJ+iv2fAvVhAdt0lUqSLxDmFwfefSOGcu5omAni2laMIUeAEzdDIQ
         SObsBwFZjjZOjaRVbzSf7zDwPB5t8WFtgyADSuhyZ8AGwESsS5lvryYP8IEVgm0J80Fa
         a6AVYf3PZnd494Z9oVXA+dNMJpPxE5xp8xINAgdmct97CE2Dc/mQX5ZgnotvQ25CUSkp
         MFKA==
X-Gm-Message-State: AOAM531uwzUheBVHtqWr0av7Vxb64UUHUxBvLBLqpm29KyBKoSleo76G
        YjLr9OdHU2Xi78WwZhp16nAVwrb1rY3Or9SpuTsp88tO4xBVnDUTe00mL6G4QU+GgTfzKJFPt3s
        R67C3fveElTSmRIuBvdUdeUND
X-Received: by 2002:a7b:c309:: with SMTP id k9mr292664wmj.14.1605195881877;
        Thu, 12 Nov 2020 07:44:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcJOmNhQc4LX1KGkibEmhcyJC2zSWy0ZlOScjlyw1KRKeL72zv1sDLur1nMapHOCf6wYE/HQ==
X-Received: by 2002:a7b:c309:: with SMTP id k9mr292640wmj.14.1605195881639;
        Thu, 12 Nov 2020 07:44:41 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 34sm7209189wrq.27.2020.11.12.07.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 07:44:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 07/17] x86/hyperv: extract partition ID from
 Microsoft Hypervisor if necessary
In-Reply-To: <20201105165814.29233-8-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-8-wei.liu@kernel.org>
Date:   Thu, 12 Nov 2020 16:44:39 +0100
Message-ID: <877dqqy3yw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> We will need the partition ID for executing some hypercalls later.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 7a2e37f025b0..73b0fb851f76 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -30,6 +30,9 @@
>  bool hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>  
> +u64 hv_current_partition_id;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> @@ -335,6 +338,26 @@ static struct syscore_ops hv_syscore_ops = {
>  	.resume		= hv_resume,
>  };
>  
> +void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	u16 status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> +		HV_HYPERCALL_RESULT_MASK;
> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("Failed to get partition ID: %d\n", status);
> +	else
> +		hv_current_partition_id = output_page->partition_id;

Nit: I'd suggest we simplify this to:

	if (status != HV_STATUS_SUCCESS) {
		pr_err("Failed to get partition ID: %d\n", status);
		BUG();
	}
	hv_current_partition_id = output_page->partition_id;

and drop BUG_ON() below;

> +	local_irq_restore(flags);
> +
> +	/* No point in proceeding if this failed */
> +	BUG_ON(status != HV_STATUS_SUCCESS);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -430,6 +453,9 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> +	if (hv_root_partition)
> +		hv_get_partition_id();
> +


We don't seem to check that the partition has AccessPartitionId
privilege. While I guess that root partitions always have it, I'd
suggest we write this as:

	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
		hv_get_partition_id();

	BUG_ON(hv_root_partition && !hv_current_partition_id);

for correctness. Also, we need to make sure '0' is not a valid partition
id and use e.g. -1 otherwise.

>  	return;
>  
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index 62d9390f1ddf..67f5d35a73d3 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -78,6 +78,8 @@ extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  extern void  __percpu  **hyperv_pcpu_output_arg;
>  
> +extern u64 hv_current_partition_id;
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e6903589a82a..87b1a79b19eb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
>  	u64 gva_list[];
>  } __packed;
>  
> +/* HvGetPartitionId hypercall (output only) */
> +struct hv_get_partition_id {
> +	u64 partition_id;
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

