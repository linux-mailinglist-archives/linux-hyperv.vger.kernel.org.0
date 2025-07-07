Return-Path: <linux-hyperv+bounces-6130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AEAAFBA38
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CB0188F7B8
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Jul 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC1231837;
	Mon,  7 Jul 2025 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b62LsCCv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F02C17A586;
	Mon,  7 Jul 2025 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911085; cv=none; b=Ug26llt8WxPcYy3RZiMBdERW/Lv5bKOhg/TzxwZSdOyIq/6N0Pp6akuP1/vDNHE9KD8OwSXaGmfpxBiFA1Br1dHdOIMlwzn7aEzCLvOD7AFLV/G+wBPAaruWxs0TfATB30x9gHI67AzkWyhg3hIjxK8Fx5lW7DL8+Gxip72R+SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911085; c=relaxed/simple;
	bh=k03GcAkLCf/4dmIXknxGKTEcIRrtnumrhxNG6DlohwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJR8ggufYHPEtV6EEbvK+EIe6PU+Z/IppIei/Og+rxpGbV6FMCOP0lhEqB3nHmsjtxbbhPAJv/YoPV3Gg3XkNbBjKFTXAZ75w2uucYfMSg3rvLNx2w8gE2NaFoY+xSGzdF95JFetsSqP6pDAnnRCy813GYprAiDxQrlyt6a490o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b62LsCCv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A8073204E7E8;
	Mon,  7 Jul 2025 10:58:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8073204E7E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751911083;
	bh=Ofit84r25MUKuTupYbHaH43gJPibTveW2L+yk/Exi3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b62LsCCvU5pqu8hWitu0fCXbZ5nVM9z8Wqc8vAelvhT5fxVmoiYBTFP3G6pczNqpe
	 o0V5rv1E7MW3aupISpwEz6UYoI/nYIDmCvUHbUBd0yw3X1CACxFpj4XE+IjOSsPzNI
	 ojptbUUgWY9vnQE2p5s0QHS/aq6D09C1GvP0L0lE=
Message-ID: <5f3ca2ac-cf06-4c81-89bd-e8685b222aa9@linux.microsoft.com>
Date: Mon, 7 Jul 2025 10:58:03 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Fix the check for HYPERVISOR_CALLBACK_VECTOR
To: Naman Jain <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, namjain@microsoft.com,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
References: <20250707084322.1763-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250707084322.1763-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/7/2025 1:43 AM, Naman Jain wrote:
> __is_defined(HYPERVISOR_CALLBACK_VECTOR) would return 1, only if
> HYPERVISOR_CALLBACK_VECTOR macro is defined as 1. However its value is
> 0xf3 and this leads to __is_defined() returning 0. The expectation
> was to just check whether this MACRO is defined or not and get 1 if
> it's defined. Replace __is_defined with #ifdef blocks instead to
> fix it.
> 
> Fixes: 1dc5df133b98 ("Drivers: hv: vmbus: Get the IRQ number from DeviceTree")
> Cc: stable@kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---

[...]

Appreciate fixing that! From what I learned from you, x86 was broken.
Very likely I did a smoke test there only while focusing on arm64. Sorry
about that, thanks again!!

LGTM.
Reviewed-by: Roman Kisel <romank@linux.microsoft.com

>   
> 
> base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a

-- 
Thank you,
Roman


