Return-Path: <linux-hyperv+bounces-2184-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB1F8C8A5F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98541F21B06
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891413D8BF;
	Fri, 17 May 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiDOD0pv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5813D8A8
	for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 16:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964864; cv=none; b=KrgnyGLTseALgdf4Gj9TZg7XMpSsDXRpgX83q+69b7Kbvsu5MjBkZzIKGCQgF6jNfwVf5D5QvwjNWfR5pmpgqDteIedG8CvkYwt4drNnySnCKr+H43v7KA6xE97CVlMtEHJWzPBt6xS5gcPOqMNwmHu8FFpzb9Eju9RJuUyaoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964864; c=relaxed/simple;
	bh=YoPUOJ5vAGXPmQOgRbq370zFkqkHGyujhuWx2V7WA/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1pHgWyPMJTtMP0l1dwAQVvOLbhWOLwQiyP14ov7FtciWh50C3X2Uv0PBK39ucho6AagRzF4O+arKpOoXuVF1agu0LCtzkoN5W8i9imO7YbrhGp6PSQ1sTAs5WMKcoqAIp9tu0AT294lr96SRL5GIMKcoWcn/OPD5cfqDkPG+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiDOD0pv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715964862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GF1WBPKZvZgqchSylvUIsk3qQvjijLvE4tqcy73C8QE=;
	b=XiDOD0pvTxINF7kEDpN4akaTpKTJk+SjNMgN6adu3W+ZjqjfJiULqvs8pNyIg9MC089BnE
	V2b6Yn8rXQUE2b9R1mLx9vBcp/tvBdKJeRH+3oY8Wwxe8nw0Mby/zoE0sRnJroDMfR0wRc
	zrfMBwI/F4uMpCZ8M9am/fmjobvcJaI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-lg8s03bEPMyPA32KH1euGQ-1; Fri, 17 May 2024 12:54:20 -0400
X-MC-Unique: lg8s03bEPMyPA32KH1euGQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-572a175621bso3355946a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 09:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715964859; x=1716569659;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF1WBPKZvZgqchSylvUIsk3qQvjijLvE4tqcy73C8QE=;
        b=SFs+URJSEAst258YIfQHZcjEPyVTAnkdDiZLANqbHdWlWoAIrku6rnhvKzbtZipjMC
         BmRzIoDvX6/2W+nztaEDudjrfL/uTfeNwz0epwD1zvXMbgNZlOAEib0TP3Vmm7ah7YjN
         HFY6EZkw3qDE9H2UphdG49OE6yEHr31wnIt6BF5LzNZdIy7/Slo4V8OlpoDg1aiKlSZd
         JKjRYpgr90RwUu8c5WSTvow7wocFzsSo946r4NthvfN+LX35l+9jX/xhB6UGC8+pkki5
         gs18GUnCkoWBnUcDuthTQ1bJDdl40G6awC//J6drYqUSrokD/x6a6tHXUmvM9hDV9e0n
         10tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdZlaufrqgokgU59L324dUkF0ZYs545fWKoynPJlWri95bmCLN+qsEaOeaVexxxn2WUjM0SE6dogSxD0NwX87zUNVotKaKBFD9qDXf
X-Gm-Message-State: AOJu0YzyEfaUeqn6gj4qd84Y9Z6wGNbJ4s4JPV6KyYcVcPzf8nHHP6nt
	7LN+fcOwOZaJ8CczUSKXz0fK57hLN2G23TiVKAoaIfNBfxDkXcMuV/7VbvErx4CEGW5eCFdkPAr
	JFWCinWrn4d76EgtHjfn+gY7gSaBuPMyuEMyfEW2vQT6RiJXUgRdJ8a5i1DHLPA==
X-Received: by 2002:a50:d6d9:0:b0:572:9c4c:2503 with SMTP id 4fb4d7f45d1cf-5734d70378fmr15180726a12.38.1715964859792;
        Fri, 17 May 2024 09:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU0KHnfopom3+D9iocqjRaYCyCisJHBNEFmDCyMf2L36ipxsnLxIuqinUuhzU12BxKwaZYFA==
X-Received: by 2002:a50:d6d9:0:b0:572:9c4c:2503 with SMTP id 4fb4d7f45d1cf-5734d70378fmr15180720a12.38.1715964859422;
        Fri, 17 May 2024 09:54:19 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5750d24c8c1sm2249663a12.72.2024.05.17.09.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 09:54:17 -0700 (PDT)
Message-ID: <58b02adc-7389-4fcd-a443-1856af7886b7@redhat.com>
Date: Fri, 17 May 2024 18:54:15 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] x86/tdx: Add macros to generate TDVMCALL wrappers
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <20240517141938.4177174-3-kirill.shutemov@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240517141938.4177174-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 16:19, Kirill A. Shutemov wrote:
> Introduce a set of macros that allow to generate wrappers for TDVMCALL
> leafs. The macros uses tdvmcall_trmapoline() and provides SYSV-complaint
> ABI on top of it.

Not really SYSV-compliant, more like "The macros use asm() to call 
tdvmcall_trampoline with its custom parameter passing convention".

Paolo


