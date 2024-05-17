Return-Path: <linux-hyperv+bounces-2185-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F658C8A71
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80E11F24711
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292013D8B4;
	Fri, 17 May 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnITEk6o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297ED13D8A8
	for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965353; cv=none; b=OoNwQ0cnvZo9LCIswNo6mbbMyvGV0FZzUc6R/WCxC1MkmwQI8ZKvZo4bZ8+m42QWj1vwGVJ6AzSTPGaUd2CIE4u37aPGkG4jrQL51wls8d9mpHE071KMMZFaN8C07lH8MNOYjem04E6O847aIkxvdAs2vsBTieN93lKHSQEsG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965353; c=relaxed/simple;
	bh=RujlaPkC5uomwQRFCiv19JY6ekyqruHf/iabfYuDvik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+6QUnS2R2CJPl2RjzpUcFFl/aI7gLHjvwdp7+EHCvm5XYhw/Sf57g/BrgpH8cEq0iUYjkiJOhwS9DLihX5Kt/zUQdffYfwNXxO201sMiDx3KVhIpLiN4ITWXE2AloX+cHv7eiAW6yIHoap/lAieAU7R4yBOEIFgeyID0ftR4Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZnITEk6o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715965351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bcBEPXdmgQZyP7M+gSm8KFg/XGQstBv7ECAJLR2IyB0=;
	b=ZnITEk6oLrD9drw+Aaa/JPpv3aBQbgPqKxGD5ca2d7/oxTqDishBJtEtn4OLh1DDMNb8wv
	DxA1IieZblQ/75FIYaeRymryDVIt4f+fDYHExBen2CHrQpVsrfab8SDeB7rtSBAQzgySZE
	WilukGzUMlc7sIqPMfvRTyTJZC4EM68=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Qf80lG86MQibvX4gZCPdfQ-1; Fri, 17 May 2024 13:02:29 -0400
X-MC-Unique: Qf80lG86MQibvX4gZCPdfQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-574fd71d398so2262699a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 10:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965348; x=1716570148;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcBEPXdmgQZyP7M+gSm8KFg/XGQstBv7ECAJLR2IyB0=;
        b=qqJ0zzM0EsJ6tlMU6U5JNwW7FqUsfCnh3QIQRorY4jwC4XrP7fwgdgtnOfh4lKIxaA
         0wqojyPBBgBMsBEKlUEU+YetnZidb9xJLzV4wqlstNIPb4AH6e4NAgmWCcTD0fB1t0ep
         0CYg6FAc+8Kbh7HfUc9diEIDkuEdGetgY+HDrb8k68nfQtIfr701I8WANqNW1+TjpWI6
         Eh4H3zYyZrd8T0iDQSZLSzbN7ai/nZtFyyvr38clOpv/9n/S6t0UvpC5kt0n4iTzbwBa
         5wtEnLvmINAQYULRhVFxkJHhP8y3jBS2FFy7Eu4kcDJ0/G6qSs8ENcsxh/6j64aBGKk2
         qzfA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/SExhas+V7vntE7WlMz3p/Uti9KKBCrgLjUhc4afOzLeniGvd/aULxoCtQ466HKf9UXgGimMshzDDbg5FGEnJzKgYiEjRl7uLgQI
X-Gm-Message-State: AOJu0YwqG0s/Z7RRo8ktJRgiUIPoUuYb4Iu/jIDSQH8z+IAOaYAjhtIB
	04q8VV4cdnnR2c3Gajh8aoJ8RZItg5ou5M273BAj6rq9anG8OTii/jvAXVSKuveNgssOrJ83i1L
	wLloImmhf6EWqIg/g7HL5MYWBvzt3KDV3I52dgg8NrGpaBe/1vQM2PyaAZ0W+BA==
X-Received: by 2002:a50:bb0e:0:b0:572:df77:c1bf with SMTP id 4fb4d7f45d1cf-5734d5974f2mr16594194a12.3.1715965348650;
        Fri, 17 May 2024 10:02:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8BxwjPFxnN0vB84qYaxvJvP6JzHa+BW69UJeAQ13Spyes5Hz+DYs0A4puQkEZx1PcRBHdZw==
X-Received: by 2002:a50:bb0e:0:b0:572:df77:c1bf with SMTP id 4fb4d7f45d1cf-5734d5974f2mr16594173a12.3.1715965348297;
        Fri, 17 May 2024 10:02:28 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6bfsm12089492a12.28.2024.05.17.10.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:02:26 -0700 (PDT)
Message-ID: <9cd7f179-673b-4e96-be08-128dc6fb6271@redhat.com>
Date: Fri, 17 May 2024 19:02:25 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] x86/tdx: Introduce tdvmcall_trampoline()
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
 <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240517141938.4177174-2-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 16:19, Kirill A. Shutemov wrote:
> The function will be used from inline assembly to handle most TDVMCALL
> cases.

Perhaps add that the calling convention is designed to allow using the 
asm constraints a/b/c/d/S/D and keep the asm blocks simpler?

Paolo


