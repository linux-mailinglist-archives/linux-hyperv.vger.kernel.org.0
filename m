Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29E566DE66
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 14:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjAQNMV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 08:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjAQNMV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 08:12:21 -0500
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4257518B14;
        Tue, 17 Jan 2023 05:12:20 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so20942685wma.1;
        Tue, 17 Jan 2023 05:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUZKyu7BaCXWonkETCdXped84B9t0FbMKyhIpYp4ti4=;
        b=GrzusxOv0GGGjGUPdYJ3zSsBYu05rNLD0yMO9VmmKxNx6gAWZE88qL8JA7VsrkT5XQ
         YMqwPIJEMHuQMEjQHuVb4mHLiSgbsMzQvrqRsGKogPsqvpikim4grur/GacBa6mVK1kx
         Na1GvEHBZLaX06yws9iJdpj0frvz5MPQZSYK66sqcyfztbbb1lpeltyyvWPZeiA7ii+z
         RdtMge0G9EE2sw+ypgy4F35molb3KQxX/FJvoYGCfG2U/3mWGT8rROhce0PYYAPtrMzG
         TBYZdUMfH3c0d+/I01VKpcv18Hil8bWli57K+ucW80cyjqXV0PcW730L1wjuwNRer+Lu
         edOg==
X-Gm-Message-State: AFqh2krLEU3FteT/ZxgxA0rFluC+YduXIl6JPXKZACYZSfayvlLdnovK
        YxiNVAFFWkibcFUWHt9a3B4=
X-Google-Smtp-Source: AMrXdXu/S8R5o0gP1HNWCUvKuhMJSNQNpIfayLACO/eZ5s2SlcyUOARmRYtgDc13+7s7mnGFcaO4Ag==
X-Received: by 2002:a05:600c:3d8b:b0:3da:2a0f:29a3 with SMTP id bi11-20020a05600c3d8b00b003da2a0f29a3mr3165131wmb.33.1673961138628;
        Tue, 17 Jan 2023 05:12:18 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm35767700wmq.9.2023.01.17.05.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 05:12:17 -0800 (PST)
Date:   Tue, 17 Jan 2023 13:12:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     Tom Rix <trix@redhat.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mikelley@microsoft.com,
        nunodasneves@linux.microsoft.com, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: conditionally build hv_get_nested_reg()
Message-ID: <Y8aesLLS3sBPwLQY@liuwe-devbox-debian-v2>
References: <20230114015643.3950640-1-trix@redhat.com>
 <401ef436-5f78-6dd7-0157-5b580c6b7f87@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401ef436-5f78-6dd7-0157-5b580c6b7f87@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 17, 2023 at 03:41:18PM +0530, Jinank Jain wrote:
> Reviewed-by: Jinank Jain <jinankjain@linux.microsoft.com>
> 

I will just fold this into the buggy patch since that has not been sent
to Linus.

Thanks Tom and Jinank.

> On 1/14/2023 7:26 AM, Tom Rix wrote:
> > cppcheck reports
> > [arch/x86/kernel/cpu/mshyperv.c:44]: (style) The function 'hv_get_nested_reg' is never used.
> > 
> > hv_get_nested_reg() is built unconditially but is only used conditionally in
> > hv_get_register() and hv_set_register() by CONFIG_HYPERV.
> > 
> > Move the conditional #if to also include hv_get_nested_reg()
> > 
> > Fixes: 89acd9b2ff8e ("Drivers: hv: Setup synic registers in case of nested root partition")
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >   arch/x86/kernel/cpu/mshyperv.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> > index b8bb13daacf7..9ca202970569 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -41,6 +41,7 @@ bool hv_root_partition;
> >   bool hv_nested;
> >   struct ms_hyperv_info ms_hyperv;
> > +#if IS_ENABLED(CONFIG_HYPERV)
> >   static inline unsigned int hv_get_nested_reg(unsigned int reg)
> >   {
> >   	switch (reg) {
> > @@ -61,7 +62,6 @@ static inline unsigned int hv_get_nested_reg(unsigned int reg)
> >   	}
> >   }
> > -#if IS_ENABLED(CONFIG_HYPERV)
> >   u64 hv_get_non_nested_register(unsigned int reg)
> >   {
> >   	u64 value;
