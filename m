Return-Path: <linux-hyperv+bounces-7395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A14C26DE3
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 21:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CD742755C
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 20:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDC531B83B;
	Fri, 31 Oct 2025 20:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gsnc0Mk6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7D9283FD6;
	Fri, 31 Oct 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761941329; cv=none; b=DlAEflhhg0kacJht0N870nmlJjIXQnGBSp2tB7sJu0HUKdYX+Z3oziUk0NbAyXY6cpUqvVYPh7dpTop4OMnkLWS9h+RgEFOpkeLO3eF7TcPflTAk+f8SxRqNFoA8Vz3b8B7vRGXCqPpjfpkzUFFW5aCHh0SOzILuXOYhCygn50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761941329; c=relaxed/simple;
	bh=EL9F5S97G8vzOhU7NaniWA8pefyRkwTlhmtrIPEmZkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTPVMKvjboMwYgYNL/KGEPAhobIATMhMvvhnXra7w3uLQ6wmDZ+er1QxLiRhB7B6WBOumSMJEqjZgc0LzobVPmv0WTOVVQi6L3l7sQfs5NJXsjbwgnb3FvkdR/wcS5iKFfxasPyZsxoqYBX8ISVOVehIjlKpa4bZsrI7m+/kUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gsnc0Mk6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.255] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 64F7C211E344;
	Fri, 31 Oct 2025 13:08:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 64F7C211E344
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761941327;
	bh=Gx6AHsv91Sdxbg2gKThn+6GlZSNoLXafPPqn8huw99U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gsnc0Mk6Km5YrmgBqXpgeCXSQQaYnG/jOX5jWeWpWFyThBs5Cpg4S/DaIEnWczYMG
	 utg2babT7haTySlZoEYHQxTBoiUC5Daqmwhk5QtBZok3yqzwiecxnc4NeVEUdbgr9Q
	 kuxiXBiT0MCddXLuPk0QM89t7wXgq+HL84EFHHJA=
Message-ID: <28ab51c0-fe14-4122-8828-3f680207865d@linux.microsoft.com>
Date: Fri, 31 Oct 2025 13:08:45 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 muislam@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
 skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
 Jinank Jain <jinankjain@microsoft.com>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20251031183109.GC2612078@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251031183109.GC2612078@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/2025 11:31 AM, Wei Liu wrote:
> On Thu, Oct 30, 2025 at 02:40:31PM -0700, Nuno Das Neves wrote:
>> From: Muminul Islam <muislam@microsoft.com>
>>
>> The existing mshv create partition ioctl does not provide a way to
>> specify which cpu features are enabled in the guest. This was done
>> to reduce unnecessary complexity in the API.
>>
>> However, some new scenarios require fine-grained control over the
>> cpu feature bits.
>>
>> Define a new mshv_create_partition_v2 structure which supports passing
>> through the disabled cpu flags and xsave flags to the hypervisor
>> directly.
>>
>> When these are not specified (pt_num_cpu_fbanks == 0) or the old
>> structure is used, define a set of default flags which cover most
>> cases.
>>
>> Retain backward compatibility with the old structure via a new flag
>> MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables the new struct.
>>
>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>> Changes in v2:
>> - Fix compilation issues [kernel test robot]
>>
>> ---
>>  drivers/hv/mshv_root_main.c | 176 ++++++++++++++++++++++++++++++++----
>>  include/hyperv/hvhdk.h      |  86 +++++++++++++++++-
> 
> There is no mention of updating hvhdk.h in the commit message.
> 
Ah, that's true..

> Can you split out this part to a separate commit?

I put the header changes in this patch because a patch containing
those alone doesn't have much merit on its own.

I know we have split header changes into separate patches in the
past but I'm not sure it's always the right choice.

Thinking about this, I could also split it up another way: one
patch to introduce the new cpu features flags and use them in the
driver, and one patch to introduce mshv_create_partition_v2.

Nuno> 
> Wei


