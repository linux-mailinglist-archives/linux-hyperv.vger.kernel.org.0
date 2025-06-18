Return-Path: <linux-hyperv+bounces-5958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10C6ADF53A
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EB51BC0761
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 17:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341D2F3C3F;
	Wed, 18 Jun 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YNMZ1E/N"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9313085A6;
	Wed, 18 Jun 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269470; cv=none; b=h+i+wzCrhzH2HFTk8vgvCT+PPccWfzz7MUNTQGXE0dG0jP7W8S+cY6JI3id4bScmsjCEG9yWoT/AAHA63bqh8faNOtsD0jDWRVMN+Ea5llCEsdwx14N8olmgpM+KLHQ0Oc29BF4Bjd8jY5gu38ww3FKDvTX7tEeAx8d0+CWA+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269470; c=relaxed/simple;
	bh=VHWpHqNeE+SKQMKcWuOQRBsppipjRfLdmgldY+Vp3lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5DAiM0kjZPh4pdStiwj81GOZCx2oRiRWqvf82WsjeO3oH0/SOZdDsgIke5KXuyw+h7dApmNjOrva4XtYHbJ1tto3wnOVZsPbJDNoK7dLls5OrLXy2jpcpOstAH0n3yck7YMnjbnXpb24DXRD48cX+m8mSlsqMVYB5S7enCgrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YNMZ1E/N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0919D201C77F;
	Wed, 18 Jun 2025 10:57:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0919D201C77F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750269468;
	bh=r0yXO5WKMtf/RbA0D78yHpcsjqHvAhoAVEOtzAC/jPY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YNMZ1E/Nk9DTKlQqpD5ZXxizjzYI42bYzR8A11MDi46jt5unNsGa46e2K6dxCZMXz
	 vn5GTQr067Iv+0A6vVey0uWLO0JXRxoUJUVBvTSE6dD2kDSZS9yy6ojZiw4U5Gwobu
	 3n/8ggSZ85M/0bzIBFTOxHFHUWWm187SV28xKxHo=
Message-ID: <bf0575c7-f78a-458c-b905-7baa7347c03f@linux.microsoft.com>
Date: Wed, 18 Jun 2025 10:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp
 UUID
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, mark.rutland@arm.com
References: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
 <20250610160656.11984-1-romank@linux.microsoft.com>
 <aFKu9TFA6oj1N2cR@anirudh-surface.localdomain>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aFKu9TFA6oj1N2cR@anirudh-surface.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/18/2025 5:20 AM, Anirudh Rayabharam wrote:
> On Tue, Jun 10, 2025 at 09:06:48AM -0700, Roman Kisel wrote:
>>> (sorry for the delay, found the patch in the spam 🙁)
>>
>> "b4" shows the the mail server used for the patch submission
>> doesn't pass the DKIM check, so finding the patch in the spam seems
> 
> How do you check this? I mean, what b4 command do you run?
> 
> I think it should be fix now. Let's see...


"b4 am" was showing the failed DKIM check, and all good now!

| $ b4 am 20250521094049.960056-1-anirudh@anirudhrb.com
|
| Grabbing thread from 
lore.kernel.org/all/20250521094049.960056-1-anirudh@anirudhrb.com/t.mbox.gz
| Analyzing 7 messages in the thread
| Looking for additional code-review trailers on lore.kernel.org
| Checking attestation on all messages, may take a moment...
| ---
|   ✓ [PATCH] firmware: smccc: support both conduits for getting hyp UUID
|     + Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
|     + Tested-by: Roman Kisel <romank@linux.microsoft.com> (✓ 
DKIM/linux.microsoft.com)
|     + Reviewed-by: Roman Kisel <romank@linux.microsoft.com> (✓ 
DKIM/linux.microsoft.com)
|   ---
|   ✓ Signed: DKIM/anirudhrb.com
| ---
| Total patches: 1
| ---
|  Link: 
https://lore.kernel.org/r/20250521094049.960056-1-anirudh@anirudhrb.com
|  Base: applies clean to current tree
|        git checkout -b 20250521_anirudh_anirudhrb_com HEAD
|        git am 
./20250521_anirudh_firmware_smccc_support_both_conduits_for_getting_hyp_uuid.mbx
|


[...]
>> Anirudh had been OOF for some time and would be for another
>> week iiuc so I thought I'd reply.
> 
> Thanks Roman!

My pleasure :)

> 
> Regards,
> Anirudh
> 
>>
>> The patch this depends on is 13423063c7cb
>> ("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID"),
>> and this patch has already been pulled into the Linus'es tree.
>>
>> As for routing, (arm-)soc should be good it appears as the change
>> is contained within the firmware drivers path. Although I'd trust more to your,
>> Arnd's or Wei's opinion than mine!
>>
>>>
>>> --
>>> Regards,
>>> Sudeep

-- 
Thank you,
Roman


