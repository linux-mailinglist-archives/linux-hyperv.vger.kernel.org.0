Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273D767538D
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jan 2023 12:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjATLnr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 Jan 2023 06:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjATLnq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 Jan 2023 06:43:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6BA9515B
        for <linux-hyperv@vger.kernel.org>; Fri, 20 Jan 2023 03:43:44 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id q8so3805760wmo.5
        for <linux-hyperv@vger.kernel.org>; Fri, 20 Jan 2023 03:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFIZGqHgBTv4Y7yKFU4agF8AmAfMOPOT/AAIFzNAuic=;
        b=xH0Bubx4lz+orm1pj5QuQ5nFZya7YPPsigoNT2tH6DXNyswvyDAhGEXPrbvIzlVzB5
         Hnk3ckQWp9fchImrbmP4tzGer0vjtXBsPSj/q3pB1bdJfTdHaH+Hw6RhvE/yUL/wQM00
         PCzpVmtcp56p+lquKtOQnYwRRKe7gkmpMi+hMyMTeVWA3rmEPUk6/komzxGKhzPwzSXD
         Z5lIoGj8ec4mRaV1WRG2r8iJTKNbbY/2n1Yn9KYffBtkKOJK9Gi9sPCW7BVj/SEBfDDK
         gldciUtx2dP7rO15SUhI5kPdF9XX4aJ7ORp2eFrDYQZ9f+x5Bc3u4FyIoe8ywMpFKjOh
         KbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFIZGqHgBTv4Y7yKFU4agF8AmAfMOPOT/AAIFzNAuic=;
        b=frL4HE77B3ZfqYs8ri640wL3IwPSe6MIwHC7Z7m5XS7oVDY0tvWAVBnrdHgFKKuHXw
         wRMyHXSmOvmu21Mmn30QH9DOjqyNARbsAZeoZLjUiyWlYwwvOeW6mYDBK4gC9nZQUE1h
         hH2qd60sH5p463alpsAj+GRftU25IO4ccruSEbHFepBspRdMFvbCSonFuyVUD8efRLIW
         CMq0zClAA41jUZnaBcOTcSFrGR0w9Gd5j04ASGplzkgMtZN7ZHJ5AJEKKGzS1UXXoQMF
         3ZxsewzRY5+9kn/ajdMPzwAauoQP2S7x3jy8T5L5N+02QBTXoCRlOEM2NQD+0VMu5myy
         I7Ow==
X-Gm-Message-State: AFqh2koUrX7Fe1GNsUIWmM+bfTkvV7VoxiD59gNLa/4XDyOKMidxETMU
        2YZFRRNZWIZszp90p5KpaJCLYg==
X-Google-Smtp-Source: AMrXdXs9wmH3qJgIKDgCPqKkCUTV4ImERAqK9Oy21EPXPx94m7yWkoW1ubB6EOce1rqJiagNMao2sQ==
X-Received: by 2002:a05:600c:c0a:b0:3db:2858:db84 with SMTP id fm10-20020a05600c0c0a00b003db2858db84mr4357678wmb.34.1674215023312;
        Fri, 20 Jan 2023 03:43:43 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c4f5200b003cffd3c3d6csm2210588wmq.12.2023.01.20.03.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 03:43:42 -0800 (PST)
Message-ID: <f6b80686-d8bc-9c7b-205c-635d4e681f50@linaro.org>
Date:   Fri, 20 Jan 2023 12:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
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
 <23a7ae1d-cd49-8c78-5284-4134755ea19a@linaro.org>
 <20230117155258.GA14857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117155258.GA14857@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

On 17/01/2023 16:52, Saurabh Singh Sengar wrote:
> On Tue, Jan 17, 2023 at 04:41:22PM +0100, Krzysztof Kozlowski wrote:
>> On 17/01/2023 16:13, Saurabh Singh Sengar wrote:
>>> On Mon, Jan 16, 2023 at 07:55:13PM +0100, Krzysztof Kozlowski wrote:
>>>> On 16/01/2023 17:48, Saurabh Sengar wrote:
>>>>> Add dt-bindings for Hyper-V VMBus
>>>>>
>>>>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>>> ---
>>>>>  .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
>>>>
>>>> Also, there is no "hv" hardware, so that's not correct location. If your
>>>> bindings describe firmware, this should go to firmware. Otherwise, this
>>>> does not look like suitable for DT. We do not describe software stuff in DT.
>>>
>>> VMBus is a virtual device this is simmilar to virtio. I can rename this folder to vmbus.
>>>
>>
>> Then virtio directory. The directories are per subsystems (hardware
>> classes).
> 
> Apologies if I was not clear, I meant to say this is a device conceptually
> similar to virtio. But this driver has nothing to do with virtio, we should

Bindings are for hardware, not drivers, so if the device serves the same
purpose, it's driver differences do not matter.

> be creating a new folder for it OR I am fine moving it under bus if that's
> okay.

Since you do not have children here, it's not really a bus to fit under
bus directory...

Probably this should go together with virtio bindings to dedicated
hypervisor interfaces directory. We do not create directories for
specific solutions (implementations) with only one or few bindings.
Directories are for entire classes.

Best regards,
Krzysztof

