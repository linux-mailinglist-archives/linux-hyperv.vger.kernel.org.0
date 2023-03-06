Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DBA6AB740
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Mar 2023 08:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCFHtf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Mar 2023 02:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCFHte (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Mar 2023 02:49:34 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EECAA26F;
        Sun,  5 Mar 2023 23:49:31 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 63D5F2057489; Sun,  5 Mar 2023 23:49:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63D5F2057489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678088970;
        bh=frdMW5la5Ht2zoOrd7r3lWod8cuLZF1K+Pwls405WJI=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ebiMdNY5z2faP71lhX0o1Vy7C3fI6ALk6ZRaKdk6Pry0e4/A6nvjrhzL8Y+LaYn9w
         Nfu7wfYR0DzjbgitiUDbne1dSJAweVwAk2Y/oAazCTQMzLkgyjuzyCMOwEAKyn4S+/
         vQpXxCkAAdfoEYc/UYzl1ZNmQrnXc3JZtI6xSPw0=
Date:   Sun, 5 Mar 2023 23:49:30 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v7 4/5] dt-bindings: bus: VMBus
Message-ID: <20230306074930.GA22542@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
 <1677151745-16521-5-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677151745-16521-5-git-send-email-ssengar@linux.microsoft.com>
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

On Thu, Feb 23, 2023 at 03:29:04AM -0800, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V7]
> - update ranges; property in simplie-bus for correct 1:1 translation.
> 
>  .../bindings/bus/microsoft,vmbus.yaml         | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> new file mode 100644
> index 000000000000..a8d40c766dcd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/microsoft,vmbus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft Hyper-V VMBus
> +
> +maintainers:
> +  - Saurabh Sengar <ssengar@linux.microsoft.com>
> +
> +description:
> +  VMBus is a software bus that implement the protocols for communication
> +  between the root or host OS and guest OSs (virtual machines).
> +
> +properties:
> +  compatible:
> +    const: microsoft,vmbus
> +
> +  ranges: true
> +
> +  '#address-cells':
> +    const: 2
> +
> +  '#size-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        bus {
> +            compatible = "simple-bus";
> +            #address-cells = <2>;
> +            #size-cells = <1>;
> +            ranges;
> +
> +            vmbus@ff0000000 {
> +                compatible = "microsoft,vmbus";
> +                #address-cells = <2>;
> +                #size-cells = <1>;
> +                ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f32aca51242f..aae3c1fb55fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9510,6 +9510,7 @@ S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
>  F:	Documentation/ABI/stable/sysfs-bus-vmbus
>  F:	Documentation/ABI/testing/debugfs-hyperv
> +F:	Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>  F:	Documentation/virt/hyperv
>  F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
>  F:	arch/arm64/hyperv
> -- 
> 2.34.1

Hi Rob,

Did you get chance to review this. Please let me know if you need any additional
information or if its good to be merged.

Regards,
Saurabh


