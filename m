Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D832A662
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Mar 2021 17:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384077AbhCBOsC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 2 Mar 2021 09:48:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350867AbhCBM7H (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 2 Mar 2021 07:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614689824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OEF+iB48cTNiKP+ZNMz7BjR6LuPsBJJOqmuhL+aZPXo=;
        b=JxeY/sU0JVUw0XQWQGMgGV68V3ogYqPOHH3nouxBfmTjmXGdOhkFqTzyA1Z6eXPytSI5//
        XTe20PwLRmig02sl5/2lUXhTv59pGtj4DrV21bLGR455JWbzo4pdekQ6a14t2Fnsrs26BE
        WCsNmbiRaEj4PLFREw7mLOkovQLu6xY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-yqVafKrCN4eenAsYfIH3XQ-1; Tue, 02 Mar 2021 07:57:03 -0500
X-MC-Unique: yqVafKrCN4eenAsYfIH3XQ-1
Received: by mail-ed1-f70.google.com with SMTP id i4so10326924edt.11
        for <linux-hyperv@vger.kernel.org>; Tue, 02 Mar 2021 04:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OEF+iB48cTNiKP+ZNMz7BjR6LuPsBJJOqmuhL+aZPXo=;
        b=g21+CkVVV/GSpu7oWnRM3WWD0gNoMxtI2Z4jtZ0aHbKjjfmMGmCGbJLopORwAdBORi
         AYLazkotRPZYRXemu/21DyXCGuxXfuZDFAaunjsE+NsxyTlz7Uo7OGsQEskwqKY+g1BW
         8l+7lj8jVKDjT9PlHaNIm4kPF1i1JlOzfKJZ0c5UqjSn1UyL3jTUNLv+mIjVMvcRVNsd
         ZdFwJRlHyBiOHDPMcuUUtNgz8BxTz4p7OqYPWLH/8SMuC9EzCSMdVTil7i5t6eAv5Ijg
         M+fPU8uH7YqNpFC9QepyKOsJ3iVjZIOxCD+eGUQGw2XKl8si8YSii/YgtmKe1TaqnpVh
         EHDA==
X-Gm-Message-State: AOAM532WFMsasKc1VIAH/uJ0PDUhSEssCnqQ2AcPeUlPgigIaRc5Y6jz
        EjdALnSpAdyIK7Tl8gfQfdobAVBOgEwKp1rDtr3UFgB6glk94LNThEteRUvuoJ5ZGTmtxeOmtnb
        C/VIgleSFho4qwjQa622qedUJc/7VkJGUAJp7sUwDxWDdZxTbceVfFEPaBEUqFmxNL4wMsl/Ukr
        cN
X-Received: by 2002:aa7:c403:: with SMTP id j3mr20422778edq.137.1614689821948;
        Tue, 02 Mar 2021 04:57:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzG88ql2RFUHF/MFuqHfbe5TvkqJOeJQQ1KRkXPoJOvtrX/awvU92pp8hadPNxU4p+haIk9Ag==
X-Received: by 2002:aa7:c403:: with SMTP id j3mr20422757edq.137.1614689821763;
        Tue, 02 Mar 2021 04:57:01 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id k27sm18623879eje.67.2021.03.02.04.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:57:01 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, sthemmin@microsoft.com,
        kys@microsoft.com, wei.liu@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Subject: Re: ** POTENTIAL FRAUD ALERT - RED HAT ** [PATCH v2 01/10] Drivers:
 hv: vmbus: Move Hyper-V page allocator to arch neutral code
In-Reply-To: <1614561332-2523-2-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
 <1614561332-2523-2-git-send-email-mikelley@microsoft.com>
Date:   Tue, 02 Mar 2021 13:57:00 +0100
Message-ID: <87r1kxemsj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> The Hyper-V page allocator functions are implemented in an architecture
> neutral way.  Move them into the architecture neutral VMbus module so
> a separate implementation for ARM64 is not needed.
>
> No functional change.
>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/x86/hyperv/hv_init.c       | 22 ----------------------
>  arch/x86/include/asm/mshyperv.h |  5 -----
>  drivers/hv/hv.c                 | 36 ++++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  4 ++++
>  4 files changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b81047d..4bdb344 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -54,28 +54,6 @@
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
>  
> -void *hv_alloc_hyperv_page(void)
> -{
> -	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> -
> -	return (void *)__get_free_page(GFP_KERNEL);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> -
> -void *hv_alloc_hyperv_zeroed_page(void)
> -{
> -        BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
> -
> -        return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> -}
> -EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
> -
> -void hv_free_hyperv_page(unsigned long addr)
> -{
> -	free_page(addr);
> -}
> -EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
> -
>  static int hv_cpu_init(unsigned int cpu)
>  {
>  	u64 msr_vp_index;
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ccf60a8..ef6e968 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -233,9 +233,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>  
>  void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
> -void *hv_alloc_hyperv_page(void);
> -void *hv_alloc_hyperv_zeroed_page(void);
> -void hv_free_hyperv_page(unsigned long addr);
>  void set_hv_tscchange_cb(void (*cb)(void));
>  void clear_hv_tscchange_cb(void);
>  void hyperv_stop_tsc_emulation(void);
> @@ -272,8 +269,6 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> -static inline void *hv_alloc_hyperv_page(void) { return NULL; }
> -static inline void hv_free_hyperv_page(unsigned long addr) {}
>  static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
>  static inline void clear_hv_tscchange_cb(void) {}
>  static inline void hyperv_stop_tsc_emulation(void) {};
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index f202ac7..cca8d5e 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -37,6 +37,42 @@ int hv_init(void)
>  }
>  
>  /*
> + * Functions for allocating and freeing memory with size and
> + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> + * the guest page size may not be the same as the Hyper-V page
> + * size. We depend upon kmalloc() aligning power-of-two size
> + * allocations to the allocation size boundary, so that the
> + * allocated memory appears to Hyper-V as a page of the size
> + * it expects.
> + */
> +
> +void *hv_alloc_hyperv_page(void)
> +{
> +	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> +
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL);
> +	else
> +		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);

PAGE_SIZE and HV_HYP_PAGE_SIZE are known compile-time and in case this
won't change in the future we can probably write this as

#if PAGE_SIZE == HV_HYP_PAGE_SIZE
       return (void *)__get_free_page(GFP_KERNEL);
#else
       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
#endif

(not sure if the output is going to be any different with e.g. gcc's '-O2')

> +}
> +
> +void *hv_alloc_hyperv_zeroed_page(void)
> +{
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
> +	else
> +		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +}
> +
> +void hv_free_hyperv_page(unsigned long addr)
> +{
> +	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
> +		free_page(addr);
> +	else
> +		kfree((void *)addr);
> +}
> +
> +/*
>   * hv_post_message - Post a message using the hypervisor message IPC.
>   *
>   * This involves a hypercall.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index dff58a3..694b5bc 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -117,6 +117,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
>  /* Sentinel value for an uninitialized entry in hv_vp_index array */
>  #define VP_INVAL	U32_MAX
>  
> +void *hv_alloc_hyperv_page(void);
> +void *hv_alloc_hyperv_zeroed_page(void);
> +void hv_free_hyperv_page(unsigned long addr);
> +
>  /**
>   * hv_cpu_number_to_vp_number() - Map CPU to VP.
>   * @cpu_number: CPU number in Linux terms

-- 
Vitaly

