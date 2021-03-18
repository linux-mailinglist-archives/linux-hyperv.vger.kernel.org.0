Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5B340489
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Mar 2021 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhCRLYu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Mar 2021 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCRLYU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Mar 2021 07:24:20 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798F4C06174A;
        Thu, 18 Mar 2021 04:24:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5169619wmi.3;
        Thu, 18 Mar 2021 04:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7qJv0lmltyhc5pLle5TGq0wHOrg4Xv+8MBOabo0U+fQ=;
        b=cbdK40LKe8CsIG8ZwTUMcukZVEkgnIWdPSsm7+P0bECdTtthwoS9fuXpZkR4Z7rRgQ
         Pb5Nb43hNMfp57cYd0Us0hOm12SOtZyFyn0b3sKReFBkC7VAyr3Cek1O/IGnrOI+BVt4
         qD7yRQUkDjlh0IAFKGvpPnYugURNC6t8xElERQvEKCViTZniQGgac8GO5wrxtO+M2FeW
         ifeGr7eiFWbavrxBrTdzvmWl++rxYv86oS1YsHvu3kSdlssvawBM+C053+24xBiEzBHk
         L2NnmLO07DzXz110GZpvgFf+lwx5nm76CuPJr1CpRkOg/hZzQvvG6CIvqHciHdsAl8Uh
         q5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7qJv0lmltyhc5pLle5TGq0wHOrg4Xv+8MBOabo0U+fQ=;
        b=WcfqX3ubnUAROImKexgJugNwsfrNuobwIoK96+UELp+tQAh8V5WHQdpSxkzxNlaOSe
         NVnGR7/Mh0IhieLNDjkiD8/1RC0kJ7LI5LYPTfGzJ/s1WWc3df4Po6wFDvAGpfL8JbyD
         9Xf/9tJnK3BUTshOuu7BInn+wME1A2wskogNfF7wh7BicehpSPIIIZvzLiLSKVIqRS0g
         wJKnKacefJtK+45xl1XI243SWXQob2PHiiNwmFCJPVUX5Cju0Js+CVqRaS0kWLOd6HCe
         J2EBA2potPhY/h2uyyAmMjge+8BTVibOHVMwQGCmvvAuKbUc0Q3yGPramKttEqDml6Gh
         HlQQ==
X-Gm-Message-State: AOAM533zAoJZVj6wDvtT/FuQXrjXt5Mp8tCS5PNBlOjmBpqSwoOY4/V5
        VQvwOg9kYg9zRZWAMEc1ni/UhodLuFk=
X-Google-Smtp-Source: ABdhPJz3lLcv0vMupNne2uqgg3lfiSO4Nvz15rmiJ7mwQrBj4JL+DXzW1AhOMwvUJEb5juWUTAZfeA==
X-Received: by 2002:a7b:c410:: with SMTP id k16mr3045685wmi.121.1616066658306;
        Thu, 18 Mar 2021 04:24:18 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g5sm2666179wrq.30.2021.03.18.04.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:24:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 18 Mar 2021 12:24:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Xu Yihang <xuyihang@huawei.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] x86: Fix unused variable 'hi'
Message-ID: <20210318112415.GA301630@gmail.com>
References: <20210318074607.124663-1-xuyihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210318074607.124663-1-xuyihang@huawei.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


* Xu Yihang <xuyihang@huawei.com> wrote:

> Fixes the following W=1 kernel build warning(s):
> arch/x86/hyperv/hv_apic.c:58:15: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Yihang <xuyihang@huawei.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index 284e73661a18..c0b0a5774f31 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -55,7 +55,8 @@ static void hv_apic_icr_write(u32 low, u32 id)
>  
>  static u32 hv_apic_read(u32 reg)
>  {
> -	u32 reg_val, hi;
> +	u32 hi __maybe_unused;
> +	u32 reg_val;
>  
>  	switch (reg) {
>  	case APIC_EOI:

Why and under what config does this function trigger the warning?

Thanks,

	Ingo
