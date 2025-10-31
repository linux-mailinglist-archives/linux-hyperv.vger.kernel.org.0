Return-Path: <linux-hyperv+bounces-7394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF4BC26D2E
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 20:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAF9D4EA1E1
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20D3314D02;
	Fri, 31 Oct 2025 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dxDfctlv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC14274B42;
	Fri, 31 Oct 2025 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940156; cv=none; b=ao+UQFTMluKNXofG+fAq44/wAMdDEltOLqzCLsyHoCcnu0la35NpVu+QzUIa7bBqXLcDrhBYo9tFHU0KaQZNBnSWOxtDfiucr5Yjzc1PWSwFjC+oG/MivPSJf2nHQ0vVK7AHui/2S3WRd6vzofw37CN6whC1u7YmF+jNl/JxiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940156; c=relaxed/simple;
	bh=huvcD6HQblCYH9tKumQU+KOTOATTW7f7xFYpdnBW7sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIOpqW9hvxooPsc6H5fnxYsCY9/WZjEWtiLP+aPw+2wezqfqMQttSV3xusSki9dWI3J3uwR2kOveTOGiiXAwFy5WoKn5b/LXLYfTZDTurjrBC+FW/Z/8dvr0+HusTcwxN+bu0bg/B+gYMyhlkiHUhv255/PUM6WSdbit6slHT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dxDfctlv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.255] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AD2E211D8DC;
	Fri, 31 Oct 2025 12:49:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AD2E211D8DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761940154;
	bh=xM3PEY5QxVmM9YoLt2SHtReJl4SeYau3QeL4aNz8w14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dxDfctlvddpZQ9KXqKAzlQp5ENPpwURhvBqmjamyNtZUCJL23sy1n2JXARNwIA1SA
	 r1MgZ3ll3oRX++60QtSVz0VzDUZi/0Vb9zPBl0yv1IFGtxY8JSOqhJZIvkBvoLcOpZ
	 V+VvTWhkmSIYOYrCfVD1CF/1y86jfFJseTzcySIk=
Message-ID: <ae9c0915-3472-4929-9bfa-866171d32758@linux.microsoft.com>
Date: Fri, 31 Oct 2025 12:49:12 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 muislam@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 mhklinux@outlook.com, skinsburskii@linux.microsoft.com,
 romank@linux.microsoft.com, Jinank Jain <jinankjain@microsoft.com>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
 <119f11e7-6074-4bd4-a72b-fc76370c284f@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <119f11e7-6074-4bd4-a72b-fc76370c284f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/2025 11:37 AM, Easwar Hariharan wrote:
> On 10/30/2025 2:40 PM, Nuno Das Neves wrote:
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
>>  include/uapi/linux/mshv.h   |  34 +++++++
>>  3 files changed, 272 insertions(+), 24 deletions(-)
> 
> lkp also pointed out that we are leaking a kernel config to userspace:
> https://lore.kernel.org/all/202510292330.LCHvPCLt-lkp@intel.com/
> 
> In the v3 that Wei requested, please address that as well.

Thanks, I did fix this issue in v2 but I didn't mention it explicitly.
I'll update the changelog in v3 to call it out.

> 
> Thanks,
> Easwar (he/him)
> 
> <snip>


