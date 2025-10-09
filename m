Return-Path: <linux-hyperv+bounces-7172-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DF7BCA606
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Oct 2025 19:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDCE94F2546
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Oct 2025 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8072C242D98;
	Thu,  9 Oct 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sQOED602"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1342423BF8F;
	Thu,  9 Oct 2025 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031023; cv=none; b=DGvyPgug7GmoJPJtJQtj4lEgp58yCzsAyCO1dsgHbJ4938T48aFitKUwUzCPadE79jNTMEP2eAvv9uEZnNFhJSamslnX3rKXozbhpvpxm+ev2yO0Ut1lwyXgiX6g3YCurF0QIt+7sL7YLRCCnPxM3n9WMq8jqbh7WoxZzMSaEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031023; c=relaxed/simple;
	bh=GvdvkRWA6Kd23yt4xy0Vd42eMJKmHLYTN2tTjf1JsAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AqXiKlDxj9waRiBxmORNQ7nM7kDAy67IDHW2LLUAVSOoRRpccyX8soORNo7BYSojAQKH5LgeD1g+YNdr7RWZ77gLTMO5/nNghdq/Uq8XitJTr+QpdEOTSyrdrJuUdWJEqJx4P1ybuk2I1yb7Y2ApufXFDXMJzsu91Dmo0Uko7uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sQOED602; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AA28211CFA1;
	Thu,  9 Oct 2025 10:30:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AA28211CFA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760031020;
	bh=tgZUJxZXrzSuKSSRKKFhuDWO01I1VDYsdsBFVceffNw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sQOED60229Ujdc3486VDY8Kk1bBBVv4xR6kgeyElRyOAqKf/dq/zA4Gm3nM0sEFcJ
	 K+cFdqmKCt68hFNZZgwF/wlkHZ/QQcl8TZtv/jrJNkqMyKDV3PGHK0VIqnSN0VbmXc
	 o9uE/AXQNmD+rTYfl43CxVvCq5FrClvFv4TCH+QU=
Message-ID: <9c24124d-6520-4850-a1c2-1a529076d648@linux.microsoft.com>
Date: Thu, 9 Oct 2025 10:30:06 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 easwar.hariharan@linux.microsoft.com, anbelski@linux.microsoft.com
Subject: Re: [PATCH 1/2] hyperv: Add definitions for MSHV sleep state
 configuration
To: Praveen K Paladugu <prapal@linux.microsoft.com>
References: <20251009160501.6356-1-prapal@linux.microsoft.com>
 <20251009160501.6356-2-prapal@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251009160501.6356-2-prapal@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 8:58 AM, Praveen K Paladugu wrote:
> Add the definitions required to configure sleep states in mshv hypervsior.
> 
> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Co-developed-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
> ---
>  include/hyperv/hvgdk_mini.h |  4 +++-
>  include/hyperv/hvhdk_mini.h | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

