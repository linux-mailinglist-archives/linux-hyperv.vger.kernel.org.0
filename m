Return-Path: <linux-hyperv+bounces-7640-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A284C65906
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3F0D729204
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BFB308F27;
	Mon, 17 Nov 2025 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XJ5nLYrk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE034305063;
	Mon, 17 Nov 2025 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763401295; cv=none; b=Aiq3twMenU/Opewqdm7rPGJjhEIqpHddWcF+eWahcGOsw+BHv40eOEAmgIFds24djEm30iuyP8/YnraiDm3D2JlGJrkPSwNcOhAeuwJieh7/4rKt5+V3GzcXck7TFYLCn+6VR5zksCIyHa8kFOK9DAzaBiZurKBS41yFdWtpedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763401295; c=relaxed/simple;
	bh=oANOt64uco5yiTYGF8tU+dJ4GQibeYjCnt1kkfIdqYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzCb7/I4YP/3/NzH9MLx+BwCk0dITVxoLFuDRzgf1DfKnwJTS5gnExitf/qkYbXzIpROp9qf+hb/nbGP39MbvzuzwG5sgHO+sbsQRnrrwzem8NKso7NlSLqEOCbBvQkAdgBhd8ABtJXYGDgsX+ErtQNwgPl52scsHCn1srEjrJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XJ5nLYrk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.192.165] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAFB62119CCB;
	Mon, 17 Nov 2025 09:41:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAFB62119CCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763401293;
	bh=R+qrQ4lprMLFXNOJBsltyEBTs+EtrTEmRmeXfss7c+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XJ5nLYrkz+icoe3dO5U4S/M0lE//gNZxjb/wv+/sZuhl5cQLxMbKcZy43scAHHBXp
	 fM5PpixRzXB3eKkel+cO+3er41aOktqXGA6LtWQB0IkEPbHswZP2kcvEmGJ89wMQLW
	 UGnQbjlPex8gMTM+zbSwkONkR+3IESf5l80qAQP8=
Message-ID: <522f1bc2-417f-434a-92f9-7b417744cef4@linux.microsoft.com>
Date: Mon, 17 Nov 2025 09:41:19 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
To: Wei Liu <wei.liu@kernel.org>, kernel test robot <lkp@intel.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
 <202511161617.KcDzR4sA-lkp@intel.com>
 <20251117173428.GB2380208@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251117173428.GB2380208@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/2025 9:34 AM, Wei Liu wrote:
> +Nuno
> 
> On Sun, Nov 16, 2025 at 04:17:08PM +0800, kernel test robot wrote:
>> Hi Anirudh,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on linus/master]
>> [also build test ERROR on v6.18-rc5]
>> [cannot apply to next-20251114]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Rayabharam/Drivers-hv-ioctl-for-self-targeted-passthrough-hvcalls/20251114-182039
>> base:   linus/master
>> patch link:    https://lore.kernel.org/r/20251114095853.3482596-1-anirudh%40anirudhrb.com
>> patch subject: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
>> config: x86_64-buildonly-randconfig-005-20251116 (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202511161617.KcDzR4sA-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/hv/mshv_root_main.c:125:2: error: use of undeclared identifier 'HVCALL_GET_PARTITION_PROPERTY_EX'
>>      125 |         HVCALL_GET_PARTITION_PROPERTY_EX,
>>          |         ^
> 
> Anirudh, please check this.
> 
This is introduced in hyperv-next, in:
59aeea195948 mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall

But the bot applies the patch to linus/master, that is probably why.

>>>> drivers/hv/mshv_root_main.c:175:18: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
>>      175 |         for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
>>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is from the original patch. Perhaps adding the explicit declaration
> of the array size would help.
> 

I think this is just due to the earlier error...

Nuno

> Wei


