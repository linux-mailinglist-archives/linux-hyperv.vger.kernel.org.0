Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEFD66E28C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jan 2023 16:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjAQPoO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Jan 2023 10:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjAQPnj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Jan 2023 10:43:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2C442C4
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 07:41:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b7so5020093wrt.3
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Jan 2023 07:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Sq5mqKsexCWXCOic8J9pe+B3N8PYnTwi9qY7eGHBxk=;
        b=rMtBegvKhr4EUsWsXeJbJPR4lIPhWn0VjwHAXcJ0LSgDBrkeHLrGw0MxB3AlVV2SLC
         ZF6zVHCstouiIxxHulQuzpiPf+554IuqNSod1odrHmBulVH0asDz3UXu6DQ+3kh6r5IS
         rIKs2olglP3f8NOqecLABX4Q0qFQhGWzTBSGmHKm1BiAEQxUsvqMP6zguAxdNr5uRCd8
         dlK+4jjllZ7kj2DCxYzAngRj5osdHxyekJYlBEzQUN3zj8hLZLvWXXsooTGCfcdOo6NT
         XTqXDA431ApzH6c2FOGlB0jHcvYPFfKyxZryr6ym/Sa3Nikg0J5wGToTfmFzWrCkZFeo
         7Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Sq5mqKsexCWXCOic8J9pe+B3N8PYnTwi9qY7eGHBxk=;
        b=wN2uxlPyo6aELhltC1b6DUgSO4rdCMNmEvqkAYO26CAdMCKfMn7EwJh88fp2X6hAft
         db14l+ucXatn5olcraT9GAbrpJKYbXEAuYPiOVhc4/Gtl6i91FpcLpuUOjaX99uKCbqF
         v55ZLludFV3NbzVBupP40s/KeUhhq60ItgludwDV3yWtqm6x/MQl3jPGuuM7fhtq4xpi
         sHL3hKlWHbwxSp/gvkm3iLM+i/XL8f8FMHBd7lgLOE4+mZVV5lpfZh6xZfnuIiMVQo43
         yJc4t2EL/r8jxjgRrOr+0lX53leoAZTHC1hjSHOgbUHVsl7I6VFtMuR+K+x9wNu008Ff
         i3SA==
X-Gm-Message-State: AFqh2krBB0YOAwtv0uiaG2/N6IxkRT8umPBdyOI5OfcnUDt8q4JQ3qp1
        pwi66x6WlmmCUUsTgFCjC6iu2Q==
X-Google-Smtp-Source: AMrXdXsZ1dgrVfEXi6FqUzbhTJkQGI2CqN5bloBxIDTiXwohuBAau4tN5lLMDf5WfR/m7bGjogUd0w==
X-Received: by 2002:a5d:6e0e:0:b0:2bb:6c50:a559 with SMTP id h14-20020a5d6e0e000000b002bb6c50a559mr2992490wrz.38.1673970085079;
        Tue, 17 Jan 2023 07:41:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm28863436wrf.42.2023.01.17.07.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 07:41:24 -0800 (PST)
Message-ID: <23a7ae1d-cd49-8c78-5284-4134755ea19a@linaro.org>
Date:   Tue, 17 Jan 2023 16:41:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
 <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
 <31d78b4c-1416-d8cb-a187-bf924168ee1e@linaro.org>
 <20230117151325.GA9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117151325.GA9806@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On 17/01/2023 16:13, Saurabh Singh Sengar wrote:
> On Mon, Jan 16, 2023 at 07:55:13PM +0100, Krzysztof Kozlowski wrote:
>> On 16/01/2023 17:48, Saurabh Sengar wrote:
>>> Add dt-bindings for Hyper-V VMBus
>>>
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> ---
>>>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
>>
>> Also, there is no "hv" hardware, so that's not correct location. If your
>> bindings describe firmware, this should go to firmware. Otherwise, this
>> does not look like suitable for DT. We do not describe software stuff in DT.
> 
> VMBus is a virtual device this is simmilar to virtio. I can rename this folder to vmbus.
>

Then virtio directory. The directories are per subsystems (hardware
classes).

Best regards,
Krzysztof

