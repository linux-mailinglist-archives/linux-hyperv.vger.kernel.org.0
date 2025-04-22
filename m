Return-Path: <linux-hyperv+bounces-5041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91FCA96E59
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDA4440548
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Apr 2025 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7D5FB95;
	Tue, 22 Apr 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="INuE0Avi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C668280CC9;
	Tue, 22 Apr 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331978; cv=none; b=mMFQrIEwc/0gQN6i/m1DKY7AkXnRGxBPOc2ZkVcMywvwXlp5ibGZ+qomqST09eaptDvRpcbAs/xwABP2h1Nbw2Z01/3GJkn38N9mngXHmqIC6dv9clP+T8CMe/x1TuAwYUpYt2gwXP/X220qkkYaNuFxDQZoYP1Bl4b3p0WlHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331978; c=relaxed/simple;
	bh=hcdPNYqaUKaDR9suMSui6z7W3Bsc/fDKAPyVIJfmccA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIRBn1b4UDtwFdDldIUEHQtM6c+5I9kpOvIwTNcdks4lTGuYQRaYQPOdlvxzQjeT6IguO6v2QWJtlfHUfn1rhfXwQVTo2wCyss/JthbaBnbu4d6OzOWwFUQAUo1eQCi7KlaDH5+ZteNlPnWL7O5o0PEaNVCwJLuOIzr6h42Hdos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=INuE0Avi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.233.161] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 26F53203B870;
	Tue, 22 Apr 2025 07:26:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26F53203B870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745331976;
	bh=etmDYz7dIz0Kvwm2juce8sa4UWnRxZKBhfxdfqOVdxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=INuE0AvinIkEQeelqQgU29crDO7vDQO8aVE0hYFK0DKMsJGgKb7hVWSps9C2I4k1v
	 WEamI+K/p/3AmidGH8pgCJOiHtkabtV6oCaTHmqFMBU1Q0EzDCpLBeDM5XqlpuTvQd
	 6ZiJYLGVZMlmmRv8OMVAqQAMLpSZKYWgJw1k2UMQ=
Message-ID: <599c3a2a-c42b-484d-aa9d-0a9313c10ce8@linux.microsoft.com>
Date: Tue, 22 Apr 2025 19:56:12 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
To: Dexuan Cui <decui@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@kernel.org" <stable@kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250415164452.170239-1-namjain@linux.microsoft.com>
 <20250415164452.170239-3-namjain@linux.microsoft.com>
 <BL4PR21MB4627622A03EB8E5D68EC20E4BFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <BL4PR21MB4627622A03EB8E5D68EC20E4BFBF2@BL4PR21MB4627.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/18/2025 6:43 AM, Dexuan Cui wrote:
>> From: Naman Jain <namjain@linux.microsoft.com>
>> Sent: Tuesday, April 15, 2025 9:45 AM
>> [...]
>> actual ring buffer size for each channel. This will ensure that
>> fstat() on ring sysfs node always return the correct size of
> s/return/returns/
>> [...]
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thanks. I'll make the required changes.

Regards,
Naman

