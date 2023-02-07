Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B216668E021
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 19:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjBGSfI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 13:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjBGSfB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 13:35:01 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5217C114;
        Tue,  7 Feb 2023 10:35:00 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id y17-20020a4ade11000000b0051762fdf955so1510843oot.3;
        Tue, 07 Feb 2023 10:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmUJZFRlbRzZC0YLBDimsvsgtraFo5ZlVa8PFNVIqis=;
        b=Q3X+dKTS5Cf2OaznSvQF5Jc9cqXWAz85TFfLqIysgaTt5CN4lyqwlObRezPxhElLpi
         fs55GJctu7WvVxzkc0YTKFOlV0LkVsncWoGdsv0FmxQ5w2s/Cymw5UXybJ2LIUEGuNaI
         Q7+I4N2Xcsos2LsSomavbX9THKN3VpSctY8v1zn9rbyF5PesXsdKze5GVS7B/FPjddOL
         SSDnuNOzvAmvxdakoSK38XJRuWILkxk5ES7VFc/M727qapi5EnU+xtgdPhNPMto7p3qP
         kWkZgFQmIIKF2SlF2+EvoDCFPnsu4kQiEfe4am/T+mJgugxHpxosXwmw0tFjiCKGZraD
         i2rw==
X-Gm-Message-State: AO0yUKVZ6R55n4rl8XwLMFL/ZeJppcaCnJPlpW/wthdlUY7syo0Wk6df
        1z+wt7Hve05SvuUMU2DBLA==
X-Google-Smtp-Source: AK7set8WYI0yMhZcAyVDo98cgFXsIl818m7fxZKDYCkOjHC0+0s2Z/ySRz0St+Ru1mLcVsJ+Zcp8yg==
X-Received: by 2002:a05:6820:502:b0:4ff:4687:dc6c with SMTP id m2-20020a056820050200b004ff4687dc6cmr2789900ooj.0.1675794899461;
        Tue, 07 Feb 2023 10:34:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d18-20020a4aa592000000b005176974faf3sm6330919oom.35.2023.02.07.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:34:59 -0800 (PST)
Received: (nullmailer pid 3944512 invoked by uid 1000);
        Tue, 07 Feb 2023 18:34:58 -0000
Date:   Tue, 7 Feb 2023 12:34:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     mikelley@microsoft.com, wei.liu@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        ssengar@microsoft.com, virtualization@lists.linux-foundation.org,
        decui@microsoft.com, haiyangz@microsoft.com,
        linux-hyperv@vger.kernel.org, dphadke@linux.microsoft.com,
        kys@microsoft.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 5/6] dt-bindings: hypervisor: VMBus
Message-ID: <20230207183458.GA3753062-robh@kernel.org>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
 <167577470818.3213850.12635304061765127789.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167577470818.3213850.12635304061765127789.robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Feb 07, 2023 at 07:00:23AM -0600, Rob Herring wrote:
> 
> On Mon, 06 Feb 2023 23:49:58 -0800, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../bindings/hypervisor/microsoft,vmbus.yaml       | 48 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.example.dtb'
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2

You can ignore this, it's a problem with the CI job.

> 
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/virtio/
> MAINTAINERS: Documentation/devicetree/bindings/virtio/

But this probably needs to be fixed.

Rob
