Return-Path: <linux-hyperv+bounces-5726-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E4AACCEF0
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 23:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00133A3141
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Jun 2025 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD10224B01;
	Tue,  3 Jun 2025 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ggoEAq8K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4C224AF2
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Jun 2025 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985966; cv=none; b=eLygDrg6uo2+cNWiGun6S7JAx3mZkD54Tkv5rZfYhRlr9Epwsn5iopEyGcFEsYIOCyrosn1jYyOKOzGAtJ87Lx4+rG2eGNLElRCrizG1KTAcnXjcobj6gCEU/qaA+nIWd1KC3GJYItG5raK8S8+rkb5RQSRIbiumFPWIVcwFW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985966; c=relaxed/simple;
	bh=QPVwGI7NawmLRY/JWHrUogCQ75bRNhAIlt41EA4Gyxs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ln+D/ysjaE9Z2UHr4yx2tV1xJWMH7ZeqJSgmIE5RLcYKlmW4qxGEeXfjts3se3VjRjSZvx4lbeoSmdzrKsyIFEDi4TNYyWz9Iiz5Dow8ARNnkihzLiLNqvpjD9TziCTzhhWr6fCgBfjCmBgz0asTcTE46BCx43Z8p2RWEoV+XmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ggoEAq8K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.32.178] (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 561CE2078632;
	Tue,  3 Jun 2025 14:26:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 561CE2078632
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748985963;
	bh=1LpIPJXRrgWZzYHGhSfaGlhD0HqEJ++jDt1Aik2Q1+w=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ggoEAq8KhECMCVUuorDsEBpIbi0w70BEPD9n5nwY1+KSYAYA6iPkWMogFqPCiaARI
	 oJ7NAS0xdxBqgFDowof25DBfE0KoX3xpZLVBsL3RQWbhwpHrwzyf/b0NkgFbxSrH52
	 f6DrPKYZuN2zM0Bhp/SePjTxSzNX+q8ebjrznygs=
Message-ID: <e174e3b0-6b62-4996-9854-39c84e10a317@linux.microsoft.com>
Date: Tue, 3 Jun 2025 14:26:02 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, eahariha@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, ssengar@linux.microsoft.com
Subject: Re: [PATCH v2 0/1] Path string from the host should not be treated
To: yasuenag@gmail.com
References: <82cbefe0-c9d0-457e-99dd-82842ee64cef@linux.microsoft.com>
 <20250602235612.1542-1-yasuenag@gmail.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20250602235612.1542-1-yasuenag@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/2025 4:56 PM, yasuenag@gmail.com wrote:
> From: Yasumasa Suenaga <yasuenag@gmail.com>
> 
> Hi,
> 
> Easwar, thanks a lot for your comment! I fixed where you pointed.
> Let me know if something wrong in this patch - this is my first
> contribution to Linux kernel...
> 
> Yasumasa Suenaga (1):
>   Path string from the host should not be treated as wchar_t
> 
>  tools/hv/hv_fcopy_uio_daemon.c | 36 +++++++++++++---------------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 

Please run scripts/checkpatch.pl --strict on the patch and fix the reported
issues.

As I mentioned previously, https://www.kernel.org/doc/html/latest/process/submitting-patches.html
is a good reference for the expected format of the patch. Specifically:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz" instead 
of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to do frotz", 
as if you are giving orders to the codebase to change its behaviour."

The same also applies to the subject line.

Thanks,
Easwar (he/him)

P.S: It's good etiquette to explicitly CC folks who have provided comments
on the subsequent versions



