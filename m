Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612F272254E
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jun 2023 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjFEMOQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 5 Jun 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFEMOP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 5 Jun 2023 08:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD61A1
        for <linux-hyperv@vger.kernel.org>; Mon,  5 Jun 2023 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685967215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFPAE5ohpVyr08nMX1EcEfF4UhhbllJe9amhr2huvq8=;
        b=OIuE20Loc3LFxJuV0+LU1ZZKMLVEUgeQkmEIkO8gE+1Hv97fi4+hw8z26h/hXKuBMOOEL2
        TgGVEWYeqOfJhmMK2GWfQVMkoIzxqL3rUV6R3qdvqBFb1tZftBuU9PeXaD8AAuFnYXbf/f
        g6LFKDfO6tJEbN33BKozKTSBdNFaBvw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-R6-mHm83PwC1L11NoeuLcg-1; Mon, 05 Jun 2023 08:13:33 -0400
X-MC-Unique: R6-mHm83PwC1L11NoeuLcg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3f6b33be156so41729801cf.1
        for <linux-hyperv@vger.kernel.org>; Mon, 05 Jun 2023 05:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967213; x=1688559213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFPAE5ohpVyr08nMX1EcEfF4UhhbllJe9amhr2huvq8=;
        b=BNYXwvmdXu7NrYLLAwqZbf04EerY4xQBX1L9/7CwOhgc5d6dNrFR3lx44pmDZ7Z3Nw
         HHVj3I5qtTfjs8wn0py75E9B6LUDv1EeRLhSm/zM3niBCMd6FOlKn2/mpzd+0ksB4nUu
         9ae7aTYJ3MRAPMTyd5NsZTT0qbv2/wSY5Ewz19E3twHHB1H0kKqc4X8tkYm+vwwIBVin
         QsuPhbAIoS1PGAhkzIEv8HZVmN5Ze7Lpap0M4m7vYdHlB+lrGMwrIIv4Ygu/q8YPQyRM
         cWAJMy/uhA2/lhMsGJ0gAw4reUmg+XUuZLZRlGiDiCl/SOhZ390lZDSmSaF8nKcPjxP9
         MFPw==
X-Gm-Message-State: AC+VfDzbltm6N8c9CJrRt2ntaiFiDXDoUWwN2ADh1nYXOz7zVyjUlWho
        qLj4QcOrc1MblliEO8w8zN7G7ZB2yzWGxxWkBjSpaJy928NoGIAp9LUYa4NxieN598JJ2HIkGKT
        qTxjkhp/R4OPmm6tJH/nYFDP/
X-Received: by 2002:ac8:574b:0:b0:3f5:2177:eca0 with SMTP id 11-20020ac8574b000000b003f52177eca0mr6159128qtx.5.1685967213409;
        Mon, 05 Jun 2023 05:13:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4JadlUNRHirs0VSuDH2KVG503ZN3GXJ9bc/XJ9WIKXlYivskf8yvoaOVreWjtOxl/p3DNR+Q==
X-Received: by 2002:ac8:574b:0:b0:3f5:2177:eca0 with SMTP id 11-20020ac8574b000000b003f52177eca0mr6159102qtx.5.1685967213181;
        Mon, 05 Jun 2023 05:13:33 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id h13-20020ac8714d000000b003f17f39af49sm4664985qtp.18.2023.06.05.05.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:13:32 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted
 in SEV-SNP enlightened guest
In-Reply-To: <20230601151624.1757616-4-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-4-ltykernel@gmail.com>
Date:   Mon, 05 Jun 2023 14:13:29 +0200
Message-ID: <873536ksye.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Tianyu Lan <tiala@microsoft.com>
>
> hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
> So mark the page unencrypted in the SEV-SNP guest.
>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b4a2327c823b..331b855314b7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -18,6 +18,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
> +#include <asm/set_memory.h>
>  #include <linux/kexec.h>
>  #include <linux/version.h>
>  #include <linux/vmalloc.h>
> @@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
>  
>  	}
>  	if (!WARN_ON(!(*hvp))) {
> +		if (hv_isolation_type_en_snp()) {
> +			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
> +			memset(*hvp, 0, PAGE_SIZE);
> +		}

Why do we need to set the page as decrypted here and not when we
allocate the page (a few lines above)? And why do we need to clear it
_after_ we made it decrypted? In case we care about not leaking the
stale content to the hypervisor, we should've cleared it _before_, but
the bigger problem I see is that memset() is problemmatic e.g. for KVM
which uses enlightened VMCS. You put a CPU offline and then back online
and this path will be taken. Clearing VP assist page will likely brake
things. (AFAIU SEV-SNP Hyper-V guests don't expose SVM yet so the
problem is likely theoretical only, but still).

> +
>  		msr.enable = 1;
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
>  	}

-- 
Vitaly

