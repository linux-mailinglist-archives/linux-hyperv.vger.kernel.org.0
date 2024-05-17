Return-Path: <linux-hyperv+bounces-2186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864AC8C8A7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E7284E19
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 May 2024 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218DA13D8B8;
	Fri, 17 May 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzmFZOeJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A332913D8AC
	for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715965511; cv=none; b=MdfU+3Z//tSZWJWd5tx5Alhzx/7Tn9TYt5dOG9KFoAI6fcMYZIkbuqn4AP74FhPIc8trVfDt8LvZHerBnpkEO9WpNmZOYEG/mW3wd4+5nKn2sbMTtREfKn+95NdNKRJw0EpHdlVvi8QQwLPIMef2RISY0iIOicV/y3TOzWss1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715965511; c=relaxed/simple;
	bh=cicBuaDXb0+iJuraKbqW3IUKE/RHOlM5V7//N93fDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/RZO1qFWGVxzCKxw0y3nx55n7VeL2zTSvkuR4JqeEXmW0TUsu5zxeOaloJec3r/35kgh/Ujle3fLhMiFSXAySq/0kv8UQQbk+2J/lijgGmOOzx1tBh6kuMsUffUlIJeCnlnNVZ3E58bGgnxH+0GiWFOwfpd5hxM0UJLX9Yymjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZzmFZOeJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715965508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NWyzI/owlrZS3OdD2++L32ikBFzAP0809WyjNtkngNs=;
	b=ZzmFZOeJkVlklJJGzPP8OAZnsLuzSRtqJKq+e6pqJzRGGupxfXrXjchj/yhxK/LDzLsP1c
	VrVsNvg7tCvk0U+dKUS08F+s+E1FWOP8yfZIS0tHfEV985zn87GfcSUuee6GfipaMQLbs8
	PlV+bGOUilbTdjUxbPSFDyLz4kcfz/k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-yRP1rIzWNCSffmOyfdXYQw-1; Fri, 17 May 2024 13:05:07 -0400
X-MC-Unique: yRP1rIzWNCSffmOyfdXYQw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56c1ac93679so4094183a12.2
        for <linux-hyperv@vger.kernel.org>; Fri, 17 May 2024 10:05:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715965506; x=1716570306;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NWyzI/owlrZS3OdD2++L32ikBFzAP0809WyjNtkngNs=;
        b=O2dtkzT0CqdEtoIrSEhs7xW5qZjCCJwidqX0s7gV1O5tVDlNyiAejRr31//jviiPvu
         ni0PO89eiXVHBC5Iq9j50rRsSMScg+zrDUNyhbmqMQRhgVRjo6QaK6OAs4zQdscuJ5gC
         WJAmRzv0wlliBoOZ3mZ0ttfq7tlVCkjGhP2zMUUDK8ErA21Q3agJpjWxc5hoNCNZqVpj
         REfZI3qoKiU97J3Pt9tjuE2OOPlDx8ZAucfJrNOgAYUXMguFlLfc8PpOoOv0B/MFiFl0
         0bpcTzd+VrMZFwGpwVcOv3JvK1i51HZ6n4C1VezA7nP+H7bePekqFpypt2sjwFyHGDHF
         5KSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq6CSC57MpMRTbn5J9AwJHAMsBaRo79RAiUC+rZ/aUeFW6+mWVYZFG8lup3CG+Ai+ztliOm8qAeukt0UgjlmXT4cc6YnOT/w004l4c
X-Gm-Message-State: AOJu0YzVLtDelbt2n4z6zsKZPrzHM57FiFK4hwwmEZFBMArLnkUk6feK
	RPEsGmDDkJ7pzav2h4/TawZRUp8JTTLI5CwNhOTZqO4wjJXo83uDTHERaSFr/PXwajoeqbQgEtV
	/PiBdIPZwh5l5WdqGpEGo5M+Ac7ShNWsM7BjlxIaVNpQWC5l12Wcv+bT116999A==
X-Received: by 2002:a50:d7c2:0:b0:572:68a6:97c with SMTP id 4fb4d7f45d1cf-5734d5ccb06mr14616449a12.11.1715965506132;
        Fri, 17 May 2024 10:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBkw0YYpSkt2yxgiSoGJntzhzh4riVN4usDdXUeWQ9Z+S4uipkj5tqYjRErSZduDCSpNGBXg==
X-Received: by 2002:a50:d7c2:0:b0:572:68a6:97c with SMTP id 4fb4d7f45d1cf-5734d5ccb06mr14616416a12.11.1715965505723;
        Fri, 17 May 2024 10:05:05 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.155.52])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65e2sm12095404a12.19.2024.05.17.10.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 10:05:04 -0700 (PDT)
Message-ID: <05277f00-d5a9-46a4-b11e-8ed6e8885e73@redhat.com>
Date: Fri, 17 May 2024 19:04:49 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] x86/tdx: Add macros to generate TDCALL wrappers
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
 <20240517141938.4177174-15-kirill.shutemov@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240517141938.4177174-15-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/24 16:19, Kirill A. Shutemov wrote:
> Introduce a set of macros that allow to generate wrappers for TDCALL
> leafs.
> 
> There are three macros differentiated by number of return parameters.
> 
> Signed-off-by: Kirill A. Shutemov<kirill.shutemov@linux.intel.com>
> ---
>   arch/x86/include/asm/shared/tdx.h | 58 +++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)

Can you explain in the commit message why you picked a different 
approach?  That is, a sequence of inlined movq instructions here vs. 
compiler-generated movqs + a trampoline for TDVMCALL.

Paolo


