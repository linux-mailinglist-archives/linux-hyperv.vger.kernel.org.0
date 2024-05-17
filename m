Return-Path: <linux-hyperv+bounces-2189-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB58C8B35
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53841F219CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF1113DDB9;
	Fri, 17 May 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhBCQv2Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A013DB92
	for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967465; cv=none; b=U32iEiHyFxfz8btYUmnhHJ4/Jxc3EpUsssYCt58ym2Vg9i75BtQD7ijDOqqyU3x2oGpE/Bul3numGZZ6P1VCDx0YsM5ESV7SRrjpIUd0ec80p+c0vPSvGoa7Qif47deRH+99ZOAa2pKub/plBGaOCk3xZ+jXmv708G+w/vlVA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967465; c=relaxed/simple;
	bh=4fwMhfzb7fiHGB6Z+7pTdjWRCgM/C43wT1KTzj+itQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzTMajW1CMo0hpG7zriPFOwkuKmGKwY2BLaQIr0HmZfAgNhP18+fowjTVP0I2kUaio90Vw5eX+pExTrYRFuiFxFFmFGz1A13A+6urMGAH+iujuM4/X1jijAXhwLkflMRglPl6HXx/MAh5/TE9NpZkfWdKBjpfS5ZQfhFPRFoQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hhBCQv2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715967463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NEWIlFygRFbrzz7CO5yPIyO8pAuoM+szqWUDzEi5+48=;
	b=hhBCQv2YLlRUpJ3MmD24jHI5dJ7PN5pdi3rdPcwrzcnCEYtcDl7tfheT8YMyJnOQmMChNB
	D4qkn+c3hYRtnJQyoLQPhf8DUdQ1ftfRK3qOv42KiGoz8i3mRNcvXVBYh+7SwU83aQeOUy
	b9rJn4ZEz4j6ZMEnVe7At6m3O+x5ho4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-MkeImVA9PAaavCo91Evz9A-1; Fri, 17 May 2024 13:37:41 -0400
X-MC-Unique: MkeImVA9PAaavCo91Evz9A-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5a8f3bc8e0so259079466b.1
        for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 10:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967460; x=1716572260;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NEWIlFygRFbrzz7CO5yPIyO8pAuoM+szqWUDzEi5+48=;
        b=cvKsJDlUrZ6JhESDqBWLwtZG0aopp4cm6TFS4gy7xeDh8++pFfiBiPhKv2/wRPfnxo
         O+nZhhQRgl3PY4mshqVNlklLcqm/DIDgaiAhSFv5tWStxY9uczz0y2O4fpU4+szS+0xe
         YAhD+LyVEUcgFCo7GT5FuZxEOLSJvEg1HqJ1OzsrceSAZHiNil0upA7xh2HwOhNKN4NA
         lliW+FW8reVQtw+IVmwXEm+lai/CdP0eibgHdzoYv2sJnlfxxjw/Bj7D/q9hPO52ljfd
         6n2KMrAoGlIhT1Ti+ZdUUBUfOPW/hO3HEmEqSOfJOOy8EaQS4vM9mRse5VKrCCat4CmM
         aaag==
X-Forwarded-Encrypted: i=1; AJvYcCXdzT1PyIlyYLgM5SUM5pwpBaRImDV4IXWsaZlZVNIx8q65XFbdiN4KTOIgt0iMCsG8v9IGNr5LVchazFw43+A0SMKubyaiSz2fXtnW
X-Gm-Message-State: AOJu0YwgWefjfAwj4A8+egXodU6qorl+uKct900VagxoQeH4cvrAtCHc
	nXoRTP8USA47qRxNEtsAoM6pD5uAVQOPeIY+34zdVjHKasfChSCSJIkN/HVNCxovQJu0lt1LBF/
	MUDqdcflJAGenmGaNkIq7LYOBZb+q0NyfJlu5/jsg2XJDOQ9NlzMPD7bmx5oaaA==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1371413666b.70.1715967460411;
        Fri, 17 May 2024 10:37:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKWPixH6mYyA8TAAYupqydQAjnpAf/qhf9Y/XZQ9Jx8TWF9XhpEP0k3m95s88l/5fQaoXnkQ==
X-Received: by 2002:a17:906:37d6:b0:a55:9dec:355f with SMTP id a640c23a62f3a-a5a2d676774mr1371412066b.70.1715967460070;
        Fri, 17 May 2024 10:37:40 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5cdd444323sm293562366b.183.2024.05.17.10.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:37:39 -0700 (PDT)
Message-ID: <611a387b-ba7e-46d7-b6bf-84dc6c037d33@redhat.com>
Date: Fri, 17 May 2024 19:37:38 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] x86/tdx: Convert port I/O handling to use new
 TDVMCALL macros
To: Dave Hansen <dave.hansen@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
 <20240517141938.4177174-4-kirill.shutemov@linux.intel.com>
 <dc292ce2-d450-400c-a0e9-c807aeb671dc@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <dc292ce2-d450-400c-a0e9-c807aeb671dc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 17:28, Dave Hansen wrote:
> On 5/17/24 07:19, Kirill A. Shutemov wrote:
>>   static inline void tdx_io_out(int size, u16 port, u32 value)
>>   {
>> -	struct tdx_module_args args = {
>> -		.r10 = TDX_HYPERCALL_STANDARD,
>> -		.r11 = hcall_func(EXIT_REASON_IO_INSTRUCTION),
>> -		.r12 = size,
>> -		.r13 = 1,
>> -		.r14 = port,
>> -		.r15 = value,
>> -	};
>> -
>> -	__tdx_hypercall(&args);
>> +	TDVMCALL_0(hcall_func(EXIT_REASON_IO_INSTRUCTION),
>> +		   size, TDX_PORT_WRITE, port, value);
>>   }
> 
> I actually really like the self-documenting nature of the structures.  I
> don't think it's a win if this is where the lines-of-code savings comes
> from.
> 

It's just a tradeoff.  For example someone could well have written

#define TDVMCALL_0(reason, a1, a2, a3, a4) \
   do { \
	struct tdx_module_args args = {
		.r10 = TDX_HYPERCALL_STANDARD,
		.r11 = reason,
		.r12 = a1,
		.r13 = a2,
		.r14 = a3,
		.r15 = a4,
	__tdx_hypercall(&args);
   } while(0)

even with the current __tdx_hypercall() implementation.

I agree that TDVMCALL_x is somewhat less legible; on the other hand it 
highlights that these TDVMCALLs all have a common convention for passing 
parameters / retrieving results, and reduces the potential for silly typos.

This is also why I asked about the different approaches for TDCALL vs. 
TDVMCALL.  Given that there are only a handful of appearances for 
tdvmcall_trampoline, maybe the best of both worlds is just to inline the 
whole thing?  This way the code in the macros matches the parameter 
passing convention of the GHCI.

Paolo


