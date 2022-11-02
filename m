Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF30616E39
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Nov 2022 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKBUEA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 16:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKBUD7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 16:03:59 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA3195;
        Wed,  2 Nov 2022 13:03:58 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so2020379wms.0;
        Wed, 02 Nov 2022 13:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsGagrnXfOYz6vU7QqoUfhq8mfUslwH8snuvpr5ej/A=;
        b=6DgSY8KqBt2C81CzTIQFQ5tMUunSP2fpZu0yxk6B4U2N6hPbW6ZfzyWurRSIXqYlUU
         7Xdg1NbbDVIAT80hIdsQCbKVtsCQo1h8og4X0qPnHOK5fW+uRJsf1MSBS6UkFmli3Acg
         EY/uKly7wIVxGgC+wXtJX77MzaBlqBnjsE2LRYy6lnvpDCKeCGO3sEINLt/QVVkLbv6A
         ota5rvicIvCCSrOYVKO0z2eQE+OaHzlTG++YCaZpyUnDgdkrwCN5Rt9wnW6n41KbJwAs
         wlLoa1+SO8gQJ9VRolrdMzlURmaBXi8R8x22LScoSrN5fcQGb+B1W5p6vgJoFbv51pM3
         LI7Q==
X-Gm-Message-State: ACrzQf3uolUJtLE1cv4XIbH1Ng5aUaW9n14mzg2eO4mK/PEQMALDPrKq
        NZojm3rYs5N9MI4QMRcJFCg=
X-Google-Smtp-Source: AMsMyM7dN09I1H6DUvZVYwKeh3Wo3od2T2FW3E/x/EUJx2QP7CR/tCbJlwJA/zkv6gBvd04ujsu34A==
X-Received: by 2002:a05:600c:a05:b0:3b9:cecc:9846 with SMTP id z5-20020a05600c0a0500b003b9cecc9846mr26462234wmp.3.1667419437216;
        Wed, 02 Nov 2022 13:03:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u32-20020a05600c4d2000b003c64c186206sm2969147wmp.16.2022.11.02.13.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:03:56 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:03:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 3/4] drivers/clocksource/hyper-v: Use TSC PFN getter to
 map vvar page
Message-ID: <Y2LNJRj/NSZlYz8o@liuwe-devbox-debian-v2>
References: <166732356767.9827.4925884794177179249.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166732387510.9827.8987757583900408743.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <Y2JmbH3k2pdIaUJV@liuwe-devbox-debian-v2>
 <CA+DrgLzxmjWg0-Zvg6gf+vm2EisPYJozC64Y8aZAqkvvn-c7Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DrgLzxmjWg0-Zvg6gf+vm2EisPYJozC64Y8aZAqkvvn-c7Zw@mail.gmail.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 02, 2022 at 09:48:47AM -0700, Stanislav Kinsburskiy wrote:
> > > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > > index 311eae30e089..6976416b2c9f 100644
> > > --- a/arch/x86/entry/vdso/vma.c
> > > +++ b/arch/x86/entry/vdso/vma.c
> > > @@ -210,11 +210,10 @@ static vm_fault_t vvar_fault(const struct
> > vm_special_mapping *sm,
> > >
> >  pgprot_decrypted(vma->vm_page_prot));
> > >               }
> > >       } else if (sym_offset == image->sym_hvclock_page) {
> > > -             struct ms_hyperv_tsc_page *tsc_pg = hv_get_tsc_page();
> > > +             pfn = hv_get_tsc_pfn();
> > >
> > > -             if (tsc_pg && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
> > > -                     return vmf_insert_pfn(vma, vmf->address,
> > > -                                     virt_to_phys(tsc_pg) >>
> > PAGE_SHIFT);
> > > +             if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
> > > +                     return vmf_insert_pfn(vma, vmf->address, pfn);
> >
> > hv_get_tsc_pfn() can return 0. You will insert PFN 0 into the page
> > table. I think you should check if the PFN is valid.
> >
> >
> I'm confused. Isn't "if (pfn &&" checks for non-zero value?

I misread. The code is fine.

Wei.
