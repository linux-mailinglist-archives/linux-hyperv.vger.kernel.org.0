Return-Path: <linux-hyperv+bounces-11022-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLgUE25KDGrjdQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11022-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:33:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEBB57DAF6
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D67C531A8A27
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 11:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7A025B663;
	Tue, 19 May 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9UTC5nE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lqr9PpuP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88983A3E9F
	for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188415; cv=none; b=UTW9dnJYNPe0UpRohKVBetx51Zo1cy8RYM1VKfeS5BPjzaUfI2chZLEAAzAJjQgO5V5sCJfSP4/wqbgYcDcigl+x/RFQHTcwRs9yMqRRzUzdiRmnQwDhOAcPNf7VW+Segg6u844jkpagUr1hsLse2NGarUH6a6gKyQV1QI2baeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188415; c=relaxed/simple;
	bh=n5B6+29nvQxZ/wHGFunRXCweF9/I5ooQyav/joDC1Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q1vywbQnCUwkhgmIGWEUGVnZ/jrkuwtpoJCa5BqDVoPVJyb5N0igFViPWDaToLzvx/fLcLMMXEUi1CE3WSeMENxyP8DAQnPOwTUt1AGwdCnB0D1wgu8vwVr3ZIXWk74cM3VXA/b5XmvRTpCQiOA3ec0f5mV9hIgcT47WSNqmMYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9UTC5nE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lqr9PpuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779188410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E/R7pULBaPP9T6iOFYumwv5ZvUtdIBTximZQUVwysfc=;
	b=O9UTC5nE/tw8cCMyKszOzr8CSSWGaJlzpHD729ZzsOjo7jztr06k+lec72L3GMCvctP60l
	YRf8rZzzsSww+e8w2Q0r7fgkpJrY+PtPMguAeHQMpoeys62q+U9Y+cTqKclYV+/8vy1nq3
	547ku1jP6FAqGoURnxH7eVzr1P6XJAU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-2wGAhg1XOKGuZkqv6EIZOA-1; Tue, 19 May 2026 07:00:08 -0400
X-MC-Unique: 2wGAhg1XOKGuZkqv6EIZOA-1
X-Mimecast-MFC-AGG-ID: 2wGAhg1XOKGuZkqv6EIZOA_1779188407
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso2980523f8f.3
        for <linux-hyperv@vger.kernel.org>; Tue, 19 May 2026 04:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779188407; x=1779793207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E/R7pULBaPP9T6iOFYumwv5ZvUtdIBTximZQUVwysfc=;
        b=Lqr9PpuPjwo3YudVUUXbjouAMXWS+euf1Q5DySZWiYXjCryFE6TpDjrcWtI8rmNXXI
         DkVrheFtgzD9skCrS7XWwEgFR7QkmzRP1KeZ/EaAf/0XxP363I+gUDbvXXp/Y+PmTl+D
         tfvDP9jqms+W1rnbY/8Vo0HYJ/HHfJsz7Hs4oDrkd5qIy+jvVFtll/D5PanmoScs4JWM
         qXabsy3X+SxSEyP4laaRHNtWQtiVL1Owa12taeJfZjh4wUsEkr8OFY3djnjoShA8v+Ry
         zaFBznKWySCXDeXY7xikvU3VaJO02jQnI0M4NjrC1U1H5d/LQyLS7Vr63R2hQ6inWlM3
         XpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188407; x=1779793207;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/R7pULBaPP9T6iOFYumwv5ZvUtdIBTximZQUVwysfc=;
        b=feuo8kbLeL1qs/2CE8rXwYH2VxHcmJXdjcrlHVf/kl4T1j423/67hbsfYzkyFYdKFA
         GiwYLcG55MsZ5iyLBoccoY7o7J54GZYMXHdTQmVutZUpieKvMJSrPqM6v6Z1GaYvUAA1
         03mW8JLo9OdY5dTX8WyXIJeGmX3oKkUiMX+bGVUlfKNhCFm8p/326v+rwNm1Z4TZ9P06
         hkX5a2CGXN19uANFGpJ+CAfXdbPwvcnnTQO31IgCZdTvfRFdtXEf6MmiFoK69PYokry5
         sxLYdH3nVvp8OLaK8lVor613GzHqm51pRco7z8BbIy7Lu6EcCRGXoguylzshi93kBbw0
         kNYA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZKhOIbA7PIku6dIJ4bZrGQs56+vWa0iUnvH6StB84rCFYweiIaEbyb5RIywkU1jq2aFyhgKj27z3kkmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqQEWL911cqKekzgc1+9t4RVYQovZVaDvmyNsdhIe6RWWqgWg
	lfDz/esfkl98xYY+TaOPzjVHmJdcVUYlwJjZCIZO2vuA8X3SzkjLc8yXsTufvp7oGnF6pYKyYsM
	T7Byder67tSONodqrNlIdHbpniC04RjdYrYwnNdsusWEB5TIAbnCUJQDFZu2Bd8mvNQ==
X-Gm-Gg: Acq92OH1Synp4VqtQKiYLY7GAEmqNuTLd6u8FVZHug+ORs2Brgd8lTOD/nfzsqbV/Xi
	ahUjHX+jSJVNmScS/C5D3xbbWexvR8F8XS9ToD94YIn+e0w//0IaGtWpWZYQzVAMWRmD9vKZvNM
	F4rwU2LbGZxG9UXqpzsnPp8VLBM6nMjdfeJLVzPljsquLhc4mOMElmIRCuRxsvkxP6u9qdsMMDb
	MPeNkBbhr7bhHQ0fhuPSk46B7u/EI9WOga5zmZGmhGVRO/5/nlLbM68RBBRdmVuWwIuLGkk3p3h
	+AX9VGvKCTOArkbAH0ZtKJrvO3a6KpeEWw+ieQt1ENkNnrJxX/ktUhifnxPEMvb/S9iqj+EpLQO
	GCTN54en+1OlVV+9znhwMnZgLyvBpCqdBYhnWeN6yqa79Ap1STz6I01k=
X-Received: by 2002:a05:6000:40cc:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-45e5c5ccb3amr31758316f8f.35.1779188406934;
        Tue, 19 May 2026 04:00:06 -0700 (PDT)
X-Received: by 2002:a05:6000:40cc:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-45e5c5ccb3amr31758224f8f.35.1779188406402;
        Tue, 19 May 2026 04:00:06 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768acesm47847795f8f.7.2026.05.19.04.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 04:00:05 -0700 (PDT)
Message-ID: <8a33f35a-195a-4f1f-9282-85f68399b89f@redhat.com>
Date: Tue, 19 May 2026 13:00:04 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mana: Fix TOCTOU double-fetch of hwc_msg_id from
 DMA buffer
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dipayanroy@linux.microsoft.com,
 horms@kernel.org, kees@kernel.org, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514194156.466823-1-ernis@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260514194156.466823-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11022-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DBEBB57DAF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/14/26 9:41 PM, Erni Sri Satya Vennela wrote:
> In mana_hwc_rx_event_handler(), resp->response.hwc_msg_id is read from
> DMA-coherent memory and bounds-checked, then mana_hwc_handle_resp()
> re-reads the same field from the same DMA buffer for test_bit() and
> pointer arithmetic.
> 
> DMA-coherent memory is mapped uncacheable on x86 and is shared,
> unencrypted, in Confidential VMs (SEV-SNP/TDX), so each load goes
> directly to host-visible memory. A H/W can modify the value
> between the check and the use, bypassing the bounds validation.

Sashiko noted there are more related issues in the nearby code:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260514194156.466823-1-ernis%40linux.microsoft.com

you may consider a follow-up.

/P


