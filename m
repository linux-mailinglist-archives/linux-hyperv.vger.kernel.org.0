Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B8F735C06
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jun 2023 18:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjFSQQj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 12:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjFSQQ3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 12:16:29 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5FC1
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Jun 2023 09:16:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f849605df4so4717455e87.3
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Jun 2023 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687191387; x=1689783387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leWAGSFt7ZRZTiV68pCw/bS8IvitjMX4ssop8zLCQLk=;
        b=KPqCsivXnm5TyZDYJDfxHUfqAQuL7m7AzIjRWUYJlgYoKbRmBF3nqbCkkTdaANIqGM
         /rF+TgrYHg41YGJJVwU11kD4kBQ/ohoHUvNVt22jSuDjqEOlcZg3cP+z5gGj9kdej6qB
         0m7HNbU3XcBvw8pz9RNgbCzRnd4RIB0XxocRsraAqPgHVCp6XYwxwplNUja+5OVL5zeq
         STxkQGP+CIKy5gswxMYXz21pDLuHGDTrAjQKcFuMP4FUxSQwp6wa/VMFAGHU6ohm3XzD
         0TjR4W8+B5ELk/hZjqGMF6iNVDWv6VQEoAJWF+LTLbV5H++K+0keHkgww5X0RKGZfXhl
         PskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687191387; x=1689783387;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leWAGSFt7ZRZTiV68pCw/bS8IvitjMX4ssop8zLCQLk=;
        b=ecfHZd1r72z8AABALGDu/Mh1J2iKzpkxByoSRW9eMQK96N6rrafJZWs0GwazW6p7Rl
         0HyEZ2rwui+3gVUv2aCyHPCNddlnEfufVeo/s/fNArXe5TnLbnyfQgxMeFEJQpJxw9Iq
         JmbGX0enMqAUIMERQrCFhyS3rpbj2uvhcMp41EZ3k/qaW9JwebVUBA2ONDPn4Bu4Ys+l
         5UeXe+IFZSuWm9fEK6jnGGBymak6O3/Aj57xTgTklT1xl1+lS6PMwPSyKSMuQAyvwk9t
         5UlbAKdx5Hi7FZLghW0AZEdThsP2ghEXQa5Z9zntzi1qqxyQtAh+ztktzECMxDXenKs6
         +u+A==
X-Gm-Message-State: AC+VfDz6BHrMgDuwvSDfiaG4oSqJ+WFwMFxgb4b/Q9h7+0g/tAvKdkMW
        Ikj4dRBcYVL8RvVbLXflg/tT5XNKgwAOY3NzQyo=
X-Google-Smtp-Source: ACHHUZ5nU8CDnotXYqoQdUIkgLe6l8Zg3bvGXgRhke6j+ElbL2Iu5NUib34O1rrxegBd2AJ+aG1bqQ==
X-Received: by 2002:a05:6512:288:b0:4f6:924:8fa3 with SMTP id j8-20020a056512028800b004f609248fa3mr5669498lfp.58.1687191386660;
        Mon, 19 Jun 2023 09:16:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:13d0:1b6c:ce40:5429? ([2a05:6e02:1041:c10:13d0:1b6c:ce40:5429])
        by smtp.googlemail.com with ESMTPSA id c9-20020a05600c0ac900b003f7eeec829asm146142wmr.10.2023.06.19.09.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 09:16:26 -0700 (PDT)
Message-ID: <fdc643c4-6298-d337-1d8d-3f28f6c1acfc@linaro.org>
Date:   Mon, 19 Jun 2023 18:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Content-Language: en-US
To:     Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 09/06/2023 17:47, Michael Kelley wrote:
> Current code assigns either the Hyper-V TSC page or MSR-based ref counter
> as the sched clock. This may be sub-optimal in two cases. First, if there
> is hardware support to ensure consistent TSC frequency across live
> migrations and Hyper-V is using that support, the raw TSC is a faster
> source of time than the Hyper-V TSC page.  Second, the MSR-based ref
> counter is relatively slow because reads require a trap to the hypervisor.
> As such, it should never be used as the sched clock. The native sched
> clock based on the raw TSC or jiffies is much better.
> 
> Rework the sched clock setup so it is set to the TSC page only if
> Hyper-V indicates that the TSC may have inconsistent frequency across
> live migrations. Also, remove the code that sets the sched clock to
> the MSR-based ref counter. In the cases where it is not set, the sched
> clock will then be the native sched clock.
> 
> As part of the rework, always enable both the TSC page clocksource and
> the MSR-based ref counter clocksource. Set the ratings so the TSC page
> clocksource is preferred. While the MSR-based ref counter clocksource
> is unlikely to ever be the default, having it available for manual
> selection is convenient for development purposes.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

The patch does not apply, does it depend on another patch?

Rejected chunk:

--- drivers/clocksource/hyperv_timer.c
+++ drivers/clocksource/hyperv_timer.c
@@ -485,15 +485,9 @@ static u64 notrace read_hv_clock_msr_cs(struct 
clocksource *arg)
  	return read_hv_clock_msr();
  }

-static u64 noinstr read_hv_sched_clock_msr(void)
-{
-	return (read_hv_clock_msr() - hv_sched_clock_offset) *
-		(NSEC_PER_SEC / HV_CLOCK_HZ);
-}
-
  static struct clocksource hyperv_cs_msr = {
  	.name	= "hyperv_clocksource_msr",
-	.rating	= 500,
+	.rating	= 495,
  	.read	= read_hv_clock_msr_cs,
  	.mask	= CLOCKSOURCE_MASK(64),
  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

