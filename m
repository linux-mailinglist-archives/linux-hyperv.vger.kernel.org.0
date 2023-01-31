Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27F26835BC
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 19:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjAaSzJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 13:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjAaSzF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 13:55:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDE2577F2
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Jan 2023 10:55:00 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t18so15185003wro.1
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Jan 2023 10:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QuexQnSJj1/dEzqqzwt9cJfQTWna5k6Z7+DQSeslwSo=;
        b=UiFzOWFB4a/3xgSp1yUwchiAQ8AKbNngi8yAmudhhCWJPkH/vxdFxKnmN52dgge+99
         qV3JOlCLHqFjy9hcRlUHUKdwen91bD+PkvYzAYTR2ty2z7aKbQKdw1C8d4VPFkiKKTpl
         m/VAUSTxqu8ueLRRQUL9BBaylQ7omcTh92y39KQGo3LWPTIaYWhsaG23o15L+JPz/CYO
         KkmmixGlhfeo+NMFMvn+tXpyvnXBO2YKnH3OoRDt8BMVJWCKbQTRjKQp1zLrsVWtTC3V
         e6mdZXE6kookzzCJ/wh3wMXHTP/qJy9S92/66UvKZkeI1tYpylvfi1+eioXQCTQRcGYS
         yqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuexQnSJj1/dEzqqzwt9cJfQTWna5k6Z7+DQSeslwSo=;
        b=YVVIx1kVVjutUB7X1Fl4AE4m/8X61Qi+nes1RItr26ncjcNks0QowBW6xk9eYY/4au
         6zhjKb6yrNt8TPMbbxaeJMBXr2MHrnWtUw59TCSj8yi/hGlb/DqyHyAUjazy9NpKv8XS
         tsuhnWAwIEd5aCw/carHKnpywTVb+vghOiJu2VTEPeqMi3qseT++yc9o27AVdvjNBk2+
         F+///rJBAGAAAWsWVcmZmDpmnguoFoI7iMBkb2SmZXY9K2MTrc7Ol2O83p3PO4myuDQZ
         S1GJOCgD7mb/8oAPbGYL/AyhzyIeAbWH/UDbmoqQMzxNEJRp6Nb4qgmlVx6JUNaQOydQ
         jdhg==
X-Gm-Message-State: AO0yUKXf1GNhGm0YT5oDTSqOIwrV/E5/8A3WuyxGhvpRjCR+RbzLQtiI
        Jfo+assuLxXwJzA2eHdm94oHlg==
X-Google-Smtp-Source: AK7set/71U7zFmoH6k8sW32CesgMw/oX9q60A5z4fWakNgzXRDUUedjJa/xOqvp4MjzwwWbSNWAoaQ==
X-Received: by 2002:adf:fe86:0:b0:2bf:b36e:f6ac with SMTP id l6-20020adffe86000000b002bfb36ef6acmr30914wrr.39.1675191299268;
        Tue, 31 Jan 2023 10:54:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v9-20020a056000144900b002c3b2afae00sm112304wrx.41.2023.01.31.10.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:54:58 -0800 (PST)
Message-ID: <9a3bbaf0-eb1d-613a-a8ba-272896ef2da8@linaro.org>
Date:   Tue, 31 Jan 2023 19:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/6] dt-bindings: hypervisor: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 31/01/2023 19:10, Saurabh Sengar wrote:
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

> +  - |
> +    / {
> +        compatible = "foo";
> +        model = "foo";
> +        #address-cells = <0x02>;
> +        #size-cells = <0x02>;

Except previous comments (all of them were ignored), also:
Drop entire part. Not related, not correct, not helping and you cannot
have top level nodes in example.

> +
> +        vmbus@ff0000000 {
> +            #address-cells = <0x02>;
> +            #size-cells = <0x01>;
> +            compatible = "msft,vmbus";
> +            ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 1f7a519a936f..ab74ea97535f 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -876,6 +876,8 @@ patternProperties:
>      deprecated: true
>    "^mscc,.*":
>      description: Microsemi Corporation
> +  "^msft,.*":
> +    description: Microsoft Corporation

Don't duplicate vendor prefixes. Drop and use correct prefix.

Best regards,
Krzysztof

