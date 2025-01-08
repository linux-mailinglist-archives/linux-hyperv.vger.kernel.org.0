Return-Path: <linux-hyperv+bounces-3617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E13A0645B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 19:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F583A6A1E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 18:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C32200138;
	Wed,  8 Jan 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mYOvjifL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EA315853B;
	Wed,  8 Jan 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736360970; cv=none; b=BYwyAm/aWbWt6oXRfnAIgZwVJwLl51Ww22MDudYAHIhe8CDezrtT/A/0JCPmDDIq8ejLNUFIa6OMJwi6mhMts7F7ERoafO4+R1Q6JN3B+TSDMBFsbWoAWa9R5MrDWGN+LcIX7XDP1Pj8Xh4QyDQ+BgIH0fUVk96cRAhDimedFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736360970; c=relaxed/simple;
	bh=oCxzLWoqtCyQWuL7I1iXSvjWc9RlbCLYYteK6nu/N8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AewS6J+QpXK/UlMtOuYPJpVaKoCHHjRCOczJgByY2pTh0HjPNMoxv/Y4Sq5YM/ia7/2kyUP/oiBZKSRp6xb994Wxms+iC3l9J/bEOVME49nmgWDeO68X8yeHOmsmXwy90lOxx9mdLGmYkvhSwu/obXE/C9a7EjXw0uVTUkrQwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mYOvjifL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0695203E3A5;
	Wed,  8 Jan 2025 10:29:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0695203E3A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736360968;
	bh=I5x2oV/2iEO1YfTd2I3H/oL38SZl00DQEaYeTv/rG1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mYOvjifLHImCvJl+EQ1ZyDpvmdJadQivvLMbsupCDOinycK3v0fi4FlMHGfransSa
	 AwekNBoYyemI9doI0uLC01mtNFehvlsmV2LBmAGMRDeLkKW9i/25zrdd3R9VI3i6ln
	 D3z+n4y8lCF8Xne50QMTKG1t5ZU6Nt08uUUCzAxc=
Message-ID: <c900e377-be7d-4a41-afd9-000d956d9eeb@linux.microsoft.com>
Date: Wed, 8 Jan 2025 10:29:27 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] hyperv: Define struct hv_output_get_vp_registers
To: Michael Kelley <mhklinux@outlook.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kys@microsoft.com" <kys@microsoft.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "tiala@microsoft.com" <tiala@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
 <20241230180941.244418-2-romank@linux.microsoft.com>
 <SN6PR02MB4157F8C28BD92F36B27C9032D4102@SN6PR02MB4157.namprd02.prod.outlook.com>
 <7a60c96c-2fc1-411b-ac08-2b69f507af4e@linux.microsoft.com>
 <BN7PR02MB41482C89094DBC3E811C5918D4122@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <BN7PR02MB41482C89094DBC3E811C5918D4122@BN7PR02MB4148.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/8/2025 10:22 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, January 8, 2025 9:58 AM
>>
>> On 1/6/2025 9:37 AM, Michael Kelley wrote:
>>> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, December 30,

Thanks Michael and Nuno for your indispensable help! I'll fix the
the patch as suggested then.

> 
> Michael

-- 
Thank you,
Roman


