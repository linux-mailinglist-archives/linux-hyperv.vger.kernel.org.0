Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C213F4229B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2019 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406375AbfFLKgF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jun 2019 06:36:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406027AbfFLKgF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jun 2019 06:36:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id g135so6019085wme.4
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Jun 2019 03:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F2AOmZb2yguiGSmSU0nhevs48sI1vSX5WkrCsfTsjyQ=;
        b=bVn+2qywaR2qReWzasOxEYPqq9kvm27zp0AR9tbSYpzf+wxEJ0QM5pLCgLvOwgRdtR
         g8rwOJLQYwl0NxqEzxlBS/GhJdn+yIdiaZgLY+aHs8GILMkSdMzUqCzVlrWhjn9Zm4a7
         DffYBbC91YYFBdtUe01zBjURfeUvCoz+n0TvLWZGlgmV1YGv+O3iXQOrjPld/2CztsPf
         IWrNW/W9CytNk3Fp1IzngdH249UJ74n79lqDse5UjfpOzNcDL4RKjthxThrWUf0Ui0w4
         VMzu02oBFNlFifjAO3nqY2GxfxuC2BY6HIMFxYujOrXWNe8gj5OSYBww+fbwfTTlZH96
         hc2A==
X-Gm-Message-State: APjAAAWYQdlD+eFdF4wW+NjuYinve0MAOO+NP2SvNLLS3rRNTb0Z4UWX
        k7XR/Gd01cy567LOz/YzDRDlVA==
X-Google-Smtp-Source: APXvYqxNR2gVHhO6j5Y+UrOQNTZS2wito02Q/MeNcfwjcH9EZhZUbFaMW+BWDVTz7rkhc+WsLQVgMg==
X-Received: by 2002:a7b:c933:: with SMTP id h19mr22587462wml.52.1560335762925;
        Wed, 12 Jun 2019 03:36:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q21sm4318286wmq.13.2019.06.12.03.36.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 03:36:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH v2 1/5] x86: hv: hyperv-tlfs.h: Create and use Hyper-V page definitions
In-Reply-To: <67be3e283c0f28326f9c31a64f399fe659ad5690.1559807514.git.m.maya.nakamura@gmail.com>
References: <cover.1559807514.git.m.maya.nakamura@gmail.com> <67be3e283c0f28326f9c31a64f399fe659ad5690.1559807514.git.m.maya.nakamura@gmail.com>
Date:   Wed, 12 Jun 2019 12:36:01 +0200
Message-ID: <87pnnjdram.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> Define HV_HYP_PAGE_SHIFT, HV_HYP_PAGE_SIZE, and HV_HYP_PAGE_MASK because
> the Linux guest page size and hypervisor page size concepts are
> different, even though they happen to be the same value on x86.
>
> Also, replace PAGE_SIZE with HV_HYP_PAGE_SIZE.
>
> Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index cdf44aa9a501..44bd68aefd00 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -12,6 +12,16 @@
>  #include <linux/types.h>
>  #include <asm/page.h>
>  
> +/*
> + * While not explicitly listed in the TLFS, Hyper-V always runs with a page size
> + * of 4096. These definitions are used when communicating with Hyper-V using
> + * guest physical pages and guest physical page addresses, since the guest page
> + * size may not be 4096 on all architectures.
> + */
> +#define HV_HYP_PAGE_SHIFT	12
> +#define HV_HYP_PAGE_SIZE	BIT(HV_HYP_PAGE_SHIFT)
> +#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
> +
>  /*
>   * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
>   * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
> @@ -841,7 +851,7 @@ union hv_gpa_page_range {
>   * count is equal with how many entries of union hv_gpa_page_range can
>   * be populated into the input parameter page.
>   */
> -#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
> +#define HV_MAX_FLUSH_REP_COUNT ((HV_HYP_PAGE_SIZE - 2 * sizeof(u64)) /	\
>  				sizeof(union hv_gpa_page_range))
>  
>  struct hv_guest_mapping_flush_list {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly
