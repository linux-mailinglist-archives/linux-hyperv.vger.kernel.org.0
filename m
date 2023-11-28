Return-Path: <linux-hyperv+bounces-1084-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A0C7FB2CD
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 08:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95801C20C25
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Nov 2023 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDF13AF5;
	Tue, 28 Nov 2023 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB22W+e2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6ED1AE
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701156857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eyjo55qLliRYjmYTzBCIbN4AdrhCtAA/uK2GJwWiVO0=;
	b=UB22W+e2AwyrsV3GR7I79g4BxTh4SKPhvi9MQF9qgjv2t+FEae6dh0oTadF3InwaVGCqZS
	JSCwyFkFiiCCxs8AkPmoNV5UdHmH124e2XZ4LAObHtCFCgD02828TqS4pBdwdAqBnwe3D/
	fbVG+WA12p8WtY1LtQdbSDnpPG088N8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-BPPA0SboPzWD22oF9tw-ZQ-1; Tue, 28 Nov 2023 02:34:14 -0500
X-MC-Unique: BPPA0SboPzWD22oF9tw-ZQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c87972a358so45229271fa.2
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Nov 2023 23:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156853; x=1701761653;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eyjo55qLliRYjmYTzBCIbN4AdrhCtAA/uK2GJwWiVO0=;
        b=qf0JAEKfOTd+r1id/+GCoRlGyvXwcEcoVC+Kcf5CqZXB1N4P+Cek3GcWyEnBi6aS92
         GYo4nqPiHxryLC4ja81OZQMhX2o/QeiiRkqQTK/yAjvOih3ZJVVqt8GdpgEsf0QERVgL
         Q0SN247Tjj19mcTmsjmY0AAuGtiL/TtAT48BV9Ry1DWEQNm+MhB3BuAq2dVIMmL+t40e
         E13dNgol2hWac1jp7+pa5WPz+tCLKmB6ZWMyKvs4dgLxsTAv9ASmtkzmd3A7qGWPA9Ud
         OoxSJi8wjHzzFi4aztQSmP6IVmwAZkmQBY65qwKYJKqYdUdAbCwLpYsPXvlx/Vw29c6R
         l+jQ==
X-Gm-Message-State: AOJu0YzL9Yxx3i0Tss1x5YyyiDBnXkneX0pJW0UWHO1/tJh98uR6CwFF
	U/E8PJkfO+0G2Hspqe2g2Tr5/KeL+quXPH/QOexZAgM01pAAYTb9mDTWFVAqz04wpG2vcOos6Xw
	WRzdLRnmT0/W9tKABtqAzHFH0
X-Received: by 2002:a05:651c:c85:b0:2c9:9376:1ae7 with SMTP id bz5-20020a05651c0c8500b002c993761ae7mr8406395ljb.28.1701156852841;
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhKW22SAvKwvjE7CTORodsLpg9bL5WiFyycmYSgUDV6WJI08pAgC+6hurQK/6T/oEOp7zr0g==
X-Received: by 2002:a05:651c:c85:b0:2c9:9376:1ae7 with SMTP id bz5-20020a05651c0c8500b002c993761ae7mr8406365ljb.28.1701156852519;
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
Received: from starship ([77.137.131.4])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c19cd00b0040b4110f548sm9598049wmq.23.2023.11.27.23.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:34:12 -0800 (PST)
Message-ID: <5838ebdd46bcddd836bc87d0ec7d57fadbfb79f6.camel@redhat.com>
Subject: Re: [RFC 14/33] KVM: x86: Add VTL to the MMU role
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>, Sean Christopherson
	 <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com, 
 anelkz@amazon.com, graf@amazon.com, dwmw@amazon.co.uk, jgowans@amazon.com, 
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 x86@kernel.org,  linux-doc@vger.kernel.org
Date: Tue, 28 Nov 2023 09:34:10 +0200
In-Reply-To: <CWVCX8ZD8QQZ.2FVZ6DODV8A6T@amazon.com>
References: <20231108111806.92604-1-nsaenz@amazon.com>
	 <20231108111806.92604-15-nsaenz@amazon.com> <ZUvE2clQI-wOzRBd@google.com>
	 <CWVCX8ZD8QQZ.2FVZ6DODV8A6T@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2023-11-10 at 18:52 +0000, Nicolas Saenz Julienne wrote:
> On Wed Nov 8, 2023 at 5:26 PM UTC, Sean Christopherson wrote:
> > On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> > > With the upcoming introduction of per-VTL memory protections, make MMU
> > > roles VTL aware. This will avoid sharing PTEs between vCPUs that belong
> > > to different VTLs, and that have distinct memory access restrictions.
> > > 
> > > Four bits are allocated to store the VTL number in the MMU role, since
> > > the TLFS states there is a maximum of 16 levels.
> > 
> > How many does KVM actually allow/support?  Multiplying the number of possible
> > roots by 16x is a *major* change.
> 
> AFAIK in practice only VTL0/1 are used. Don't know if Microsoft will
> come up with more in the future. We could introduce a CAP that expses
> the number of supported VTLs to user-space, and leave it as a compile
> option.
> 

Actually hyperv spec says that currently only two VTLs are implemented in HyperV

https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/vsm

"Architecturally, up to 16 levels of VTLs are supported; however a hypervisor may choose to implement fewer than 16 VTL’s. Currently, only two VTLs are implemented."

We shouldn't completely hardcode two VTLs but I think that it is safe to make optimizations aiming at two VTLs,
and also have a compile time switch for the number of supported VTLs.

In terms of adding VTLs to MMU role, as long as it's only 2 VTLs, I don't think that this is a terrible idea.

This does bring a question: what we are going to do about SMM? Windows will need it due to secure boot,
so we can't just say that VSM is only supported without SMM.


However if we take the approach of having a VM per VTL, then all of this is free, except that every time userspace changes memslots,
it will have to do so for both VMs at the same time (and that might introduce races).

Also TLB flushes might be tricky to synchronize between these two VMs and so on.

Best regards,
	Maxim Levitsky




