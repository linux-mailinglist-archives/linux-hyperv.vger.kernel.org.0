Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9D4AC818
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Feb 2022 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiBGSB1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Feb 2022 13:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345044AbiBGR4O (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Feb 2022 12:56:14 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB511C0401DA;
        Mon,  7 Feb 2022 09:56:13 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id m14so26209141wrg.12;
        Mon, 07 Feb 2022 09:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VANB5eLHbFe+mcOUZTXCO8085NJWiAnZpaxFhcfyGQg=;
        b=iZSIQqsGC/FlZTPHRADkgy0FyTzuCdgIIcdg1/Xp0ZDItHxrhsSgi6/6e1jt2rYNPm
         j99sgXP2hNlUMVKlfQ8Dqs63YUWAqnYU1O7voAw/rrTp91XHZzMxqB4wRPU8zXAZOVkT
         PP390YgWJPn4X+sWKCmz5N113JJo1SmdnhwHuutEZlR9ZTBTLd03HiqMnsA7RLKzQMqi
         3neypZUFhrkki4el/M55RstfVkvegPZotuRYIcEq6cBVdmMHIuAxXLw7AR2x2KGjJbh/
         lXM4C+s40FGRHjyKrqS+i573sS+krU98lbJUsKTdKKKxRBEDiULu3lrhsmWy1FwWNU7/
         OALg==
X-Gm-Message-State: AOAM533M1fC3TlMT/0njfsbil4fH0yohdMsI2QOWBWWaHLtyx4GsKf25
        4GhmWPTmZGhmXK36RGWNhW4=
X-Google-Smtp-Source: ABdhPJy+UZLmhDTpX5ObL76eagCOxR1zQgFmHIPctpKJTg9fy1tIFL5aCPMqR4ApMo/VcnIk+x/C1Q==
X-Received: by 2002:a5d:4b11:: with SMTP id v17mr452829wrq.461.1644256572330;
        Mon, 07 Feb 2022 09:56:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t17sm10633453wrs.10.2022.02.07.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 09:56:12 -0800 (PST)
Date:   Mon, 7 Feb 2022 17:56:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "vt@altlinux.org" <vt@altlinux.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Rework use of DMA_BIT_MASK(64)
Message-ID: <20220207175610.rrhgfuyvsfp7evcp@liuwe-devbox-debian-v2>
References: <1644176216-12531-1-git-send-email-mikelley@microsoft.com>
 <YgB36FwuRaF85WQq@dev-arch.archlinux-ax161>
 <MWHPR21MB1593B68BFCFC1AF8F39345ECD72C9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB1593B68BFCFC1AF8F39345ECD72C9@MWHPR21MB1593.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Feb 07, 2022 at 02:42:31AM +0000, Michael Kelley (LINUX) wrote:
> From: Nathan Chancellor <nathan@kernel.org> Sent: Sunday, February 6, 2022 5:38 PM
> > 
> > Hi Michael,
> > 
> > On Sun, Feb 06, 2022 at 11:36:56AM -0800, Michael Kelley wrote:
> > > Using DMA_BIT_MASK(64) as an initializer for a global variable
> > > causes problems with Clang 12.0.1. The compiler doesn't understand
> > > that value 64 is excluded from the shift at compile time, resulting
> > > in a build error.
> > >
> > > While this is a compiler problem, avoid the issue by setting up
> > > the dma_mask memory as part of struct hv_device, and initialize
> > > it using dma_set_mask().
> > >
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Reported-by: Vitaly Chikunov <vt@altlinux.org>
> > > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > > Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for storvsc driver")
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > 
> > Thanks a lot for working around this. I am hoping that this will be
> > fixed in clang soon, as it is high priority on our list of issues to
> > fix. Once it has been fixed, we should be able to undo this workaround
> > in one way or another.
> 
> FWIW, the new code is as good a solution as the old code.  The new code
> also follows some existing patterns, such as with struct platform_device.
> As such, I don't think of this as a workaround that needs to be undone
> in the future.
> 

Yes indeed.

Patch applied to hyperv-fixes. Thanks.
