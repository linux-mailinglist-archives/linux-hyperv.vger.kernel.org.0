Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22308772C
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2019 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406366AbfHIKZT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Aug 2019 06:25:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53931 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406037AbfHIKZT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Aug 2019 06:25:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id 10so5168827wmp.3
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Aug 2019 03:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9RMmhoSUrN0Bhtv9fCJWAnol3TBLl1D92lZ0b8FvEvQ=;
        b=QtDpC4EdRI/zicBjIAlvDcLCU0dMAdXgyZFz707slwvKABTu0hiybVLF65zFdic9GB
         nRRqIa9266NVuG0SP64u93b9FuA+IRIiinRDaicCL9Cob+6H4U6tzrXvvZawmKve5FKa
         7LNd95EhIHL/mvyA4+Ed98tZLMmsPymmsml5svGpRhIb2yhJd42VxZHOjcz95aGYC51Y
         YQMIp/U+cF9Oq442Uu2rTRZfXLDoXGg4sTQuTBUi4BzV/GG6Wb6VbRo1GnYrdaa5oKQk
         9T/E2AAN6+XCHrP61rKNFg7fwROzimZZv5GEZaBZ0lor5ENacgLOPP8iN0SRDEH0kUnU
         pWPA==
X-Gm-Message-State: APjAAAV8EqWVvi61I59dubp5mU7X17SnwOF9kIat6tSfnj09tZJmgnXe
        qEbqRCTpv7XtOozHaCtgvdyLBg==
X-Google-Smtp-Source: APXvYqyJ40a5L04Ns0aHchac7p2jnJnwM+yb5T8gVpHG3KVtOStxdWUTnYLvrdmG+zuCj+G/jj4KJg==
X-Received: by 2002:a1c:7606:: with SMTP id r6mr9682972wmc.118.1565346317107;
        Fri, 09 Aug 2019 03:25:17 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id u6sm5604014wml.9.2019.08.09.03.25.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 03:25:16 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     lantianyu1986@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, corbet@lwn.net, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com
Subject: Re: [PATCH 1/3] x86/Hyper-V: Fix definition of struct hv_vp_assist_page
In-Reply-To: <20190809094939.76093-2-Tianyu.Lan@microsoft.com>
References: <20190809094939.76093-1-Tianyu.Lan@microsoft.com> <20190809094939.76093-2-Tianyu.Lan@microsoft.com>
Date:   Fri, 09 Aug 2019 12:25:14 +0200
Message-ID: <87tvaqbppx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

lantianyu1986@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> The struct hv_vp_assist_page was defined incorrectly.
> The "vtl_control" should be u64[3], "nested_enlightenments_control"
> should be a u64 and there is 7 reserved bytes following "enlighten_vmentry".
> This patch is to fix it.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index af78cd72b8f3..a79703c56ebe 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -517,11 +517,11 @@ struct hv_timer_message_payload {
>  /* Define virtual processor assist page structure. */
>  struct hv_vp_assist_page {
>  	__u32 apic_assist;
> -	__u32 reserved;
> -	__u64 vtl_control[2];
> +	__u32 reserved1;
> +	__u64 vtl_control[3];
>  	__u64 nested_enlightenments_control[2];

In PATCH3 you define 'struct hv_nested_enlightenments_control' and it is
64bit long, not 128. We should change it here too as ...

> -	__u32 enlighten_vmentry;

enlighten_vmentry filed will get a very different offset breaking
Enlightened VMCS.

> -	__u32 padding;
> +	__u8 enlighten_vmentry;
> +	__u8 reserved2[7];
>  	__u64 current_nested_vmcs;
>  } __packed;

-- 
Vitaly
