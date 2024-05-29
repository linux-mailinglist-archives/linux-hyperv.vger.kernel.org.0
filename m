Return-Path: <linux-hyperv+bounces-2254-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A308D367C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820FC1F21750
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 May 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93C181312;
	Wed, 29 May 2024 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="NSR466NE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06178181309
	for <linux-hyperv@vger.kernel.org>; Wed, 29 May 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986020; cv=none; b=ST5nx/mlzDIxTgrYyRYn5lCIkUkHsEtD9kCn/JGS3fihmVyIFRovlEsY4ulvHHl1O7N7GKMzLXMPV+u3OE5vaFKphjIfsALiBI6MTGeecEF29JUKC0GkEkxl1Ry2PTHa2KDbnQvgN/x0hxWkVyT8mGd6JA3F4BedngUQ50ey7Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986020; c=relaxed/simple;
	bh=Kjz4o7E9Vi+goRaYpgYsPsr72HU+LspMKlqcruc8gzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a8rGMg+/Taw4dnyFWS8/O1PZ2w3t/WhPQFp8FRbIuW14tdCbSX3uJMJ3J2DNzX2PhmKUbw0dJxte/CN+qM14UKFf5PahRjstIqtvZyBcPuXpjV/kwt894XEUK6mjAfdWK2/T4p7zqWXAsxQoD/nl/8fhFISpR2ylBetbNjB3AP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=NSR466NE; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso160183866b.0
        for <linux-hyperv@vger.kernel.org>; Wed, 29 May 2024 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1716986017; x=1717590817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjz4o7E9Vi+goRaYpgYsPsr72HU+LspMKlqcruc8gzU=;
        b=NSR466NEIO5ofKy5wZSHd2p2r5xA5rI/OqrcOuDiNQ1+oU5dh7jX1MlQHenETSvrpA
         tPHFfYQorYkF6ez6n1uhiIBBFlaUVdXFDgokV/c0YkSep76UHhvoislF7lbvcy7elKX2
         oaZ+oNUk2/DC4qiJKeIxMiPeadm/9JinQlUTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716986017; x=1717590817;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kjz4o7E9Vi+goRaYpgYsPsr72HU+LspMKlqcruc8gzU=;
        b=NEAEOVG3qTbpzaU7u6QWd7umhfeoJdkIBjpQY8CHOUtXJKlkHmIpD0JvExv+0S9i0Q
         VQAQ5sLeCT9NTRxzHyQBKnNTEI7byxFmzmgfnkLoN0jHXdmq3BfxlWwQOi1KLffgDRj5
         65ii1dfFA94CQmdP8KbTz683q1fasrXq/nkLokd78Mlwsj+Pt23wu1h63MQkqBX3AQ9q
         BdaSbsX63iX9DcGqO+sfcm07UefwU6XHGY/WiAbXvRULJ7MLysRU2MbMQSS84KyVS9Z6
         1oa3X7vOfLeNRnAycX1BnKSNV1m6PquVLJok8n3IkzK5e/Ql3TwcLs0ptyrLEDsLPp7D
         5aBA==
X-Forwarded-Encrypted: i=1; AJvYcCXAeO/SFSD2dbrDnv4An1I/YGhLU7xg2NxfBTYn3sraS4iZSqL7D7iH27TKG7MUA3koAqzhrosyb83ZoM4ELR63HVjkGKYhFjbNrT9G
X-Gm-Message-State: AOJu0YzqBg2NHa9NYbVSKHKd9uocDFk0CsZSZRBANQR9gQ8wX+PvMXY9
	+Vz1522eVfF3XILMIqlDRpXuEIzaiNSstFCt6uHCGe+VZj2bbVni6AsVl8rLll4=
X-Google-Smtp-Source: AGHT+IGiLc7AgUl827FgV2aZOE13ynn0TtZqmMLpd+MxfDu7nEToYL/rmYy1RVA6e8sosXqFNMmqag==
X-Received: by 2002:a17:906:40c8:b0:a62:a48c:1123 with SMTP id a640c23a62f3a-a642d2775bamr178860766b.5.1716986017274;
        Wed, 29 May 2024 05:33:37 -0700 (PDT)
Received: from [10.125.231.30] ([217.156.233.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a637386898bsm95138766b.220.2024.05.29.05.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 05:33:37 -0700 (PDT)
Message-ID: <55bc0649-c017-49ab-905d-212f140a403f@citrix.com>
Date: Wed, 29 May 2024 13:33:35 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 05/19] x86/relocate_kernel: Use named labels for less
 confusion
To: Borislav Petkov <bp@alien8.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 Baoquan He <bhe@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <20240528095522.509667-6-kirill.shutemov@linux.intel.com>
 <1e1d1aea-7346-4022-9f5f-402d171adfda@suse.com>
 <t3zx4f6ynru7qp4oel4syza2alcuxz7q7hxqgf2lxusgobnsnh@vtnecqrsxci5>
 <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240529112852.GBZlcRdI3oqBtjKxAV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2024 12:28 pm, Borislav Petkov wrote:
> On Wed, May 29, 2024 at 02:17:29PM +0300, Kirill A. Shutemov wrote:
>>> That jmp 1f becomes redundant now as it simply jumps 1 line below.
>>>
>> Nothing changed wrt this jump. It dates back to initial kexec
>> implementation.
>>
>> See 5234f5eb04ab ("[PATCH] kexec: x86_64 kexec implementation").
>>
>> But I don't see functional need in it.
>>
>> Anyway, it is outside of the scope of the patch.
> Yap, Kirill did what Nikolay should've done - git archeology. Please
> don't forget to do that next time.
>
> And back in the day they didn't comment non-obvious things because
> commenting is for losers. :-\
>
> So that unconditional forward jump either flushes branch prediction on
> some old uarch or something else weird, uarch-special.
>
> I doubt we can remove it just like that.
>
> Lemme add Andy - he should know.

Seems I've gained a reputation...

jmp 1f dates back to ye olde 8086, which started the whole trend of the
instruction pointer just being a figment of the ISA's imagination[1].

Hardware maintains the pointer to the next byte to fetch (the prefetch
queue was up to 6 bytes), and there was a micro-op to subtract the
current length of the prefetch queue from the accumulator.

In those days, the prefetch queue was not coherent with main memory, and
jumps (being a discontinuity in the instruction stream) simply flushed
the prefetch queue.

This was necessary after modifying executable code, because otherwise
you could end up executing stale bytes from the prefetch queue and then
non-stale bytes thereafter.  (Otherwise known as the way to distinguish
the 8086 from the 8088 because the latter only had a 4 byte prefetch queue.)

Anyway.  It's how you used to spell "serialising operation" before that
term ever entered the architecture.  Linux still supports CPUs prior to
the Pentium, so still needs to care about prefetch queues in the 486.

However, this example appears to be in 64bit code and following a write
to CR4 which will be fully serialising, so it's probably copy&paste from
32bit code where it would be necessary in principle.

~Andrew

[1]
https://www.righto.com/2023/01/inside-8086-processors-instruction.html#fn:pc

In fact, anyone who hasn't should read the entire series on the 8086,
https://www.righto.com/p/index.html

