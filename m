Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2876E258AF5
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Sep 2020 11:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIAJGN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Sep 2020 05:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgIAJGK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Sep 2020 05:06:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F7C061244;
        Tue,  1 Sep 2020 02:06:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b3so320085qtg.13;
        Tue, 01 Sep 2020 02:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1PJjxl04vIbaOs4ebAEDi29TuKqnfLhXms4e4vAfJA=;
        b=QTp0drHkzoxPRdICP28IjclRm08/ZlHuAEtqzP1QG+vFQRN0wCHglbA4imGiRgaqQO
         vks9z3Oso2USraYzRybz8FI/N6N3pWRsUsc5mUvct+cAoZvC9nP8Q150X3oE+lVOh+uI
         cc5eAaKJppdn4BQl1wpeaony/BfyeOocoxpuZh716y4jvk1A8r/m/WkOXkLisljNgvJB
         BC+UzYfw2mq6UumWvrmF6vC9yUvrTEUAWTzGbkL+CrArI1Hh4guazMfegiUJHg1JaONv
         tjMS9UnBxWu3DcNoGgnvuzvZzihXwkA3A7lzQaDpeLmVP2VDewI206ZixijmZreELJ2C
         A1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1PJjxl04vIbaOs4ebAEDi29TuKqnfLhXms4e4vAfJA=;
        b=sncnfnFPRAU6BNuMoUyYDANCzDv4x2Gf7CBkQ/OZo5FoWFQdm502O0BGLCb8XoC2Kt
         FVEv4+iPQOSyxAlGGYbBJ99IxWR2Ih9anBaNGUc2e8xpUoxIk5G5ombgTMqsnNe3FKbf
         ZZI/956OlMFFqyvIwrlwj6xhz7Gej8A14p0du3e5FgMeBCeuRMSqmKGgfcjp+zJMEZwl
         CSeFqktKrYBH63Ll5prqWS+XSEp/DGEWYzLGuuaBT2+I149MvW4DkINEON5u10/9LX25
         59iU+kTSp/NHoh/w/U9UzvwdIqRzCdWroFfgoepSc+Yskjayqy/+/d0eW9/IgnQzt28Y
         hvTA==
X-Gm-Message-State: AOAM530ue9EIKCG6IENSoLqCR/mbSCXKtWoLNssJXMsx9rMG0GTbeYKv
        sltRsZMSjTODOof918oSznI=
X-Google-Smtp-Source: ABdhPJxt3ZrWQoEsnnEytmhabGXMOaQWqtDOIGFcf7SKiVbdrdYBFa/qMAesxlpKByq3CmY3wYvUtw==
X-Received: by 2002:aed:2c06:: with SMTP id f6mr732113qtd.362.1598951169970;
        Tue, 01 Sep 2020 02:06:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id 16sm821427qks.102.2020.09.01.02.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2020 02:06:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id A373327C0054;
        Tue,  1 Sep 2020 05:06:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 01 Sep 2020 05:06:06 -0400
X-ME-Sender: <xms:_Q5OXyPVVGbcpSw2EztgFitqADIXh0znK6ysN4qTLzqv55nU0M0zsA>
    <xme:_Q5OXw9O1ucVg3XzURv5aBq9MWR-ujm1IY0XBjjrSQuPefDtuFYRg4XAcGDZcBkMp
    tcXR3XAdGe7v1BMaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedvrdduheehrdduud
    durdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtd
    eigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehf
    ihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:_Q5OX5QOlS9hptseCXLPkG7f68kHMQUlI3i-jPDbOGRzKYLyASdR7Q>
    <xmx:_Q5OXyuZ4zrB-ZbtoRa-Rpu_UoWQUIzoHuQrRiWd91wlsnAL9BcM1g>
    <xmx:_Q5OX6edbEi7U5puDhdDP9GBqTCRDrm3ddwWE59ZoxpGMHZzP9Qovg>
    <xmx:_g5OX2_-nLoht5YCspRL8HNcVmpA0wZmAAc-P8oKxThtmQZ08oqIImQ4auc>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 897A630600A9;
        Tue,  1 Sep 2020 05:06:04 -0400 (EDT)
Date:   Tue, 1 Sep 2020 17:06:03 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200901090603.GA110903@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200826111628.794979401@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826111628.794979401@linutronix.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On Wed, Aug 26, 2020 at 01:16:28PM +0200, Thomas Gleixner wrote:
[...]
> 
> The whole lot is also available from git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git device-msi
> 
> This has been tested on Intel/AMD/KVM but lacks testing on:
> 
>     - HYPERV (-ENODEV)

FWIW, I did a build and boot test in a hyperv guest with your
development branch, the latest commit is 71cbf478eb6f ("irqchip: Add
IMS (Interrupt Message Storm) driver - NOT FOR MERGING"). And everything
seemed working fine.

If you want me to set/unset a particular CONFIG option or run some
command for testing purposes, please let me know ;-)

Regards,
Bqoun

>     - VMD enabled systems (-ENODEV)
>     - XEN (-ENOCLUE)
>     - IMS (-ENODEV)
> 
>     - Any non-X86 code which might depend on the broken compose MSI message
>       logic. Marc excpects not much fallout, but agrees that we need to fix
>       it anyway.
> 
> #1 - #3 should be applied unconditionally for obvious reasons
> #4 - #6 are wortwhile cleanups which should be done independent of device MSI
> 
> #7 - #8 look promising to cleanup the platform MSI implementation
>      	independent of #8, but I neither had cycles nor the stomach to
>      	tackle that.
> 
> #9	is obviously just for the folks interested in IMS
> 
> Thanks,
> 
> 	tglx
