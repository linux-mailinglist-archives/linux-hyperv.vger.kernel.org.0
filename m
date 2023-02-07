Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF46E68DF74
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 18:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjBGRyV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 12:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjBGRyI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 12:54:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC488699;
        Tue,  7 Feb 2023 09:54:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C73960F71;
        Tue,  7 Feb 2023 17:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A6CC4339E;
        Tue,  7 Feb 2023 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675792446;
        bh=QRBQnyyHAR4nNDWnh2/Xyc0CKoOqb7mHoQfl7kZ5vpk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lgi/S5+a1/ZukFGv53T3arvczqE+I9asjszo6+cA1299DkGCPnySgcfj9zTFFlUTf
         T2Jt7Zd9IWFxaYQvUptoNjBfr4XCGQrn1RjxaQ0HKubVTj66/up/qYDwgsBsw4sXE3
         aj4ZIUDZTZedaeuvuXTfAsVQiZmc9izSzFq3LPMI5P8GAVV9VDncsDBRw407iXjcdE
         axwkA0AEIbSF33cuR2fSOVRf4019mEArjfaK4wQmOCxOzEhL61zRU6SZCwDZvGgs73
         S1GdrGJEjnD6VMs35rufyWWVn5CsQoYvYZLfQpjq6TUwFqzC8rhjk05pUupGHLwy6k
         oTyFWfNDu0Pkw==
Received: by mail-vs1-f41.google.com with SMTP id t20so2851782vsa.12;
        Tue, 07 Feb 2023 09:54:06 -0800 (PST)
X-Gm-Message-State: AO0yUKUQ8cQAagWOY/CcwOwg7LEvzCMwcMHMtdP0RpqIyt51AuIV4Ydr
        zeXHmFW0c89LAcHiJgBB6P0VGlS/51F5Klp5Cg==
X-Google-Smtp-Source: AK7set+aGI6c3afb0NAGVijCIp/ouYbW3+D03JuQO2RqNg4GVnToaFDDhXrPsBKRZa22R6HxxHE3Q1Ywvlh75hzvsMs=
X-Received: by 2002:a67:7206:0:b0:3ea:c8c:48a5 with SMTP id
 n6-20020a677206000000b003ea0c8c48a5mr825382vsc.53.1675792445449; Tue, 07 Feb
 2023 09:54:05 -0800 (PST)
MIME-Version: 1.0
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org> <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Feb 2023 11:53:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
Message-ID: <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 1, 2023 at 10:34 AM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Wed, Feb 01, 2023 at 08:51:46AM -0600, Rob Herring wrote:
> > On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> > > On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > > <ssengar@linux.microsoft.com> wrote:
> > > > >
> > > > > This set of patches expands the VMBus driver to include device tree
> > > > > support.
> > > > >
> > > > > The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> > > > > build.
> > > > >
> > > > > The third patch converts the VMBus driver from acpi to more generic
> > > > > platform driver.
> > > > >
> > > > > Further to add device tree documentation for VMBus, it needs to club with
> > > > > other virtualization driver's documentation. For this rename the virtio
> > > > > folder to more generic hypervisor, so that all the hypervisor based
> > > > > devices can co-exist in a single place in device tree documentation. The
> > > > > fourth patch does this renaming.
> > > > >
> > > > > The fifth patch introduces the device tree documentation for VMBus.
> > > > >
> > > > > The sixth patch adds device tree support to the VMBus driver. Currently
> > > > > this is tested only for x86 and it may not work for other archs.
> > > >
> > > > I can read all the patches and see *what* they do. You don't really
> > > > need to list that here. I'm still wondering *why*. That is what the
> > > > cover letter and commit messages should answer. Why do you need DT
> > > > support? How does this even work on x86? FDT is only enabled for
> > > > CE4100 platform.
> > >
> > > HI Rob,
> > >
> > > Thanks for your comments.
> > > We are working on a solution where kernel is booted without ACPI tables to keep
> > > the overall system's memory footprints slim and possibly faster boot time.
> > > We have tested this by enabling CONFIG_OF for x86.
> >
> > It's CONFIG_OF_EARLY_FLATTREE which you would need and that's not user
> > selectable. At a minimum, you need some kconfig changes. Where are
> > those?
>
> You are right we have define a new config flag in Kconfig, and selected CONFIG_OF
> and CONFIG_OF_EARLY_FLATTREE. We are working on upstreaming that patch as well
> however that will be a separate patch series.

Fair enough, but that should come first IMO. Really I just want to see
a complete picture. That can be a reference to a git branch(es) or
other patch series. But again, what I want to see in particular is the
actual DT and validation run on it.

> > Also see my comment on v1 about running DT validation on your dtb. I'm
> > sure running it would point out other issues. Such as the root level
> > comaptible string(s) need to be documented. You need cpu nodes,
> > interrupt controller, timers, etc. Those all have to be documented.
>
> I will be changing the parent node to soc node as suggested by Krzysztof
> in other thread.

Another issue yes, but orthogonal to my comments.

>
> soc {
>         #address-cells = <2>;
>         #size-cells = <2>;

You are missing 'ranges' here. Without it, addresses aren't translatable.

You are also missing 'compatible = "simple-bus";'. This happens to
work on x86 because of legacy reasons, but we don't want new cases
added.

>
>         vmbus@ff0000000 {
>             #address-cells = <2>;
>             #size-cells = <1>;
>             compatible = "Microsoft,vmbus";

'Microsoft' is not a vendor prefix.

>             ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
>         };
> };
>
> This will be sufficient.

All these comments are unnecessary because the tools will now check
these things and we shouldn't have to.

Rob
