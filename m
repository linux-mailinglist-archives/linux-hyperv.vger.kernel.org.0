Return-Path: <linux-hyperv+bounces-3547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BB99FD73D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 20:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710C31885C6D
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069C1F891C;
	Fri, 27 Dec 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iIVEDyOn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6C433D9;
	Fri, 27 Dec 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735326752; cv=none; b=savH4XpwiKH3K+ukU52502gTHXKH3RCdAN1bjfE1lZweB28Xrr4qMmFS8jNswJF5B9V01w0vg0VxzOX/lMuTOygUj7xGYP9WtqmI/OgQD6LYQ4rzJlNl2SBi9UIAhy0/GzaKpKj2Zwg9gfZiK/1/eiq5lobNqYZUkHE8qi/ahkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735326752; c=relaxed/simple;
	bh=Ar0SAG/Ar404VRkUMhU42Te/UaEBc0jFW8b1/mMyAbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RAC+NFM7HGmzy5A/A4PK+AYJd669b/StyoOEON1MFb1WjXk/1xn0aJWUGua2Ovw2LhwEA+E6doctHZ9dPQjeOYPzW3YiRa5eGmllL+on+h+Nyd6O9EamUJQAyHN0FOGHWThKT4fi3KWoSIsVfyLINa0uEdMlvO3vMoSR0gFy9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iIVEDyOn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id EB577203EC3B;
	Fri, 27 Dec 2024 11:12:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB577203EC3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735326751;
	bh=laHPOWjfOI3xZMjQMewdG8Z012LK6ryR5Gs4o08BRqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iIVEDyOnrnJZKUFK3MaV3kIIdOj0LTdaZGc8KHUIT9ox0rgPp2j+Tr/7zKCUoNDYq
	 oIK5ZshJoeZUOft8lfG6jdyJspETPx3zzdfzYEtjPW5ax2YndsoCbQVatZ9Mxsdk3I
	 1FD4lu7RwXBji/uFpLo9T9GGqMfnNUI7GNU7uBkk=
Message-ID: <add7db72-37e2-4eca-a71d-30c4b978120e@linux.microsoft.com>
Date: Fri, 27 Dec 2024 11:12:29 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] hyperv: Fixes for get_vtl(),
 hv_vtl_apicid_to_vp_id()
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20241227183155.122827-1-romank@linux.microsoft.com>
 <9cbdbad3-9ee8-42db-bd0d-b31986a07731@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <9cbdbad3-9ee8-42db-bd0d-b31986a07731@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/27/2024 10:42 AM, Easwar Hariharan wrote:
> On 12/27/2024 10:31 AM, Roman Kisel wrote:

[...]

> 
> Thank you for the persistence!
I feel most fortunate learning from you, Michael, and Nuno :)
Thank you!

> 
> For the series,
> 
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

-- 
Thank you,
Roman


