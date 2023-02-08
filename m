Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEC68E648
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 03:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBHCuj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 21:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBHCuj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 21:50:39 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 407AE10A91;
        Tue,  7 Feb 2023 18:50:37 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id C27A020C7E3E; Tue,  7 Feb 2023 18:50:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C27A020C7E3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675824636;
        bh=zH8jTNGZgnkW9RivS+15tp6q+pdN9GIpfKHsobyIFXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iv4linVSsVgkBZBZO5nDS4kC8c8zfRuhkC0eIaOSSGeCNsiTaAtywxuap0DqitiOz
         VbbEAtd5TySmdvZyQ/FWuJDtXrUSHZQj6ncS3nmrVUj4eiPiaZiGSIauD4bOSLZ7rV
         eFIzGx0K1dQzjDcnMQiWRJ9pU+kMttkJlPEkXVJk=
Date:   Tue, 7 Feb 2023 18:50:36 -0800
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Rob Herring <robh@kernel.org>
Cc:     mikelley@microsoft.com, wei.liu@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        ssengar@microsoft.com, virtualization@lists.linux-foundation.org,
        decui@microsoft.com, haiyangz@microsoft.com,
        linux-hyperv@vger.kernel.org, dphadke@linux.microsoft.com,
        kys@microsoft.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 5/6] dt-bindings: hypervisor: VMBus
Message-ID: <20230208025036.GB838@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
 <167577470818.3213850.12635304061765127789.robh@kernel.org>
 <20230207183458.GA3753062-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207183458.GA3753062-robh@kernel.org>
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

On Tue, Feb 07, 2023 at 12:34:58PM -0600, Rob Herring wrote:
> On Tue, Feb 07, 2023 at 07:00:23AM -0600, Rob Herring wrote:
> > 
> > On Mon, 06 Feb 2023 23:49:58 -0800, Saurabh Sengar wrote:
> > > Add dt-bindings for Hyper-V VMBus.
> > > 
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > >  .../bindings/hypervisor/microsoft,vmbus.yaml       | 48 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 49 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
> > > 
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > make[1]: *** Deleting file 'Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.example.dtb'
> > make[1]: *** Waiting for unfinished jobs....
> > make: *** [Makefile:1508: dt_binding_check] Error 2
> 
> You can ignore this, it's a problem with the CI job.
> 
> > 
> > doc reference errors (make refcheckdocs):
> > Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/virtio/
> > MAINTAINERS: Documentation/devicetree/bindings/virtio/
> 
> But this probably needs to be fixed.

I have updated MAINTAINERS as part of 4/6 patch, and there is no mention of
Documentation/devicetree/bindings/virtio/ in MAINTAINERS post 4/6 patch.
I have ran the tool locally as well on top of 4/6 and then 5/6 but it
never reported this error.

Anyway as per your latest comment I should be moving VMBus to bus folder
instead, so no need to worry about this.

Regards,
Saurabh

> 
> Rob
