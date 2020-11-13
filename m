Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E22B1F9F
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Nov 2020 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKMQJP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 13 Nov 2020 11:09:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34876 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMQJP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 13 Nov 2020 11:09:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id k2so10516296wrx.2;
        Fri, 13 Nov 2020 08:09:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxymz4VLWzgAdHAVQnubnBzAdJF89SBL0L0e0p6yRZ8=;
        b=Vxbhxav5seB0FT+Y9mQtYYF4Uw/qwKB4ypa1fNO0S4kh/hZA5sjHovBK4BEiIbbtYA
         HCwsubIkZAsVpqDJPS5B6BfPvBM639HpF0kX/LKsHyfGohG0eRvOB346ZoSboFWmZno7
         e0mCtM6Qeu6XWC8aBzqMaPtJyBqroo4ctLI9kbamVVKqWKRAVrtT2DqyMTpHn0kXNSqh
         CC7d+H0BodwKWiHQWrKIufDPBl96eOAH3oq1nuL0fzP33RrxloL0mbo7t53IRoJnVqaA
         vjvzPrN8yFNeI56pVU358w0nG/udaDqVsIkjcvgdvQOQ67bKp476ArlBW0A28qm4/2G5
         Vllw==
X-Gm-Message-State: AOAM532wgJJ6BpPPIX3FPFNSuhSc9zzwDNbyVpWN9tEIgVEk6u4d8ghC
        ztSXKDY+WCSAk0mQuswR4A0=
X-Google-Smtp-Source: ABdhPJze4NdkFTi+E4MauQ5LvBBNv7+FmGhBei6c+Wt8TEV7sXuket0Aqkwj0/2jPVVP4wNc7KXLFQ==
X-Received: by 2002:a05:6000:364:: with SMTP id f4mr4315571wrf.290.1605283749327;
        Fri, 13 Nov 2020 08:09:09 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a128sm10773950wmf.5.2020.11.13.08.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:09:08 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:09:07 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
Message-ID: <20201113160907.rwgpge3zo53fcgvo@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
 <874kluy3o2.fsf@vitty.brq.redhat.com>
 <20201113153333.yt54enp5dbqjj5nu@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113153333.yt54enp5dbqjj5nu@liuwe-devbox-debian-v2>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 13, 2020 at 03:33:33PM +0000, Wei Liu wrote:
> On Thu, Nov 12, 2020 at 04:51:09PM +0100, Vitaly Kuznetsov wrote:
> > Wei Liu <wei.liu@kernel.org> writes:
> > 
> > > When Linux is running as the root partition, the hypercall page will
> > > have already been setup by Hyper-V. Copy the content over to the
> > > allocated page.
> > >
> > > The suspend, resume and cleanup paths remain untouched because they are
> > > not supported in this setup yet.
> > 
> > What about adding BUG_ONs there then?
> 
> I generally avoid cluttering code if I'm sure it definitely does not
> work.
> 
> In any case, adding BUG_ONs is not the right answer. Both hv_suspend and
> hv_resume can return an error code. I would rather just do
> 
>    if (hv_root_partition)
>        return -EPERM;
> 
> in both places.

Correction: hv_resume is void, so I won't add that code snippet. But we
should still be fine because hv_suspend will have already failed in the
first place.

Wei.
