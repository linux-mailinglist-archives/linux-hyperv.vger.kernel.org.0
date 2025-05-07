Return-Path: <linux-hyperv+bounces-5418-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12639AAE902
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 20:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412C1189FE56
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC4E28C005;
	Wed,  7 May 2025 18:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sGG1FoJM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860428B7EB;
	Wed,  7 May 2025 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642260; cv=none; b=CKRLglXB6xSVbFBK6rRTd9bm+Z0XE4TJRs0uvy1Vy0RpStHNUzP9Wn7++UghEtZCdQA3XIPKRpoaUcn6bKO9ZWHHTKi/4fWpYWDDDyAM8Xr91JD+/ma8EWmfZewcxZqqcBavMLI0cmeIV7SPNVDQEA/1O/d5g3vW/RhgnRTivWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642260; c=relaxed/simple;
	bh=q66ZYgh4pS4CZb1tH6C5gKK7uXWaLWK3kl2y7mzaHVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSuagZLaoZ874LQmaAcQHx/5Gg0lnqQWrTI0TstJXRz/QfNOBXll5M8+f9N8BqeuvVCC8KSa2CDfPqdCKmFjzAZc8gG64PxvgGgXXfSpU+DtyTV9sfqnnAPix5EGZMK4Bic8CdASLNisDzqmpnW/p+/P3seF+vOqG3ORt6+2l/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sGG1FoJM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6538521199DD;
	Wed,  7 May 2025 11:24:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6538521199DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746642257;
	bh=h85GkaZcJUQFyjBamnk94rpw/4ulSYgWghCaugoGUiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGG1FoJMeZ3xnAsRQL4TKdo4uVX/3mPMZBu63wzD8BtEVUTn0GnSgQcQdpGOX02BP
	 l0FDAI2ohi0+cvm0zhZVHcoLkJD4gntLF94pgJEc/2D3ivE78G2amweNOSZaHDRCnY
	 KjTH0fJujAtES7gCuZUfuPeLjCWgdh9UxwfcSegE=
Message-ID: <c21ebd4c-b658-4f46-ba5c-4c347bbe396b@linux.microsoft.com>
Date: Wed, 7 May 2025 11:24:17 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4] x86/hyperv: Fix CPU number and VP index
 confusion in hv_snp_boot_ap()
To: Wei Liu <wei.liu@kernel.org>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
 mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
 tiala@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250506174249.11496-1-romank@linux.microsoft.com>
 <aBr-cScjbkhyoBFA@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <aBr-cScjbkhyoBFA@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/6/2025 11:32 PM, Wei Liu wrote:
> On Tue, May 06, 2025 at 10:42:49AM -0700, Roman Kisel wrote:
[...]

> 
> This is dropped from the tree because it breaks builds.
> 
> Since this needs to be backported, it makes more sense to apply this
> patch first before the other one (assuming that one doesn't need to be
> backported).

Combined the two patches into a small patch series with that patch
first. Fixed the build break in the second one.

Appreciate your advice very much!!


> 
> Thanks,
> Wei.
> 
-- 
Thank you,
Roman


