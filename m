Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D468E032
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 19:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjBGSje (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBGSje (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 13:39:34 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560174489;
        Tue,  7 Feb 2023 10:39:33 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id x26-20020a056830115a00b0068bbc0ee3eeso4504009otq.0;
        Tue, 07 Feb 2023 10:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnOOq9bnjd33c9I9u467kZfQTzJzMXOdinGlABSXslQ=;
        b=I3V+njsffI3/yU9r9J6mcKo8DmgpBUC3IJdTc5v9uBBqItI8Y2DpbrbvKRbsJZI3XA
         JTDjbJwVHf56PCPpbNKYuZcjt7j2AQDfGMfwF+R1Vn4YAYxmy4dpmdOU/Q9qME+0QHNs
         kk3W30MiC/c/09PXzR/ws78kw70KIaW25RN7pV39EmUElcOqhrdxqJqb4id+icmEx53m
         juk3npDVuXREsVsiGutBhlKlZNWPVShP13dQhiVsGOnMV3ehV9l56ATxwbLkGNEMJvfJ
         EhEYBORZdzjnRVXCaIee4nyeJhsEEbq21l4NWI+mi3apMNvqLHvBu+1QzAYnBAs/UeE7
         ba8A==
X-Gm-Message-State: AO0yUKW/Mw7pInnpsIbrGKVazbR1N1nLQwL8busQfJP5qH2Y7WdQ7npq
        swZb5bF53JbpzeCnsDwEPQ==
X-Google-Smtp-Source: AK7set9o6FrcZ/UZLBqQivtYh8syeRwjj0znAHcKuQP7cKo9BOmXT6TonjdC18HOmcQGBizl1bIhEQ==
X-Received: by 2002:a9d:7d01:0:b0:68b:ce98:1f9f with SMTP id v1-20020a9d7d01000000b0068bce981f9fmr2911101otn.34.1675795172568;
        Tue, 07 Feb 2023 10:39:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d7487000000b0068bce2c3e9esm6850234otk.14.2023.02.07.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:39:32 -0800 (PST)
Received: (nullmailer pid 3950307 invoked by uid 1000);
        Tue, 07 Feb 2023 18:39:31 -0000
Date:   Tue, 7 Feb 2023 12:39:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: Re: [PATCH v4 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Message-ID: <20230207183931.GB3753062-robh@kernel.org>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
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

On Mon, Feb 06, 2023 at 11:49:57PM -0800, Saurabh Sengar wrote:
> Rename virtio folder to more generic hypervisor, so that this can
> accommodate more devices of similar type.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-virtio.yaml               | 4 ++--
>  Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml    | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml         | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml     | 2 +-
>  Documentation/devicetree/bindings/i2c/i2c-virtio.yaml                 | 4 ++--
>  MAINTAINERS                                                           | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

virtio is used for more than just an interface to hypervisors. I think 
this should remain. Instead, I'd put vmbus under bindings/bus/.

Rob
