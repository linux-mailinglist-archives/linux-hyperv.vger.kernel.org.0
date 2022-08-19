Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345AD59A076
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Aug 2022 18:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350776AbiHSQCi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Aug 2022 12:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351334AbiHSQBU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Aug 2022 12:01:20 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269ED6555F;
        Fri, 19 Aug 2022 08:53:15 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id r16so5659297wrm.6;
        Fri, 19 Aug 2022 08:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sxgN3UpSGxFCTDm8l7AkBbvt36WRpMvVU8huEaNlcOs=;
        b=krMD8u17JLUs7BC7T89T+rrc9DGrJZxxZO1IEYiBVt6sjxFOZMRmcwm7D8ubrcK7ni
         Ed0Mlaic95bguHMxOg6+RpMEkgCJ2RCm7VRevKIfYzkgCsWbOXgGzouNU1BB2cmqzlHd
         TgwB8c28BD4iumsUVeM9C7A7hUXtzqQ1+k8rlJiZgVqmyY/rgI8jCBrILdSsgKAyNKvo
         tyZ5HULWC44kXKjyVqj1Rj6WyOlYIF6AN/EexmD7mDbeC2zN1Egmw41+JymTX3uHuaEH
         0DkQUoOa14SXz6Bw0CmoEgTaRlOp0NstT3zMModZVKSPJQsCHWeflaFDE9NnT5LPgvpK
         C/7g==
X-Gm-Message-State: ACgBeo02tuVb5NKUH+J7AlbnRgx6Tjhc8kkbmwl6Wikue9MCiCXpUDif
        bjiQiodSz8mgSdt0t+QdKZ8=
X-Google-Smtp-Source: AA6agR5TsuC+RQkNW3QES9UmlM4mewKq8N5myFw6BuEs9uWD/uzR+muUu/Xrq5C9HCu4xndgmWD2Fw==
X-Received: by 2002:a5d:6da6:0:b0:225:385a:7071 with SMTP id u6-20020a5d6da6000000b00225385a7071mr2224863wrs.351.1660924365060;
        Fri, 19 Aug 2022 08:52:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b003a603f96db7sm12280373wmq.36.2022.08.19.08.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:52:44 -0700 (PDT)
Date:   Fri, 19 Aug 2022 15:52:42 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, quic_jhugo@quicinc.com,
        wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        robh@kernel.org, kw@linux.com, alex.williamson@redhat.com,
        boqun.feng@gmail.com, Boqun.Feng@microsoft.com,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: Re: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Message-ID: <20220819155242.w32vcwobt4ucvpyv@liuwe-devbox-debian-v2>
References: <20220815185505.7626-1-decui@microsoft.com>
 <20220815203545.GA1971949@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815203545.GA1971949@bhelgaas>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 15, 2022 at 03:35:45PM -0500, Bjorn Helgaas wrote:
> s/definiton/definition/ in subject
> (only if you have other occasion to repost this)
> 
> On Mon, Aug 15, 2022 at 11:55:05AM -0700, Dexuan Cui wrote:
> > The local variable 'vector' must be u32 rather than u8: see the
> > struct hv_msi_desc3.
> > 
> > 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> > hv_msi_desc2 and hv_msi_desc3.
> > 
> > Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> 
> Looks like Wei has been applying most changes to pci-hyperv.c, so I
> assume the same will happen here.

I can take care of this one via hyperv-fixes, but ...

> 
> > ---
> > 
> > The patch should be appplied after the earlier patch:
> >     [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
> >     https://lwn.net/ml/linux-kernel/20220804025104.15673-1-decui%40microsoft.com/
> > 

... this patch looks to be rejected.

Thanks,
Wei.
