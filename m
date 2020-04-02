Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B196419C170
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2020 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgDBMvK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 08:51:10 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34677 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgDBMvK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 08:51:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so1721562pfj.1;
        Thu, 02 Apr 2020 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6/nWoRvmCe8w3U/nkA8FUKN/5D+Y/S7xThy2DIwl4ck=;
        b=McTkrTjEtMRWK0fIQdesQ2rsYWNg49LLQuiXS4hSABxLsqa0USR11B0M+w8w1tZc2K
         zW5N43j9kjwFwK53/IOQqEW8JF4nOLnv2WGsjWKyfWjqqea+J8DQUFrDAjVxdmra5hjr
         Njwu9NVzilWhmlSRZ8Wz/QTc/gZpwp9a606vm19npi+GU9g+vnALciIZhheZeR1OWanu
         zuzsUtxvAYgTRBlvJ1YhX8Hyn+T+3aam8IWHPfznL9ualr8qF+7rdLWCPtAWxNK4fQ09
         o8YnY5KsT3PUWrdCqbXLUYQM3hbJIaIfz2fItFW8fymPTnKPmI4PCJM4QtADxQz1gv7g
         MGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6/nWoRvmCe8w3U/nkA8FUKN/5D+Y/S7xThy2DIwl4ck=;
        b=i/x040Q0Xr+Tki2g6PC0zvn2ZEh+nYTVq3dH/1K+rjlrwZOkkc2FC9SbWQ4UscT7DA
         u1Y3XL0B4KiHrTRzaz0qgBYcV/ViLa0XNJttMv2/VClp/IxCo60virFLrEV04W9QZ9kr
         NN7FFxVyUVFyHXM72zujYyGk1IeQS/1ROA411GRFA081epmJiLnnFa6SYnUsymcV6BeQ
         wqY5/Pge/VanWCQpi9FOV4NOIZBElgEcITzrv+o9zf0sUKchveluG3eqzJ4SNCh9SA5r
         5AGagqk7J7at+Ap81Fqaq/ns89HyYBgXKbLktFfjTmnaVkSTl3WEvjpmBcy+NNWPw3BC
         xD4w==
X-Gm-Message-State: AGi0PuZjG/n6OqeI6rJMH+rXZ4/wC0o4Tnu+F7cH2u/ItuSVNU2Jon9S
        0INwunl5NQqgx7aYULqa7mo=
X-Google-Smtp-Source: APiQypJnJJoVs/cGvhRNyEmFUyU9+jjwcXiY5Svk8lisjjpi8LrjpiJBjfmpN/f7+PqjpWe66gRSew==
X-Received: by 2002:aa7:870b:: with SMTP id b11mr3069588pfo.134.1585831868842;
        Thu, 02 Apr 2020 05:51:08 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id w16sm3758652pfj.79.2020.04.02.05.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:51:08 -0700 (PDT)
Subject: Re: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
References: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
 <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1052A8FEF85F381B3EAF7D36D7C80@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <9eb81216-8e00-64e5-ab1c-b363983b245e@gmail.com>
 <20200401185336.fsnwxejwn3nd5lhx@debian>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <634f84e8-01ce-5fa1-5b60-f7be7c4513cd@gmail.com>
Date:   Thu, 2 Apr 2020 20:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401185336.fsnwxejwn3nd5lhx@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 4/2/2020 2:53 AM, Wei Liu wrote:
> On Tue, Mar 31, 2020 at 10:26:06PM +0800, Tianyu Lan wrote:
>>
>>
>> On 3/31/2020 9:51 PM, Michael Kelley wrote:
>>> From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 31, 2020 12:39 AM
>>>>
>>>> When oops happens with panic_on_oops unset, the oops
>>>> thread is killed by die() and system continues to run.
>>>> In such case, guest should not report crash register
>>>> data to host since system still runs. Fix it.
>>>>
>>>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>>> ---
>>>> Change since v3:
>>>> 	Fix compile error
>>>> ---
>>>>    drivers/hv/vmbus_drv.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>>> index 172ceae69abb..4bc02aea2098 100644
>>>> --- a/drivers/hv/vmbus_drv.c
>>>> +++ b/drivers/hv/vmbus_drv.c
>>>> @@ -31,6 +31,7 @@
>>>>    #include <linux/kdebug.h>
>>>>    #include <linux/efi.h>
>>>>    #include <linux/random.h>
>>>> +#include <linux/kernel.h>
>>>
>>> Unfortunately, adding the #include doesn't solve the problem.  The error occurs when
>>> CONFIG_HYPERV=m, because panic_on_oops is not exported.  I haven't thought it
>>> through, but hopefully there's a solution where panic_on_oops can be tested in
>>> hyperv_report_panic() or some other Hyper-V specific function that's never in a
>>> module, so that we don't need to export panic_on_oops.
>>
>> Yes, I don't consider modules case. I think we may introduce a check
>> function of panic_on_oops in the mshyperv.c and expose it to module.
>>
> 
> Why expose something new? You can just test panic_on_oops in
> hyperv_report_panic and bail if it is false, right?
> 
> Something like the following (not compiled) diff:
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b0da5320bcff..0dc229a9142c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -424,6 +424,9 @@ void hyperv_report_panic(struct pt_regs *regs, long err)
>          static bool panic_reported;
>          u64 guest_id;
> 
> +       if (!panic_on_oops)
> +               return;
> +
>          /*
>           * We prefer to report panic on 'die' chain as we have proper
>           * registers to report, but if we miss it (e.g. on BUG()) we need
> 
> I haven't checked all the error reporting paths and don't know if this
> works or not though.

Hi Wei:
     hyperv_report_panic() is also called in panic() which may not be
triggered by die(). In these cases, we still need to report crash
register data to host even when panic_on_oops is unset.
     Another approach is to add new parameter "in_die" for
hyperv_report_panic() and just check panic_on_oops when the function is
called in die notifier callback and "in_die" is set to true.
