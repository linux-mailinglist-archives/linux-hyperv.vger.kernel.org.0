Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E215F418B5C
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Sep 2021 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhIZWEt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 26 Sep 2021 18:04:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhIZWEt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 26 Sep 2021 18:04:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632693791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqxOiBdeytJus8bgCkvYKAJdNenVvStYS90LIV9ToYo=;
        b=mHbgZaHCFWguQUU2p3BhLzogeqBKGmGRJzL5LVzhKotqeX8nCOftDep14zyQ+435VDspQr
        48GpqkVqZbL45MgkbEPv/f+/7ez57UX2t09qxikdPrSCzHeYBvXMJ7g7jmDAiy03AkV9tk
        eWyAOapaqDi6OI1LDI5NVI73QhbcLjMZlcVmgmsH1dWW/2lEEpS1kijSd2SGbkMyCnanIn
        aVyPq93oWGl7mgk0Xgk/IyIy1qWKk+DW4G+klYdjtYEoQDZYhNVxco4N1qNgjvsCRX0Uyi
        LGHm6jBXpIfVYmLjzbMl9b2HHwqQhTZ3dvheeIKyrhT64t7fhT/Zrq+nPD6kQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632693791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqxOiBdeytJus8bgCkvYKAJdNenVvStYS90LIV9ToYo=;
        b=VTzuQu3ZVYeFvsvV5Qn+Ze7rFe6iRArxJQtvvVM6OsFvgBucarYK1V3EeRSmq1/XfKE5TL
        NvzIOerREB5D9jCg==
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        sthemmin@microsoft.com, Wei Liu <wei.liu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] x86/hyperv: remove on-stack cpumask from
 hv_send_ipi_mask_allbutself
In-Reply-To: <20210910185714.299411-3-wei.liu@kernel.org>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-3-wei.liu@kernel.org>
Date:   Mon, 27 Sep 2021 00:03:10 +0200
Message-ID: <87ee9batb5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Wei!

On Fri, Sep 10 2021 at 18:57, Wei Liu wrote:
> -static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
> +static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
> +		bool exclude_self)
>  {
>  	struct hv_send_ipi_ex **arg;
>  	struct hv_send_ipi_ex *ipi_arg;
> @@ -123,7 +124,10 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector)
>  
>  	if (!cpumask_equal(mask, cpu_present_mask)) {

Not part of that patch, but is checking cpu_present_mask correct here?
If so then this really lacks a comment for the casual reader.

>  		ipi_arg->vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> -		nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
> +		if (exclude_self)
> +			nr_bank = cpumask_to_vpset_noself(&(ipi_arg->vp_set), mask);
> +		else
> +			nr_bank = cpumask_to_vpset(&(ipi_arg->vp_set), mask);
>  	}

But, what happens in the case that mask == cpu_present_mask and
exclude_self == true?

AFAICT it ends up sending the IPI to all CPUs including self:

	if (!nr_bank)
		ipi_arg->vp_set.format = HV_GENERIC_SET_ALL;

Not entirely correct, right?

Thanks,

        tglx
