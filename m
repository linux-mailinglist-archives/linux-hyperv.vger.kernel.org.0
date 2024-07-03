Return-Path: <linux-hyperv+bounces-2529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E9C9260D2
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E073288203
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Jul 2024 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B217A594;
	Wed,  3 Jul 2024 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7QCLfwU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7840A17A58A
	for <linux-hyperv@vger.kernel.org>; Wed,  3 Jul 2024 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720010929; cv=none; b=Yr4+oqyTedfD+DBGbFLZEAw1Z01owYVcPQO3lLIc583AQpZZpXMEIbXvn5EGiP8mKHveZGJCgy0C5HnYIGtGiCXqTWZLTkBXgzsTQEL5H2+Z8MlJmG2bKNRZQwGVvF/kktqk/mM4hyKWUKXUCz9vi/ZOje0GQtr/AEAwZS1R33w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720010929; c=relaxed/simple;
	bh=nOrLYdaQKWbCBzur09331cdOZ260WekYtYvlyXlVvNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M+Cgjvyn6uPP+e4WuY8s29uwKQ9SDYtDPayAceugkQfCeOqaf1ieuJh8RoVRr9LF980gVhxAIoFdwpICPP7oI4S2yKmrufQ+umw8xTlRzbZSsRyEMzFbMGzi+249GLyPMrqk/sJGvQXuIAI1tV3+dikWeG/4GZNrYHogfGalunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7QCLfwU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720010927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
	b=P7QCLfwUcz3mg2A5ElG0ooCZzvadMZYJQAY+KS5kE9t26MDPBMjQjMeIVsODzCMY0DCEJe
	Ep41J0lxy3oVja+gVxtNGpFAqxAWuEZ+B4IoZ6kbPZ0+Ce8G1w7kNVvkv7sURdc29q/d8S
	McbqP4YFFDZhyIzrpg868ivJMZwIMfI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-qAX94j5VOcmH3xdlb8X3aQ-1; Wed, 03 Jul 2024 08:48:46 -0400
X-MC-Unique: qAX94j5VOcmH3xdlb8X3aQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ee864483c2so6101661fa.2
        for <linux-hyperv@vger.kernel.org>; Wed, 03 Jul 2024 05:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720010924; x=1720615724;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MEP5KBKlMKx9T4CmY7WwoI0xWCk7Wv3Ry4wWTTbIMQ=;
        b=FNeykPo0hX3PsKlKVGMRtGlueK2rhMG7cTob3D+DX4+EpVoxcDYwQPF8DuZZe4bIwd
         4a/UYGNwX3O2kYGzx9Q82v+MBVmta4CqO+DHNbF9mGhZ3GO2nYfHCJDk/SZqND65ASDB
         qlHYL8ust4w/3RXfwtgR49Pdj1Jw5qK1V+FTSlppRhOqChnyBgnLX4Nf3vxJiozGMMG4
         5KXkc+rh937rJIFd9I3Wx+6+Xq7tdreNhL8tnEAZLCe2yIbHwhWvryjNs8bmzsplKriI
         c+rkIdNu1TS+uAiWsx7BcHXhhjxTzID0NnsOI7OucCqhhNtcV9P0O9BEWaLCpNk9G2vE
         ItGg==
X-Forwarded-Encrypted: i=1; AJvYcCXvCa07Oa8QNxPfH9h6wpr6j0+O9ujfhGzwh8C9Anl6gVpPE0elkvPIlYmijDXhEk9kUK6o5tkVaMWlN6mfNEFauUM2o97/vPX0gt0e
X-Gm-Message-State: AOJu0YyZp7O6OOqZxxq0cevyE13OjGY5QCXwL4aJsdgEZzCNRukufTDR
	6gcURvDLDbG5tPB3Mv73m2x1DKjLKojPZZhgLWenEkUVLE037wj3W2KnDuYDaXx3qskdq4y0J84
	SD1u5uVMp9Mz5eGfZoPT/MZB3G1MqLGH3AGcrYsds++C+vuFBlTR1Lxfe4ssmlg==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78433911fa.47.1720010924673;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5TqWKFAuIwTILcZtQfViw3L54aF8RKuLImctjrV+bIlLQQRnHKZJF7c8esvbcZCiclXd1w==
X-Received: by 2002:a2e:a7c2:0:b0:2ee:45f3:1d13 with SMTP id 38308e7fff4ca-2ee5e704e51mr78433691fa.47.1720010924256;
        Wed, 03 Jul 2024 05:48:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d8cd8sm15773145f8f.27.2024.07.03.05.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 05:48:43 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, seanjc@google.com
Cc: pbonzini@redhat.com, seanjc@google.com, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
 nsaenz@amazon.com, linux-trace-kernel@vger.kernel.org, graf@amazon.de,
 dwmw2@infradead.org, pdurrant@amazon.co.uk, mlevitsk@redhat.com,
 jgowans@amazon.com, corbet@lwn.net, decui@microsoft.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, amoorthy@google.com
Subject: Re: [PATCH 00/18] Introducing Core Building Blocks for Hyper-V VSM
 Emulation
In-Reply-To: <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
References: <20240609154945.55332-1-nsaenz@amazon.com>
 <D2FTASL4CXLN.32GYJ8QZH4OCR@amazon.com>
Date: Wed, 03 Jul 2024 14:48:42 +0200
Message-ID: <87ikxm63px.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nicolas Saenz Julienne <nsaenz@amazon.com> writes:

> Hi Sean,
>
> On Sun Jun 9, 2024 at 3:49 PM UTC, Nicolas Saenz Julienne wrote:
>> This series introduces core KVM functionality necessary to emulate Hyper-V's
>> Virtual Secure Mode in a Virtual Machine Monitor (VMM).
>
> Just wanted to make sure the series is in your radar.
>

Not Sean here but I was planning to take a look at least at Hyper-V
parts of it next week.

-- 
Vitaly


