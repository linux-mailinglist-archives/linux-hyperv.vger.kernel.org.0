Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F423B6836E7
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 20:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjAaT5k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 14:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaT5j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 14:57:39 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2F045884;
        Tue, 31 Jan 2023 11:57:38 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-142b72a728fso20806179fac.9;
        Tue, 31 Jan 2023 11:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m82eJrTLsCVv6+8d1tBF70ypw6dfuc3iNnRL2mCyZ7Q=;
        b=t6yPnyCtoNhSg26TgMDaiLvakC7WdESszfa3LRwM4d68CSVTFvXSkVKZhdAVvIfyrl
         RC5OtwBKC78Z5kdAaKWpVCqT9+ap2wDlnfLhp8gNqF5AlHhKmgVxMRc/RvS+2b/rxY/z
         86rrk5I+IYZgPFT4CCVmGAN5wCA5gaMavAI52iAkGBszWssRSGKPd6yDS+ySB1wUC7wK
         XtSJKVc1QdI/19Zu23ns3Hdp2gs2CNoaFHt0OYpY/rpBv+AZ19M2E6FtUlE5kzi00oO9
         jiUvqeUtz244UmtkMUO0U4CaZ8zMolYelh+yXOBnc5+3j+YkRcN3ARbPWWS3RZP9FMUQ
         Eq3Q==
X-Gm-Message-State: AO0yUKUasGQGsvfah+IusIzxxl+rMLjMTaAEZm9/Kn80fY4qiw3mNSlO
        wB38GL8vHhbff9wj6yVRQA==
X-Google-Smtp-Source: AK7set9mqa5Na5vbUcPoMSNwU8zMyBTBeTBDFDOv7+2/nvgRcTdmrhpji7/Gn0VRdn0ekPOq4E9Swg==
X-Received: by 2002:a05:6871:10e:b0:15e:db7e:b4dc with SMTP id y14-20020a056871010e00b0015edb7eb4dcmr8075396oab.35.1675195057458;
        Tue, 31 Jan 2023 11:57:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r12-20020a05687080cc00b00163af122666sm3197311oab.3.2023.01.31.11.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 11:57:37 -0800 (PST)
Received: (nullmailer pid 1853627 invoked by uid 1000);
        Tue, 31 Jan 2023 19:57:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     tglx@linutronix.de, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wei.liu@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        virtualization@lists.linux-foundation.org, haiyangz@microsoft.com,
        decui@microsoft.com, daniel.lezcano@linaro.org,
        ssengar@microsoft.com
In-Reply-To: <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
Message-Id: <167519443459.1836211.1945655170442861713.robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Date:   Tue, 31 Jan 2023 13:57:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Tue, 31 Jan 2023 10:10:07 -0800, Saurabh Sengar wrote:
> Rename virtio folder to more generic hypervisor, so that this can
> accommodate more devices of similar type.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../devicetree/bindings/{virtio => hypervisor}/mmio.yaml        | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml   | 2 +-
>  .../bindings/{virtio => hypervisor}/virtio-device.yaml          | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/i2c/i2c-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
./Documentation/devicetree/bindings/gpio/gpio-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '#address-cells': [[1]], '#size-cells': [[0]], 'light-sensor@20': {'compatible': ['dynaimage,al3320a'], 'reg': [[32]]}, '$nodename': ['i2c']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.example.dtb: gpio: False schema does not allow {'compatible': ['virtio,device29'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], '$nodename': ['gpio']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hypervisor/virtio-device.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '$nodename': ['i2c']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/virtio/

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

