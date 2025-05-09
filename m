Return-Path: <linux-hyperv+bounces-5448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A81AB1BFB
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 20:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37C21C44AEA
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 May 2025 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52D22D4C9;
	Fri,  9 May 2025 18:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AeGMfrjb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7407B2192F3;
	Fri,  9 May 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814059; cv=none; b=IUm70qeL0a4SVR0hiiYEa8M6Gw6pBTEP7FPvWdIiJkAnb4aac/Iw3VQeOWGnd9py+TQXEwmlCiz0ocnrmbi9D8G3ZnbQ/EHw6pZ0c5/i7dJZq+Gqn19FjPamrM3vH182ZmQWefYhCRVGigxUq0byn1y2IIYHXbeVOMIHZz87pOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814059; c=relaxed/simple;
	bh=fbVYwBymigLCgNTY2DVq7cg10dRitwaA+r4YJAINYRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XOdE7kmwodGiug0Fjirw+2GfpWiJokrLej0i0cwWs0r2n343AM7GvrZGZElcm/B2zn6qUAvmmFrIurADoG+jk7Mx7JPIT3WV64V8Yced4SnMromHFJDzmBULaDLOfrcIy3P7HYWKXK0X2JlhTmbQ2794xrVgzN1vqSUMRf/Yi84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AeGMfrjb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E6FEE21199FA;
	Fri,  9 May 2025 11:07:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6FEE21199FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1746814058;
	bh=HtYMMSJ+yVkTkgsEuq0uk5YKCOkCruAtoaxuL6aJjzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AeGMfrjbf6m08A6TcNVQVTfIgj47mmVQuEZjuiBYJlgcxQEzNPdbAEiTwfkkZj4Cv
	 6v5P1oWBeL6fxKmIytzux8kPQ3u7MCNx01FGNK+f8ZclFWImZRDDRJNZCinMyldxUH
	 LN1JK31XQfPJHzhRN/in6D//mAQD/24PEyVvFt1Y=
Message-ID: <426016ad-d03d-4700-867c-8ae2527412d7@linux.microsoft.com>
Date: Fri, 9 May 2025 11:07:37 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: Introduce mshv_vtl driver
To: Saurabh Singh Sengar <ssengar@microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Cc: Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
References: <20250506084937.624680-1-namjain@linux.microsoft.com>
 <KUZP153MB1444858108BDF4B42B81C2A0BE88A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <8f83fbdb-0aee-4602-ad8a-58bbd22dbdc9@linux.microsoft.com>
 <KUZP153MB14443C667E14262FB5878A27BE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <KUZP153MB14443C667E14262FB5878A27BE8BA@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/7/2025 7:59 PM, Saurabh Singh Sengar wrote:
>   

[...]

>>
>> If you're not changing this, feel free to keep my "Reviewed-by".
> 
> Lets discuss and reach an agreement, while still having your Reviewed-by 😊

As you suggested on the other thread, let us fix that for the non-CVM
case for now and leave a TODO to extend that later.

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

> 
> - Saurabh

-- 
Thank you,
Roman


