Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58EA314FC3
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Feb 2021 14:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhBINGN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Feb 2021 08:06:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231159AbhBINF7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Feb 2021 08:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612875871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YlDBN62QT+LjsTA/QUxGQGe58lH6AMBqtq7gFGvrAJU=;
        b=h+zcKPaZLzfWCXivP745Kiq+Ey9uZ+SD0rxSXpkgMxG4ykzSzVGJ3l4SHOjWgiSJvRAXD7
        VS2GfN0f8rIUQji6zEhCnlPwzYqQZiDFKlWQcrKpSdpwliFNG1b+lTPpoVeRp2HVY0bROV
        te0Gkt7GY6vIKE+1b+SgKTmCbzi+xaw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-5UGn4PRvMTqSJ6U8DjyqSA-1; Tue, 09 Feb 2021 08:04:30 -0500
X-MC-Unique: 5UGn4PRvMTqSJ6U8DjyqSA-1
Received: by mail-ed1-f70.google.com with SMTP id f21so14749533edx.10
        for <linux-hyperv@vger.kernel.org>; Tue, 09 Feb 2021 05:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=YlDBN62QT+LjsTA/QUxGQGe58lH6AMBqtq7gFGvrAJU=;
        b=WqdKU55Bcuyny5a16xkdlEXS/OB2jMcHp7YNWvZ4YZ74YnsWZf7I31MU53gmh/j35M
         Ium9thhVDexiW5d1hkjh/w1r0KACsUzXDOP5zQyBs8bs/M8HZjcAiaxY5kb/7P+n3c4H
         g9hNUMc7XKxalcRMgvuVlcsDFg7/CY3SKP0qcVkBffL0lu/3KpdECnEDExee+96gSe7V
         GIDQE8/x/3dJT6giTTRpBVq74VYTjDjG4wU9azuxmPNP62tX6OUVqqaYJWV6AmDKex6S
         PkPLrGaMZ8pg4DuMyAxgCCrl5DCV8KgJR5RjxlguVfh7fkV8zMyRP3iehbvAZVY/UAkL
         RxmA==
X-Gm-Message-State: AOAM533SDCODqkITcKQ5jf6YaaVmpIUOerexn2+9NupbLJ1Hj402HXPK
        RVdtmU6fvuCOvuP5uCmdvCVjC4xwS5g7GkaTng0E+xJTHVDpi0sgpmg8ntaG8dhg/7T3TuXb5as
        ze3pL8bOsK7x5qESNY47VQ8kx
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr23107270edu.316.1612875869257;
        Tue, 09 Feb 2021 05:04:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyo4HIuR+0T9rUcQDNRaZ095+7jSeihXr6nVh2iiZp6SzMTP3xc+j9f2+Ss547tuohb9vi9EQ==
X-Received: by 2002:a05:6402:104e:: with SMTP id e14mr23107248edu.316.1612875869035;
        Tue, 09 Feb 2021 05:04:29 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a25sm11417578eds.48.2021.02.09.05.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:04:28 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
        ligrassi@microsoft.com, kys@microsoft.com
Subject: Re: [RFC PATCH 01/18] x86/hyperv: convert hyperv statuses to linux
 error codes
In-Reply-To: <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
References: <1605918637-12192-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1605918637-12192-2-git-send-email-nunodasneves@linux.microsoft.com>
Date:   Tue, 09 Feb 2021 14:04:27 +0100
Message-ID: <871rdpo0is.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> Return linux-friendly error codes from hypercall wrapper functions.
> This will be needed in the mshv module.
>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_proc.c         | 30 ++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h   |  1 +
>  include/asm-generic/hyperv-tlfs.h | 32 +++++++++++++++++++++----------
>  3 files changed, 50 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index 0fd972c9129a..8f86f8e86748 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -18,6 +18,30 @@
>  #define HV_DEPOSIT_MAX_ORDER (8)
>  #define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
>  
> +int hv_status_to_errno(int hv_status)
> +{
> +	switch (hv_status) {
> +	case HV_STATUS_SUCCESS:
> +		return 0;
> +	case HV_STATUS_INVALID_PARAMETER:
> +	case HV_STATUS_UNKNOWN_PROPERTY:
> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
> +	case HV_STATUS_INVALID_VP_INDEX:
> +	case HV_STATUS_INVALID_REGISTER_VALUE:
> +	case HV_STATUS_INVALID_LP_INDEX:
> +		return EINVAL;
> +	case HV_STATUS_ACCESS_DENIED:
> +	case HV_STATUS_OPERATION_DENIED:
> +		return EACCES;
> +	case HV_STATUS_NOT_ACKNOWLEDGED:
> +	case HV_STATUS_INVALID_VP_STATE:
> +	case HV_STATUS_INVALID_PARTITION_STATE:
> +		return EBADFD;
> +	}
> +	return ENOTRECOVERABLE;
> +}
> +EXPORT_SYMBOL_GPL(hv_status_to_errno);
> +
>  /*
>   * Deposits exact number of pages
>   * Must be called with interrupts enabled
> @@ -99,7 +123,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  
>  	if (status != HV_STATUS_SUCCESS) {
>  		pr_err("Failed to deposit pages: %d\n", status);
> -		ret = status;
> +		ret = -hv_status_to_errno(status);

"-hv_status_to_errno" looks weird, could we just return
'-EINVAL'/'-EACCES'/... from hv_status_to_errno() instead?

>  		goto err_free_allocations;
>  	}
>  
> @@ -155,7 +179,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>  			if (status != HV_STATUS_SUCCESS) {
>  				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
>  				       lp_index, apic_id, status);
> -				ret = status;
> +				ret = -hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> @@ -203,7 +227,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>  			if (status != HV_STATUS_SUCCESS) {
>  				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
>  				       vp_index, flags, status);
> -				ret = status;
> +				ret = -hv_status_to_errno(status);
>  			}
>  			break;
>  		}
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index cbee72550a12..eb75faa4d4c5 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -243,6 +243,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
>  int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
> +int hv_status_to_errno(int hv_status);
>  
>  extern bool hv_root_partition;
>  
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index dd385c6a71b5..445244192fa4 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -181,16 +181,28 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
>  
>  /* hypercall status code */
> -#define HV_STATUS_SUCCESS			0
> -#define HV_STATUS_INVALID_HYPERCALL_CODE	2
> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
> -#define HV_STATUS_INVALID_ALIGNMENT		4
> -#define HV_STATUS_INVALID_PARAMETER		5
> -#define HV_STATUS_OPERATION_DENIED		8
> -#define HV_STATUS_INSUFFICIENT_MEMORY		11
> -#define HV_STATUS_INVALID_PORT_ID		17
> -#define HV_STATUS_INVALID_CONNECTION_ID		18
> -#define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_SUCCESS			0x0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE	0x2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT	0x3
> +#define HV_STATUS_INVALID_ALIGNMENT		0x4
> +#define HV_STATUS_INVALID_PARAMETER		0x5
> +#define HV_STATUS_ACCESS_DENIED			0x6
> +#define HV_STATUS_INVALID_PARTITION_STATE	0x7
> +#define HV_STATUS_OPERATION_DENIED		0x8
> +#define HV_STATUS_UNKNOWN_PROPERTY		0x9
> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	0xA
> +#define HV_STATUS_INSUFFICIENT_MEMORY		0xB
> +#define HV_STATUS_INVALID_PARTITION_ID		0xD
> +#define HV_STATUS_INVALID_VP_INDEX		0xE
> +#define HV_STATUS_NOT_FOUND			0x10
> +#define HV_STATUS_INVALID_PORT_ID		0x11
> +#define HV_STATUS_INVALID_CONNECTION_ID		0x12
> +#define HV_STATUS_INSUFFICIENT_BUFFERS		0x13
> +#define HV_STATUS_NOT_ACKNOWLEDGED		0x14
> +#define HV_STATUS_INVALID_VP_STATE		0x15
> +#define HV_STATUS_NO_RESOURCES			0x1D
> +#define HV_STATUS_INVALID_LP_INDEX		0x41
> +#define HV_STATUS_INVALID_REGISTER_VALUE	0x50
>  
>  /*
>   * The Hyper-V TimeRefCount register and the TSC

-- 
Vitaly

