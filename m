Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4B26864C3
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 11:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjBAKxQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 05:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBAKxP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 05:53:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55FD644BDD;
        Wed,  1 Feb 2023 02:53:14 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 1042920B74F7; Wed,  1 Feb 2023 02:53:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1042920B74F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675248794;
        bh=u6xY+MjMRo8fO7fdvwYCp6a/E0wL/T2x+iwrgYUQBA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/T21LLk285Lc3xQ3YEJ2yYzCwz37PZFw0s0JZPHeJAGbtfX0bdEszVUIq6veJe4J
         5fRyxzl2aJ8mRayr1QgasGIyKYfLky7w430pj20/L0KTH/0QsrM/s86sIoTRFKMJhC
         kFu3wjomkuvMuwrY0erQDWOw2sG5togbWMFdclhc=
Date:   Wed, 1 Feb 2023 02:53:14 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Message-ID: <20230201105314.GA5733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
 <f74fe561-dc20-0681-12af-4a4782a060be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74fe561-dc20-0681-12af-4a4782a060be@linaro.org>
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

On Mon, Jan 16, 2023 at 07:53:07PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2023 17:48, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus
> 
> Missing full stop.
> 
> Subject: drop second/last, redundant "dt-bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.

Will fix in v3.

> 
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hv/msft,vmbus.yaml b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> > new file mode 100644
> > index 0000000..66cb426
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/hv/msft,vmbus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microsoft Hyper-V VMBus device tree bindings
> 
> Drop "device tree bindings"

Will fix in v3

> 
> > +
> > +maintainers:
> > +  - Saurabh Sengar <ssengar@linux.microsoft.com>
> > +
> > +description:
> > +  VMBus is a software bus that implement the protocols for communication
> > +  between the root or host OS and guest OSs (virtual machines).
> 
> Why this cannot be auto-discoverable? Why do you need OF for this?

This is a virtulization device, and I guess we have discussed this in greater
length in other thread.

> 
> > +
> > +properties:
> > +  compatible:
> > +    const: msft,vmbus
> > +
> > +  ranges :
> > +    const: <0x00 0x00 0x0f 0xf0000000 0x10000000>
> 
> Did you test the bindings?
> 
> This property does not look correct. If you have static addresses, you
> do not need OF. What do you want to discover here?

fixed in v2

> 
> > +
> > +required:
> > +  - compatible
> > +  - ranges
> > +
> > +examples:
> > +  - |
> > +        vmbus {
> 
> Use 4 spaces for example indentation.

Fix in v2

> 
> > +		#address-cells = <0x02>;
> > +		#size-cells = <0x01>;
> 
> That's not correct style. Drop hex notation. Drop leading zeros.

Will fix in v3

> 
> But anyway you did not test the bindings. This cannot work. Try.
> 
> > +		compatible = "msft,vmbus";
> 
> compatible is a first property.

fixed in v2

> 
> > +		ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
> 
> What do you translate? There is no reg, no unit address.

Commented on v2 thread, if there is any further concern using ranges
please let me know.

> 
> > +	};
> 
> Best regards,
> Krzysztof
