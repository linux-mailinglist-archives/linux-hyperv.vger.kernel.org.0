Return-Path: <linux-hyperv+bounces-9728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOK/ETJxwmmncwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9728-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 12:10:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6B83070E6
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 12:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4E79308FBE4
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 11:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E773E6DF6;
	Tue, 24 Mar 2026 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsTKp/qv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZ1meEOg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0589B3DDDB5
	for <linux-hyperv@vger.kernel.org>; Tue, 24 Mar 2026 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350225; cv=none; b=Q1clOpKxGwznCSjSFWCwJ2B+WomZGUVjDn4ZkXzBRoNbwYU8CL+5w7tK7JdiakCd/6jKiKW6Rb27r+wpSFRMwLmxmIeTnkfnKbfyGCQghcHC5GCzjm/srHm/BF2KqtSLfrxqc2FvYm+8yGInV2CwWHcA9suqnzGcix6BQ+vIZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350225; c=relaxed/simple;
	bh=7UraO4dglaksPNTanlAZQ41lUWjbrZ+rn/5BdzV3KGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBehrMbSwNN5K2lF9adtiWCJXEBAXQO9nlSxTP2lH0QUv3mqrzeemjjh7lSDZzN173HZ2EoluXi0k92sEtTGNtWjmmCYeH9x1DiZZnQeViHFhPGLmp+cGXiuBf+/tv2ykv+niuYEJlKo194ZMA8WHDUidFtg02vwYYIemDa+hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsTKp/qv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZ1meEOg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774350223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
	b=hsTKp/qv9X/bYbgSGzfbLpI/RZTkHkFi1njqmyslsjxnohcgow0H1ov4JCcToqC9b513xa
	smVO2UJa5y/V6GZ71Cq/hNKzayAnWA1QxeSS/2Sy9eOzoTgLMPwsxIVOo1jUbN/SSrThnu
	bi5TITs/TVHlFv+SPjn+loRDk5gzMlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-rihmkjpjNXe9hwNKhjSv4w-1; Tue, 24 Mar 2026 07:03:41 -0400
X-MC-Unique: rihmkjpjNXe9hwNKhjSv4w-1
X-Mimecast-MFC-AGG-ID: rihmkjpjNXe9hwNKhjSv4w_1774350220
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852d27f473so28613925e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 24 Mar 2026 04:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774350220; x=1774955020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
        b=jZ1meEOgLDTFfxKvZASl3nM2MOd8mRr5d3tnWAcyESe/7Bi8sxxA1v6l20nFNLA0VL
         xQrPIbtrpeT3d/6ul/gfGw9jFyLOC+w5++r1co0vOam5LSN6I2/jK2yK7FwuFrFJJrJT
         dEo7YG3lDV0VPHF7HdPMxhgaLQc1RWwoKoFmuLN41C+yPK+HP9KqLtaE5lL10dHXaVr3
         sNHp96uxLo2datqMlc6ruu6BTnHHQMemMAM1bTpA5AATQEcNIpROpR8oVQpXnLay87VX
         qlEjaS+jkhSAGGyIVN1w0dlvAe/G8b7P4C3nQ3FM7AA0DaC/GhO6aNoSDbZugURh4lxO
         ZpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350220; x=1774955020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qn88B+Jk4xaYv5o/3ZZaHy9YAu2hPUmi4YuKkPVhWBg=;
        b=jwteJi8gvc7UpvmtKY+pBbK80nroBEHTdXncKpJLLGIvs2jvS8mQkou/1ZbVGdrBSh
         IlI2zlWhQ+d0xzk+08dFvmUGrbE9Jho+uttcyEkFMaTtsmWN43upgWcA0gnPa/YqWxi/
         77eEEIsROkR02jRlpsduiOSd426zUi9oIIbXR7xrqCAviQadQ62tBbzJzXF4FwgTES58
         nHb4wVigEnF+oACRpEO/6+3qcJQ4H5YE650N6u1RMDPegSe9GeIv0YGyBjSdO0yLh7/g
         LkGRevwbjUDAve/Y2s4Sjnp5QWe9iMTGqfhV1KaEmlQqp6l3jrd8picHPPIaVUPSyigv
         QMmw==
X-Forwarded-Encrypted: i=1; AJvYcCVg0Pqnu9/a81CCOcp85qzRFGXEn/ZFb/la4vtII7al1396rjm1zde6n2ItqZmzM3evitzXzuoGfpeCLrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7154cqGeRa8OJ751o+UBBya9pbKp6RpXgiUReK8dHyV3VG8gW
	ENHudRF5zzVqID8JzVrL/Tbk+rPEfA6jC7myM1bQ8g51XiOWI7epGvXxzGNoQU7Pxz5/TbEZU5x
	v96TIVy+qGbPIqncvCD15ONsadmpMZMpyewrkrVCZo4gEhEMTlVxDpMdKPNB7gKX2zw==
X-Gm-Gg: ATEYQzyuzY3CeNcBNWQz3TyqecNIN8f2NJBdKaYA/KDdK6Wa8hE6oVynomVTYOazMe4
	mLNQB/zTPkOyLXtnMh2f25ZT9cI+zs/ZmRBNTi7FBg6KHABr4MkXA98OYRaUjq59geNQzVXFU5z
	5+3c3FNMp2uJIsB4D5Zxd4E8PUf/UEl9wWl5XyJ25z/HZWCwHXYA3ze5WJgf9rXb+2IyNuSw+Jx
	aDnIvdnIhR5fcv2cZFcAV8ht9USVojf9SFnptZxzh3oFYeup7Bzo3um1BuvjAOgqEzPKLDZmfg2
	RZdcDgjcqUTPuVUostKNlPrRRv8ssdJBLwFLUfuzBDFgjyeeKymMlwd8v+9V0wWARouMIjOr18J
	a5IAtpf/r5kecQ0dnsM76qOD9OFz6XOw8+LNCR2zEoR1XJ4r8JW574WYD
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id 5b1f17b1804b1-486febb5996mr207492355e9.2.1774350220302;
        Tue, 24 Mar 2026 04:03:40 -0700 (PDT)
X-Received: by 2002:a05:600c:8219:b0:485:ae14:8187 with SMTP id 5b1f17b1804b1-486febb5996mr207491755e9.2.1774350219805;
        Tue, 24 Mar 2026 04:03:39 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c0c13sm83877085e9.7.2026.03.24.04.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:03:39 -0700 (PDT)
Message-ID: <c8fe221f-2e1c-47a0-970f-e7a1318a15bf@redhat.com>
Date: Tue, 24 Mar 2026 12:03:37 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Use at least SZ_4K in doorbell ID
 range check
To: Simon Horman <horms@kernel.org>,
 Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shradhagupta@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, kotaranov@microsoft.com, yury.norov@gmail.com,
 kees@kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260320122107.1560839-1-ernis@linux.microsoft.com>
 <20260321100425.GX74886@horms.kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260321100425.GX74886@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-9728-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA6B83070E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/21/26 11:04 AM, Simon Horman wrote:
> On Fri, Mar 20, 2026 at 05:21:01AM -0700, Erni Sri Satya Vennela wrote:
>> mana_gd_ring_doorbell() accesses doorbell offsets up to 0xFF8 + 8 = 4KB
>> within a doorbell page. When db_page_size is zero, the validation check
>> in mana_gd_register_device() reduces to:
>>   db_page_off + 0 > bar0_size
>> which passes, even though mana_gd_ring_doorbell() will access
>> [db_page_off, db_page_off + 4KB) and may go beyond BAR0.
>>
>> Use max(SZ_4K, db_page_size) in the range check so that a zero or
>> unexpectedly small db_page_size still results in a rejection when the
>> doorbell page would fall outside BAR0.
> 
> Thanks Erni,
> 
> I understand the maths here. And to that extent this change makes sense to me.
> But I am curious to know how a db_page_size of zero works. I was expecting
> some space is required there.

To rephrase Simon's question, this feels like papering over a
memory/state corruption. I think at best it deserves a cleaner explanation.

/P


