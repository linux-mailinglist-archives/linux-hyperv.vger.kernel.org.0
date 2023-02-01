Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508B46868E2
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBAOvu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBAOvt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 09:51:49 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3A542BFA;
        Wed,  1 Feb 2023 06:51:48 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so2034863otq.13;
        Wed, 01 Feb 2023 06:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tljt9O289Ygn6RcNGURVZg0WLWtxuH5o9nRRq4d+zBg=;
        b=VCB+HC8x6mr9/xOilQHNFt8kd0PonzESWg3NLMinZ2JWNZy5QEcBPHbn0bNqeOsNOZ
         2bLWxtOXZrk2F6zXC+RZZNdpIXpcsWSdxFu4qQpt/t4PCg5MOs83T1RgPPIfYImrRzEi
         yIRu6A9W1XA7aJ9uEnnx5PYFGNdL0QvwN3DpeLynesyg0D9ApqQWTNxpnL4/gREwDSOC
         sI3rUznTRijeAjJ0mXG+xnBsSDkBm6XHQ1L/++XC6zmVUNH/aVCrPL9Nz9DzHCWPEtu/
         Ut3ZfqwQnuurkmeig9j+TYXvujo1CaFYH8n75+mA6r47oKnGD9uErhTT+uj6M/cKevER
         Ufng==
X-Gm-Message-State: AO0yUKV8stU4dHIn9A4d2dvVYjCB6EaD8h0HFAGaDp/gBG4MF/YopAky
        FKu8N3J/ssXSuAWDl/XFgg==
X-Google-Smtp-Source: AK7set+yHHJTXSgQrEBo/14mWJ9B0EPRO/kN/uQP7vYXz6zGUE9ij0ke5wXk6VULnR0zcZ6KWd+jLA==
X-Received: by 2002:a05:6830:14cc:b0:686:5047:8478 with SMTP id t12-20020a05683014cc00b0068650478478mr1529863otq.16.1675263107506;
        Wed, 01 Feb 2023 06:51:47 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t14-20020a9d590e000000b006864816ecd9sm7825565oth.59.2023.02.01.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:51:47 -0800 (PST)
Received: (nullmailer pid 3364869 invoked by uid 1000);
        Wed, 01 Feb 2023 14:51:46 -0000
Date:   Wed, 1 Feb 2023 08:51:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Message-ID: <20230201145146.GA3352796-robh@kernel.org>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > <ssengar@linux.microsoft.com> wrote:
> > >
> > > This set of patches expands the VMBus driver to include device tree
> > > support.
> > >
> > > The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> > > build.
> > >
> > > The third patch converts the VMBus driver from acpi to more generic
> > > platform driver.
> > >
> > > Further to add device tree documentation for VMBus, it needs to club with
> > > other virtualization driver's documentation. For this rename the virtio
> > > folder to more generic hypervisor, so that all the hypervisor based
> > > devices can co-exist in a single place in device tree documentation. The
> > > fourth patch does this renaming.
> > >
> > > The fifth patch introduces the device tree documentation for VMBus.
> > >
> > > The sixth patch adds device tree support to the VMBus driver. Currently
> > > this is tested only for x86 and it may not work for other archs.
> > 
> > I can read all the patches and see *what* they do. You don't really
> > need to list that here. I'm still wondering *why*. That is what the
> > cover letter and commit messages should answer. Why do you need DT
> > support? How does this even work on x86? FDT is only enabled for
> > CE4100 platform.
> 
> HI Rob,
> 
> Thanks for your comments.
> We are working on a solution where kernel is booted without ACPI tables to keep
> the overall system's memory footprints slim and possibly faster boot time.
> We have tested this by enabling CONFIG_OF for x86.

It's CONFIG_OF_EARLY_FLATTREE which you would need and that's not user 
selectable. At a minimum, you need some kconfig changes. Where are 
those?

Also see my comment on v1 about running DT validation on your dtb. I'm 
sure running it would point out other issues. Such as the root level 
comaptible string(s) need to be documented. You need cpu nodes, 
interrupt controller, timers, etc. Those all have to be documented.

Rob
