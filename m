Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364F638E0D
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Nov 2022 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKYQF4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Nov 2022 11:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiKYQF4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Nov 2022 11:05:56 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 66B314C24F
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Nov 2022 08:05:55 -0800 (PST)
Received: from [192.168.1.10] (unknown [122.181.76.145])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9962420B6C40;
        Fri, 25 Nov 2022 08:05:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9962420B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669392355;
        bh=iGbzoNGwLRYVAvYzJMo77rkHiOHNmfadtGtT6UC2jxU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UdLFPU0eyCuLktJL7qt6HNZtcuRNOfOKFIzihV2quWOuISrOrLbzD5ofM0Rdtx52F
         zm8a8R2jlQ2hxRmwVa878R5gvs4VvYPWsNnG6lc0c8HGzOGHN16bU0TZzWkQjL7loo
         YR4LbBa0jcews7dhCR01LGseeuuhrL1oiUHeylO0=
Subject: Re: [PATCH] x86/hyperv: Remove unregister syscore call from hyperv
 cleanup
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-hyperv@vger.kernel.org, bp@alien8.de,
        mikelley@microsoft.com
References: <1669267391-9809-1-git-send-email-gauravkohli@linux.microsoft.com>
 <Y4DfOq94C4sPWM5+@liuwe-devbox-debian-v2>
 <a7689a77-ff0d-97c2-3938-9e6422ec069b@linux.microsoft.com>
 <Y4DmtKikFh5PqjtL@liuwe-devbox-debian-v2>
From:   Gaurav Kohli <gauravkohli@linux.microsoft.com>
Message-ID: <97cb8e12-3467-a93c-6a1a-c2a78f3f4dbc@linux.microsoft.com>
Date:   Fri, 25 Nov 2022 21:35:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <Y4DmtKikFh5PqjtL@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 11/25/2022 9:30 PM, Wei Liu wrote:
> On Fri, Nov 25, 2022 at 09:09:52PM +0530, Gaurav Kohli wrote:
>> On 11/25/2022 8:58 PM, Wei Liu wrote:
>>> On Wed, Nov 23, 2022 at 09:23:11PM -0800, Gaurav Kohli wrote:
>>>> Hyperv cleanup codes comes under panic path where preemption and irq
>>> Please use "Hyper-V" throughout.
>> Thanks for the comment, sure will do on v2.
>>>> is already disabled. So calling of unregister_syscore_ops which has mutex
>>>> from hyperv cleanup might schedule out the thread and never comes back.
>>>>
>>> While on paper this looks problematic -- have you seen this issue
>>> triggered in real life?
>>>
>>> This looks to be only triggered when there is another thread already
>>> holding the mutex, which seems rather rare in the life cycle of the
>>> machine?
>>
>> Earlier we also suspected the same that someone was holding the lock, but
>> actually there
>>
>> was no owner of lock and it got scheduled out due to might sleep code in
>> mutex_lock.
>>
>> Looks like where voluntary preemption config is on, there it is getting
>> scheduled out in might sleep.
> If there is only one CPU online and the mutex is free, then
> rescheduling will not have any adverse effect, right? Does it not get
> scheduled on the only available CPU and make further progress?

As this is in panic path where preemption and irq is disabled, so looks 
like it is not able

to schedule back to this cpu once scheduled out.

>> But there is no need of unregister_syscore_ops as this is in crash path
>> only, So removing the same.
> I'm not against removing it, but the reasoning left in the commit
> message and comment should reflect what happens.
thanks, will update the comment.
>
> Thanks,
> Wei.
