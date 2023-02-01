Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB381685CB2
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 02:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBABjf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 20:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBABje (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 20:39:34 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 928AB521DE;
        Tue, 31 Jan 2023 17:39:33 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 4375620E0A43; Tue, 31 Jan 2023 17:39:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4375620E0A43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675215573;
        bh=XpQhT9NIysGEPHEUWmwIA/c/PHSo1/eWTpwuRKMmvg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FI7f/O4pB0kP0feT1rxwZ3ENwxscMoUDw009gs/ywZN8iGkk4GWwo3XJ8WdkJoTfc
         PY5EFxZWAN05OZh0kAjsjXsVkOrejuKMAAnCWUZO5SiQz9ZEyaEjgf6Lcw97/IS84h
         ao7rpsSOa59l0b/dsPtvbOHTTeBiCyEXxXM1e2gk=
Date:   Tue, 31 Jan 2023 17:39:33 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH v2 5/6] dt-bindings: hypervisor: Add dt-bindings for VMBus
Message-ID: <20230201013933.GA20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
 <63fd0037-0994-bbfd-6b99-f9dcd095cbca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fd0037-0994-bbfd-6b99-f9dcd095cbca@linaro.org>
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

On Tue, Jan 31, 2023 at 07:51:20PM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 19:10, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../bindings/hypervisor/msft,vmbus.yaml       | 50 +++++++++++++++++++
> >  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> > new file mode 100644
> > index 000000000000..8f50d6097c48
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/hypervisor/msft,vmbus.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microsoft Hyper-V VMBus device tree bindings
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 
> (other places as well...)

Hi Krzysztof,

Thank you for the review. Sorry I missed this, will fix in V3.
The patches have gone significant modification, and I have thought
I have fixed all the comments you have provided hence didnt send the
follow up discussion. Apparently, I may have missed few will look again
and fix in next version.

Regards,
Saurabh

> 
> Best regards,
> Krzysztof
