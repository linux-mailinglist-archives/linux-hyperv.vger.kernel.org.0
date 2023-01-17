Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3129E66D3C6
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 02:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAQBRk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 20:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAQBRk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 20:17:40 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD2124101;
        Mon, 16 Jan 2023 17:17:39 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1442977d77dso30523259fac.6;
        Mon, 16 Jan 2023 17:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F4Bj+9QmhG6TNUKdKsjnHuIPQwjxlaYL7LZm3G7wZxA=;
        b=VuneVeKCpRfJ4p6wsrtSnpVslcKRx+gP7oNUYc/Kxw99NIl/VkOGbYGg9zILxrXYSC
         zIL5ktZ721gZLq99DLI5fkR7Yq/hm6JKBWsHihwlsHZqZDGOGOwNG9ZZY75ZVC0d9iHP
         vd0rHtGPRVBJ17CuJl55c8zqseHvWGu+7pUu1EBtdkLXdLJKJRqetuTPEphYscXBNRvC
         io2XgCzinyjEcUHAx50pW4CCJMQKt4/E/W6eVzQCczDV4hZsceunb5R7DVvxOpodcSYV
         M8Y1pqfGQBJW/xiVvStPaPleFfn0mY3V2PlgoOlkoEBSpe+0tpp4dRIDzFXs6Gk5toGH
         52Gw==
X-Gm-Message-State: AFqh2krnq1cGaRoRbfeaon9fobV/Z9HYNLqZw4HZWCT4/Nj1FwKUr9r/
        iiXl68RagQ9oy4UK1b2smg==
X-Google-Smtp-Source: AMrXdXvyn5tRRIBo75GpJ3Ah/S7lll9isVzYuogPxxl78Gv5qOMGaO9/SAB1qriEJIwYcJbxeqwSRQ==
X-Received: by 2002:a05:6870:bf0d:b0:150:c935:201d with SMTP id qh13-20020a056870bf0d00b00150c935201dmr880763oab.20.1673918258217;
        Mon, 16 Jan 2023 17:17:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t18-20020a056870e75200b0014866eb34cesm654464oak.48.2023.01.16.17.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 17:17:37 -0800 (PST)
Received: (nullmailer pid 1512748 invoked by uid 1000);
        Tue, 17 Jan 2023 01:17:36 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     daniel.lezcano@linaro.org, kys@microsoft.com, robh+dt@kernel.org,
        wei.liu@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        haiyangz@microsoft.com, mikelley@microsoft.com,
        ssengar@microsoft.com, linux-hyperv@vger.kernel.org,
        devicetree@vger.kernel.org, decui@microsoft.com
In-Reply-To: <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
Message-Id: <167391822562.1511774.11947732900116239438.robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Date:   Mon, 16 Jan 2023 19:17:36 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On Mon, 16 Jan 2023 08:48:08 -0800, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hv/msft,vmbus.yaml:20:9: [warning] too many spaces before colon (colons)
./Documentation/devicetree/bindings/hv/msft,vmbus.yaml:30:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/hv/msft,vmbus.example.dts'
Documentation/devicetree/bindings/hv/msft,vmbus.yaml:30:1: found a tab character where an indentation space is expected
make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/hv/msft,vmbus.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/hv/msft,vmbus.yaml:30:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hv/msft,vmbus.yaml: ignoring, error parsing file
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

