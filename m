Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669744CAD6D
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiCBSYH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 13:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCBSYF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 13:24:05 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D3E286F9;
        Wed,  2 Mar 2022 10:23:20 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id a5-20020a05600c224500b003832be89f25so1812155wmm.2;
        Wed, 02 Mar 2022 10:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEIn6h+Irt2Serj+ca61KZsU1HkIiucTzhp6nNONDRA=;
        b=pzjIsEoEXwogSwkuVDQTIvLjMo4h8cy/6IBk9qFGUsGx6SRUcYvdsr0Sou82t2xfJG
         pBkwMgXH3qlek8FbNJbOF8jE8u94O2rJEBbLbEohanighdPYvhjoIkEoFwBijR2s2O5j
         dBWOgdq/wbe0wuT7U5O+m4N06TK/fPrC6fxAafQp3K6ug+phPJkjqLh7DqawX3H0C2GA
         FrDTAQvIz09QDGM0BDUmxz3KGfoGbhOFAAeBV6i0VrkNQ5We81F7mX8ThUh8yESFjR/0
         T/Idxkir8LBsLuGWM11xTizHlWIN2QXyI+4m6aXxAL35sbxfHiE3mxrSIsSwHLodUiAP
         qZDQ==
X-Gm-Message-State: AOAM530WOfkFc74vu4lWk1TNHe56RUDTSIkarGqwVKCSnGjA5bD2P8nB
        tgwA1/x9RsBD+LpHCBojyFE=
X-Google-Smtp-Source: ABdhPJyvw/f9Yt4q/MlG3j/oulM4h5JtJF9j1rkmFIxsiq2ReGLrMvnXPcrVnk8yH/R1dHWDbXGBzw==
X-Received: by 2002:a05:600c:1e1f:b0:381:7817:f5f6 with SMTP id ay31-20020a05600c1e1f00b003817817f5f6mr913504wmb.96.1646245399088;
        Wed, 02 Mar 2022 10:23:19 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b001edc107e4f7sm25381686wrq.81.2022.03.02.10.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:23:18 -0800 (PST)
Date:   Wed, 2 Mar 2022 18:23:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 26/30] drivers: hv: dxgkrnl: Offer and reclaim
 allocations
Message-ID: <20220302182316.lcagv5ghum4525rm@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <3a6779567438b02566012679f01ebb065e3761db.1646163379.git.iourit@linux.microsoft.com>
 <20220302142517.kgc5o7ufj2yf4cif@liuwe-devbox-debian-v2>
 <fe018236-35b5-3bc1-6984-fca9537e47c7@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe018236-35b5-3bc1-6984-fca9537e47c7@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Mar 02, 2022 at 10:13:34AM -0800, Iouri Tarassov wrote:
> 
> On 3/2/2022 6:25 AM, Wei Liu wrote:
> > On Tue, Mar 01, 2022 at 11:46:13AM -0800, Iouri Tarassov wrote:
> > > Implement ioctls to offer and reclaim compute device allocations:
> > >   - LX_DXOFFERALLOCATIONS,
> > >   - LX_DXRECLAIMALLOCATIONS2
> > > 
> > > When a user mode driver (UMD) does not need to access an allocation,
> >
> > What is a "user mode driver" in this context? Is that something that
> > runs inside the guest?
> 
> Hi Wei,
> 
> The user mode driver runs inside the guest. This driver is written by
> hardware vendors.
> For example, the NVIDIA's Cuda runtime is considered a user mode driver.
> The driver
> provides a specific API to applications (like the Cuda API).
> 
> The cover letter explains the design of the virtual compute device
> paravirtualization
> model and describes all components, which are involved. I feel that I do
> not need to
> include explanation to every patch.

It's fine. I was just asking a question -- I didn't have all the terms
in my head by the time I got to this patch. There is no need to add the 
explanation to every patch.

Thanks,
Wei.

> 
> Thanks
> Iouri
> 
