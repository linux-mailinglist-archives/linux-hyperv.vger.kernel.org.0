Return-Path: <linux-hyperv+bounces-8158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A8CF56A8
	for <lists+linux-hyperv@lfdr.de>; Mon, 05 Jan 2026 20:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A1DA3004EE7
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jan 2026 19:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BE30F94B;
	Mon,  5 Jan 2026 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Vl+5APro"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CA3C38;
	Mon,  5 Jan 2026 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642275; cv=none; b=IqJ/DzUhffW3hiJaYA9msIJDGzfuDnV1vRxFTfToPJZtEAUc4q4JLFhL8Er81bmwRazcqhtixuUqSnYXACSkz+f7SlAWPsT1IH7pBo99BXkZ7wOcT5+WZO4KFNTwokYZEL0IxEMF5AqKbFXg8LEICunQy3w2VQtdgE/7mz0Me2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642275; c=relaxed/simple;
	bh=/knI0EYepj2hCloVjmmx3+UNDBZ3a2Ke/CryExX3cnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaX8Za6qTswx+yXOZqXFGy8fAkjpbg42nRmrl7pEw4YQ46/MyRAr1mmv4g8k7JIvYUDYI6hu0wh+kfLXkeYrXNidr3ktiFnlgbch3W+xav7g9NNhWCdc2R36xMcoaFAl1ZqLTc8yI7sSRwRkkT09dWpGAM/sRELSYodaov4/gb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Vl+5APro; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11772212539B;
	Mon,  5 Jan 2026 11:44:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11772212539B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767642270;
	bh=0c3dGD1XxUWXlyiI5ux6YX6t5eJaycE75PolAV2dDpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vl+5APronuSmy07rKlyxwbFRzuerIOGe0G2UYPjdpJCcUEVuyDmacjPXc1L/cqQJ2
	 ictMrA7z63b/9OSvZYsaa+hLNyWW+UQyW8vHOLemNen6apUp+EG1ip4eNL/iqLJdRo
	 Yocz2Z6dHUM5ZHqy8Yjtbihi9n8Z0dplaXaHF0jM=
Message-ID: <f2bb047e-8b85-b37a-9418-ab5ed8728ac9@linux.microsoft.com>
Date: Mon, 5 Jan 2026 11:44:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 1/2] hyperv: add definitions for arm64 gpa intercepts
Content-Language: en-US
To: Anirudh Rayabharam <anirudh@anirudhrb.com>, vdso@mailbox.org
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260105122837.1083896-1-anirudh@anirudhrb.com>
 <20260105122837.1083896-2-anirudh@anirudhrb.com>
 <993970797.13531.1767629162352@app.mailbox.org>
 <atnnav7x4gzbeghpuh4fjpdig3i4zxzb56kpfvx3stgelajbm6@52lzmsycwzss>
From: mrathor <mrathor@linux.microsoft.com>
In-Reply-To: <atnnav7x4gzbeghpuh4fjpdig3i4zxzb56kpfvx3stgelajbm6@52lzmsycwzss>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 11:27, Anirudh Rayabharam wrote:
> On Mon, Jan 05, 2026 at 08:06:02AM -0800, vdso@mailbox.org wrote:
>>
>>> On 01/05/2026 4:28 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
>>>
>>
>> [...]
>>
>>>   
>>> +#if IS_ENABLED(CONFIG_ARM64)
>>> +union hv_arm64_vp_execution_state {
>>> +	u16 as_uint16;
>>> +	struct {
>>> +		u16 cpl:2; /* Exception Level (EL) */
>>
>> Anirudh,
>>
>> Appreciate following up on the CPL field in that ARM64 structure
>> and adding the comment!
> 
> My bad, actually I was gonna explain this in a reply to the previous
> thread but it slipped my mind.
> 
>>
>> Still, using something from the x86 parlance (CPL) and adding a comment
>> stating that this is actually ARM64 EL certainly needs an explanation
>> as to _why_ using an x86 term here is beneficial, why not just call
>> the field "el"? As an analogy, here is a thought experiment of writing
>>
>> #ffdef CONFIG_ARM64
>> u64 rax; /* This is X0 */
>> #endif
>>
>> where an x86 register name would be used to refer to X0 on ARM64, and
>> that doen't look natural.
> 
> Well, in this case neither CPL nor EL is an architecturally defined
> register name. These are just architectural concepts.
> 
>>
>> So far, I can't seem to find drawbacks in naming this field "el", only
>> benefits:
>> * ARM64 folks will immediately know what this field is, and
>> * the comment isn't required to explain the situation to the reader.
>>
>> Do you foresee any drawbacks of calling the field "el" and dropping
>> the comment? If you do, would these drawbacks outweigh the benefits?
> 
> As a general rule we want to keep these headers exactly same as the
> hypervisor headers so that we can directly ingest them at some point in
> the future.

Having said that, we've communicated the concern to the hyp team, and
there is no opposition to changing it. After the change is made on
that side, it will propagate to this side in future.

Thanks for your diligence.

-Mukesh



> I am not seeing a substantial benefit in breaking that rule. The CPL ->
> EL analogy is not a huge leap to make IMO and the comment helps. One
> could think of "current privilege level" as a generic term here.
> 
> Thanks,
> Anirudh.
> 
>>
>> [...]
>>
>> --
>> Cheers,
>> Roman


