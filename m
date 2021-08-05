Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041B23E14FD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbhHEMqG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240545AbhHEMqF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 08:46:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857DC061765;
        Thu,  5 Aug 2021 05:45:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cl16-20020a17090af690b02901782c35c4ccso5324390pjb.5;
        Thu, 05 Aug 2021 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UnQ03oOngNmEkX2RgYECAHu+zjiI5dLikqmWa8ZL0fs=;
        b=UDFSEnFX+P4D9dsBIpJXdiBDvFFosSFjV5A69fRAMBpYEuPR/kPhRSQT3t5X9zzZKT
         Vrm2OtKTz8EhYg6VE+HJJYVkvpoPT20eHrl0bUD9R3aKUqckaqhXIqKySeliUj954Ml2
         bZddEqAIyd2Os0Nw/zD4AzC/gPjf4LGKvd9l0mFEOcajMDhklpqkyzKbTfbc9dTAl0Eu
         2MbKnuC0XAVQoUzGUQUs3NDbtWnkaT9siO8g5mXDko/Y58pnN40zMNu/dUsbw5FSj24u
         sXHacU7T0WuWEKWp4GJzAz/mJlcviQzTggQVQiEuKbTK/sHfxPpTM7KK9whHv0N7d0MS
         Sj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UnQ03oOngNmEkX2RgYECAHu+zjiI5dLikqmWa8ZL0fs=;
        b=mo+0QLA/3run/+qB5PSu6l7C2HY2HUisHwAMuDn2PG16qHWZ5k92FK8Lrme6jvBIZF
         8XsXU0nX83Ihx5RGliIQVYuZUjrsJTHmEfMIGkYxQUwi6w81ZwjyF2TYzAVnVOM8FIxa
         9PWdtQm3zXpqF2tlFtBad6k3+i0QEkiM2gspcuD+E/C28zEjn06aqMmtWYqt9l6bZ3FI
         xcwjIg90I66p90fxhg+xVpaAN/MGM8BDPZjHlSWkNsxQrc/J5pZTtXnLjsZNFqqvwqKc
         efhxvbYTgILhN26Uenmpz4iY2OAuAjU6/CRJI/wCnptQ+gB83diryfI6Ma8KJC65wZZ3
         pV0Q==
X-Gm-Message-State: AOAM533xjirdHaLyKjlF56GvDv+xgdN/hFkWEZL0OI2n00dIA40jZQ7H
        bx0C8wAE6QXocCTC0yAuN28=
X-Google-Smtp-Source: ABdhPJyPIvuRj0WS5honl3gpwUJRNlaY/tqyu7YrNlWPhrOIfYzyCSQx6EuxhZ5KXVdagwF6xp7ecA==
X-Received: by 2002:a62:878c:0:b029:3c5:f729:ef00 with SMTP id i134-20020a62878c0000b02903c5f729ef00mr4911562pfe.43.1628167550056;
        Thu, 05 Aug 2021 05:45:50 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:5:8000::4b1? ([2404:f801:9000:18:efec::4b1])
        by smtp.gmail.com with ESMTPSA id s5sm1983191pji.56.2021.08.05.05.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 05:45:49 -0700 (PDT)
Subject: Re: [PATCH] x86/Hyper-V: Initialize Hyper-V stimer after enabling
 lapic
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
References: <20210804184843.513524-1-ltykernel@gmail.com>
 <db8d38c9-e11d-1abe-8617-d8a231cc22e2@linux.microsoft.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <4ceb1504-205a-26fc-2fec-2d87f8601b31@gmail.com>
Date:   Thu, 5 Aug 2021 20:45:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <db8d38c9-e11d-1abe-8617-d8a231cc22e2@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Praveen:
     Thanks for your review.

On 8/5/2021 2:41 PM, Praveen Kumar wrote:
>> +
>> +static void __init hv_setup_initr_mode(void)
>> +{
>> +	if (old_setup_initr_mode)
>> +		old_setup_initr_mode();
>> +
>> +	/*
>> +	 * The direct-mode STIMER depends on LAPIC and so allocate
>> +	 * STIMER after calling initr node callback.
>> +	 */
>> +	(void)hv_stimer_alloc(false);
> In my understanding, in previous implementation we were ignoring the return error as there was a fallback handling for LAPIC.
> However, I'm not seeing the same here, or am I missing something ?
> 

Nice catch. The original comment should be keep and will add back in the 
next version.

