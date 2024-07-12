Return-Path: <linux-hyperv+bounces-2560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472692FC4C
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F80B2837C5
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A97171653;
	Fri, 12 Jul 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkQjljxl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F8171094
	for <linux-hyperv@vger.kernel.org>; Fri, 12 Jul 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793506; cv=none; b=OBwIXKAWUS4WxFyRQEz9Yz2MxGZHyPh22y2bfJ1rqXlhK4ppc/2m0e0YERXB+GnPvqhXEXsMqvyKMxJG4VWked/JSWyeeCl9jdvCQ9lupKPnnMWHsKCmGrAP2Owo8pRuX8ER1qNmedjd2Ah+1Ry82Syc2AOCJOe5//pM/Xa3fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793506; c=relaxed/simple;
	bh=VYT4EUbGnMCQC1n9ebq+pDVC9xpjFj7DYFt7QmAktps=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rb9um3+z/5xmlJQmDmnRJHRWNKY8f19su+/VioQs5lD5Liak2XK1ikwSudpx1ZNMosc0OpUwBV9gSwRPNidSsgqbg23gFwnc5/qbcUuwwiRvR4U/qC/gwOEZraJ8zYZZCDrT0NmVQTlAwVwICW4kJJA1Qojdjb7B2/39Jz+xwC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkQjljxl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720793504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
	b=HkQjljxlILzTzV1aj+mMzoq99YUaImdsbkQj5kio7EJKjoJu1moa6thlhUZw6ARtpFljpm
	K37lKQDd5fQkMQ4p1bUUzeA4RJNz9vVieSGSlgA80oi/UGUzDFuLKQZosvebsgWdYp/VHK
	TAyvSPCBZi/LxcNRpcxUQtAfUgfcLQM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-cb8WwgHuP7qkTUc9pV394g-1; Fri, 12 Jul 2024 10:11:42 -0400
X-MC-Unique: cb8WwgHuP7qkTUc9pV394g-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3678e549a1eso1106746f8f.0
        for <linux-hyperv@vger.kernel.org>; Fri, 12 Jul 2024 07:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793501; x=1721398301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o2DwS+N+WpDe9hXUlwXatDaB5K36zULgGVjjk0aits0=;
        b=CaGvaU4Rz4+9TYG4m3jV5a9uwRMCe5FXQTsM+ezidHQNt1cn88ZrqStkWqk2aw3rWS
         HAP8nF0rKDTlGjDWi7T42FlzJRCoKWcI+cxI5uUymAaQwkTvTgtxTJ00BBjdeMn4VeMP
         mfo4hlewUQc0nrzGgZe2jq1B+o5yhEDN6Q/KADaOfdKCjpFHZSUm+Yx+I3vIvdvYpw6T
         nz8eax32OjWUhDWVgeg3FBo422Fh416MVnEpLli/M9hxn2BLNK2VNq7Rfo2AT92O8uDZ
         J9An9Ml5ddlEnmYNV/SpLoJYKJGmuqYI6RZ8R5/bO0EKUWxbRaaMmHyE5NQ0IB7yVubp
         kDPg==
X-Forwarded-Encrypted: i=1; AJvYcCU8hx+264YzcBCcT14DTCBzLulx4cEJjl6b7aanMrCc9LTKlqXaWskveUEPlUEZ25sZecYquyubBuXfqXg18w89gr1Ti4EuApV0Qkx9
X-Gm-Message-State: AOJu0YwAjLksz2nP9mFohEbfCGMDIjtEQpWnT3JCLqsWuniTxgVMNhdI
	sOGYW93YwP1WfAglLI1jhdW3BgS/YY3aR9qBPaDtg/sv7cJRzeUX4ipkkQik7k2FderDR5S2LKr
	SWtSNcv49WXdKGZ1qxCgQopxeeRHyuVGce6jrYumiUnnUD1nFi4bi4vEzNki/pw==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911316f8f.34.1720793501794;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf3U4d9gFM4veykTOQEiy8D2ryeNYD+ff/pVMiWh3YGrTu6bLAg3UO2081Jf+2o1pI3Alwgw==
X-Received: by 2002:adf:f8d2:0:b0:367:40eb:a3c3 with SMTP id ffacd0b85a97d-36804fec57emr1911266f8f.34.1720793501451;
        Fri, 12 Jul 2024 07:11:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm10376600f8f.21.2024.07.12.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:11:40 -0700 (PDT)
Message-ID: <a24ea2d7-9f48-412c-9a40-9624f6c4f9d9@redhat.com>
Date: Fri, 12 Jul 2024 16:11:38 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
 <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
 <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <277007E3-48FA-482C-9EE0-FA28F470D6C4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/07/2024 15:34, Kees Cook wrote:
> 
> 
> On July 12, 2024 2:59:30 AM PDT, Jocelyn Falempe <jfalempe@redhat.com> wrote:
>> Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and hyperv, to be able to push it in the drm-misc tree.
> 
> Oops, I thought I'd Acked already!
> 
> Acked-by: Kees Cook <kees@kernel.org>
> 
> And, yeah, as mpe said, you're all good to take this via drm-misc.

Thanks a lot. If there is no objection I will push it to drm-misc mid 
next week. I may have all required acks by then.
> 
> Thanks!
> 
> -Kees
> 
> 

Best regards,

-- 

Jocelyn


