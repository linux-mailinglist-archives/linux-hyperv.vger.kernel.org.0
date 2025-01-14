Return-Path: <linux-hyperv+bounces-3681-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF5A10C38
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7BC167023
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jan 2025 16:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC01C5F0F;
	Tue, 14 Jan 2025 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kxRhajGR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97561C2324;
	Tue, 14 Jan 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871897; cv=none; b=Ek6Hr1B95VJBYulu5U38Wdq/o+qj7oILpibloBrLFPjeRC6mEq0QsRmxeCGgn2qTICB7llnButwCVN4YhsmaLtvzNBj0VI6xZINx6XEPWVa7w6KmfsaDCl0Ia4DH02/pGyPTGVeIMXvCzMWhfjyuECUooms7GLL6GmV7qjbgttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871897; c=relaxed/simple;
	bh=4C0G2XCT+MQY0IIkXI2xbO/jgLunjRLy7KJnpGEApQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WISmZhYoWtBsnAL2mY/Zi8dmE4JnTGuEK0wlV9QvXc3m56oRb8Y6j5Ocr58WOfRqGOryLcppe5St6N3ZgZa1NP3MvhgvMYHyM+UiQeokf+/KuEFodMYb22cYRGGq7iuJHvDTFWzs6hcyNvWbtl/be9y82xNi6xen88NiZ/4aQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kxRhajGR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E6BD20BEBE1;
	Tue, 14 Jan 2025 08:24:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E6BD20BEBE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736871895;
	bh=+XptpPcdbzr3RxIdizNt2dhRuo/DfalHaLG+30JWpuI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=kxRhajGRzD2nNxYfiZnc0CpG0xbo3avP/pQifztmisYFVJzkmX/NPL10jkSTw8GHp
	 T9a+7ghkbvWohh0T+5npPbPYZBhZ7Y2Vpcm9KffFV5UGo6VUPMkyRs/TsSxLygnI9f
	 RL8ztXYu7SfJ1EJWhyQ3fFgE52x3yLyUcpovIDcY=
Message-ID: <639df81f-4411-4815-88ca-381e09065174@linux.microsoft.com>
Date: Tue, 14 Jan 2025 08:24:55 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20250113145645.1320942-1-mhklinux@outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250113145645.1320942-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/13/2025 6:56 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>

[...]

An incredible read, thank you, Michael!

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

> diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
> index 79bc4080329e..c84c40fd61c9 100644
> --- a/Documentation/virt/hyperv/index.rst
> +++ b/Documentation/virt/hyperv/index.rst
> @@ -11,4 +11,5 @@ Hyper-V Enlightenments
>      vmbus
>      clocks
>      vpci
> +   hibernation
>      coco

-- 
Thank you,
Roman


