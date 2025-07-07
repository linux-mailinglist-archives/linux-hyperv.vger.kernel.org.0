Return-Path: <linux-hyperv+bounces-6132-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4700AFBA90
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC9B1AA6CDA
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2557E2620FC;
	Mon,  7 Jul 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CpyYx8G/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94523202F7C;
	Mon,  7 Jul 2025 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912360; cv=none; b=RyrdB8Lp8Iv9AjYgoeurTr18IJKs4KAhFiYPV36FDSUFzvYkONkCu2zEDaEYOqa4ZCxx6sYpiK+34x3TG6BdJONXI9Ja6V7QpLi69b/johLko+DYjIO8dsrSmHI/eNGfSjn4BeSJXaSDRDv/n9IS/mtCeB7T2y7MmBEZM4WwG1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912360; c=relaxed/simple;
	bh=AlyWUUk45lzlF6FtNE/K0HgamLakRdcRf91Z+Ag8wig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFoYKawn8TxE76grDQE2RIBokUT80BihbkAh1gWveQXhrcAD83mGt96Z0Wai6htUwOayvWLyD6sV6oNuj2hXTEZpNSrPDks65+WP5S5opVLT40AW3LLGRf/v0+a60C3jK7blJnWW2bLGp4w/EO6V8Ptd/w1V7rwLbynFV/OeEX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CpyYx8G/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.225.228] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A63D201B1B2;
	Mon,  7 Jul 2025 11:19:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A63D201B1B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751912358;
	bh=Q/ovB6qLqPcbU35wCDWCKviOzlbLO2oERbjs1l8pv6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CpyYx8G/9r/8bn4VodiaCI2P12/6dv11eleUchaoxBXdjDQ01msSZaylE/Bo6gGzz
	 6VeCoKMY9PpTKKgnOMalPuXtYyHSPzr0sYbhdR9bNt+aze5B+LdVt+3QsZxU67WTk+
	 MYhKF3msWtcsyCOQlunmo7uie2NVGJBdGfCKVaas=
Message-ID: <32b541e0-bc5f-485a-bfe4-190519b4c150@linux.microsoft.com>
Date: Mon, 7 Jul 2025 11:19:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] Drivers: hv: Use nested hypercall for post message
 and signal event
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "romank@linux.microsoft.com" <romank@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "x86@kernel.org" <x86@kernel.org>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1751582677-30930-3-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41576CBCA98ECA4C77BCC2D7D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576CBCA98ECA4C77BCC2D7D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/2025 8:13 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, July 3, 2025 3:45 PM
>>
>> When running nested, these hypercalls must be sent to the L0 hypervisor
>> or VMBus will fail.
>>
>> Remove hv_do_nested_hypercall() and hv_do_fast_nested_hypercall8()
>> altogether and open-code these cases, since there are only 2 and all
>> they do is add the nested bit.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>  arch/x86/include/asm/mshyperv.h | 20 --------------------
>>  drivers/hv/connection.c         |  7 +++++--
>>  drivers/hv/hv.c                 |  6 ++++--
>>  3 files changed, 9 insertions(+), 24 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 5ec92e3e2e37..e00a8431ef8e 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -111,12 +111,6 @@ static inline u64 hv_do_hypercall(u64 control, void *input,
>> void *output)
>>  	return hv_status;
>>  }
>>
>> -/* Hypercall to the L0 hypervisor */
>> -static inline u64 hv_do_nested_hypercall(u64 control, void *input, void *output)
>> -{
>> -	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
>> -}
>> -
>>  /* Fast hypercall with 8 bytes of input and no output */
>>  static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
>>  {
>> @@ -164,13 +158,6 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
>>  	return _hv_do_fast_hypercall8(control, input1);
>>  }
>>
>> -static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
>> -{
>> -	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
>> -
>> -	return _hv_do_fast_hypercall8(control, input1);
>> -}
>> -
>>  /* Fast hypercall with 16 bytes of input */
>>  static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
>>  {
>> @@ -222,13 +209,6 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
>>  	return _hv_do_fast_hypercall16(control, input1, input2);
>>  }
>>
>> -static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u64 input2)
>> -{
>> -	u64 control = (u64)code | HV_HYPERCALL_FAST_BIT | HV_HYPERCALL_NESTED;
>> -
>> -	return _hv_do_fast_hypercall16(control, input1, input2);
>> -}
>> -
>>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>>
>>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
>> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
>> index be490c598785..47c93cee1ef6 100644
>> --- a/drivers/hv/connection.c
>> +++ b/drivers/hv/connection.c
>> @@ -518,8 +518,11 @@ void vmbus_set_event(struct vmbus_channel *channel)
>>  					 channel->sig_event, 0);
>>  		else
>>  			WARN_ON_ONCE(1);
>> -	} else {
>> -		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
>> +	} else if (hv_nested) {
> 
> As coded, this won't make any hypercall for the non-nested case.
> The "else if (hv_nested)" should be just "else".

Ah, forgot to change this line. Thank you for catching it

Nuno

> 
> Michael
> 
>> +		u64 control = HVCALL_SIGNAL_EVENT;
>> +
>> +		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
>> +		hv_do_fast_hypercall8(control, channel->sig_event);
>>  	}
>>  }
>>  EXPORT_SYMBOL_GPL(vmbus_set_event);
>> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
>> index 308c8f279df8..b14c5f9e0ef2 100644
>> --- a/drivers/hv/hv.c
>> +++ b/drivers/hv/hv.c
>> @@ -85,8 +85,10 @@ int hv_post_message(union hv_connection_id connection_id,
>>  		else
>>  			status = HV_STATUS_INVALID_PARAMETER;
>>  	} else {
>> -		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
>> -					 aligned_msg, NULL);
>> +		u64 control = HVCALL_POST_MESSAGE;
>> +
>> +		control |= hv_nested ? HV_HYPERCALL_NESTED : 0;
>> +		status = hv_do_hypercall(control, aligned_msg, NULL);
>>  	}
>>
>>  	local_irq_restore(flags);
>> --
>> 2.34.1


