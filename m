Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F194BDE76
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Feb 2022 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376737AbiBUNxd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 21 Feb 2022 08:53:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377097AbiBUNx3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 21 Feb 2022 08:53:29 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B4DBF73;
        Mon, 21 Feb 2022 05:53:01 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso13599373wme.5;
        Mon, 21 Feb 2022 05:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVZxpUvN+zstZFcKDqV/8zmg5Gk1qj5hbIIYrPrX9Ls=;
        b=kMwnYDDdmuiMBqOOuLMuOOk7Xj4jMoxY6TOtyv9H8GQv3AKqwLHyJXeb9b7zbx4Dem
         ViIGex0cpSZ1qtitJuHECvJUWMgC9Fu/ZDm4T6XCDinxEs1S8vYv4Feb1mlOvmQZ7dc4
         +ug0+B9qiYCIOemXLCz6NECYKhviksnLW+TvM7plElyhH7u805qokUQAX17TgWs+78qO
         6kZyRZg2sIjB6D7qtA0YgNiWxHK79hfZlVrk3LBrImsrX/dKw0K5XCUcE7FX1NjVTEgC
         rQ+r4JvsMKXSRUvMR2olp9efx+qrE8+54k1Hqae8bTBrWXQupghJlXRtu8ywRS/HmfYi
         unNQ==
X-Gm-Message-State: AOAM533WuUpkp3lGCT74WM3KbRWLO5k5CYuH0oNPbU5BfpyOnw6cU7CV
        QZFPjDI47A/JibXVXXSos+s=
X-Google-Smtp-Source: ABdhPJzLOEYRW5GD8yq3kxkuqYJ3JVjEJVI3qB1VJlyRSXhVBfP0Bsz3YLK51THp24/oSndCDkeemQ==
X-Received: by 2002:a7b:c19a:0:b0:37b:c68c:7162 with SMTP id y26-20020a7bc19a000000b0037bc68c7162mr20931277wmi.7.1645451580286;
        Mon, 21 Feb 2022 05:53:00 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c9sm30128821wrn.51.2022.02.21.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 05:52:59 -0800 (PST)
Date:   Mon, 21 Feb 2022 13:52:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, kirill.shutemov@linux.intel.com,
        knsathya@kernel.org, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCHv3.1 2/32] x86/coco: Explicitly declare type of
 confidential computing platform
Message-ID: <20220221135258.4qcpt6i2zaou7ygm@liuwe-devbox-debian-v2>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <YhNyY5ErqQHZ961+@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhNyY5ErqQHZ961+@zn.tnic>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 21, 2022 at 12:07:15PM +0100, Borislav Petkov wrote:
> On Sat, Feb 19, 2022 at 03:13:04AM +0300, Kirill A. Shutemov wrote:
[...]
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index 5a99f993e639..d77cf3a31f07 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/nmi.h>
> >  #include <clocksource/hyperv_timer.h>
> >  #include <asm/numa.h>
> > +#include <asm/coco.h>
> >  
> >  /* Is Linux running as the root partition? */
> >  bool hv_root_partition;
> > @@ -344,6 +345,8 @@ static void __init ms_hyperv_init_platform(void)
> >  		 */
> >  		swiotlb_force = SWIOTLB_FORCE;
> >  #endif
> > +		if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> > +			cc_init(CC_VENDOR_HYPERV);
> 
> Isn't that supposed to test HV_ISOLATION_TYPE_SNP instead?
> 
> I mean, I have no clue what HV_ISOLATION_TYPE_VBS is. It is not used
> anywhere in the tree either.
> 
> a6c76bb08dc7 ("x86/hyperv: Load/save the Isolation Configuration leaf")
> calls it "'VBS' (software-based isolation)" - whatever that means - so
> I'm not sure that is going to need the cc-facilities.
> 

Hi Boris and Kirill, I only see VBS mentioned here so I don't have much
context, but VBS likely means virtualization-based security. There is a
public document for it.

https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-vbs

Whether it needs a new isolation type or not, I am not sure. Perhaps
Tianyu can provide more context.

Thanks,
Wei.
