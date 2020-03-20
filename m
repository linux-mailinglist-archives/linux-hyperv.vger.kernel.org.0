Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45DA18C537
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2020 03:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCTCVY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 22:21:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33992 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCTCVX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 22:21:23 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so2465755pfj.1;
        Thu, 19 Mar 2020 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1e0OIgkjQ6p7TmGWHOMEDLToq6DxMQ1K/qUCQ00OSsE=;
        b=sniiSpXFwyTHUSlN47I3KABcFhKy/rESwfd4t4Rd4dStHstVZetNNbSwswCAfb8j6L
         juUHZCKYi0M0rGjdNux6o+/PiDjbpALQc0LGbL9xw72TDuToXyA4qvpTtvmGhVmutuE4
         22Hjra6h3wBuz5GDD8iigePpVyqwgMatho9bRqu/rM+xuUioBrNGFbA2GKZtZrbrnaji
         +xLA/yV3qZw6jaThH4qACRmwA4L1ylfZIKVbAgqEcKLhbg3POVz66T3MLR964hU3NSJf
         tzs+uWks4FyO0PHllKxiWFp1Dpz9pmbM4JX832ABORLtpjpfhRMZgsYPwedIXli71ivI
         FZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1e0OIgkjQ6p7TmGWHOMEDLToq6DxMQ1K/qUCQ00OSsE=;
        b=Imhg+arP4WwkRge064mV7m62W09BY3XgZRTRpJGSK8LyLxvoi884+05xKwZq08e5ys
         3sAjadEBSx10xEPiLMCkQfGPm2oJuzqMFrwaRa7wmlbbTiB7ffbESQm7RSJ/miYoQ+YD
         GMQbneECpFeELPDECchc1kDXJaYplJGPTY2hKS7J4+ZT6jADsOHEfUC7Jtiv4YV4bNwP
         s7DbsgO+IQc9UuypLM7p4GPwVKkW489J5YFEyv8QVy7o17E/U9PvRcsCrhnDgJ2FhOgi
         pgNsPxeEXeyu63j2Hn+z6sskCPYnwJRpxLBke7AIMYedRs4wKi8SV379hi/BVmZEYCiU
         bFJA==
X-Gm-Message-State: ANhLgQ36d+lMrl1Ap/slDFO9OJMO1szO39zG4Lzh4dqktzgE++o4+799
        GVXoh2wQi7HRLaTQIFt7uJ4=
X-Google-Smtp-Source: ADFU+vuualpYOQw6rEp32Ouqr2sB1e7zLyk6l6RtfZWIicJH883ZIleH5bAUpRCRspDvex3tUpkStg==
X-Received: by 2002:a63:5506:: with SMTP id j6mr6339246pgb.43.1584670881865;
        Thu, 19 Mar 2020 19:21:21 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id v123sm3537228pfb.85.2020.03.19.19.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 19:21:21 -0700 (PDT)
Subject: Re: [PATCH 0/4] x86/Hyper-V: Panic code path fixes
To:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052F185AF4134EB2BB9ECBFD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <1d1bc90c-7fbe-6123-eeea-5f9a5aad77e4@gmail.com>
 <MW2PR2101MB10524F27F366005959A1007FD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <MW2PR2101MB1052A7AFC5222CC9D78FA77ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <66750077-bd3e-d24a-688c-f71c4eda30a3@gmail.com>
Date:   Fri, 20 Mar 2020 10:21:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052A7AFC5222CC9D78FA77ED7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 3/20/2020 12:07 AM, Michael Kelley wrote:
> From: Michael Kelley <mikelley@microsoft.com> Sent: Thursday, March 19, 2020 8:15 AM
>>
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Thursday, March 19, 2020 7:08 AM
>>>>>
>>>>> This patchset fixes some issues in the Hyper-V panic code path.
>>>>> Patch 1 resolves issue that panic system still responses network
>>>>> packets.
>>>>> Patch 2-3 resolves crash enlightenment issues.
>>>>> Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
>>>>> VM in order to report crash data or kmsg to host before running
>>>>> kdump kernel.
>>>>
>>>> I still see an issue that isn't addressed by these patches.  The VMbus
>>>> driver registers a "die notifier" and a "panic notifier".   But die() will
>>>> eventually call panic() if panic_on_oops is set (which I think it typically
>>>> is).  If the CRASH_NOTIFY_MSG option is *not* enabled, then
>>>> hyperv_report_panic() could get called by the die notifier, and then
>>>> again by the panic notifier.
>>>>
>>>> Do we even need the "die notifier"?  If it was removed, there would
>>>> not be any notification to Hyper-V via the die() path unless panic_on_oops
>>>> is set, which I think is actually the correct behavior.  I'm not
>>>> completely clear on what is supposed to happen in general to the
>>>> Linux kernel if panic_on_oops is not set. Does it try to continue to run?
>>>> If so, then we should not be notifying Hyper-V if panic_on_oops is not
>>>> set, and removing the die notifier is the right thing to do.
>>>>
>>>
>>> hyperv_report_panic() has re-enter check inside and so kernel only
>>> reports crash register data once during die().
>>
>> Ah, yes, you are right.
>>
>>>  From comment in the
>>> hyperv_report_panic(), register value reported in die chain is more
>>> exact than value in panic chain. The register value in die chain is
>>> passed by die() caller. Register value reported in panic chain
>>> is collected in the hyperv_panic_event().
>>>
>>> If panic_on_oops is not set, the task should be killed and kernel
>>> still runs. In this case, we may not trigger crash enlightenment.
>>
>> I'm not completely clear on your last statement.   It seems like there
>> is still a problem in that die() will call hyperv_report_panic() even if
>> panic_on_oops is not set.  We will have reported a panic to Hyper-V
>> even though the VM did not stop running.
>
Yes, the die callback is still necessary and we should skip report
if panic_on_oops isn't set.

> 
> There's one more issue to consider.  hv_kmsg_dump() skips calling
> hyperv_report_panic_msg() if sysctl_record_panic_msg has been cleared
> by a sysctl command.  (This sysctl option gives a customer the ability to
> increase privacy by not having the VM's dmesg contents sent to Hyper-V.)
> In this case, the earlier hyperv_report_panic() call should be used.  Otherwise,
> there would not be any notification to Hyper-V about the panic.
> 

Nice catch. I will fix this in the next version.

Thanks.


