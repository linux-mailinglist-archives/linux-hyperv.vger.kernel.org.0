Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523906E692F
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Apr 2023 18:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjDRQRm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Apr 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjDRQRh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Apr 2023 12:17:37 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8E5BB;
        Tue, 18 Apr 2023 09:17:31 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1206617wmo.0;
        Tue, 18 Apr 2023 09:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834650; x=1684426650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u48ltrmLgSm3bX6CavVnW/eH0ziuSM7JReekh8fg9iU=;
        b=JeqArQr5Bj0w7zqGqzc/QzAANa3FfIhGQPUw152gmcr8XWOWCsYDLneAnts6vygC+M
         nI37WPtic3RWdsm0c8h2PBLR9Tb2KF5mp4xqAgWG6IfflldPI6vdoAZut9/ZUZkHD09E
         6hKkwRxmCZd8o/d+vRErPG/hB1pUAhuqAlVAdRqJAP5h4MwBR0qdH99Xs69yIZaL5DvD
         LWjlEW7sgULpYTohTJce2c2o/lydQg99pGG6RZzo9pJ1WW9JX+iR6q+usIk/SsK5SPfN
         7pSQDaEl+sMqm9RsuPAb5LXjnnj3CGTCM+ioGRr2TD8Pq2fIAMssiYEnGR6XQKMLwlMR
         MYiw==
X-Gm-Message-State: AAQBX9fEfJ1mI74/EwnrbPItbbsuXsuR1enFTptLjPgT0ejCGYWwV9VT
        kr648P4RgeZClDLuAjJirvYe33nR5oLS7w==
X-Google-Smtp-Source: AKy350bF2tBaDvlhbbvSha05MV0fLLdpnMXeeKQkBRNyMBdgVVgSsr9Tj1nMPHK1KtQAuctPyXzJ9A==
X-Received: by 2002:a05:600c:20c:b0:3f1:75d2:a689 with SMTP id 12-20020a05600c020c00b003f175d2a689mr4382739wmi.33.1681834650184;
        Tue, 18 Apr 2023 09:17:30 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m7-20020a7bcb87000000b003f17131952fsm8223618wmi.29.2023.04.18.09.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:17:29 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:17:26 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Saurabh Sengar <ssengar@linux.microsoft.com>, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix for applied series [PATCH v5 0/5] Hyper-V VTL
 support
Message-ID: <ZD7CllwJv7aAB4vO@liuwe-devbox-debian-v2>
References: <1681794761-13734-1-git-send-email-ssengar@linux.microsoft.com>
 <20230418093321.GAZD5j4SZ7QWmUyAXW@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418093321.GAZD5j4SZ7QWmUyAXW@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 18, 2023 at 11:33:21AM +0200, Borislav Petkov wrote:
> On Mon, Apr 17, 2023 at 10:12:39PM -0700, Saurabh Sengar wrote:
> > [PATCH v5 0/5] Hyper-V VTL support is already applied, however
> > there are couple of kernel test bot warning reported. This patch
> > series on top of [PATCH v5 0/5] Hyper-V VTL support fixes these.
> > I expect them to be squash commit on respective patches.
> 
> That was supposed to happen when applying those using -rc7 as a base.
> 
> Wei, what's up?

I did use -rc7 as the base. This is what is in hyperv-next right now.

https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/commit/?h=hyperv-next&id=25dcc7316ef7def25cdab3658ac665bf0ce0ddc5

I think Saurabh was responding to a report that was generated on his v5
series. I don't think the first patch is needed.

The second one is probably still needed.

Thanks,
Wei.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
