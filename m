Return-Path: <linux-hyperv+bounces-7393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D644C269DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 19:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB15C1A65E99
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 18:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA92EB840;
	Fri, 31 Oct 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cVGeyDc/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430FA2F12B0;
	Fri, 31 Oct 2025 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935872; cv=none; b=KvST978PGhOifyOkJDCyWk8/4G61Clvga/EXOsTkIkeTpTBElI4Vi1pWCrQMWvNAaSjkJAaTPph+7FNaiNBRuCaE9hwDD3SsiU9IahmNZejfow0Dk2Dt1MiNvlq9IPo8/0QvI+FncrM4L2/QeTLELcTfy3/Hb8pXvlyklumhPcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935872; c=relaxed/simple;
	bh=S84aBI11Cwi78Sh4CoE5/xqmzTnuFt8l0phxn1A7lHE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nEyXZFdcCCh+UV4mVnOqaCEzKcLVZD3kwc1uZGusxraNYBku9NEF66eaNbkj/+ZXNWJkW+ndMDK7BX/p3QSBNyom5J46taLUAy5TgH8DZCA6nDRv7F6VIKRczR4fr7tez6/vaYbhxLSEr2NGF93rJS9hwcCoyPVyFNNkxUEJHbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cVGeyDc/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A7C6211E340;
	Fri, 31 Oct 2025 11:37:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A7C6211E340
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761935870;
	bh=hAeSnh+PBTwEDF8TLrXRk+JviRX/cs7c9zxiIq3XKME=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cVGeyDc/vnRaIrSL8+PA/ydyTFRoG8DsE9kwsNxoYLvt93cC80unoh3Hu2Rrw4+cj
	 iPSiQNqZ98bJsMV59OtP2OUb5HF/oSg+81h/z+WMGHx/xfhJKpKNJ3fSYDd10XKqK2
	 4X0dbZTF/pcmDawRIaEPCJBd+ivVJA7krwfnhDDQ=
Message-ID: <119f11e7-6074-4bd4-a72b-fc76370c284f@linux.microsoft.com>
Date: Fri, 31 Oct 2025 11:37:40 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 muislam@microsoft.com, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
 skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
 Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/2025 2:40 PM, Nuno Das Neves wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. This was done
> to reduce unnecessary complexity in the API.
> 
> However, some new scenarios require fine-grained control over the
> cpu feature bits.
> 
> Define a new mshv_create_partition_v2 structure which supports passing
> through the disabled cpu flags and xsave flags to the hypervisor
> directly.
> 
> When these are not specified (pt_num_cpu_fbanks == 0) or the old
> structure is used, define a set of default flags which cover most
> cases.
> 
> Retain backward compatibility with the old structure via a new flag
> MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables the new struct.
> 
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v2:
> - Fix compilation issues [kernel test robot]
> 
> ---
>  drivers/hv/mshv_root_main.c | 176 ++++++++++++++++++++++++++++++++----
>  include/hyperv/hvhdk.h      |  86 +++++++++++++++++-
>  include/uapi/linux/mshv.h   |  34 +++++++
>  3 files changed, 272 insertions(+), 24 deletions(-)

lkp also pointed out that we are leaking a kernel config to userspace:
https://lore.kernel.org/all/202510292330.LCHvPCLt-lkp@intel.com/

In the v3 that Wei requested, please address that as well.

Thanks,
Easwar (he/him)

<snip>

