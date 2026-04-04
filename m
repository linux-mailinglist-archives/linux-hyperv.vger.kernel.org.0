Return-Path: <linux-hyperv+bounces-9982-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOyxNpqv0Gnm+wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9982-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:28:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E039A20E
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 08:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4FD3017F80
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F14378819;
	Sat,  4 Apr 2026 06:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4M/5nzd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E37107E
	for <linux-hyperv@vger.kernel.org>; Sat,  4 Apr 2026 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284119; cv=none; b=MRfBlxKdi4J85w07VwHX3xs/tKwbsf8q4rXjIXtGVgiJ31ELLwGslkzmPcTx4NHNmdJjW3xKGd7goDsFNdN+KP5vrSL3Hy7PRXKph1Ny+TTYkSfNNn/4dypW2CZwZmxPNkF/vz6itWyvdcwhypVTF5dvqIIKq3Cr3n8TqxS+yXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284119; c=relaxed/simple;
	bh=hwTFZRoADlXh/N6qW8gpb06kXvexppjqxyBSIsIzn0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K0Ue0qOj/KZKdq65sYfB4prxjCnd9VbKwC6hXtWpq2GVrIMSo35MbydlGfdvOt1qpgN4OMwlQsXqwiQod/UYJg8FtsiBFQjk3EabO9v8vpAb6Qb4sjo8FaBt+mrSsjd6Owp2QJiP1MW+gZeTUDx54y2IXDf2Rnm/3Bf49rWZANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p4M/5nzd; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2876431eec.0
        for <linux-hyperv@vger.kernel.org>; Fri, 03 Apr 2026 23:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775284117; x=1775888917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cgZZLGPezZdvn7l9dIMqmT3RJ+IWbeo+NSrliAQXbM=;
        b=p4M/5nzd+Dr18QEyK5bADWvrdYjlSw5J1wGDOmv6CFUGRC3PdwE44QVe21DS7NRL7W
         WO5M49jQSYOo/r+hWyv8UEzwZqK70QkQ9UgZyvDgvo2Q5+p3qJLSAxwwrrzsFtLJKgWM
         WOguI2Jr2akCSZ+uxjZE7ynXmMWI+c297i6SdTtEqH/aFiEFzyzgg07hyc6IRVaPXVSF
         wowzH/AorGjkHeGZxQYX3MHXxGsVFGZLSDx/u7O/XCPKiMkH8qEToMwI5MkQ5PFEQiGb
         7QbB9aaEgkp4OXenJODUJU2GONAoSM/cf6DpKxONGyhnTGT9+rJHv7T9atrR2ghMy2k1
         AqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775284117; x=1775888917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+cgZZLGPezZdvn7l9dIMqmT3RJ+IWbeo+NSrliAQXbM=;
        b=mkhsfXf33A04Ijsimc1mHMQlt3ULbWq8hRxw+7L9lwUq7jifGSLAzioabfrDBO0xb4
         EfGRFbo0r8ag9VFjKHdFxJxJS5P+mg2r0jsgDBEFnipLlhDRUaI+TrnrHWs9SsGp1RWF
         ExRZDNbvgeNKPH+utP5I9/ZV2rJmW7YW7HHINX3dQ43+9Aseap1Fi4oGSkid5OVucGRH
         JY39D6r5TSz31hhDq01yCl9AWtb1hoCLEvaPjb6JH46lvziqO+hNzJ8ztSRUd1/SMULV
         F54aUKRL1lshok7aNjGpCfAImNWwd12zs0LsBX8Gp5qBijQwwGIrFxkzGZp+aDkHw+uE
         c7Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVrwdh727wko5bzajEL0rmMgTkIS0Iemlkt/+QmjuyR2mim1EljHitzB3Iv2d4sc3bJW9vhweon8kUHNgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6eYlyBvfdQqLvxQ2R1j6kf3okuHgLbAIi+sftJvevPoyUMhI
	hdkkxS8dKpakFWGCbjh0lE8yiNLZpaCMJJwyMpSWTV/mcUaejGLzYnMu
X-Gm-Gg: AeBDieufLAfPI3zuC/Bu5N/MNZUrDNNN6UTf02NMu6W1SnkBymMsGjBoEy5IvIY/Wff
	kLjv7sOk5nUGDeK6v8s6AMXspS66E96rRrsEsCJzTL0yWQ2z7ZZ6AmpdnwyaT7TzTSmcjH7XwcM
	05osRtcIRKqNsdcw2vo5JtPcsPAHxeZaGdtQj18of57uI0PhEkqt8rOgCoIgGjRpC+y1dm/Exoq
	OsflM0ntwyPIuYLLIB6A+cWRorvPxS/NBtBh3PXkRhBAJ32vT6UFEXTVokfqLkCFhWJNTOGu3xY
	jVJeTFr4pDZ3z9WYbNDgc4cdFGCr57fqnOkMCQCjD1xqjDJp/5HkF3Zl7MbR/RVvpponPlpO7bj
	0jVaCVt/za0LhQb5NoJP0uC8qFwC2eevtNhvGvcUbHhhZ9u5qAvmTxD7f7NoaN9ZAJOPmfj8cMI
	bYxumsSkirbDlK037z2HnTbLdfRfqtcWQjLgEJ/FyfaJZOUb5Htj7v+BughjEq
X-Received: by 2002:a05:7301:1001:b0:2cb:990a:b5e with SMTP id 5a478bee46e88-2cbfa5bfb54mr2868306eec.15.1775284116940;
        Fri, 03 Apr 2026 23:28:36 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::1057? ([2620:10d:c090:400::5:9b00])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cc6e17e0bdsm3433390eec.31.2026.04.03.23.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 23:28:36 -0700 (PDT)
Message-ID: <62c3fcc1-6758-47c4-984e-f6940139de0c@gmail.com>
Date: Fri, 3 Apr 2026 23:28:34 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: mana: Fix probe/remove error path bugs
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 gargaditya@linux.microsoft.com, shirazsaleem@microsoft.com, kees@kernel.org,
 kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403070948.9225-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260403070948.9225-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9982-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B0E039A20E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/3/26 12:09 AM, Erni Sri Satya Vennela wrote:
> Fix four pre-existing bugs in mana_probe()/mana_remove() error handling
> that can cause warnings on uninitialized work structs, masked errors,
> and resource leaks when early probe steps fail.
> 
> Patches 1-2 move work struct initialization (link_change_work and
> gf_stats_work) to before any error path that could trigger
> mana_remove(), preventing WARN_ON in __flush_work() or debug object
> warnings when sync cancellation runs on uninitialized work structs.
> 
> Patch 3 prevents add_adev() from overwriting a port probe error,
> which could leave the driver in a broken state with NULL ports while
> reporting success.
> 
> Patch 4 changes 'goto out' to 'break' in mana_remove()'s port loop
> so that mana_destroy_eq() is always reached, preventing EQ leaks when
> a NULL port is encountered.
> 
> Erni Sri Satya Vennela (4):
>    net: mana: Init link_change_work before potential error paths in probe
>    net: mana: Init gf_stats_work before potential error paths in probe
>    net: mana: Don't overwrite port probe error with add_adev result
>    net: mana: Fix EQ leak in mana_remove on NULL port
> 
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 28 +++++++++----------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
I believe mana is already in the mainline so fixes go to the net tree?

