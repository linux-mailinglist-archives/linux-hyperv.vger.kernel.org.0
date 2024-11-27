Return-Path: <linux-hyperv+bounces-3366-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD139DA27F
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 07:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10AC2837DF
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Nov 2024 06:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA9C13D89D;
	Wed, 27 Nov 2024 06:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kwKiscaq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFC613BAE4;
	Wed, 27 Nov 2024 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732690268; cv=none; b=R5oinLT3mjjnXKmaPmFhkXV57gY1kruNKZcaefyE2iVrsHEZNu7DSkMg8+0hxrhi7Rrepr9qnOwT0XjSIcOPIdxsUiJdGzuQT1dpfO+3BITR8mCH77z2tbheCX5yCH8Pyr5/pm0M1AKyjV/1rwAtpTkzwha6u/pGJByul2IZzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732690268; c=relaxed/simple;
	bh=xOouENdGDvIEEU0VIXcVAdXGuhbB2aIZ+2J1DQ0QTHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WE76yZ/MhWNY9vjpN3rEuGS02DVMQWwcYDA07HY4eslhvAsyNf8IWfiP2iNSbLs9Pd/sqAiHpVJMgUYovC7jcEnfOCBBT7diqeDN56Kne1VUiihjdvcldSrdHEwjVT29IBKMtZYuK6C5On9LoExqGCd8oD+9SNCPsYxomEsA264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kwKiscaq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.103] (unknown [49.205.255.211])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2403420545BB;
	Tue, 26 Nov 2024 22:51:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2403420545BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732690266;
	bh=9srNrzuHWrGmuiY0B+CImVL3ghbKkXIAUWnCd92AWdc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kwKiscaq6zQ+TUzpTkSIUqG86p7kbKa6ouRptdKPH2tEfq7xrl3/sTJDzeA1AH5A3
	 1DC5cT09sKOaA4Q9lh6nQ7w/e6/MnNcTHEIP7Qpr4JugvmVoBgfuU9u1r5Ss5P2QiO
	 l0sq6xyCQ7aN9SMX1SLTfNOkoPZ8h7Pa09hhSAcY=
Message-ID: <21faa338-6f61-4ead-9cdc-41a2c354a44a@linux.microsoft.com>
Date: Wed, 27 Nov 2024 12:21:00 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Add a check for HV_NIC for send, receive
 buffers setup
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241125125015.1500-1-namjain@linux.microsoft.com>
 <20241126163354.GA5185@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20241126163354.GA5185@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/26/2024 10:03 PM, Saurabh Singh Sengar wrote:
> On Mon, Nov 25, 2024 at 12:50:15PM +0000, Naman Jain wrote:
>> Support for send and receive buffers was added for networking usecases
>> in UIO devices. There is no known usecase of these buffers for devices
>> other than HV_NIC. Add a check for HV_NIC in probe function to avoid
>> memory allocation and GPADL setup which would save 47 MB memory per
>> device type.
> 
> Thanks for the patch. How about rephrasing the commit message like this:
> 
> Receive and send buffer allocation was originally introduced to support
> DPDK's networking use case. These buffer sizes were further increased to
> meet DPDK performance requirements. However, these large buffers are
> unnecessary for any other UIO use cases.
> 
> Restrict the allocation of receive and send buffers only for HV_NIC device
> type, saving 47 MB of memory per device.


Thanks for the review. I'll rephrase it and push it in a new patch after
a few days, considering ongoing merge window.

Regards,
Naman



