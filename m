Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBF692A47
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Feb 2023 23:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjBJWhq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Feb 2023 17:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjBJWho (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Feb 2023 17:37:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C0E75F4E;
        Fri, 10 Feb 2023 14:37:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AAA3B8260A;
        Fri, 10 Feb 2023 22:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD9DC433A1;
        Fri, 10 Feb 2023 22:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068661;
        bh=iK+tBPAiu01pEvh0+OHolfWyJobDjLhw3U9kq8y5css=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SO12eblYCh0Rj7McukUDEmZGf1CdswU1cDYT1fDDM5GW34mikGJSbf6JOkZkVzVzs
         SkKp+j1brLCBJUjeGItpHow9+OYeo6amLbFMgp2nNVrk41J9jgrZGoNafPo7BF1gWr
         t3fruPMRmOPdkx2g7xMASnbWMuvPw1ai9oClTxJmIUyQseXh/MQqhnTF897+sC+xzH
         nI5x8LQpfi6n6djyz9y8l2l2qSyQ4ZMjFnOmsSKh1/VGYqj/bovf1V/AJNZMdX05YC
         SItoUlQmx63SSOU3AchIs1HkjX0q8Pj5VIHXa4N/63rStorx76ZrUlhWZVdayom7OX
         567Ags5YNGHzw==
Received: by mail-vs1-f42.google.com with SMTP id g8so7249728vso.3;
        Fri, 10 Feb 2023 14:37:41 -0800 (PST)
X-Gm-Message-State: AO0yUKU4Jfywn6NwPOmEfEvr3TWR1R9rBbTG9tQKnwMM5oOlJ3uCrY+k
        0dTG/M9H1Skg2OSYWIEAzuHWKyPWdJY15Ia4rA==
X-Google-Smtp-Source: AK7set9O0c1yRR7QYD34Nm5OHxKCKMCrU4Kdq47PxrUDpelrvvjy1BNnBNSjRDithMgqJl8eNIu57PUOy4hVSUPWMFQ=
X-Received: by 2002:a05:6102:2fc:b0:411:a939:432 with SMTP id
 j28-20020a05610202fc00b00411a9390432mr3109150vsj.7.1676068660088; Fri, 10 Feb
 2023 14:37:40 -0800 (PST)
MIME-Version: 1.0
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
 <1675944939-22631-6-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK0WgWm-mG=fYyDVAi4uhL+fM0OD7KEF+xYYOOGNX8-oQ@mail.gmail.com> <20230209174641.GB1346@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230209174641.GB1346@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 10 Feb 2023 16:37:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+4ecEmGyo0jVs3B-E6Rjj4Lo8vB0En6pEUR1P4cRXpA@mail.gmail.com>
Message-ID: <CAL_JsqK+4ecEmGyo0jVs3B-E6Rjj4Lo8vB0En6pEUR1P4cRXpA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] Driver: VMBus: Add device tree support
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        dphadke@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Feb 9, 2023 at 11:46 AM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Thu, Feb 09, 2023 at 09:50:31AM -0600, Rob Herring wrote:
> > On Thu, Feb 9, 2023 at 6:15 AM Saurabh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > Update the driver to support device tree boot as well along with ACPI.
> >
> > Devicetree

[...]

> > > +       for_each_of_range(&parser, &range) {
> > > +               struct resource *res;
> > > +
> > > +               res = kzalloc(sizeof(*res), GFP_ATOMIC);
> > > +               if (!res)
> > > +                       return -ENOMEM;
> > > +
> > > +               res->name = "hyperv mmio";
> > > +               res->flags = IORESOURCE_MEM | IORESOURCE_MEM_64;
> > > +               res->start = range.pci_addr;
> >
> > This is not PCI. It's a union, so use 'bus_addr' instead.
> >
> > But wait, resources and IORESOURCE_MEM are *CPU* addresses. You need
> > cpu_addr here. Your DT happens to do 1:1 addresses so it happens to
> > work either way.
>
> bus_addr works for us, will send V6

Sigh. bus_addr may work, but is wrong as I explained.

And you've already sent v6... Please slow down your pace with sending
new versions. 4 versions in a week is too much. Give others time to
comment and me to respond to discussions. Like a week...

Rob
