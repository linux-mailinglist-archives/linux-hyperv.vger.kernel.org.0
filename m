Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1396166E2D5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 16:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjAQPx0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 10:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjAQPxB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 10:53:01 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEAFC55AD;
        Tue, 17 Jan 2023 07:52:58 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 905DE20DFE9A; Tue, 17 Jan 2023 07:52:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 905DE20DFE9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673970778;
        bh=3NZCtRK3OOYyaszjw8eLOn5YIJHXVKjO2S3F0Zwdygs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KamhbA+yDFn/R9/614rnJfl4WspLcMyiqsYgzG9TvUhpCpJxZbo+eKhZCNJhac0+I
         brZSAoa4X10J52aYfQgstAFcASysnn0BGYm1B+WpAV87micQ8QEt2JX3DS7QSgHUJN
         TnTjrOvfO3KRyJdyuNbINCwzTSSlTfAJW980AFUA=
Date:   Tue, 17 Jan 2023 07:52:58 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Message-ID: <20230117155258.GA14857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
 <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
 <20230117151325.GA9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <23a7ae1d-cd49-8c78-5284-4134755ea19a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a7ae1d-cd49-8c78-5284-4134755ea19a@linaro.org>
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

On Tue, Jan 17, 2023 at 04:41:22PM +0100, Krzysztof Kozlowski wrote:
> On 17/01/2023 16:13, Saurabh Singh Sengar wrote:
> > On Mon, Jan 16, 2023 at 07:55:13PM +0100, Krzysztof Kozlowski wrote:
> >> On 16/01/2023 17:48, Saurabh Sengar wrote:
> >>> Add dt-bindings for Hyper-V VMBus
> >>>
> >>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >>> ---
> >>>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
> >>
> >> Also, there is no "hv" hardware, so that's not correct location. If your
> >> bindings describe firmware, this should go to firmware. Otherwise, this
> >> does not look like suitable for DT. We do not describe software stuff in DT.
> > 
> > VMBus is a virtual device this is simmilar to virtio. I can rename this folder to vmbus.
> >
> 
> Then virtio directory. The directories are per subsystems (hardware
> classes).

Apologies if I was not clear, I meant to say this is a device conceptually
similar to virtio. But this driver has nothing to do with virtio, we should
be creating a new folder for it OR I am fine moving it under bus if that's
okay.

> 
> Best regards,
> Krzysztof
