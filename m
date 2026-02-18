Return-Path: <linux-hyperv+bounces-8876-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W8ZKLq4plWmkMQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8876-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:53:34 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E290152BDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 03:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25164302001D
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5047F2874E0;
	Wed, 18 Feb 2026 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gayNSGhB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C861B425C
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771383211; cv=none; b=qH/fBaq6oHxo34SmFQXgXeDv0/qpj7o0gbXBQjPFnEIc6KCNRMYf7B4ExWkV9LF2RmqrVmp3BLljjYgY+TkAZ6dPIXe8Y+ZLKBUY42rAKzdGM6v0n6+SyT/4Z8rwRpRh4k75ox9lrhat0KkRnndizglODcXgkQhbRFpXorC/STo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771383211; c=relaxed/simple;
	bh=ac2XxHEaTkFuv7UyIRLD6z604IhhBl4SwJsAujiwFK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RMxcCIN/RC7TA1QEp/0PvwCsaMTHrDAPc37fJbbX2Ma93MefJczAJqu35G5ud/yI6yQrW8r/deXrKACr1HIrJEyJpsPOeU/xtfttNqjQngeaQ30+sGVQsWxhkGW/Fqngl++IszKRPgdoXtp61We4epHAxJYkZFAxyItxtDskLD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gayNSGhB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7950881727cso30566317b3.3
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 18:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771383209; x=1771988009; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac2XxHEaTkFuv7UyIRLD6z604IhhBl4SwJsAujiwFK4=;
        b=gayNSGhBayeHXXe6sVnSPEsFluy7TM4ZsSa04g805udc/9f6wxPabGnyMTfwOh3vHl
         glyQ8cB+Al16uztpznSrw4Yf53vyZtVlgc37LV/UyXCZ/nTULZypigHmT3wCWJVtWAvA
         2ajcUfT+WlhYgQlnlP6Ji0rwxU6Az8QWduWbxnaUeR382QwUqxZdILS+JX/fcU4/XlFl
         BoKv/OMclQBZ65XfPrOSUdaTQoKacJit4LU+J/8ZtvLvW0kJXsmRajAuq2DP2/mulajh
         5j67UUzVhN+sl6u5PjjkellBkRor34mfUT61fs1Yh5VRVgQdM1cq+mDYRwh1aPC+4zmp
         JMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771383209; x=1771988009;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ac2XxHEaTkFuv7UyIRLD6z604IhhBl4SwJsAujiwFK4=;
        b=UaexLzNyFIlS1XfHgx8atEXCDLvygDnN/WnTUddo18j9pMO74MiiOEovLuGvr8a0P3
         LiJOmKbGJf03a3siQugkGsGvFyNi4k6ZxoBj/iy/Gfk7Y3PfV8rCyCdvzV0n5qaPOUyK
         cxwm925EjpYB0RxxA36FWwqbqdEV+b6OA9Qoon5ZjxgV+fSdahRkmVmvyXHNkTDBS8EA
         8Fetv02wFqSjYzM05Q5Bs9tsA7E3xuKa8uacAEn5wBkAVOwbBHKjwo274KAPpP7ynd3E
         kitHnJiNJYl67n00EM9UnGWDQq3FabxUTAuSwfAMx4cyzrPDgqOIDtywFIpZt+cdIu7c
         XWZg==
X-Forwarded-Encrypted: i=1; AJvYcCUPTc4Uw3o1dAy1IKvftb5duLWrrpgIVuBAlkcmr1MmI2jmPgsEYuqrS2yKWj3U5Ds18GEJUVOahqHakbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF5EUlmzIIxrsKHCgT/EIZq4YxXXvcdVHGtk6kVVPZ5IlSqLHX
	4orXzhaHGiMQzyQQCxpQyZPMphOVQgy3UMKdgn1ezMZXWjtLg0Yj4T8N
X-Gm-Gg: AZuq6aLiaG7IuI2ZcIgoWbXMsxsBTNoSBLONJ72mnCQ5j23+PtV7Iw8hS7tshGo1TdS
	k7aW9dgHcPH9ZOigbuOY/zUt+NcVdV9gQObFX4naIp/UlWt+J9qhhGunBp/wwEJJZxPS/T8GfAs
	MuZAbCI5rMQwk+iiDrWu74HzNKE2KWYRwHoZ1t8aGG/d1FkAOSkzrktd/dnjsRqi6pvCwgiVktU
	9Tyb233Ov9gMBISc2RgYZoG621fm8AV4iaQt5pQFVWDoq6DXBEOPTvU7uvbz++aYcEXZHd/TEJI
	Ggf/WuQ6dhk+b7fciKvt1d853EdRtC+kA27lSpOA5Z6OJw3E40WjVAwmkbAbegHZNag/11ob7z+
	sG05jShaJE8L5jyCRDCcLhdvYkKY7CAlAYXkyb67VOKwC3jtO6e3ADP6HaRydpAb9ABh7sMLpOs
	Vm5mkkZjKOehVTvFZ8KXNhmRgq//eb59wGnzxP+b3HwjACeLLOJIMuo1xA+7JxsaiNesefq8HFg
	+11QCmQM2FTu135Xw3T/dCAxVIDFIwxZCHosrGreeTwrYYyx8TROvIfR2Ti5A==
X-Received: by 2002:a05:690c:fca:b0:797:e4f4:72a6 with SMTP id 00721157ae682-797f717b016mr6632277b3.13.1771383208974;
        Tue, 17 Feb 2026 18:53:28 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22ead7f0sm5423023d50.9.2026.02.17.18.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 18:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 20:53:11 -0600
Message-Id: <DGHQXO0DOY0U.V7O2PSAUE47C@gmail.com>
Cc: <x86@kernel.org>, <hpa@zytor.com>, <mhklinux@outlook.com>,
 <ssengar@linux.microsoft.com>, <linux-hyperv@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyperv: Fix error pointer deference
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, <kys@microsoft.com>,
 <haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
 <longli@microsoft.com>, <tglx@kernel.org>, <mingo@redhat.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260218024351.594068-1-ethantidmore06@gmail.com>
In-Reply-To: <20260218024351.594068-1-ethantidmore06@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8876-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,microsoft.com,kernel.org,redhat.com,alien8.de,linux.intel.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,zytor.com,outlook.com,linux.microsoft.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E290152BDE
X-Rspamd-Action: no action

On Tue Feb 17, 2026 at 8:43 PM CST, Ethan Tidmore wrote:
> The function idle_thread_get() can return an error pointer and is not
> checked for it. Add check for error pointer.
>
> Detected by Smatch:
> arch/x86/hyperv/hv_vtl.c:126 hv_vtl_bringup_vcpu() error:
> 'idle' dereferencing possible ERR_PTR()
>
> Fixes: 2b4b90e053a29 ("x86/hyperv: Use per cpu initial stack for vtl cont=
ext")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Just noticed typo "deference" ignore this.

Thanks,

ET

