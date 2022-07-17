Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD45778BD
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Jul 2022 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiGQXPG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 17 Jul 2022 19:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiGQXPF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 17 Jul 2022 19:15:05 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007AEE15;
        Sun, 17 Jul 2022 16:15:01 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so4231280wmo.0;
        Sun, 17 Jul 2022 16:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LH4n7A71z2UtMbdkqz51CcJRsS37ykAzmXuCekcdsw8=;
        b=e//POZtzkiCGbQkiS0IXf4VTzGgOtKOOHL+lbMWTUxTLR8Z0vDZ1fCSWx1iN69j0Xd
         OdH33ABjyST00bAkEkRHUKTB4ZucC/XUyrF82RoFVbHFcARhLP4QcYxlrpboX0QdLF6E
         GSx77Mvs5GY5LRUVwmcnZihPjka02rR+6F4noP9tjxrqAX4G54IHRjKQXrtj1LlReO9+
         eMo3bEja/C2J2NEllFZtotD/ppmKkeRT3XOJ8sbMvmnIy51xv/+i7HkpMHts+Bx3UrBz
         JiC1VkAZWRFr1bJandOyIJqZBixVPquJr1z+2hF6zPSi2Urr2AEPxe4NeTWJDjOsra53
         XNhw==
X-Gm-Message-State: AJIora++C48F/nwZJeLIxEfcpZH8va9nZefCIfGqu2F2HAWpF7Em6sm0
        HkuWtw6Gpjo9UEObgTWa1vs=
X-Google-Smtp-Source: AGRyM1u8fxdRrPu5eHRAitR/Y3qVMxpcFQiHk6KAe4cpvkR7OIrC7QeZwJjDkXwscQ0Zi3ew+B4WBQ==
X-Received: by 2002:a05:600c:4e54:b0:3a0:4e07:ce with SMTP id e20-20020a05600c4e5400b003a04e0700cemr24563197wmq.37.1658099700314;
        Sun, 17 Jul 2022 16:15:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d4cce000000b0021d82a6095bsm9168383wrt.95.2022.07.17.16.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 16:14:59 -0700 (PDT)
Date:   Sun, 17 Jul 2022 23:14:58 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Documentation: hyperv: Add basic info on Hyper-V
 enlightenments
Message-ID: <20220717231458.zcapml7bfccw2pjw@liuwe-devbox-debian-v2>
References: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
 <20220711185640.px4bwf4ldqqqw5ij@liuwe-devbox-debian-v2>
 <8735f44w27.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8735f44w27.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 13, 2022 at 02:06:08PM -0600, Jonathan Corbet wrote:
> Wei Liu <wei.liu@kernel.org> writes:
> 
> > On Mon, Jul 11, 2022 at 10:48:21AM -0700, Michael Kelley wrote:
> >> This documentation is a high level overview to explain the basics
> >> of Linux running as a guest on Hyper-V. The intent is to document
> >> the forest, not the trees. The Hyper-V Top Level Functional Spec
> >> provides conceptual material and API details for the core Hyper-V
> >> hypervisor, and this documentation provides additional info on
> >> how that functionality is applied to Linux. Also, there's no
> >> public documentation on VMbus or the VMbus synthetic devices, so
> >> this documentation helps fill that gap at a conceptual level. This
> >> documentation is not API-level documentation, which can be seen
> >> in the code and associated comments.
> >> 
> >> More topics will be added in future patches, including:
> >> 
> >> * Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
> >> * Virtual PCI support
> >> * Isolated/Confidential VMs
> >> * UIO driver
> >> 
> >> If you think I'm missing a topic that fits into the overall
> >> approach as described, feel free to suggest text, or let me
> >> know and I can add it to my list.
> >> 
> >> Changes in v2:
> >> * Updated clocks.rst to use section hierarchy that matches
> >>   overview.rst and vmbus.rst [Wei Liu]
> >> 
> >> Michael Kelley (3):
> >>   Documentation: hyperv: Add overview of Hyper-V enlightenments
> >>   Documentation: hyperv: Add overview of VMbus
> >>   Documentation: hyperv: Add overview of clocks and timers
> >
> > Content-wise all patches look good to me.
> >
> > Jonathan, let me know how you would like to handle this series. I'm
> > happy to carry them in hyperv-next.
> 
> I went ahead and applied them while I was in the neighborhood.

Thanks!
