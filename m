Return-Path: <linux-hyperv+bounces-8292-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728BD20DBE
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 880693008726
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D098433A007;
	Wed, 14 Jan 2026 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7tiMi+A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AD33970F;
	Wed, 14 Jan 2026 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415965; cv=none; b=GSnWsWM41uvN9uk7yk6b1/KFkrtnFOnuKvLMD7QtBYCnf+LmRbOFW9C1LrlPwTZ7OqD+juOdwTdBdMFGoxnu2zrLq2AJ+NdST7Yal/A1S55FqSqmlI0SgNm8amWlD/W10ne2Os8slkRn737jcUKxBIpK6+dS0q+oukh5Pt7LiQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415965; c=relaxed/simple;
	bh=exMitu9PzfrK6hzYlE6sQBC+ouupHRjFArkPrtJUKu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUXIQurK0oZpOu3rh0KESvjmke7iKUe077O8buWeIhCXEaLTUiJNUx9OVvdXrwF6QZb+Q8ssYcX4m3AKl3lQlIoPF2Wkg9cqBEAsqu/lAx2kQeuta04v3Vb4tLKy1WDJFS49DdfGb1M7x+LhGUTaimkTwOW3qhC3fPQcJz6DEEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g7tiMi+A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.97.88] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 376E420B7165;
	Wed, 14 Jan 2026 10:39:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 376E420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768415955;
	bh=i38WK9YhpmuJk62xFcLjOfpJQmgOHef1eHA1OU1nIDo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7tiMi+AbK9plHCxjoVy1Wp8yjpLABj5NP5NP5+P0zlbZ5itmJZRk1iUdQ5e6z3qC
	 Yqy+fRwbpkyCA38uLnlwkdGMmkYZCqpemDRs7BFsWL006+8psk4Ck8uuIIcmv/dpVq
	 2DGGti3aj9cBpbuOPKdG+d1Al2RcyMRT1Ka2N6N0=
Message-ID: <eb163338-cd03-49c6-8c44-f6fac39ba7f6@linux.microsoft.com>
Date: Wed, 14 Jan 2026 10:39:14 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mshv: Add __user attribute to argument passed to
 access_ok()
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260114181508.143564-1-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20260114181508.143564-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/2026 10:15 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> access_ok() expects its first argument to have the __user attribute
> since it is checking access to user space. Current code passes an
> argument that lacks that attribute, resulting in 'sparse' flagging
> the incorrect usage. However, the compiler doesn't generate code
> based on the attribute, so there's no actual bug.
> 
> In the interest of general correctness and to avoid noise from sparse,
> add the __user attribute. No functional change.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/mshv_root_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index eff1b21461dc..5673af9fe101 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1280,7 +1280,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
>  	long ret;
>  
>  	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
> -	    !access_ok((const void *)mem.userspace_addr, mem.size))
> +	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
>  		return -EINVAL;
>  
>  	mmap_read_lock(current->mm);

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

