Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3047A18B8A9
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSOIQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 10:08:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33852 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgCSOIQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 10:08:16 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so2355121pje.1;
        Thu, 19 Mar 2020 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O7Q51zmRS7g4gxwj7MQtP4qiQBx0T9QoIdivgK4vLVI=;
        b=JRl6HA2/zf7Vvf60cE21OWI9S0qRbhP70JRWPmuedNCx8LrcCrszbNh4+ftzFYTmiI
         u5qM7hDwCykZmR4fwobtn0fOIN13LN3lBb71h9cICv3eUixaJFZwhjXjuomMhppv6Woz
         ddR4Gmd3UmY9wg2zTq+PrcuF64C2ZP/51WzGe/413gChPM7GHzC4AtOYQ6kCXzHOabex
         Sh+4TbPDJTkEWkgU30FR4mDdy05ZN6Us0fokChT6CY0ZqbzJWH9fXgAMtT6yvynQkiMF
         EsFbg4yrkS+sxTYH6J+zydRLLb4/Lfs+Jj1yCmEwgjbhH9UoXdBzuSznM8L3Rm0a/MRc
         tQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7Q51zmRS7g4gxwj7MQtP4qiQBx0T9QoIdivgK4vLVI=;
        b=igbPDBvUn6MeGTIiKTy+waY4/6MGdILJeJCI5LqfuQiXnblbZ3J6Zgv4z1HeivXlCg
         qD+xXhAbDveGjsKKgGuVcltg+zyGS9Ee+O8GZmuWrkFrf1lgdQ4xTMNq8xyTg1v8TkFR
         LUT/sDKpk8Rkne238GZuBN1+hqS6UIS7zUPPbD9vCaj/fS1Ptk5Dhxc3lk949ch5Yjnz
         pyMCdrtd1E5jgUKTwdBKOcPV4mimHm2AojcdcdsNQiU9vNpYSGhYV0Hmed+K3Lf8smot
         BHgHX4ur73lvOLLAFs5L0g8jysn+sxGoh/8gulH9mVEvcWf0q3Jo3Yk2mbFcUdM31omZ
         Ea2A==
X-Gm-Message-State: ANhLgQ0hDLH8Q4PYMsdp+A2QRLwiRbPnpBSCD6utSugtv34+sCuEicOn
        0eFbPvxB+KAOkLVu6Aq3XD0=
X-Google-Smtp-Source: ADFU+vt3Uom3z61eXimWi6EYH31AV5srNGn4SND8daBCtBbNg5Si/yyHZbXUD35dwdCBvZjiBbe1KQ==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr3682951plz.125.1584626894899;
        Thu, 19 Mar 2020 07:08:14 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id l11sm2434715pjy.44.2020.03.19.07.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:08:14 -0700 (PDT)
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
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <1d1bc90c-7fbe-6123-eeea-5f9a5aad77e4@gmail.com>
Date:   Thu, 19 Mar 2020 22:08:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1052F185AF4134EB2BB9ECBFD7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Michael:
      Thanks for your review.

On 3/19/2020 8:57 AM, Michael Kelley wrote:
> From: ltykernel@gmail.com <ltykernel@gmail.com> Sent: Tuesday, March 17, 2020 6:25 AM
>>
>> This patchset fixes some issues in the Hyper-V panic code path.
>> Patch 1 resolves issue that panic system still responses network
>> packets.
>> Patch 2-3 resolves crash enlightenment issues.
>> Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
>> VM in order to report crash data or kmsg to host before running
>> kdump kernel.
> 
> I still see an issue that isn't addressed by these patches.  The VMbus
> driver registers a "die notifier" and a "panic notifier".   But die() will
> eventually call panic() if panic_on_oops is set (which I think it typically
> is).  If the CRASH_NOTIFY_MSG option is *not* enabled, then
> hyperv_report_panic() could get called by the die notifier, and then
> again by the panic notifier.
> 
> Do we even need the "die notifier"?  If it was removed, there would
> not be any notification to Hyper-V via the die() path unless panic_on_oops
> is set, which I think is actually the correct behavior.  I'm not
> completely clear on what is supposed to happen in general to the
> Linux kernel if panic_on_oops is not set. Does it try to continue to run?
> If so, then we should not be notifying Hyper-V if panic_on_oops is not
> set, and removing the die notifier is the right thing to do.
> 

hyperv_report_panic() has re-enter check inside and so kernel only 
reports crash register data once during die(). From comment in the
hyperv_report_panic(), register value reported in die chain is more
exact than value in panic chain. The register value in die chain is
passed by die() caller. Register value reported in panic chain
is collected in the hyperv_panic_event().


If panic_on_oops is not set, the task should be killed and kernel
still runs. In this case, we may not trigger crash enlightenment.



> Michael
> 
>>
>> Tianyu Lan (4):
>>    x86/Hyper-V: Unload vmbus channel in hv panic callback
>>    x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
>>    x86/Hyper-V: Trigger crash enlightenment only once during  system
>>      crash.
>>    x86/Hyper-V: Report crash register data or ksmg before running crash
>>      kernel
>>
>>   arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
>>   drivers/hv/channel_mgmt.c      |  5 +++++
>>   drivers/hv/vmbus_drv.c         | 35 +++++++++++++++++++++++++----------
>>   3 files changed, 40 insertions(+), 10 deletions(-)
>>
>> --
>> 2.14.5
> 
