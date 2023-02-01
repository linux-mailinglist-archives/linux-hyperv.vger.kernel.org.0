Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEA6685CE5
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 02:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjBAB5Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 20:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBAB5Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 20:57:24 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB9DC4ABDD;
        Tue, 31 Jan 2023 17:57:23 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id A148D20E0A43; Tue, 31 Jan 2023 17:57:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A148D20E0A43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675216643;
        bh=37cqWokF/qp8iXIKUBHmR/5bc2nkXIggkT5kuzKEhHo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUs+0bSGqdzehkMC6/x2m4ARJRCHbGzam9WAfrLOK60yhQaYyjec9nPyxp+S3gqId
         g6aRl47BzC/IgIyPuyoFUv52Nq2x2R87aLAQvwsReo3r4kf2jHk44gDCmaGYTaY4ox
         Qw+pGMu9RgVkzuVqs4ze5wLdi6xvwjraNwr3SMGY=
Date:   Tue, 31 Jan 2023 17:57:23 -0800
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
Message-ID: <20230201015723.GB20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
 <9a3bbaf0-eb1d-613a-a8ba-272896ef2da8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3bbaf0-eb1d-613a-a8ba-272896ef2da8@linaro.org>
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

On Tue, Jan 31, 2023 at 07:54:56PM +0100, Krzysztof Kozlowski wrote:
> On 31/01/2023 19:10, Saurabh Sengar wrote:
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> > +  - |
> > +    / {
> > +        compatible = "foo";
> > +        model = "foo";
> > +        #address-cells = <0x02>;
> > +        #size-cells = <0x02>;
> 
> Except previous comments (all of them were ignored),

Thank you for your comments, I have tried to address them all in this version
but I may have missed few. I will go and look again all the emails, but if
there is any thing which you can point again and we can start a new dicussion
from here will be very helpful.

I think one concern was related to use of 'reg' or 'ranges', and I 
thought this patch will give clarity that I intend to use 'ranges'
without any child node. Is this acceptable ?


> also:
> Drop entire part. Not related, not correct, not helping and you cannot
> have top level nodes in example.

If I dont use the top level node, the parent address cells are assumed to be 1,
and I get below warning. If there is better way to address this warning, please
suggest I will work on it.

Warning (ranges_format): /example-0/vmbus@ff0000000:ranges: "ranges" property has invalid length (20 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)

> 
> > +
> > +        vmbus@ff0000000 {
> > +            #address-cells = <0x02>;
> > +            #size-cells = <0x01>;
> > +            compatible = "msft,vmbus";
> > +            ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 1f7a519a936f..ab74ea97535f 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -876,6 +876,8 @@ patternProperties:
> >      deprecated: true
> >    "^mscc,.*":
> >      description: Microsemi Corporation
> > +  "^msft,.*":
> > +    description: Microsoft Corporation
> 
> Don't duplicate vendor prefixes. Drop and use correct prefix.

Sure, will fix this.

Regards,
Saurabh

> 
> Best regards,
> Krzysztof
