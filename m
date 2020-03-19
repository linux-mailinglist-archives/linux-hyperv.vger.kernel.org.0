Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB3E18AE42
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2020 09:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSIYV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Mar 2020 04:24:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42188 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSIYV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Mar 2020 04:24:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so862500pgs.9;
        Thu, 19 Mar 2020 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XvsrEbF8xrvFrxkOmbaObXzMDRIRtTUFbRE8kMKL+mc=;
        b=SC7aMPeVpiaTGPI8CivsJotSRGwHhkm8so60m8Zguy01Of7Lz84x2/CPJOtgWGG5Ak
         r+TEqhmvyHHAEFbguxLx9eCWiiW3d0eLgCZSDZCGVK2UzZvidaM0laEG+n+AeYRmS9/8
         dQPVQwWlVuDbjWTldq3HIoWCcWjecUTFij8mszqKXzPm7nbBTaUIBAzmthZGkbbo3O47
         mLuL8Mbx/w9pY4aXYlm+9yNsUO85/N7DxYQHBTvemaF3FnnmlPhJZihHGAKfUbSefUfX
         SmtVW5sFKF976LzyXwOXdAImy6DSu1AWqHpRGSB+co9b4ZXXaT5PvGgur2DlakIohbqg
         eEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XvsrEbF8xrvFrxkOmbaObXzMDRIRtTUFbRE8kMKL+mc=;
        b=FsqpCVwgA6SpyDd2RFFJEsci+K0Rg/vxzmKcu6WEm6d7yDhtW/9qJaAzv0Ft8oPWl6
         JjiSRuVFzaa0SifIKJpw3lfKEIJ09tluhABAVj/GNbuOVG5jWQUnP+rbsSHW5pJGDM39
         7yjuOh5oxfJ9UMz3xqjW1VJ3jbGTcpD3sW1qOaBZ5rB54HbSRBXGrLdTKSfDtG/pYK4a
         uvIC2imJ/7cwfcQ7zMCMKoFalLWEmkS3N20MoJ6r2H1sd+Nwyg5j992l+ArF1JQinbcQ
         kCW4ioO166dr+fsQowCgBbJJGpEvTMatTs70jGOJ8X692d37PxvRcsT6oQ6CqD6WrndR
         seYA==
X-Gm-Message-State: ANhLgQ2X5ap2kEugdFjiFIR6jLNgMFwbQiYOpG3YkwS6Wl0shgKsgo9G
        U47h8jxS/H73XrG7ASApkuIZ3pYv
X-Google-Smtp-Source: ADFU+vscUUIkItJKYr8NScV0txk2GFY9ez92M0zablKilI0FdURxoMHyq00OdzpdoKDegWe3eax8Zg==
X-Received: by 2002:aa7:91c7:: with SMTP id z7mr2767320pfa.237.1584606259683;
        Thu, 19 Mar 2020 01:24:19 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
        by smtp.gmail.com with ESMTPSA id l6sm1366180pff.173.2020.03.19.01.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 01:24:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] x86/Hyper-V: Unload vmbus channel in hv panic
 callback
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
 <20200317132523.1508-2-Tianyu.Lan@microsoft.com>
 <20200317173553.jerf6gjtaotqjbac@debian>
From:   Tianyu Lan <ltykernel@gmail.com>
Message-ID: <d00f5535-d498-058e-d529-11dfec976454@gmail.com>
Date:   Thu, 19 Mar 2020 16:24:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317173553.jerf6gjtaotqjbac@debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 3/18/2020 1:35 AM, Wei Liu wrote:
> On Tue, Mar 17, 2020 at 06:25:20AM -0700, ltykernel@gmail.com wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> Customer reported Hyper-V VM still responded network traffic
>> ack packets after kernel panic with kernel parameter "panic=0”.
>> This becauses vmbus driver interrupt handler still works
>> on the panic cpu after kernel panic. Panic cpu falls into
>> infinite loop of panic() with interrupt enabled at that point.
>> Vmbus driver can still handle network traffic.
>>
>> This confuses remote service that the panic system is still
>> alive when it gets ack packets. Unload vmbus channel in hv panic
>> callback and fix it.
>>
>> vmbus_initiate_unload() maybe double called during panic process
>> (e.g, hyperv_panic_event() and hv_crash_handler()). So check
>> and set connection state in vmbus_initiate_unload() to resolve
>> reenter issue.
>>
>> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
>> ---
>>   drivers/hv/channel_mgmt.c |  5 +++++
>>   drivers/hv/vmbus_drv.c    | 17 +++++++++--------
>>   2 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
>> index 0370364169c4..893493f2b420 100644
>> --- a/drivers/hv/channel_mgmt.c
>> +++ b/drivers/hv/channel_mgmt.c
>> @@ -839,6 +839,9 @@ void vmbus_initiate_unload(bool crash)
>>   {
>>   	struct vmbus_channel_message_header hdr;
>>   
>> +	if (vmbus_connection.conn_state == DISCONNECTED)
>> +		return;
>> +
>>   	/* Pre-Win2012R2 hosts don't support reconnect */
>>   	if (vmbus_proto_version < VERSION_WIN8_1)
>>   		return;
>> @@ -857,6 +860,8 @@ void vmbus_initiate_unload(bool crash)
>>   		wait_for_completion(&vmbus_connection.unload_event);
>>   	else
>>   		vmbus_wait_for_unload();
>> +
>> +	vmbus_connection.conn_state = DISCONNECTED;
> 
> This is only set at the end of the function.  I don't see how this solve
> the re-entrant issue with the check at the beginning. Do I miss anything
> here?
> 

For this issue, vmbus_initiate_unload() maybe called on the panic vcpu
twice and so just split check and set conn_state.

> Maybe this function should check and set the state to
> DISCONNECTING/DISCONNECTED at the beginning of this function?
> 
Yes, Vitaly also gave suggestion to use "xchg" to check and set
conn_state. Will update in the next version.
