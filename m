Return-Path: <linux-hyperv+bounces-3645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6BDA07EAF
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B04188D05F
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 17:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379B518C03A;
	Thu,  9 Jan 2025 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TxoWZZK/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A6B644;
	Thu,  9 Jan 2025 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736443560; cv=none; b=fO6lbfhChgP2b23XUOi9QzTE7NZybsFzCGEHYVmm3Gr/Qlk/zVz1+WaYcTrQqqDJkcZgst7rAX/6e7pywq1B7P92kxoAeOG5WhX236C1H7Bpla7dSDY7YvsCH9rJT+jng0CN2k7wWxcl1HkSUhG1XMHyb/OAN8dO4lvO8SwxHjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736443560; c=relaxed/simple;
	bh=oSJMfCh8QD5wBOTnKmVSdm6yxMfWPoCebUWwuh0fIPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSZPS89fJTD8xfRdeRUiiG7pvy043axhpMN8octx0yEEtacNmpq8iloKViYUUPomfL6IxIae5xvUlVeUEvwqgv/GKpAEKU6qxgC4irQkAVXAP4Kkhu0p6JGJdnY3r3Gwl+BF9bBLlbPi0+2n35kdcAqI5uRCaCwYphid+lp3TVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TxoWZZK/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 30D3A203E39C;
	Thu,  9 Jan 2025 09:25:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 30D3A203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736443558;
	bh=Bk0g/Itf3/AUPhA9loelTm60WmlBb0ODZckcENQI22I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TxoWZZK/g5MUAtMEJzezE1AGY9Ur/YIutufi8GQMEwXqlhkB1bcsVimaBG+QYAMIS
	 Gi2iecwiuURIn+INk3S2lakNh06Ygn09FTXtvPpD8mwLNcbP0jUiedOEsVrzzg0k39
	 KpAGlv6ZzXrMQno35alyJyHCe7BJwsKyb/FncfuU=
Message-ID: <2102df2f-117c-4c35-b727-cd9865c0e31d@linux.microsoft.com>
Date: Thu, 9 Jan 2025 09:25:58 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Wei Liu <wei.liu@kernel.org>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com,
 eahariha@linux.microsoft.com, haiyangz@microsoft.com, mingo@redhat.com,
 mhklinux@outlook.com, tglx@linutronix.de, tiala@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-2-romank@linux.microsoft.com>
 <d5fb5c9b-a477-4043-8438-aff29dbd96bb@linux.microsoft.com>
 <Z39jvq4CsBjurJ1v@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z39jvq4CsBjurJ1v@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/2025 9:50 PM, Wei Liu wrote:
> On Wed, Jan 08, 2025 at 03:25:22PM -0800, Nuno Das Neves wrote:
>> On 1/8/2025 2:21 PM, Roman Kisel wrote:

[...]

>>
> 
> I can fix this when I commit the change . This patch will be folded into
> your old one anyway.
> 
Nuno, thank you very much for spotting that! Wei, appreciate that!
Didn't mean to create more work for you, sorry about that.

> Thanks,
> Wei.

-- 
Thank you,
Roman


