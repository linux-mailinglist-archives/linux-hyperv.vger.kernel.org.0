Return-Path: <linux-hyperv+bounces-3184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7319AD2F7
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 19:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F825B2215F
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Oct 2024 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680761CEE80;
	Wed, 23 Oct 2024 17:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PWfVDFYa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88E1B652C;
	Wed, 23 Oct 2024 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704916; cv=none; b=MqOHG2l2nbkmav8ucR7nChoYo2Fdbr9rVzaKVEYEwNEakT7+HB3Fvdi5gSMzMn6djYBCVckJXfRsAh0dnQawtc5x+5bf1dQ/Lj3rihsjORRQu0WOmouitGJH47FAHt0idUBSkABhAcJjC+GozE5EBXrxkoN54yrOMCPTw9rrof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704916; c=relaxed/simple;
	bh=m4jhBK/qe893YUqdIl/t9/zYvtxcRLKniJp1Go7azQo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eu+zytELkGbWUdV627TVNx4UG49ureFiodv6vJH/dv2Zqoh/Kr+q6p8VIEALP3cYAl91FtIbMxq1Z/OQgoWqoYZ0G7kYihTyhlevfNs7loFcpQLZhiO6RExXCOAQnk06zvSepZmZGVLHSA25EHl4gBsMWrEIpTx0wugtyx5Pb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PWfVDFYa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.16.80.132] (unknown [131.107.174.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C79F210EF41;
	Wed, 23 Oct 2024 10:35:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C79F210EF41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729704908;
	bh=2fI0FmVSzp3CATjVEDRtNc7hnO2erQWIG9OlIs0Hrx4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=PWfVDFYaoi2c60c6z3sljZNROBIMiixOEq2elKTyot8pZcjRcIeZCGThRZoStiOzN
	 L/g8rVyPt6IN/I4xojLWS2zB3sdFT27pUfdR+sFDrYUVzkWPa+ltp62ScsRHQgr4tG
	 L+gVLdrjUpjG2rHHghoWAxXOO4w1kUSPGeweaWhw=
Message-ID: <477f31d9-b696-479e-9b5b-7bfbbeaa6c47@linux.microsoft.com>
Date: Wed, 23 Oct 2024 10:35:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH 2/2] drivers: hv: Convert open-coded timeouts to
 secs_to_jiffies()
To: Praveen Kumar <kumarpraveen@linux.microsoft.com>, lkp@intel.com,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 "open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
 <20241022185353.2080021-2-eahariha@linux.microsoft.com>
 <288243cd-51d9-4c76-8337-298e9bf339d5@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <288243cd-51d9-4c76-8337-298e9bf339d5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/2024 10:36 PM, Praveen Kumar wrote:
> On 23-10-2024 00:23, Easwar Hariharan wrote:
>> We have several places where timeouts are open-coded as N (seconds) * HZ,
>> but best practice is to use the utility functions from jiffies.h. Convert
>> the timeouts to be compliant. This doesn't fix any bugs, it's a simple code
>> improvement.
>>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> I think this is second version of this patch series?
> 
> Please make sure, you update the patch version details and document the changes done in the current version.
> 

This is the first non-RFC version, but yes, I should have documented the
changes and linked the RFC version.

Thanks,
Easwar

