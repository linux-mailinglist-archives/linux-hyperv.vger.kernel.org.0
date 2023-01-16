Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEE966CF28
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 19:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjAPSxO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 13:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAPSxN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 13:53:13 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F014844A6
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 10:53:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id cf18so63767954ejb.5
        for <linux-hyperv@vger.kernel.org>; Mon, 16 Jan 2023 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhM/j9TA5swWlMFXNhb7HBu9EeesX3946xV+twadk5c=;
        b=PAUBV+0OxPJB6qnsOMGZpGHNWUUpGxW9IncoZBLyYEyXDm/paOdyEgqQyIpjw6so1k
         EEf4Q3E5+ZGUMI+QSWIbd7sAnLdlx9b39TqMCj+YR+Z5CXbc87e1UVo6iBcXDUBTx156
         1+E5uHP/DDx5V3qnAniuakzrhjJlv8akVzOPtWQYAVvv54t2pI2dQAQkjW9QjIbQh9N8
         sBTVEmOuzLe/NmFE4YgdlHqkh3dbE7ysQyys6+DHKs0tUTdW84V8Q1u65Vigl+BMUtdg
         ixhVzAURRP0BOw5j6DnMqmMtfQc1yDm6vLNo1iBufw/lBj0p5DGwKFhofx5hx8VWUa+k
         /NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhM/j9TA5swWlMFXNhb7HBu9EeesX3946xV+twadk5c=;
        b=1f0OfFQi/YtWpMkrWhT/yxN6xKvTO+b7Y+nsP3grCIq9fE0/rgkppMpS9SHBOZWDK+
         8HQiEqrsNsiSZAoISpKEfpgXskTFnKQchJ+bK7OPSu5DRZ6VZWgzh6uOwwEpj2yJeQ2y
         MHzkx+AOfFpmHBqRBOoawkNawDjxSpfAtbn4hlSnuadoGT0u/sVStEYmlSxF7TjRS8vt
         Zv1qkkenJfTVgZkp6zr9Pz4dKYlbTmKNSp6jomR5UNRZHGBMiL04IomRblk0sBBK1w6F
         8x36rk1B9UmD6bjZ4DVq30OYi3iRehMrytsuI+8oIpQGwkommk989j/etoHkd7R42IMp
         scqQ==
X-Gm-Message-State: AFqh2kr/zK5H9GDCBVKYzXCi2DvR+gMlREYzjWz5mMrj9EuHEzfSqDPe
        8VM1uPTbhNRyXxa4RWPrhKxBQw==
X-Google-Smtp-Source: AMrXdXv79SowcrX2fmpfpRRZi/t1GSCB5WlHms073aijvvFrOkQFDm1oWPHVnpHFbwUEnbKyw7LJ5w==
X-Received: by 2002:a17:907:c30c:b0:86c:cbfd:936 with SMTP id tl12-20020a170907c30c00b0086ccbfd0936mr72627ejc.11.1673895190543;
        Mon, 16 Jan 2023 10:53:10 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ez6-20020a056402450600b0048ebe118a46sm11734133edb.77.2023.01.16.10.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 10:53:10 -0800 (PST)
Message-ID: <f74fe561-dc20-0681-12af-4a4782a060be@linaro.org>
Date:   Mon, 16 Jan 2023 19:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 16/01/2023 17:48, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus

Missing full stop.

Subject: drop second/last, redundant "dt-bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hv/msft,vmbus.yaml b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> new file mode 100644
> index 0000000..66cb426
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/hv/msft,vmbus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microsoft Hyper-V VMBus device tree bindings

Drop "device tree bindings"

> +
> +maintainers:
> +  - Saurabh Sengar <ssengar@linux.microsoft.com>
> +
> +description:
> +  VMBus is a software bus that implement the protocols for communication
> +  between the root or host OS and guest OSs (virtual machines).

Why this cannot be auto-discoverable? Why do you need OF for this?

> +
> +properties:
> +  compatible:
> +    const: msft,vmbus
> +
> +  ranges :
> +    const: <0x00 0x00 0x0f 0xf0000000 0x10000000>

Did you test the bindings?

This property does not look correct. If you have static addresses, you
do not need OF. What do you want to discover here?

> +
> +required:
> +  - compatible
> +  - ranges
> +
> +examples:
> +  - |
> +        vmbus {

Use 4 spaces for example indentation.

> +		#address-cells = <0x02>;
> +		#size-cells = <0x01>;

That's not correct style. Drop hex notation. Drop leading zeros.

But anyway you did not test the bindings. This cannot work. Try.

> +		compatible = "msft,vmbus";

compatible is a first property.

> +		ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;

What do you translate? There is no reg, no unit address.

> +	};

Best regards,
Krzysztof

