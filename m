Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC3686BD2
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBAQfA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 11:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBAQe7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 11:34:59 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083DC4690;
        Wed,  1 Feb 2023 08:34:56 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id B311620B74F8; Wed,  1 Feb 2023 08:34:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B311620B74F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675269295;
        bh=4c21+WsHMdgERH83tze28bmrMD1U1gRJ4pTq1J2qqYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G7vmgFyTp14UCrjNXXNDIWrZLHdUoudSBR2CW2qUMLqCttEtMlcuwNxLv35bRu/sg
         GN5RS2CUBykO8xIOmm6saDqq+iv1QFNZQPmgMTu6yxSIlqk1JbEw+oc06A/+nNDhom
         y4ARkooDVwCNDgKQkYpKn1UGaC45j1uyvPibiSuc=
Date:   Wed, 1 Feb 2023 08:34:55 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Message-ID: <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201145146.GA3352796-robh@kernel.org>
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

On Wed, Feb 01, 2023 at 08:51:46AM -0600, Rob Herring wrote:
> On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> > On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > <ssengar@linux.microsoft.com> wrote:
> > > >
> > > > This set of patches expands the VMBus driver to include device tree
> > > > support.
> > > >
> > > > The first two patches enable compilation of Hyper-V APIs in a non-ACPI
> > > > build.
> > > >
> > > > The third patch converts the VMBus driver from acpi to more generic
> > > > platform driver.
> > > >
> > > > Further to add device tree documentation for VMBus, it needs to club with
> > > > other virtualization driver's documentation. For this rename the virtio
> > > > folder to more generic hypervisor, so that all the hypervisor based
> > > > devices can co-exist in a single place in device tree documentation. The
> > > > fourth patch does this renaming.
> > > >
> > > > The fifth patch introduces the device tree documentation for VMBus.
> > > >
> > > > The sixth patch adds device tree support to the VMBus driver. Currently
> > > > this is tested only for x86 and it may not work for other archs.
> > > 
> > > I can read all the patches and see *what* they do. You don't really
> > > need to list that here. I'm still wondering *why*. That is what the
> > > cover letter and commit messages should answer. Why do you need DT
> > > support? How does this even work on x86? FDT is only enabled for
> > > CE4100 platform.
> > 
> > HI Rob,
> > 
> > Thanks for your comments.
> > We are working on a solution where kernel is booted without ACPI tables to keep
> > the overall system's memory footprints slim and possibly faster boot time.
> > We have tested this by enabling CONFIG_OF for x86.
> 
> It's CONFIG_OF_EARLY_FLATTREE which you would need and that's not user 
> selectable. At a minimum, you need some kconfig changes. Where are 
> those?

You are right we have define a new config flag in Kconfig, and selected CONFIG_OF
and CONFIG_OF_EARLY_FLATTREE. We are working on upstreaming that patch as well
however that will be a separate patch series.

> 
> Also see my comment on v1 about running DT validation on your dtb. I'm 
> sure running it would point out other issues. Such as the root level 
> comaptible string(s) need to be documented. You need cpu nodes, 
> interrupt controller, timers, etc. Those all have to be documented.

I will be changing the parent node to soc node as suggested by Krzysztof
in other thread.

soc {
        #address-cells = <2>;
        #size-cells = <2>;

	vmbus@ff0000000 {
            #address-cells = <2>;
            #size-cells = <1>;
            compatible = "Microsoft,vmbus";
            ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
        };
};

This will be sufficient.

Regards,
Saurabh

> 
> Rob
