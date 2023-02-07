Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB46C68D788
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 14:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjBGNBF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 08:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjBGNBE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 08:01:04 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFE139B9F;
        Tue,  7 Feb 2023 05:00:27 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-15f97c478a8so18824891fac.13;
        Tue, 07 Feb 2023 05:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kWODlwdvZsu0oLYsDwnCYHspujHUtXG5z9FcEcxyHyQ=;
        b=60nbZ18E8F1ewwmcvvYRiOvPupBogXMu/SJZsBTzoIvyFN9zmbWomn9vba6jTGh9ho
         ToHJuI3pumGXayqmOk7rHlbxpVyrPnq0FisMTs9gqEjMQ8g79++sDrgfRBJxdUQHUMrD
         MdJYCWUd+0RzN680kxdUBr6YmWH+lcVYkopHmO2oZvO30QkJxH3ZRpaHT42yvN0Bp66S
         SjICZDurvNtbT+ELiymD0sK++aL79g+ZetdH8/oXuYXt1nyExlY8FofRAbVW/DUF5ipk
         uYrpmswcrCL7KO07LkhmETnJXzhXYQzEphCoxEE+F6APX8qN2+GhdBinXt+ozdazhVlq
         u0Kg==
X-Gm-Message-State: AO0yUKWfSCEcJA8CvBEDc5wG0OEmlGLPAVnP3TuNi03tLzbhB76ShfVg
        bNC1HkwNFFVTJd6uFK+PPQ==
X-Google-Smtp-Source: AK7set/AuiNu1wfO7TO0Yq1H8Nc2wRr3B6t1v/K4dh5V8fdcoownRf93LSBXHcp95e0D4fG4jyF4QQ==
X-Received: by 2002:a05:6870:c093:b0:163:b347:22fc with SMTP id c19-20020a056870c09300b00163b34722fcmr1511834oad.12.1675774826402;
        Tue, 07 Feb 2023 05:00:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a056870044400b0016a694e7e2dsm1401439oak.39.2023.02.07.05.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:00:25 -0800 (PST)
Received: (nullmailer pid 3216438 invoked by uid 1000);
        Tue, 07 Feb 2023 13:00:23 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     mikelley@microsoft.com, wei.liu@kernel.org,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        ssengar@microsoft.com, virtualization@lists.linux-foundation.org,
        decui@microsoft.com, haiyangz@microsoft.com,
        linux-hyperv@vger.kernel.org, robh+dt@kernel.org,
        dphadke@linux.microsoft.com, kys@microsoft.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
Message-Id: <167577470818.3213850.12635304061765127789.robh@kernel.org>
Subject: Re: [PATCH v4 5/6] dt-bindings: hypervisor: VMBus
Date:   Tue, 07 Feb 2023 07:00:23 -0600
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


On Mon, 06 Feb 2023 23:49:58 -0800, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../bindings/hypervisor/microsoft,vmbus.yaml       | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.example.dtb'
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/virtio/
MAINTAINERS: Documentation/devicetree/bindings/virtio/

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

