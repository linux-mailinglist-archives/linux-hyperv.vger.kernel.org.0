Return-Path: <linux-hyperv+bounces-3393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DC9E305D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 01:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CF33B2A526
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Dec 2024 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D74E4A2D;
	Wed,  4 Dec 2024 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEq+fYpp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709D7F9
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Dec 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271925; cv=none; b=RyxND/e6TQPWQmuizOCiTfNiZ+ovs6SGfzRiwhO1QaSCbG3LZAgPbhGg1zI2XH82TZoYUYGmgrDzbGfl0W/SbJGTq67ev0p2VvvH6/4HhFnb3MBiC6xrJC/qPH+aOjnvFxgLLuV7jP+63bD7FQTAAoLNPZ+x82T9gRm4EqbciDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271925; c=relaxed/simple;
	bh=Lo4binRsBPqUS9D7ps9nWAoRIkP/rPdP6eMaYI/rZXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yhh2rzvZgt1JqCm2FYue8Pqz+jmETHqWTtbdCGlFhD55e88ov3wN43ng9kYqMIF5hKTQkgfFS4wgq+DckCsucVNR0elGDsxQyl08kMvxTz6vDNT6yDSvk9fQewlIL9GxakVLwW1mMkW5FDhvgwPH3SF0zMulx/MnqQO5rKq8tms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEq+fYpp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733271922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
	b=VEq+fYppt2nN+jYLX2lOVVcbfrSsxQFT74oZQVBBIswZ/pnVdNiQGMbief5rKIqr1qaucr
	6jalJQNzZdwej1GYzG6Ooy8yf/Yfh09k6a4Fr+AVw0ZGnOLm4KLa5vvIitM8tM0P3PCN5G
	GUKCX9LfhLDNtLOG1dlLcHdTUFysFk8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-PuByFL0xP3mrxwVR-__4Dg-1; Tue, 03 Dec 2024 19:25:21 -0500
X-MC-Unique: PuByFL0xP3mrxwVR-__4Dg-1
X-Mimecast-MFC-AGG-ID: PuByFL0xP3mrxwVR-__4Dg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8858be197so73249356d6.1
        for <linux-hyperv@vger.kernel.org>; Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733271920; x=1733876720;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
        b=U4LNFFHAaw9v6tK4ToYNzoYc7X9n+aUgc95OcEaEZCf2y92Z6owlSkK1/1arkwQrMv
         sX7alBItw/FT+r/rJmv+MOn/jYCf5HBoJN8YxqItu/HWQa8xRLAs2Iar5+IdaT7htoJC
         5KJoIL8EeCbXt++81Pe6X47/aak3tyutYZdhKd+x8iimTjTiL/cINr5bHRIqVprm6m7q
         bF/AoAyx/J14C/FGCkg/lBsWvbuXz7XySoWekmJGk07MUOKfqykqeb1G/r3ykFzgBpq1
         +FaazRmzULveZ562srLhurGUI4E8M8MxC5O7wmAufPIzSMGboDOqdC6ivgEoZgUF/Gvx
         jgZg==
X-Forwarded-Encrypted: i=1; AJvYcCX8JpnL6MNC8DUcPBKY33jLoQmuMz5KLZ2q/LC2Ww63s+5TfOFi7qYf/Up6O61p48vNDx6XFeMgAVCJ92k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+h4iF6cyADddiGf3pt8xbTIlwKXGJiZyGoOK5eW+VZ0SBQHh0
	0eQOoQuCHyAHIAV9yze5iWikcJkfV8fgQ+88P9PoXLmS8CO0g28Zd76ujMJq21XuWqRWICLubEs
	QV25ZFSwKMmS5Tpp3qeM4gQXyybKaRDU5I+SxoTmHfoEWzshglFovPRXid2cR+A==
X-Gm-Gg: ASbGnctCl9NFmMtQd4TgFmrTR6etTbp/i7iDRjlp5PRylyP7yud5goPPy/AL933WOG6
	jTzim1TOiSf54GUMvX8+xVtAAu5aF11zzZLX8YhNGqnKJluruvd9DTwU4NUGTUjp+tYZ27B93Su
	V2eF0lbRVks8BAjiGr40ukOaoWzR1FLzEptcRIwsDepogf9v0bNf4Cl5VoeaCte6Lrt3/9dGAbE
	vfGBuAXNp9utDqLcTLaKufMNQhcVwJJB+BD9t29IkNddUaWng==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495516d6.28.1733271920434;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoezrTh1LfZQDXek3/OWCukqKJgO2GNowhr0mwrxAz8KSLIusKbWlk8PbDDhkEiuliYGIwDw==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495216d6.28.1733271920141;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89ef77c12sm37422936d6.81.2024.12.03.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 16:25:19 -0800 (PST)
Message-ID: <5bc32310f882c45d8713e324dd30cc1ca41ed20a.camel@redhat.com>
Subject: Re: [PATCH] net: mana: Fix memory leak in mana_gd_setup_irqs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Simon Horman <horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Yury Norov <yury.norov@gmail.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Eric Dumazet <edumazet@google.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Long Li
 <longli@microsoft.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Dexuan Cui
 <decui@microsoft.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 03 Dec 2024 19:25:17 -0500
In-Reply-To: <20241203162107.GF9361@kernel.org>
References: <20241128194300.87605-1-mlevitsk@redhat.com>
	 <SN6PR02MB4157DBBACA455AC00A24EA08D4292@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <20241203162107.GF9361@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-03 at 16:21 +0000, Simon Horman wrote:
> On Thu, Nov 28, 2024 at 09:49:35PM +0000, Michael Kelley wrote:
> > From: Maxim Levitsky <mlevitsk@redhat.com> Sent: Thursday, November 28, 2024 11:43 AM
> > > Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
> > > doesn't free this temporary array in the success path.
> > > 
> > > This was caught by kmemleak.
> > > 
> > > Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index e97af7ac2bb2..aba188f9f10f 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  	gc->max_num_msix = nvec;
> > >  	gc->num_msix_usable = nvec;
> > >  	cpus_read_unlock();
> > > +	kfree(irqs);
> > >  	return 0;
> > > 
> > >  free_irq:
> > 
> > FWIW, there's a related error path leak. If the kcalloc() to populate
> > gc->irq_contexts fails, the irqs array is not freed. Probably could
> > extend this patch to fix that leak as well.
> 
> Yes, as that problem also appears to be introduced by the cited commit
> I agree it would be good to fix them both in one patch.
> 
I'll send a v2 tomorrow. Thanks for the review!

Best regards,
	Maxim Levitsky


