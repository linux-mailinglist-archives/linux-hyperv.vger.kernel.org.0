Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E984368E637
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 03:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBHCo6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 21:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBHCo5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 21:44:57 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 049944392D;
        Tue,  7 Feb 2023 18:44:30 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 746B020C7E3C; Tue,  7 Feb 2023 18:44:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 746B020C7E3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675824270;
        bh=mQmj0TeVMvtAIj5pMSWhePBGyaMwxbET9RfvYtnSzhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QvMyd3lABvn6VuGv6hPJjknr+/J//MNGxa2n47obTYtWJwgAPxt/UDA9qKGzDO70t
         hdxUaGDfkZ4goA+1JvduGFlwABZEfRQFI5rrVObjqIXZHe6OxpiZ7IxnGVVtqPYfJa
         dNtlT0s1xiams9O7Un9repjRci39O9EKvodFK8Kc=
Date:   Tue, 7 Feb 2023 18:44:30 -0800
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
Message-ID: <20230208024430.GA838@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org>
 <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKHPg4ybcmMV2fmqG_Xo+9nR917TD8KmubfhyEwA2cwPA@mail.gmail.com>
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

On Tue, Feb 07, 2023 at 11:53:54AM -0600, Rob Herring wrote:
> On Wed, Feb 1, 2023 at 10:34 AM Saurabh Singh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > On Wed, Feb 01, 2023 at 08:51:46AM -0600, Rob Herring wrote:
> > > On Tue, Jan 31, 2023 at 06:04:49PM -0800, Saurabh Singh Sengar wrote:
> > > > On Tue, Jan 31, 2023 at 02:27:51PM -0600, Rob Herring wrote:
> > > > > On Tue, Jan 31, 2023 at 12:10 PM Saurabh Sengar
> > > > > <ssengar@linux.microsoft.com> wrote:
> > > > > >
> > > > > > This set of patches expands the VMBus driver to include device tree
> > > > > > support.
(...)
> > You are right we have define a new config flag in Kconfig, and selected CONFIG_OF
> > and CONFIG_OF_EARLY_FLATTREE. We are working on upstreaming that patch as well
> > however that will be a separate patch series.
> 
> Fair enough, but that should come first IMO. Really I just want to see
> a complete picture. That can be a reference to a git branch(es) or
> other patch series. But again, what I want to see in particular is the
> actual DT and validation run on it.

Thank you for explaining the concern. I now understand it fully. I have come to the
realization that enabling the vmbus device tree should not be impacted by any changes.
To address this, I will add the following lines to the HYPERV Kconfig definition I
used for testing:

	select OF if !ACPI
	select OF_EARLY_FLATTREE if !ACPI"

> 
> > > Also see my comment on v1 about running DT validation on your dtb. I'm
> > > sure running it would point out other issues. Such as the root level
> > > comaptible string(s) need to be documented. You need cpu nodes,
> > > interrupt controller, timers, etc. Those all have to be documented.
> >
> > I will be changing the parent node to soc node as suggested by Krzysztof
> > in other thread.
> 
> Another issue yes, but orthogonal to my comments.
> 
> >
> > soc {
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> 
> You are missing 'ranges' here. Without it, addresses aren't translatable.
> 
> You are also missing 'compatible = "simple-bus";'. This happens to
> work on x86 because of legacy reasons, but we don't want new cases
> added.

I am a bit unclear on the reason for adding the ranges property in the root node.
To provide more context, I have included my full device tree below. I believe that
having the ranges property in the VMBus device node is sufficient. Please let me
know if this can be improved.


/dts-v1/;

/ {
	#address-cells = <0>;
	#size-cells = <0>;
	model = "microsoft,test";

	cpus {
		#address-cells = <0x01>;
		#size-cells = <0x00>;

		cpu@0 {
			device_type = "cpu";
			reg = <0x00>;
			status = "okay";
		};

		cpu@1 {
			device_type = "cpu";
			reg = <0x01>;
			status = "okay";
		};
	};

        vmbus@ff0000000 {
            #address-cells = <2>;
            #size-cells = <2>;                            
            compatible = "microsoft,vmbus";             
            ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x0 0x10000000>;        
       };
};

> 
> >
> >         vmbus@ff0000000 {
> >             #address-cells = <2>;
> >             #size-cells = <1>;
> >             compatible = "Microsoft,vmbus";
> 
> 'Microsoft' is not a vendor prefix.
> 
> >             ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
> >         };
> > };
> >
> > This will be sufficient.
> 
> All these comments are unnecessary because the tools will now check
> these things and we shouldn't have to.

Agree, and its fixed in latest version.

Regards,
Saurabh
> 
> Rob
