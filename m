Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015B686088
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Feb 2023 08:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjBAHXy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Feb 2023 02:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjBAHXx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Feb 2023 02:23:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28418BB98
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Jan 2023 23:23:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so16346418wrv.7
        for <linux-hyperv@vger.kernel.org>; Tue, 31 Jan 2023 23:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWbAr9mBTWOMtAoqN4GLxi4sz+M94KHE/wqJAmQCP4Y=;
        b=Cxxt2hjYpMNG9w0CHlFVW7pp1ICkDXKprzAXGOZAiJIuIIZcEv5jkGi2oMtyJfEX/p
         gx2CGoJStdWBEubEfzP1gOSwQwi1GsXxYI9+9CweEcf2hF6l7SOyfUqxNxZRY1qv0jsb
         Tfuiu9EHcBo8+MqFQKsPylvskN2LifOOCrtQRjqiD1UrfL9Snm+jeFRktURZw7cJ9SlO
         yDumtrx+jGy8liLB0/nwqPnOfx8mO/bVDL6n+OMbYp3+4RY+fbD0ij+tfIr0YN8bbQSI
         KJ82V8wpnPXSa2o5uKAzaRPOLWvIgbZXvxMre8/TpRVot+gJDhGiT3do3dhIcv9B4b6D
         IDFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWbAr9mBTWOMtAoqN4GLxi4sz+M94KHE/wqJAmQCP4Y=;
        b=TF6ujpGUveuWuCz4z9r4XcUdeQOWkeO2Wt71ZRfX0t3qd/QYYqxZWg6kr/GHS0mnwZ
         cQsg+D1B27mT1qLcmNOPPQ+oYwi3LxsdP15OqUqdub7UZfU+u3nlDxN8995UgHC8udbV
         /+pdqInUXt52hNQH8i8yVuD74srdII9evQekxvLBsXm95VB47oT9sL7sw/96Kab9Q/Q0
         VihzglS+npfZ2ov3d50bhJ3aHZD4ho+MFeq87hw4CWFRdt41PwVtj6LZANausF4iiClY
         0ZRaKvWjuuYgvmDp4u/j1YX36ZYPbCWjjKSwhpb+f7COujEr0wPsVxWQi15lXxz3uDpl
         x82w==
X-Gm-Message-State: AO0yUKXGD5VaFD+ntOQSo8ghYV5r+N6ASdFKlCLVncDMx+XEaUN/4LKy
        tVzws2qcv67MugcQ+o0nx0tm6g==
X-Google-Smtp-Source: AK7set8cJQO3VUWKw/onCq6pDwenKE4EACMeCdvxzCOtnu69YShLVk0A8EvdjocJ92tEsMBFyoq72g==
X-Received: by 2002:a05:6000:9:b0:2bf:c338:b02a with SMTP id h9-20020a056000000900b002bfc338b02amr4815972wrx.36.1675236230671;
        Tue, 31 Jan 2023 23:23:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i16-20020adfb650000000b0029100e8dedasm5263235wre.28.2023.01.31.23.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:23:50 -0800 (PST)
Message-ID: <6cd98ec5-3d0e-eb91-b2a5-9781439ae483@linaro.org>
Date:   Wed, 1 Feb 2023 08:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/6] dt-bindings: hypervisor: Add dt-bindings for VMBus
Content-Language: en-US
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
 <9a3bbaf0-eb1d-613a-a8ba-272896ef2da8@linaro.org>
 <20230201015723.GB20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230201015723.GB20379@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On 01/02/2023 02:57, Saurabh Singh Sengar wrote:
> On Tue, Jan 31, 2023 at 07:54:56PM +0100, Krzysztof Kozlowski wrote:
>> On 31/01/2023 19:10, Saurabh Sengar wrote:
>>>
>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>
>>> +  - |
>>> +    / {
>>> +        compatible = "foo";
>>> +        model = "foo";
>>> +        #address-cells = <0x02>;
>>> +        #size-cells = <0x02>;
>>
>> Except previous comments (all of them were ignored),
> 
> Thank you for your comments, I have tried to address them all in this version
> but I may have missed few. I will go and look again all the emails, but if
> there is any thing which you can point again and we can start a new dicussion
> from here will be very helpful.
> 
> I think one concern was related to use of 'reg' or 'ranges', and I 
> thought this patch will give clarity that I intend to use 'ranges'
> without any child node. Is this acceptable ?

There were several comments.

> 
> 
>> also:
>> Drop entire part. Not related, not correct, not helping and you cannot
>> have top level nodes in example.
> 
> If I dont use the top level node, the parent address cells are assumed to be 1,
> and I get below warning. If there is better way to address this warning, please
> suggest I will work on it.
> 
> Warning (ranges_format): /example-0/vmbus@ff0000000:ranges: "ranges" property has invalid length (20 bytes) (parent #address-cells == 1, child #address-cells == 2, #size-cells == 1)

Then use soc just like every other example.


Best regards,
Krzysztof

