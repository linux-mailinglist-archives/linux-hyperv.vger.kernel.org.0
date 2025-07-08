Return-Path: <linux-hyperv+bounces-6146-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D30AFC50F
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 10:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE093BF118
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBF929B776;
	Tue,  8 Jul 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iGiE3/mt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F63298241;
	Tue,  8 Jul 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962082; cv=none; b=gy8IKFV8L8wHnDpg3KtfExZBWfHpfbRw5I5Z5QkI7wWK2GQlTTuDO1L8HuMiMecnkxVA4/SNQKhdOGnBQL/fMadCpQQyFdGRy5HA/hE5iXn3BAkrqBiuQFtVYZGaHDF8c6/3GLPGQNvVTA14j74/35nidtgCT3nLu3B7UNiVIiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962082; c=relaxed/simple;
	bh=NlrG7QqGm7wR/wrY8wo7HgU04SaVXKz4MABIdQZOs2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIlNn0OsqWm2sZfXV93LKrFqvfBhwbnWGq3Rz0u2g+K9vPK+O+3k0n+2KWcYb1g2qi+LXp/lWc+BI89h3IIExFyLzYQ9jR22mDHMQuLlnfrujksINxvN11iDbbo/SJWAsvp/oHUZGXneQ0Z3ygr9y0FmbTB36LLK7ttU0wEbNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iGiE3/mt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4CF43201B1DC;
	Tue,  8 Jul 2025 01:07:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4CF43201B1DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751962080;
	bh=KwkfFs2vLJ8vSoG8oq34D65UXBTEOk2Om+KZvcayo+I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iGiE3/mtEVhW3AFScY6fDEBv0IRp6XXlxd0c8Jn9xF2S9xwANoLrOQbYVGNioZj8O
	 qn/6cjI/4GphafuPC5dddM7nmXZMVP2TOAy2bLdt7RXImlQ9pE0hBefQkZ//sYH/5p
	 Eiuyew2Qh6jApsJfSc6q5Oj04J1j2bxhywwfMnP4=
Message-ID: <1e48ca0d-8e59-4a92-889d-c4c48b4bb02b@linux.microsoft.com>
Date: Tue, 8 Jul 2025 13:37:56 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
To: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olaf Hering <olaf@aepfle.de>, Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20250708080319.3904-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250708080319.3904-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/8/2025 1:33 PM, Naman Jain wrote:
> Size of ring buffer, as defined in uio_hv_generic driver, is no longer
> fixed to 16 KB. This creates a problem in fcopy, since this size was
> hardcoded. With the change in place to make ring sysfs node actually
> reflect the size of underlying ring buffer, it is safe to get the size
> of ring sysfs file and use it for ring buffer size in fcopy daemon.
> Fix the issue of disparity in ring buffer size, by making it dynamic
> in fcopy uio daemon.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---

Noticed that I missed adding change logs. Adding them now.

Changes since v2:
https://lore.kernel.org/all/20250701104837.3006-1-namjain@linux.microsoft.com/
* Removed fallback mechanism to default size, to keep fcopy behavior
consistent (Long's suggestion). If ring sysfs file is not present for
some reason, things are already bad and its the right thing for fcopy to
abort.

Changes since v1:
https://lore.kernel.org/all/20250620070618.3097-1-namjain@linux.microsoft.com/

* Removed unnecessary type casting in malloc for desc variable (Olaf)
* Added retry mechanisms to avoid potential race conditions (Michael)
* Moved the logic to fetch ring size to a later part in main (Michael)


>   tools/hv/hv_fcopy_uio_daemon.c | 82 +++++++++++++++++++++++++++++++---
>   1 file changed, 75 insertions(+), 7 deletions(-)
> 


Regards,
Naman

