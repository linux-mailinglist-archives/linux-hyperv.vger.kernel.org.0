Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD4C68C4FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Feb 2023 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBFRkZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 12:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBFRkY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 12:40:24 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60476274AE;
        Mon,  6 Feb 2023 09:40:23 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id E003620C7E02; Mon,  6 Feb 2023 09:40:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E003620C7E02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675705222;
        bh=BoelZ+0FjsOArgfePZ5sk4mt/DxwxPaj/WH7ulec040=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndq0JhU2Xpso8cn8II69fFhcl+OJnV5wb17bxvNGEK9qdJnfGbhrz3Wz3UOICN5D4
         ihphZ1l8xXJBz5X1OHos0HB/Vsh7u6aw/4G/CJyEUjCMYA8uYzQ7+o37yLWIJIjwHY
         qaozQpDjEvCtU8PAIt6szMhVcTmPaoLnQugh1P4M=
Date:   Mon, 6 Feb 2023 09:40:22 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Message-ID: <20230206174022.GA18911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org>
 <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <d60e9b7c-fdd5-2b5e-a449-d796718fb95f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d60e9b7c-fdd5-2b5e-a449-d796718fb95f@linaro.org>
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

On Wed, Feb 01, 2023 at 06:15:23PM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 17:34, Saurabh Singh Sengar wrote:
> >> Also see my comment on v1 about running DT validation on your dtb. I'm 
> >> sure running it would point out other issues. Such as the root level 
> >> comaptible string(s) need to be documented. You need cpu nodes, 
> >> interrupt controller, timers, etc. Those all have to be documented.
> > 
> > I will be changing the parent node to soc node as suggested by Krzysztof
> > in other thread.
> > 
> > soc {
> >         #address-cells = <2>;
> >         #size-cells = <2>;
> > 
> > 	vmbus@ff0000000 {
> >             #address-cells = <2>;
> >             #size-cells = <1>;
> >             compatible = "Microsoft,vmbus";
> >             ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
> >         };
> > };
> > 
> > This will be sufficient.
> 
> It will be ok for the example, but will not be ok for supporting your
> use case. Please solve all the points from Rob's comment above. Where is
> their documentation?
> 
> Best regards,
> Krzysztof

Hi Rob/ Krzysztof,

I am happy to update the documentation as requested. Please note
that, apart from CPUs, there is no other device node in the tree.

Here are some of the info related to our system:

Timers:
VMBus code uses a Hyper-V Synthetic timer and there is no device tree
node or ACPI method required for this. This is implemented as
drivers/clocksource/hyperv_timer.c

Interrupt controller:
The hypervisor virtualizes interrupt delivery to virtual processors.
This is done through the use of a synthetic interrupt controller
(SynIC) which is an extension of a virtualized local APIC. In the cpu
DT nodes we have APIC ids.

Below are the cpu nodes we use, please suggest if I need to update any
document for it.
	cpus {
		#address-cells = <1>;
		#size-cells = <0>;

		cpu@0 {
			device_type = "cpu";
			reg = <0>;
			status = "okay";
		};

		cpu@1 {
			device_type = "cpu";
			reg = <1>;
			status = "okay";
		};
	};

Regards,
Saurabh

