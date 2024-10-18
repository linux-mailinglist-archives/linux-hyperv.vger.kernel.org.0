Return-Path: <linux-hyperv+bounces-3156-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BDC9A3DFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 14:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46665282CE7
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663B2570;
	Fri, 18 Oct 2024 12:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i4+mwGfk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D21878;
	Fri, 18 Oct 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729253783; cv=none; b=TlMXeWuQiW1YXWKt0dn2EEZPNEIVpeIFQJiiHUnDC3RSLOWe2QU+FI7NH1xU2U1AuBB7HVEEnlndhsE9BQ4uhk5pJaTCLpM9U4eCmaF1DmHnyHtcQ8J5D0o+3S4VEUHC36x+o6u3svNksNDT+hENAfuvxYwofJZLC7kcEGZiYLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729253783; c=relaxed/simple;
	bh=0k+beNmcrY+pcRygjmZ7e8DqoH1s7rPL+86SRjP7vms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ccXMH3JVwG28zpdqD7kCkkqGLQ5uRtGDRCQJeOpkmkG8Om9RjOHbAiAqyIMZFOmJ9WMwu6yVeqoK1L+T2TSUN1pTe8twKBFK7Cr4O/+Z1yyB495Ym9wE50btZyWayuFksnYfQeGjMLOU7ohBF77mxhL0UAhdW63qwvumZgpyyi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i4+mwGfk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.160.38] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1650720FE9AB;
	Fri, 18 Oct 2024 05:16:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1650720FE9AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729253781;
	bh=1OgAmYzYozmaqji7ob1xgBvem4J3H/LILzhCtmgqTRE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=i4+mwGfkDWpHEgcooIXsJ/JC8O9tN0jUO/9B5QVUqWkqFjQea2FZRAc43U3OQ63yg
	 0iS3KJFgViyJGCoXPpOyUcovASbJ/moiyBmmcNv3INeZLTj2VUT1GswQUHhD1dNS36
	 BFaz3GE9/FJTLxjyPzfCfqDSFwMso5xLFb9xVGfs=
Message-ID: <6f9dcc74-5688-4bcb-9bb6-15c34df9317b@linux.microsoft.com>
Date: Fri, 18 Oct 2024 17:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drivers: hv: Convert open-coded timeouts to
 msecs_to_jiffies()
To: Easwar Hariharan <eahariha@linux.microsoft.com>, lkp@intel.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241016223730.531861-1-eahariha@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20241016223730.531861-1-eahariha@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/2024 4:07 AM, Easwar Hariharan wrote:
> We have several places where timeouts are open-coded as N (seconds) * HZ,
> but best practice is to use msecs_to_jiffies(). Convert the timeouts to
> make them HZ invariant.
> 
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>   drivers/hv/hv_balloon.c  | 9 +++++----
>   drivers/hv/hv_kvp.c      | 4 ++--
>   drivers/hv/hv_snapshot.c | 6 ++++--
>   drivers/hv/vmbus_drv.c   | 2 +-
>   4 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914d..3017d41f12681 100644
> --- a/drivers/hv/hv_balloon.c

<.>


>   	if (wait_for_completion_timeout(
> -		&vmbus_connection.ready_for_resume_event, 10 * HZ) == 0)
> +		&vmbus_connection.ready_for_resume_event, msecs_to_jiffies(10 * 1000)) == 0)
>   		pr_err("Some vmbus device is missing after suspending?\n");
>   
>   	/* Reset the event for the next suspend. */


Looks good to me. There can be different ways of passing arg to
msecs_to_jiffies though-

for 10 seconds
* 10000
* 10 * 1000
* 10 * MSEC_PER_SEC

I don't have any strong opinion on this, and you can probably choose
whichever feels better.

Even the current implementation with x * HZ works fine, with different
HZ values. But, yes, I agree that using msecs_to_jiffies is better.

Regards,
Naman

