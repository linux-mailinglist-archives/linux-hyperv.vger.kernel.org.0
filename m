Return-Path: <linux-hyperv+bounces-11397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FhKI2IVG2qP/AgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11397-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 18:50:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 109B560E7D8
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 18:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BDDB303CE1B
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5680B34EF07;
	Sat, 30 May 2026 16:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Zm66aS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBE33F5A3
	for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159679; cv=pass; b=In6WtNbIyTcg9XKEpu+FkTzlopovooZnxLzaCIu4VbaHcahYSPqptdIVf2sAlqeExK4WpGmCknb4M+L4A//a4xR4Hjs2VC6cFFf0GIohqlwC6KR5EupzF/bfgHoDFwmkZ40fAMgFS6xqNYLU2I8wcwN/B6q39cPX+fEmXzh4q90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159679; c=relaxed/simple;
	bh=NO55GTUIErfjMW/u3wp6zeJt9pZ5TEdqDypSXTrdktw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DWr3jmBjGRU9N46pCwEhEK68x3rfAB96OzvYRNDFJfcZ5BGqDaReR6CJOElaLiGdvmiKVTuothBY8tYX4Mh47ZEvzv0PHkymdXQ47dFW5PW8BH6f6eWUj8BsJcu9xMDIP3e9aD5TTeZmQBxLar4ng+k+xyEhs7uB1Lg2HO3rzbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Zm66aS; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bebbc325000so33173966b.0
        for <linux-hyperv@vger.kernel.org>; Sat, 30 May 2026 09:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780159676; cv=none;
        d=google.com; s=arc-20240605;
        b=GNP62k3rONt1vnBCxBQnY1TsbzOwFzydDxJcZ0KvqGoyHmRgxATUkIc8CQqhj21qYO
         je5ZfB590ZZq1ekyfG5E0eL/Agh5RBOU77g2ffVCTmhr3ixNoXpizLD7oa5NcPSkegZ8
         6qdTKfwyriEOfnlN/VXai3PY29jf8GD8UFjAn58gkzzUD9h7xTqhONid3CsTq4KVPmXD
         t+OJyW/iWp3thoeuTCWi9mH9sdpDevMInFpeqm5b9e8bVAyjZh11VzrFJnmOgBt1epm7
         pfJ19oZ0d0Bgds+AYMTvMCZyvZI8QNsUaaGxRpulJeAG5yjLBzHFTLq+5i+2Ml0KT6AL
         JSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        fh=e4WTgSXGzVy/RDkd7QIFi1vknKJGHk6eIJmeVWWJXaA=;
        b=gtXjvjHqkD8+V8f70aPWyotvC1dIAxp6wIAnbMCZaYNsi48bfz3p0QaUt8n2r7A53k
         E2tsZ8Y/mKiKSowMEfNX66bb5kNTynEvZDRhqWkurb0f2mxFhd1OHlMdVYrRlKwxv8ko
         sf5JVzc/8P7LnjsusjZ4gXVXN9aOcadKGCyCZQy23lCZLhDWiW5/LsEdhEROTOlBeoyV
         mMMqr+alYyf5vuMpvjmKdezH8o1kH9vDX7q1QjtCLUUgEyZH47uS1bRB8pFT7YOoXlqb
         vVGfhAwKOChGTKABRCcnUHWgz3TcoxuTCO1RDVaHWx0aH9xasL8K+lizNv99wmTJXzq7
         8BTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780159676; x=1780764476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=T0Zm66aSY3sD9Rf6K2p8uIg8DeLbBuEr0xEiATqw1pUjw1ctLRW/CAwskT19nTHK0I
         uhva0xhmzKgtjI2R2qv7Z5tDk5QCud4UE1KceuCb9j4RoXobIUCtq5dA+C44ICUpFeBd
         aO7T8GCA7Wxugn0PvwdzAEva/MHS7CHSa+kRtY6Sljx89GweUMD6mGyz/9vTld0F/DYZ
         vBysRfjz2lwMqEo8gh7bqebfRA9r/XqWzGB/uCR9TSW41Ld66pzE4OqamBvo0mOuegeO
         K9y2O7LkDlnQYTKLMF60IkRAKVDqNhVQeHb/lJGMWV5EZN1Zs9Z4dSI2juefl44lwyOk
         81rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780159676; x=1780764476;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDjMWTL59bSew6EuBBjyiKQsK4J1StRuWvcVY3hIZ9s=;
        b=Ko9ZZHq1b0wgERThZgYRR3L5MjHNQDxFQoHwEM56XaE5njvtdnQxKqB0+Nuv58Kl0g
         teVA8DBP/UjIz5Mm/YDsflON1JC48llQ3c5/PxiWUp78ss/4Z47/lmyhN3Jm1BidoRUV
         3WY0qZs1QTXMV6a9KF4rXzNedbKmxI+w/kRD7XrurBBdUsk6vS5PVMIbc3N5js//51Va
         4UQMUowRDZoV/emuOE3FAsiDoegS5zEfILQij7YkWlUzYXJzCU6nUweZdEc8GLqjsbvp
         05Qg0mkQOoTB8mC+3SqwbfToS6vKewj1PZsH++SNx8i5hRzyKLw2M+a1UwMgZ9KNK1+H
         3YVA==
X-Forwarded-Encrypted: i=1; AFNElJ/5X2j+LvWD9XCH3JmkK4Hwx3IldOu6awGVdrX86iodEhSsVWcFKSgg/zL8k+mfQ8a96juU+fOq4OFrGis=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywto/hM4nutkhp7UtIbCMwk+YpDPIMIjKzbSVByqYKlhwKLq/bF
	0dM1OuIh/s89v2GKW71NtQWbsoBRG7bxvN3evSzNxlyCKyB5GQJPYkpjcGk1gIcZJqFdN1fivam
	Na4Dc/qMwAWUL6XVKkztSUhOvC7ibKKE=
X-Gm-Gg: Acq92OE4b8aCwojky/RBYGw4qv9oXga6nFJRkzMN+H2ekAOWSeTv4d1yRitPSYW0mVr
	VHxU3IRfv5XetnwFMlPhAtZXIJ9WC0N0t5mpjRMC72Y1yjpsp4oJ2CQX3GJraNLwVS9g4eMr8pQ
	v4Rq+F/ZNVzylcK6OLE1nrT7J1o7exfMs7UXHIoYYGbhUJHrW4p5Vcr/Oqplm4YXEmOFaMjMYdd
	a7en6ZsVT+LXzmuFwAxAL/PDietNen6CUBMm5BZ4TkwfEvHj9m1vC4/iF2dpqij9WX682si4+AP
	MFZqissoti4JSxGhjV4hjM8DmMSXnJ+9HpNY+NyDtk9XlBV/PA==
X-Received: by 2002:a17:907:80a:b0:bae:d29c:4e28 with SMTP id
 a640c23a62f3a-beab3850c0emr227580166b.12.1780159676193; Sat, 30 May 2026
 09:47:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Sat, 30 May 2026 09:47:44 -0700
X-Gm-Features: AVHnY4LzRI4mtM2MVMA9vVPgTReaIAtSfV8wr74SnOQ4vnVCBcmxdNjiRFE8TOw
Message-ID: <CAKSQd8XBoaUf7MyvPJCv_DHeuEd-DtRYb5GnAofkbJTP89LLMw@mail.gmail.com>
Subject: Re: [PATCH v4 15/47] KVM: x86: Officially define CPUID 0x40000010 as
 PV Timing Info (TSC and Bus)
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11397-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,alien8.de,linux.intel.com,microsoft.com,broadcom.com,siemens.com,infradead.org,suse.com,google.com,zytor.com,intel.com,oracle.com,vger.kernel.org,lists.linux.dev,lists.xenproject.org,amazon.co.uk,amd.com,outlook.com,linutronix.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ludloff@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[ludloff@gmail.com]
X-Rspamd-Queue-Id: 109B560E7D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> + *  # EAX: (Virtual) TSC frequency in kHz.
> + *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
> + *  # ECX, EDX: Reserved (must be zero).

Can someone from Broadcom please speak up as to
what a non-ECX value signifies for their HV? (Asking
because I see a value of 2, not a must-be-zero.)

--
C.

