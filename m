Return-Path: <linux-hyperv+bounces-5391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1CAACA05
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 17:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E0717AAB5
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344222857D7;
	Tue,  6 May 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BuQun0hu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6B284B55;
	Tue,  6 May 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546534; cv=none; b=ncrOLrBsgMD/zywzIKgcMP0nysliDwcB6hIwlBV5ftpF2T+pzwAReRbAfZPsudnnx/kaMswHzXPxJMjJR3bggkJKghEz42piJNRP2nhYpI6ennh2T00cXO/HnuijS64jatmfaElXBb8eOdg7Dvjj1BZ35kBj9+qr5XxcAo+zJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546534; c=relaxed/simple;
	bh=b8K8VPEKo2vFno2FOkQSXnOl2aV8WRJi5ElUQaEXxrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbn94ewpGag3VvNIke4z2whm0pa72XGGLK0Wxu7/EU0ruI4NfeZbwu63rIuiB1x192Y8QkQspve+P5VMAEw9tB3eaBLFKGlqMNAXRy/pZf7OI+eJyFWgXirwwE4uDL0+qkCv/+w17+3n6ZpXlgUA0s+M+Sz8e6Hm/u1JjHRPojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BuQun0hu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2CBF62115DCE;
	Tue,  6 May 2025 08:48:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CBF62115DCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746546532;
	bh=XV5pxCSYJfDbAu7U85JaaVEZsdoplkYxyVj9/rXktcA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BuQun0hu9dClUEbfjnUfDSAQolyrHQJvzJC05eWENJSqvrATHxp1lKr8jJRio46vB
	 Y2v4wRTGIW1ann6Vn8v5wOom3gqwerlRUaApLy5k0MPeApLpJ5Jhj1fng/jjDihqUO
	 SqklYJU/lXBH5qbE6PdhGnLJcOCAyVrDHdH5WIOg=
Message-ID: <2d548dd4-ec29-4414-8450-5aa7a8ce98e0@linux.microsoft.com>
Date: Tue, 6 May 2025 08:48:51 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250506084937.624680-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/2025 1:49 AM, Naman Jain wrote:
> Provide an interface for Virtual Machine Monitor like OpenVMM and its
> use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> Expose devices and support IOCTLs for features like VTL creation,
> VTL0 memory management, context switch, making hypercalls,
> mapping VTL0 address space to VTL2 userspace, getting new VMBus
> messages and channel events in VTL2 etc.
> 
> Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
> 
> OpenVMM : https://openvmm.dev/guide/
> 
> ---

[...]

> 
> base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3

LGTM.
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


