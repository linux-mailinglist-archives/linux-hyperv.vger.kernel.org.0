Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A0866E1C8
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 16:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjAQPN0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 10:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjAQPNZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 10:13:25 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6487210F6;
        Tue, 17 Jan 2023 07:13:25 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id 273EF20DFE9B; Tue, 17 Jan 2023 07:13:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 273EF20DFE9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673968405;
        bh=a5VxxJ25k3Kmc+IF5ZD9EYc+tGwjxPrSRISjxWhsSW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaW/LbIivClq6f0A62/L45QAPDHokJwAbO0att20IBd0i+sPFmtytHQWq5GgITHVg
         eH8QaZul6LSHvKAZj3o+c6sHOefJMU5yNpHyuDt4psp3U0W2Ngkgos3XiC3HKvsxPh
         P/uWUh2UDIina1Ks+Hci96qTdDcJ9sCJCMBPWNkw=
Date:   Tue, 17 Jan 2023 07:13:25 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Message-ID: <20230117151325.GA9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
 <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
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

On Mon, Jan 16, 2023 at 07:55:13PM +0100, Krzysztof Kozlowski wrote:
> On 16/01/2023 17:48, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
> 
> Also, there is no "hv" hardware, so that's not correct location. If your
> bindings describe firmware, this should go to firmware. Otherwise, this
> does not look like suitable for DT. We do not describe software stuff in DT.

VMBus is a virtual device this is simmilar to virtio. I can rename this folder to vmbus.

> 
> Best regards,
> Krzysztof
