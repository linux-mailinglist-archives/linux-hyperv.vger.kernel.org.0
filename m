Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B9A686C93
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBARPd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 12:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBARPa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 12:15:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96A65B8
        for <linux-hyperv@vger.kernel.org>; Wed,  1 Feb 2023 09:15:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a3so11293106wrt.6
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Feb 2023 09:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VM7mwmX9y0aJv/l2uTcSI1qbCpT1RPYq3liCjHZTP+o=;
        b=XRIkjgyeFPF6oVGnLplxETaiAK3bOqM3Ssgkjrto+d1BBGcsDVBRtn3tUvkzzI0MQL
         ED755Tx+4nNxnoGfYRt9alOASVN30bDSIuqGaFQ0r+YpT1XfzpulyCcb7TQsg3mZADyS
         35LrhYqTU4iTXLQ2o1G8IhcXG9l28CQgWKJY5gjrOHNkpsKMveQ8V+j5nf+hPds+pzVs
         6luJGMMDKX0DXVHPFUIyUfJHfctSrKgTeuWo17SA9a7q1jy1kDk8nBDZ//8hh21stl2J
         R2nNOZ4hmTOiYvDZ11eRYKRqNtNcOnk8q1JEI4DOpShgexdnaVROW0ok6DKNtqoEppSM
         IuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VM7mwmX9y0aJv/l2uTcSI1qbCpT1RPYq3liCjHZTP+o=;
        b=C6rWqdNfzbaFPzz3MEhzhrzBDZBlQ/wddexKvScNBTeRTgogUFCyuizeb7FYXUuU1Z
         nE0a0X7aWvtTnOKTGty4c9qoRqeEsW0UYGItM1zGjz4dJtINcR0nJn0qkJxFjq2ofcIx
         abJnFYeya8dqYvoAjXemrl1h5Ukv0mXH5YNDjy3ue9dkqsNsIjNP7F3XhWu3k4Q9gec5
         tuDmpEbF1gCnHKFUKbuKFr2g/2nboV585TW41139LVNK8CZHUfZrs2iLKWImzrnPvv8H
         jbXQNKHwBq1MnuZnFVG1gstQkofMOIht9nQgw0vvbFjMFx0xgh7MoAPWhY/ZI5H92/uX
         xRfQ==
X-Gm-Message-State: AO0yUKXv0TJSm52sR48ygXWvywvBGxr9/a/9XE9AMLVpE5eq7+tnn1Bu
        9dJuBfAIG9SZvtVdOZvQsvY4Hg==
X-Google-Smtp-Source: AK7set+RvUdCnGg9f/Z1WgAuKSiAy0GjWjR9zmuoD/dpeP8vUs7xYvPEf7CzAuuSk3sJte/nKCFOcg==
X-Received: by 2002:a5d:4b4e:0:b0:242:eb5:254f with SMTP id w14-20020a5d4b4e000000b002420eb5254fmr2220071wrs.48.1675271725729;
        Wed, 01 Feb 2023 09:15:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe4ce000000b002bfafadb22asm18404133wrm.87.2023.02.01.09.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:15:25 -0800 (PST)
Message-ID: <d60e9b7c-fdd5-2b5e-a449-d796718fb95f@linaro.org>
Date:   Wed, 1 Feb 2023 18:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <CAL_JsqKL3JA6nAkEHuuyxbs8-Mm=Q-nNkCmpnDApNUDVbLsvKw@mail.gmail.com>
 <20230201020449.GC20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230201145146.GA3352796-robh@kernel.org>
 <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201163455.GA21409@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On 01/02/2023 17:34, Saurabh Singh Sengar wrote:
>> Also see my comment on v1 about running DT validation on your dtb. I'm 
>> sure running it would point out other issues. Such as the root level 
>> comaptible string(s) need to be documented. You need cpu nodes, 
>> interrupt controller, timers, etc. Those all have to be documented.
> 
> I will be changing the parent node to soc node as suggested by Krzysztof
> in other thread.
> 
> soc {
>         #address-cells = <2>;
>         #size-cells = <2>;
> 
> 	vmbus@ff0000000 {
>             #address-cells = <2>;
>             #size-cells = <1>;
>             compatible = "Microsoft,vmbus";
>             ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
>         };
> };
> 
> This will be sufficient.

It will be ok for the example, but will not be ok for supporting your
use case. Please solve all the points from Rob's comment above. Where is
their documentation?

Best regards,
Krzysztof

