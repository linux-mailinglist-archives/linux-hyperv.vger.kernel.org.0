Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3F2B7A6E
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Nov 2020 10:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKRJb5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 18 Nov 2020 04:31:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33183 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgKRJb5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 18 Nov 2020 04:31:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id p19so3728846wmg.0;
        Wed, 18 Nov 2020 01:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rIT1mFbEat++q/fOI2Mz1b9yVpWkTzwwX++pQ7a41t8=;
        b=ExCLecBVwO+ca/4IAZDu8b6GjCMA5OE7XHAL54jof1Gp+W8/EUIw0qyCZzS/BRcSdq
         b/Bn+su6MOcfknUG6Wr+tVQ4VCtMbO7NpWBFh78+ryZovQ5eDDthFvqghZbnCrkADSA9
         XuegazkJZJpA6Uw7yUk8SeZ0KGVT2LxeE4cdYHwx2uFD5is+f3NZ89Yk2iLQzWMUvhDR
         SKAJBv5YLQElKyaE4blgqmyi6IvqiKD4g7wfUecyeZkiTKWi6ZrLz5g8ikUZczHNGwLf
         YiYlCttJ7ghC0S+D/mL6sCFLS55iQGZiGIFkewDokXx/ZIrHJWQTVK2GSjjhLEHVhniT
         Tlfw==
X-Gm-Message-State: AOAM530pEfjNDB70wSwL6fZwmkF6xvoxdVHpjxo8XrEiNbV6sKYCmrtF
        /9bHTURdfcQWvV0t3sg3nlE=
X-Google-Smtp-Source: ABdhPJx2K36WgvCbE0rT3AXDKI70J2JUbIej7Sa2W/fRnT4BajF39d19YBEBpwCnCNy0FXjSk+qGcw==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr3302058wmj.169.1605691915142;
        Wed, 18 Nov 2020 01:31:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d63sm2799773wmd.12.2020.11.18.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:31:54 -0800 (PST)
Date:   Wed, 18 Nov 2020 09:31:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH] video: hyperv_fb: Fix the cache type when mapping the
 VRAM
Message-ID: <20201118093153.irs3i342nskkbuil@liuwe-devbox-debian-v2>
References: <20201118000305.24797-1-decui@microsoft.com>
 <MW2PR2101MB105243C3AD5106B2ABEDBAB5D7E10@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB105243C3AD5106B2ABEDBAB5D7E10@MW2PR2101MB1052.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Nov 18, 2020 at 12:20:11AM +0000, Michael Kelley wrote:
> From: Dexuan Cui <decui@microsoft.com> Sent: Tuesday, November 17, 2020 4:03 PM
> > 
> > x86 Hyper-V used to essentially always overwrite the effective cache type
> > of guest memory accesses to WB. This was problematic in cases where there
> > is a physical device assigned to the VM, since that often requires that
> > the VM should have control over cache types. Thus, on newer Hyper-V since
> > 2018, Hyper-V always honors the VM's cache type, but unexpectedly Linux VM
> > users start to complain that Linux VM's VRAM becomes very slow, and it
> > turns out that Linux VM should not map the VRAM uncacheable by ioremap().
> > Fix this slowness issue by using ioremap_cache().
> > 
> > On ARM64, ioremap_cache() is also required as the host also maps the VRAM
> > cacheable, otherwise VM Connect can't display properly with ioremap() or
> > ioremap_wc().
> > 
> > With this change, the VRAM on new Hyper-V is as fast as regular RAM, so
> > it's no longer necessary to use the hacks we added to mitigate the
> > slowness, i.e. we no longer need to allocate physical memory and use
> > it to back up the VRAM in Generation-1 VM, and we also no longer need to
> > allocate physical memory to back up the framebuffer in a Generation-2 VM
> > and copy the framebuffer to the real VRAM. A further big change will
> > address these for v5.11.
> > 
> > Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Buffer Driver")
> > Tested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> 

Applied to hyperv-fixes. Thanks.
