Return-Path: <linux-hyperv+bounces-1800-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868438816ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83E01C2088B
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Mar 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC866A353;
	Wed, 20 Mar 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c5w6EmvN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118961E49B;
	Wed, 20 Mar 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957566; cv=none; b=RJ87Sm8hF09QLSj0aHwxJjX9Q7sMiXXj005rz/GtA8fG8enNc8jP0yvn+SQAAFzsdvkpyJ1EKDlNwBVC/+utpEr83D86JeVcWlOFSi5hyJqhuV27VkTURMjPGV/gQsLRnOIG2zOTTz92jJ7zb5aD0FclO/CVFEnYooG/3OhJU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957566; c=relaxed/simple;
	bh=hwiRKS8x3Dz/MZcnQGj74zkiU1VvC70pYcQb54qBPsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJPsVPoo58LDkqLrY0YphBx29B9Wq5TXJKzGorOHzZRt0Ya8Y1U6b50DeaPTdwBWZBhzAbGdMAYrTLAO0wRiRTQfl6RUv4ez4EfpGG1nFqVuyQBrZLUAmi6OUV5L7oPX69wwp07asql5kJzLzgOL6Vi88RvJqavhw2LjS5Ts4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c5w6EmvN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.129.161] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4C44C20B74C0;
	Wed, 20 Mar 2024 10:59:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4C44C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710957564;
	bh=Rato3V56U1xIHpQYHOICTvOn543oqjGwizhO0Sk9Mt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c5w6EmvN0GXhAmCwrWt1tnxPQ5dR3a5sHEY1FuqsmONSQeNaTf5VGgGVidSxKORE5
	 IMhT+F7RGSkDFquY1SPkN9dOnLdA/vbH9kakKUTqGOvpM/Tb7eRcm0QLmv9E/SFmln
	 EYNRxQL6qS3JppOEVsgQw/ZqwKnjrm7kXZmVC1+8=
Message-ID: <2c33751e-5995-4be2-a15e-ddca6a6ab4fe@linux.microsoft.com>
Date: Wed, 20 Mar 2024 10:59:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
Content-Language: en-CA
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>,
 Shradha Gupta <shradhagupta@microsoft.com>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/2024 4:17 AM, Shradha Gupta wrote:
> If the network configuration strings are passed as a combination of IPv4
> and IPv6 addresses, the current KVP daemon does not handle processing for
> the keyfile configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
> 
> Testcases ran:Rhel 9, Hyper-V VMs
>               (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes in v4
>  * Removed the unnecessary memset for addr in the start
>  * Added a comment to describe how we erase the last comma character
>  * Fixed some typos in the commit description
>  * While using strncat, skip copying the '\0' character.
> ---
>  tools/hv/hv_kvp_daemon.c | 181 ++++++++++++++++++++++++++++++---------
>  1 file changed, 140 insertions(+), 41 deletions(-)
> 

<snip>
LGTM

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

- Easwar

