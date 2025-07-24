Return-Path: <linux-hyperv+bounces-6377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 866EFB1052B
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0698F3AC532
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712632750E8;
	Thu, 24 Jul 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XWaMDNwt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266602222B4;
	Thu, 24 Jul 2025 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753347680; cv=none; b=VDRrAXJNXlfVI40r8vHoXjFP1nzo1p5I2iaLHLdjBMnsLRwbca0u6HfFx/uarcxMpST6+7/Py87/+MBxuo/Zhz0Pi8smFGwlAAXE50iFu0FmKW1HpNFTyD53YPxbTLRmOqgpk0+Xnvww48bFWRcRb5FAC+JIk7fdtZ7aXn6/qcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753347680; c=relaxed/simple;
	bh=KZS3SWyieawnzA6ZrQHQPx0xrOH2YAeosXyOGdCKaVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZgPaehjMqGFZgOaXn5HFXA5SDeBaftMIYs3oh+AJtABy3SOMWK4tZEwzrMFuzNghuKMg7718MXUGP/wuEsHebIw5EDnLMwsO6C2pKuML0OqJssv8iGIQJp0gCnzCDFzUis87dv+bPpupFP7Kuwlq5GPnzsWBhtFELA/2j0wS4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XWaMDNwt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C1E62021884;
	Thu, 24 Jul 2025 02:01:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C1E62021884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753347678;
	bh=s999hUqMDpybNxGVFaWNVbqtoLiD/9WRNC/oRzsyyKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XWaMDNwtNdn1Qf6KCB52khOaYYXzekBwHt6ZHBDSZX/cAyWyfmWmePnKFxO3KN0pR
	 Ormh9VABGfrC29fq7MoZwKoA1e/saIGq1t3RdTfbVMtbWnnHmADUnko5tQiBuMqqBT
	 205YthplhfhdzmuvQt/2RIGlMHujOhPUXUw0YZgA=
Message-ID: <558412b1-d90a-486a-8af4-f5c906c04cca@linux.microsoft.com>
Date: Thu, 24 Jul 2025 14:31:12 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Drivers: hv: Introduce new driver - mshv_vtl
To: Markus Elfring <Markus.Elfring@web.de>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 linux-hyperv@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
 Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Alok Tiwari <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org
References: <20250724082547.195235-1-namjain@linux.microsoft.com>
 <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <fe2487c2-1af1-49e2-985e-a5b724b00e88@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/24/2025 2:26 PM, Markus Elfring wrote:
> …> Changes since v5:
> …> * Used guard(mutex) for better mutex handling.
> …
> 
> Thanks.
> 
> Do you see opportunities to extend guard applications for further data structures?
> 
> Regards,
> Markus

So I actually extended using guard to all the other places where I was
using manual mutex lock/unlock. I had to reorganize the code a bit,
which made the overall flow simpler and more robust. If I am missing
something, please let me know.

Regards,
Naman

