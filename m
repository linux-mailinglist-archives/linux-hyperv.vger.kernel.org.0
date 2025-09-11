Return-Path: <linux-hyperv+bounces-6829-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F261B5390F
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 18:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C0586B86
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Sep 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F335AABA;
	Thu, 11 Sep 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qGf+UbSM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16C369325;
	Thu, 11 Sep 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607704; cv=none; b=og22/mEZ3BoBXZudufy0NC7C7sI0kp+vOHFiaTj80QCMhBLQNOUqBAwJevl6Dfq9TNlEzn+N3CKrQpq2aklcgZFN5vBWdHG5FDeNO7asbD2g65iFrwjFRi/q8EnEcD4PX9Zf17Fty6W5faZu+LGC7sVebPKGcF+qB1lgz3ge1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607704; c=relaxed/simple;
	bh=GodpCmrKLL3EdmdoxCdmcfKHCBD/nTts2aDBxkcPeTY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KvKAIUEr2/HJ++iFiI/jV6vjTmkwxC0YXwoBg2LeL0PpbY2E4kJzaNJgNEt13qwFTVzH4JznCypEbDQLxme1Nidv1EBvJKfGLwneqjjOfmydmN7nmdwKLyLITBJniRnOruIdEv4bJgOWJDB1aBjlJ3VFqbKTMJMN7kihOWbO10k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qGf+UbSM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.243] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 100F2211AA2B;
	Thu, 11 Sep 2025 09:21:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 100F2211AA2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757607702;
	bh=Lsfv+w79ZkuH1nCaWnwi79l4YRkl4gV9wTkGdE4xfus=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=qGf+UbSMYa/mOMoz+tqUVa8lwdvZXltO60pPRXvrSAXZYrKgPFik5QRmCYsDm9+On
	 44f9PUDnlO0UeW/szlTitmtemXH9y8mntKJWH6YsSVld8mzZlmimNIO38ha7wgso68
	 YVBooGXhDWv7f1VTL7pV67prf7YhWNGRggSI/eb8=
Message-ID: <56eb6aac-19be-40f2-ba2e-a0ca8fcb3df2@linux.microsoft.com>
Date: Thu, 11 Sep 2025 09:21:42 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 prapal@linux.microsoft.com, tiala@microsoft.com, anirudh@anirudhrb.com,
 paekkaladevi@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Subject: Re: [PATCH v2 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1757546089-2002-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1757546089-2002-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1757546089-2002-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/2025 4:14 PM, Nuno Das Neves wrote:
> From: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> 
> This hypercall can be used to fetch extended properties of a
> partition. Extended properties are properties with values larger than
> a u64. Some of these also need additional input arguments.
> 
> Add helper function for using the hypercall in the mshv_root driver.
> 
> Signed-off-by: Purna Pavan Chandra Aekkaladevi <paekkaladevi@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         |  2 ++
>  drivers/hv/mshv_root_hv_call.c | 31 ++++++++++++++++++++++++++
>  include/hyperv/hvgdk_mini.h    |  1 +
>  include/hyperv/hvhdk.h         | 40 ++++++++++++++++++++++++++++++++++
>  include/hyperv/hvhdk_mini.h    | 26 ++++++++++++++++++++++
>  5 files changed, 100 insertions(+)

<snip>

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

