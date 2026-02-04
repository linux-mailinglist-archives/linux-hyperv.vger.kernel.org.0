Return-Path: <linux-hyperv+bounces-8721-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEi7Afeqg2lvsgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8721-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 21:24:23 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 903C4EC6B5
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 21:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 868B63007B8F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476C42982B;
	Wed,  4 Feb 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j5Xf056Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEF23C51D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Feb 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236659; cv=none; b=VeIa3/TaHn+rrQ/ZEEkGtt+E7rk/bb+SEizahyeHYChUfKz+u2TjzK+Tb1sMVbsd7YTPv9Bn2IOFul/ao7K0jW1VTgEUZb6sM8Cnz9nHUEiI8bfmhFCbMh+hDU0WNdS2Emchky/gODjSv+Zh7YHHZMRZS580k3lWOinWH471n9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236659; c=relaxed/simple;
	bh=loaiiTuLVVFm+xzUg/j8C/5oKnIfuWFsGrFqEILaayA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbLAiG79APeQbOW/dZHvwqsm12oBDPT5gaLaGVdRnhhYRtZP9H5t00IcGx8KjToMv9/CNzwv8BaWpQhdH7c3A6v1RbCQcKxnS34hTxTWa5FrsfzCzimiGQjW5BOw4jjkPhp+MyqaPIlb3bf49K8zTpeF8cntrco1HgTTjaBCRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j5Xf056Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86D7620B7165;
	Wed,  4 Feb 2026 12:24:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D7620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770236659;
	bh=x77o/yONEpfb4yF7y0leezNiiVUyk6kz5pCKv4/XQkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j5Xf056ZYcQywqTUe9Hlh1fjmePZL/1RMQWyphj8LROQPhNj2ArEFCnpTXMfo64qV
	 d6MmqV+dKd/f1razDtNgvS1xMguExnZxq6CdI3Nzq21fjRonehCenMNj1rs4CBaeqQ
	 XGvYWLCaQjSntnGsUhV+ZHSdxpd67rzXY7tKgPVk=
Message-ID: <0647b8f6-f12c-4307-fdd9-9a523b58946d@linux.microsoft.com>
Date: Wed, 4 Feb 2026 12:24:18 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] mshv: make certain field names descriptive in a header
 struct
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
References: <20260116224904.2532807-1-mrathor@linux.microsoft.com>
 <20260204060620.GB79272@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260204060620.GB79272@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8721-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 903C4EC6B5
X-Rspamd-Action: no action

On 2/3/26 22:06, Wei Liu wrote:
> On Fri, Jan 16, 2026 at 02:49:04PM -0800, Mukesh Rathor wrote:
>> When struct fields use very common names like "pages" or "type", it makes
>> it difficult to find uses of these fields with tools like grep, cscope,
>> etc when the struct is in a header file included in many places. Add the
>> prefix mreg_ to some fields in struct mshv_mem_region to make it easier
>> to find them.
>>
>> There is no functional change.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> I generally don't mind such changes, but this patch doesn't apply
> anymore. Please rebase to the latest hyperv-next.
> 
> Wei

Done, please find V3. Thank you.

-Mukesh


