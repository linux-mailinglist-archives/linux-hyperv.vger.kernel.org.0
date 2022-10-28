Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6019610EB5
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Oct 2022 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJ1KjW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Oct 2022 06:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiJ1Kio (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Oct 2022 06:38:44 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824FF1C8410;
        Fri, 28 Oct 2022 03:38:43 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so6332426wme.5;
        Fri, 28 Oct 2022 03:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyduwU+qbCAifE/OEo9fpCfyJvonnxXGOOWJeQlafrk=;
        b=vWEweUCxiARKFSPphqDRa0RxVSWbqdZP3hPQhWnL0nfIumsvwu3gFl2UQHnGCBoQKV
         NM5jX5Koij0IBk42vVLF3HD93WMNPk/sCJDC/KNhWoIF4qFQ7AAq2GHNl54MFxkNR+IJ
         MX56z/ymnce2jbCbZfCgRKzORJXxuT4M96XuaN6mRswG8QGfLyT73TAOIv3CY72LZn9G
         pdweomurKj23eq6orSArj+WI1TYouOrphhybM05l1cA4b5/gwutSSO1Iep6nVu7M+D0s
         OeHYHW7+o7wSVoe4BoxSpvsDNn9JdeKFTGCMW7VMJ+xapNumYJtwIY/HLPJ5UEeCCPyl
         dPLg==
X-Gm-Message-State: ACrzQf3qlcvdWisTpn9QoQQGmHrRKGjJwQbhPpmlUPi2RPUKDbuE4hrG
        pGK6ezb9jyqLG0Ak3MIMQw4=
X-Google-Smtp-Source: AMsMyM6+r0/UdXjkcGQZIm+YyMf8VdMFCya9QSxoMVd6/EmHzp/NQ//5ZfB0f7jWKFMWZcO/FdaC1A==
X-Received: by 2002:a1c:a102:0:b0:3cf:4792:d3a2 with SMTP id k2-20020a1ca102000000b003cf4792d3a2mr8742630wme.55.1666953521904;
        Fri, 28 Oct 2022 03:38:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b003b4ac05a8a4sm9171691wmo.27.2022.10.28.03.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:38:41 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:38:39 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Shradha Gupta <shradhagupta@linux.microsoft.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v2 1/2] mm/page_reporting: Add checks for
 page_reporting_order param
Message-ID: <Y1uxLyaLlKp2sfkD@liuwe-devbox-debian-v2>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
 <1664517699-1085-2-git-send-email-shradhagupta@linux.microsoft.com>
 <Y1lTWxMnk3lnS+3V@liuwe-devbox-debian-v2>
 <20221027132207.bb4e9408e1ca94b3dfaca405@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027132207.bb4e9408e1ca94b3dfaca405@linux-foundation.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 27, 2022 at 01:22:07PM -0700, Andrew Morton wrote:
> On Wed, 26 Oct 2022 15:33:47 +0000 Wei Liu <wei.liu@kernel.org> wrote:
> 
> > On Thu, Sep 29, 2022 at 11:01:38PM -0700, Shradha Gupta wrote:
> > > Current code allows the page_reporting_order parameter to be changed
> > > via sysfs to any integer value.  The new value is used immediately
> > > in page reporting code with no validation, which could cause incorrect
> > > behavior.  Fix this by adding validation of the new value.
> > > Export this parameter for use in the driver that is calling the
> > > page_reporting_register().
> > > This is needed by drivers like hv_balloon to know the order of the
> > > pages reported. Traditionally the values provided in the kernel boot
> > > line or subsequently changed via sysfs take priority therefore, if
> > > page_reporting_order parameter's value is set, it takes precedence
> > > over the value passed while registering with the driver.
> > > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > 
> > Andrew and other MM reviewers, can I get an ack / nack for this patch?
> 
> Looks OK to me.  Can this be merged via the hyperv tree?

Yes, I can take of merging it.

I will add your acked-by to the patch.

Thanks,
Wei.
