Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6114D68613A
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 09:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBAIFs (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 03:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjBAIFr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 03:05:47 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 921D93C3F;
        Wed,  1 Feb 2023 00:05:46 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 5593520B7102; Wed,  1 Feb 2023 00:05:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5593520B7102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675238746;
        bh=4UJWvH169wmPf2CQEU3PxFk0o58iKhADWRB5Z84oPmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0JsI591cGjic34SUhd4G9lmFyAE5wldPAdICUe37sN9t+Rbvn5Tm7WHXI4yJZz5+
         EtZQkvsaTRp3yGvHem2gCMs4orPJuDLEzsA9UrIAp9UIzLPbbFSplbpCLuPL50YF7u
         CnLN4mb18308pS5acdH7iS9MW939sAFEqS8r9JDA=
Date:   Wed, 1 Feb 2023 00:05:46 -0800
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
Message-ID: <20230201080546.GA15047@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
 <9a3bbaf0-eb1d-613a-a8ba-272896ef2da8@linaro.org>
 <20230201015723.GB20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <6cd98ec5-3d0e-eb91-b2a5-9781439ae483@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd98ec5-3d0e-eb91-b2a5-9781439ae483@linaro.org>
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

On Wed, Feb 01, 2023 at 08:23:48AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 02:57, Saurabh Singh Sengar wrote:
> > On Tue, Jan 31, 2023 at 07:54:56PM +0100, Krzysztof Kozlowski wrote:
> >> On 31/01/2023 19:10, Saurabh Sengar wrote:
> >>>
> >>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >>
> >>> +  - |
> >>> +    / {
> >>> +        compatible = "foo";
> >>> +        model = "foo";
> >>> +        #address-cells = <0x02>;
> >>> +        #size-cells = <0x02>;
> >>
> >> Except previous comments (all of them were ignored),
> > 
> > Thank you for your comments, I have tried to address them all in this version
> > but I may have missed few. I will go and look again all the emails, but if
> > there is any thing which you can point again and we can start a new dicussion
> > from here will be very helpful.
> > 
> > I think one concern was related to use of 'reg' or 'ranges', and I 
> > thought this patch will give clarity that I intend to use 'ranges'
> > without any child node. Is this acceptable ?
> 
> There were several comments.

Ok, let me reply to all of your comments from previous thread to avoid
any confusion. Hope this is fine.

> 
> > 
> > 
> >> also:
> >> Drop entire part. Not related, not correct, not helping and you cannot
> >> have top level nodes in example.
> > 
> > If I dont use the top level node, the parent address cells are assumed to be 1,
> > and I get below warning. If there is better way to address this warning, please
> > suggest I will work on it.
> > 
> > Warning (ranges_format): /example-0/vmbus@ff0000000:ranges: "ranges" property has invalid length (20 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)
> 
> Then use soc just like every other example.

Thanks for suggestion, I will fix this in V3

Regards,
Saurabh

> 
> 
> Best regards,
> Krzysztof
