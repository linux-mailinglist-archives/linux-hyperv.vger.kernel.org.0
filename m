Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFC2570A39
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 20:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiGKS6s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 14:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiGKS6r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 14:58:47 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D4EF598;
        Mon, 11 Jul 2022 11:58:45 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id a5so8196470wrx.12;
        Mon, 11 Jul 2022 11:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8aRKqV7/1xC7hiRH6BGwULwW18RGfbUUhEFlYZkd8k=;
        b=oM++rokBCa3gh/LpCpxQiQI0VknR/L627AvVPCFBC6uaytjC+CEwZPJYfABsIiLHUb
         XzFZQGH9WM2x4jPF46Y/RoW3szLRscV7D/bW5vvMT6FnQJAss2y8pcWIP+YFzrKoxiMw
         Lini+fO+bh6YmtYwyR7IKehy6rj1RbOlFJUkc4Q6jPcVT5akGUcMJWHe/kmT0lev8D+H
         gnq1xwRi63FQ2zCYAgaa6GP61xggPYhKmmuDMc9pqJJf2JabjqjU+WSKUnKOhSsuNIqS
         vA3VUReDbTtFbu9rzGcZg3kIw/D5jdOeoQycFixtCh3lMT4v4kW0XUZI1k5e+bnwYggY
         gaOQ==
X-Gm-Message-State: AJIora+7ikO8x4nhdQbhWEJ3ZZBWcwHLScn0vJ4rXKgfAyQtArghDhzy
        DbxpHeHsn/oPI9hXcUNA5a0=
X-Google-Smtp-Source: AGRyM1u8JZUvh67LqNH0C3GL1Syul56zrenyoWa01uzSz9BXljEDN7L8xU3d7WUfpZ2GndAMCI11hA==
X-Received: by 2002:a5d:4407:0:b0:21d:7a1d:67ec with SMTP id z7-20020a5d4407000000b0021d7a1d67ecmr17557512wrq.465.1657565923629;
        Mon, 11 Jul 2022 11:58:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c465000b003a2d92ab521sm7256187wmo.26.2022.07.11.11.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 11:58:43 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:58:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: Take a const cpumask in
 hv_compose_msi_req_get_cpu()
Message-ID: <20220711185831.rjjy3h7qbqa72g5c@liuwe-devbox-debian-v2>
References: <20220708004931.1672-1-samuel@sholland.org>
 <PH0PR21MB3025E51C68B0F77F54299768D7829@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025E51C68B0F77F54299768D7829@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 08, 2022 at 04:27:00AM +0000, Michael Kelley (LINUX) wrote:
> From: Samuel Holland <samuel@sholland.org> Sent: Thursday, July 7, 2022 5:50 PM
> > 
> > The cpumask that is passed to this function ultimately comes from
> > irq_data_get_effective_affinity_mask(), which was recently changed to
> > return a const cpumask pointer. The first level of functions handling
> > the affinity mask were updated, but not this helper function.
> > 
> > Fixes: 4d0b8298818b ("genirq: Return a const cpumask from irq_data_get_affinity_mask")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  drivers/pci/controller/pci-hyperv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index aebada45569b..e7c6f6629e7c 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1635,7 +1635,7 @@ static u32 hv_compose_msi_req_v1(
> >   * Create MSI w/ dummy vCPU set targeting just one vCPU, overwritten
> >   * by subsequent retarget in hv_irq_unmask().
> >   */
> > -static int hv_compose_msi_req_get_cpu(struct cpumask *affinity)
> > +static int hv_compose_msi_req_get_cpu(const struct cpumask *affinity)
> >  {
> >  	return cpumask_first_and(affinity, cpu_online_mask);
> >  }
> > --
> > 2.35.1
> 
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
