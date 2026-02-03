Return-Path: <linux-hyperv+bounces-8668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPKRFMpKgWkPFgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8668-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 02:09:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B2D33CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 02:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5438301469D
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5541CDFD5;
	Tue,  3 Feb 2026 01:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TLOhY6kN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DCDE55C;
	Tue,  3 Feb 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080966; cv=none; b=qNrfFItqJ/CnSttPziSdALOslDG31OdQqTno25xiBMlx+r+SWdpF1UcFKnYogcxbxvKJoYZQAzM+kf5uVPrBDlPQVwolhjV9gS845pqdAYZcDUAnSX48x/7bt5WBSPFd6Cx/OXf7pm15uvPDmfJmKCpSXPj7K8hagPubkNWVfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080966; c=relaxed/simple;
	bh=rVoqY8w0KdII+Hl4TBJCfia0mji3VGvtYi+D9AvfzhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GReurVVhs0eWKkl6PQCie6XQ72fuek+xL3Fx24pUjWenG6FQ48zoQzARFm0FD01ucwNA52SIO5ypY7ENH9OicsA/RtO9V42Y7QcQyXuo/jpJjmxwDQeUg0mu1cAixJZlbuhy4/w4hP1FKmxyEtrF/8GfKrO0ZaL0mQpVzcvPXI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TLOhY6kN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id BE84920B7169;
	Mon,  2 Feb 2026 17:09:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BE84920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770080965;
	bh=ZEAEHiAm6IHJRHwaSyp3f2EMczOctMM1r1LqwEK06eo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TLOhY6kNF7ogkJVYPxMszyEl8lnVMvt/ExfwxWFbNuhWE7aZQ/Ii3fJhit6LPOm6J
	 kVjqYAB8GDTDzL8Ua7KzvFOx8XBtIeDO4VUoYDB4BvM7HDWhICUVI3BZ/mDy8pP1ho
	 6Nz0iUfrQ17IS32/9xLs4Tkdt5cZMHV3A8dRtE74=
Message-ID: <206e8499-9d7f-3ff4-f2cf-976a310525b1@linux.microsoft.com>
Date: Mon, 2 Feb 2026 17:09:23 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/1] mshv: Add comment about huge page mappings in guest
 physical address space
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 mhkelley58@gmail.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260202165101.1750-1-mhklinux@outlook.com>
 <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aYDcLRhxx9wXRXBG@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8668-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.microsoft.com,gmail.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C21B2D33CA
X-Rspamd-Action: no action

On 2/2/26 09:17, Stanislav Kinsburskii wrote:
> On Mon, Feb 02, 2026 at 08:51:01AM -0800, mhkelley58@gmail.com wrote:
>> From: Michael Kelley <mhklinux@outlook.com>
>>
>> Huge page mappings in the guest physical address space depend on having
>> matching alignment of the userspace address in the parent partition and
>> of the guest physical address. Add a comment that captures this
>> information. See the link to the mailing list thread.
>>
>> No code or functional change.
>>
>> Link: https://lore.kernel.org/linux-hyperv/aUrC94YvscoqBzh3@skinsburskii.localdomain/T/#m0871d2cae9b297fd397ddb8459e534981307c7dc
>> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
>> ---
>>   drivers/hv/mshv_root_main.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
>> index 681b58154d5e..bc738ff4508e 100644
>> --- a/drivers/hv/mshv_root_main.c
>> +++ b/drivers/hv/mshv_root_main.c
>> @@ -1389,6 +1389,20 @@ mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
>>   	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
>>   		return mshv_unmap_user_memory(partition, mem);
>>   
>> +	/*
>> +	 * If the userspace_addr and the guest physical address (as derived
>> +	 * from the guest_pfn) have the same alignment modulo PMD huge page
>> +	 * size, the MSHV driver can map any PMD huge pages to the guest
>> +	 * physical address space as PMD huge pages. If the alignments do
>> +	 * not match, PMD huge pages must be mapped as single pages in the
>> +	 * guest physical address space. The MSHV driver does not enforce
>> +	 * that the alignments match, and it invokes the hypervisor to set
>> +	 * up correct functional mappings either way. See mshv_chunk_stride().
>> +	 * The caller of the ioctl is responsible for providing userspace_addr
>> +	 * and guest_pfn values with matching alignments if it wants the guest
>> +	 * to get the performance benefits of PMD huge page mappings of its
>> +	 * physical address space to real system memory.
>> +	 */
> 
> Thanks. However, I'd suggest to reduce this commet a lot and put the
> details into the commit message instead. Also, why this place? Why not a
> part of the function description instead, for example?

Fwiw, I also prefer this in the function prologue. IMO, larger comments
belong outside the function rather than inside, unless of course cases
where it has to be that way. This makes functions easier to study.

Thanks,
-Mukesh



> Thanks,
> Stanislav
> 
>>   	return mshv_map_user_memory(partition, mem);
>>   }
>>   
>> -- 
>> 2.25.1


