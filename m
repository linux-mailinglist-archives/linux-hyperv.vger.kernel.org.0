Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACD68E60E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 03:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBHCaz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 21:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBHCay (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 21:30:54 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 990E725E33;
        Tue,  7 Feb 2023 18:30:53 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 0429420C7E3C; Tue,  7 Feb 2023 18:30:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0429420C7E3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675823453;
        bh=FTw6lbYJqScdQtkwSa5qMiwA99Ksn8O5FYC3z9/HlBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9I7YUxBxXbpcmAN709MdMZ83oYMxkJIk1il7cLnpaUFmZ65MiYNaBdw/KLGFr/Ob
         NBiMbgHwQ3Ev11xQq3TwsfmtnNABIUYXoHNCADRs7dRQXQytlVxdRMqLifytSzrrLX
         3h5rJrb35hrV8mRUjiy65dlx5BPw+AcWRp81M+oA=
Date:   Tue, 7 Feb 2023 18:30:52 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 6/6] Driver: VMBus: Add device tree support
Message-ID: <20230208023052.GA29547@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-7-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqK_7eTTrSd6EKDGy9A8kC5w6cjVEtSi3CB1M7Awj+zg6g@mail.gmail.com>
 <20230201165133.GA24116@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201174638.GA3872117-robh@kernel.org>
 <20230203173616.GA8582@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKWWg=nL5C1Hz7GQ6YCbc0ssUP71Be6kcn57v5240GQew@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 07, 2023 at 11:38:55AM -0600, Rob Herring wrote:
> On Fri, Feb 3, 2023 at 11:36 AM Saurabh Singh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > On Wed, Feb 01, 2023 at 11:46:38AM -0600, Rob Herring wrote:
> > > On Wed, Feb 01, 2023 at 08:51:33AM -0800, Saurabh Singh Sengar wrote:
> > > > On Tue, Jan 31, 2023 at 02:12:53PM -0600, Rob Herring wrote:
> > > > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > > > <ssengar@linux.microsoft.com> wrote:
> > > > I wanted to have separate function for ACPI and device tree flow, which
(...)
> > > > can be easily maintained with #ifdef. Please let me know if its fine.
> > >
> > > Yes, you can have separate functions:
> > >
> > > static int vmbus_acpi_add(struct platform_device *pdev)
> > > {
> > >       if (!IS_ENABLED(CONFIG_ACPI))
> > >               return -ENODEV;
> > >
> > >       ...
> > > }
> > >
> > > The compiler will throw away the function in the end if CONFIG_ACPI is
> > > not enabled.
> > >
> > > That is easier for us to maintain because it reduces the combinations to
> > > build.
> > >
> >
> > I tried removing #ifdef CONFIG_ACPI and use C's if(!IS_ENABLED(CONFIG_ACPI)) but looks
> > compiler is not optimizing out the rest of function, it still throwing errors
> > for acpi functions. This doesn't look 1:1 replacement to me.
> > Please let me know if I have missunderstood any of your suggestion.
> >
> > drivers/hv/vmbus_drv.c:2175:8: error: implicit declaration of function ‘acpi_dev_resource_interrupt’ [-Werror=implicit-function-
> 
> That's a failure of the ACPI headers not having empty function
> declarations. The DT functions do...
> 
> Also, this is just a broken assumption:
> 
> #ifdef CONFIG_ACPI
> 
> #else
> // Assume DT
> #endif
> 
> Both ACPI and DT can be enabled at the same time. They may be mutually
> exclusive for a platform, but not the kernel. For distro kernels, both
> will be enabled typically if the arch supports both. On arm64, DT is
> never disabled because the boot interface is always DT.
> 
> Furthermore, this makes compile testing your code difficult. The arm64
> defconfig, allmodconfig and allyesconfig all will not build the DT
> code. The same for x86. This means all the CI builds that happen can't
> build test this.

Thanks for letting me know the challanges with testing. My intention was to give
ACPI higher priority, in case ACPI is enabled system should go ACPI flow, OF flow
should be used only when ACPI is disabled.

I can replace #else part with #ifdef CONFIG_OF if that helps.

Regards,
Saurabh

> 
> Rob
