Return-Path: <linux-hyperv+bounces-11526-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jpfQMJdIJmp8UQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11526-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 06:44:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847F6529EB
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 06:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=AE00LieU;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11526-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11526-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4BBD3003639
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 04:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FBE34D397;
	Mon,  8 Jun 2026 04:44:03 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E232BF5A;
	Mon,  8 Jun 2026 04:44:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893843; cv=none; b=L3pWnZICMgoEtWdnf1SPcOywUwR4GZ2ANovabIkn7krdQ8qWqwS23jzMpAdY6qgSUcSJcksjCzq++guedGdQ9K+Thvm+GFzhODuOttlAYBo9z/ZkHHo7UqZ56znnJggkII/0EFaeUVmjuyGHaXtc5khL37MOdy+UB34CrZhNg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893843; c=relaxed/simple;
	bh=bEQA/GxUIVi+8OVTZ2O/kfCxWO2fjdAdbUtXnz6dhWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLdWu9gBnxcH/4RPU7dg+UY78RETknPw7c9BwTsClRsZa4CkrOUxxUp6sLYXNvhUnmPc5nvic17Pahi3tRv/2hffUyYZgh/GyB0FMUgxA0qOj/qV1FlWEfrR3AszHmcUkoHpyJ6ITzpioprSvqiaZ+N9ENvyr03GShZowA8YBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AE00LieU; arc=none smtp.client-ip=13.77.154.182
Received: from [10.18.189.188] (unknown [167.220.238.220])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8594C20B7166;
	Sun,  7 Jun 2026 21:43:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8594C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780893825;
	bh=wYKrgO8LginE++yguspy37Ps284wCQjptPjsoEmmma0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AE00LieU1Ej+YX/kl6T2rCVqSFhht9nO013icXCqdpir/VQetkIx0qooMjqogfu/c
	 8vdszPshQNaVgf5sQf8dk6xEFeryevVOxMB/NH08XhJyboWZ8jFz62ce7wFlli0hJV
	 IlYbKKlw1NMMn7MAwsI//oV6QPfKpjRcGT6JfjnM=
Message-ID: <be4538a8-88c8-474c-bbb5-7a2a52fa2e5c@linux.microsoft.com>
Date: Mon, 8 Jun 2026 10:13:55 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org,
 gargaditya@microsoft.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
 <20260605182748.5f106575@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260605182748.5f106575@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11526-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shradhagupta@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:ernis@linux.microsoft.com,m:kees@kernel.org,m:shacharr@microsoft.com,m:stephen@networkplumber.org,m:gargaditya@microsoft.com,m:ssengar@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5847F6529EB

On 06-06-2026 06:57, Jakub Kicinski wrote:
> On Thu,  4 Jun 2026 01:01:24 -0700 Aditya Garg wrote:
>> Two error-path fixes in MANA queue setup, both surfaced during Sashiko
>> AI review of a recently upstreamed patch series.
>>
>> Patch 1 initializes queue->id to INVALID_QUEUE_ID in
>> mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
>> firmware id is assigned does not NULL gc->cq_table[0] and silently
>> break whichever real CQ owns that slot. This mirrors the existing
>> pattern in mana_gd_create_eq().
>>
>> Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
>> an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
>> it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
>> and a spurious error in dmesg.
> 
> Looks like these patches were generated against net-next, please rebase:
> 
> Applying: net: mana: initialize gdma queue id to INVALID_QUEUE_ID
> Applying: net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
> error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:2351
> error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not apply
> Patch failed at 0002 net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

Thanks Jakub for pointing it out.
I'll rebase against net and post a v2

Regards,
Aditya

