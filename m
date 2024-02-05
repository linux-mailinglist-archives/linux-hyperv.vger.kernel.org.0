Return-Path: <linux-hyperv+bounces-1512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72184A0CE
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867C42836F1
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Feb 2024 17:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FF44C6A;
	Mon,  5 Feb 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="O/hSThXo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF744C67;
	Mon,  5 Feb 2024 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154425; cv=none; b=jt4Hwc+2k1+/HrNgpQ3//WYJQA3TVjBPYGEzQ0LUBVPg5KYFsGl1wICirKXoNtt18N5v+vM2OR8NigxbeEw67UHexski/JtLBxZbFO2JjbY/Te26H2V1E80ltijfsfOlERHojOQe8r3kvORSIvlAbjjIOtvPhABjz2FPBP+pOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154425; c=relaxed/simple;
	bh=6KbzWkkF1SDEdyAjsG6dXdz3BrQZmGWLPdcrJqk38Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRFg3f3bC5GMRT+7R9eQgu4ksGidBd8O6QgKRF/tGo5OTM38xyGpJid8cQEDGPEoXHpdFmZkcx46vdYaqF/pPJP5Ufs76ToT5ictbMcYVUX0Nr0Cj42GHk5OPVdc9+sP0kWevEgTw0ugl6zI2H8JqJD+AilE3sl3UVECzpjwigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=O/hSThXo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so3159163a12.1;
        Mon, 05 Feb 2024 09:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707154423; x=1707759223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ElUJ3bFANKcGSpc8Ks9F6N98y85nfwFifeRegxpzAFA=;
        b=M74dp5yANnEGISbT0+pg8gYnp/Hv42SrPs4im0krsS+6s1DZuPbVB5q8zTPZ4RmTfz
         mPSddhDx1AD48NFq0qwnMMvQdgSkqK7hpSLt7VTiTtws1Dwxm0NTtuJpbWDXgHZ3fTn9
         qejwApA09PTdSQM7OO9Zek/WcMNY+tu/U/VB3CkGxRb23UWbMIVVfqQgp+hrKySHaf1i
         ObdxBIsxyoXQwFMm3CTUas9DdvbpNnL4dYzISksKqk/4lkV1hOMa9kDb6btN904R0NKC
         tdEJk4ANGIXHvLPIOZFvc7Q/wO0GJ/UF4z3CWz5PHfLd6GRoXgHCzca76IuuYu33dfrz
         0cIA==
X-Gm-Message-State: AOJu0Yzk/Y6SioF8H4CeGezRkJoId7oShwjrtHrUS4do4PxE+MRco1DM
	Da5lyO67LGWNmvVgcwEGYSr+UaBfFN1cQzC/ogbDrbCFFOUr/4NU
X-Google-Smtp-Source: AGHT+IFw0yFVouEJL7sPQVepmBZ8+P+u2K8PZ8+tyNjbhTF74yqxwdl05WX8PDFwXV5n20fHnPLOxg==
X-Received: by 2002:a17:903:40c1:b0:1d9:3843:3f07 with SMTP id t1-20020a17090340c100b001d938433f07mr223495pld.61.1707154422854;
        Mon, 05 Feb 2024 09:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWnNMQnvG5mDgs0H3SN6PW5gUa00uEW+JZOiih/iG7WgRLvJv6uEuVbdmRlQX7v0Yw+TxkzH4qUisncO9HWV8Jayxt9/eNEoAxHfA9M69EWcxqn5CTOZyJ0RXcgIAGApyVFyYd9MjlWq593++VjGEnkHxchzlyn5M0H9ypKVfscNRfYeNy3zFZPFNiQ1I01iBivsENHQMlaTvZhbf3smtEpM3RAH1K+rC7/tA0BIITd9Pe1gNyDiFLGHAtQz2lQcKbOo6pd24y0
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e18-20020aa79812000000b006e046a325a4sm103109pfl.7.2024.02.05.09.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:33:42 -0800 (PST)
Date: Mon, 5 Feb 2024 14:34:12 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707154421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ElUJ3bFANKcGSpc8Ks9F6N98y85nfwFifeRegxpzAFA=;
	b=O/hSThXogFDYMXAusvstp+yAm5cg8I09Hef199UMvk9dxtn4ZnNOanop4H9lYaOuCEtjnO
	fLgTpoFP+jrOyYYkPE+CrJyE7XevvpFh3IrG4O+26NXmNxj8Ccht1Y6NlfWK7YzyV7LAaZ
	teIg4AOksSYLGrMvo3VbsGh1ZcCVvahS4FCm0nPk67h2S8+zFVPOGswHojHMWmhgyEFmy9
	4uj+X0/DohbUW+7kH2EMZe/Vpy/SKXYUfIORkA6s+Ue/b6OpIyKyqbsRFDvYw2jw6U79HW
	/khwGkZTOW1CDe1y7DLAJ8ZmHqAVebrGVxXpIRhS29gGjfM9W/6oVz0b5xe/1g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] hv: vmbus: make hv_bus const
Message-ID: <vjfokbfk23ck6ndcxyb6gnbqn7qtdg4ynenvnyhlgt7kwvlwvm@3gvq5sttegj7>
References: <20240204-bus_cleanup-hv-v1-1-521bd4140673@marliere.net>
 <SN6PR02MB4157130171E614FED60FDC1ED4472@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157130171E614FED60FDC1ED4472@SN6PR02MB4157.namprd02.prod.outlook.com>

Hi Michael,

On  5 Feb 16:40, Michael Kelley wrote:
> From: Ricardo B. Marliere <ricardo@marliere.net> Sent: Sunday, February 4, 2024 8:38 AM
> > 
> 
> NIT:  For consistency, we try to use "Drivers: hv: vmbus:" as the prefix on the
> Subject line for patches to vmbus_drv.c.

Thanks for the feedback, I'll keep that in mind in the future. I looked
into a few commits using `git blame` and 'hv: ' seemed to be sufficient.

All the best,
-	Ricardo.



> 
> Otherwise,
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
> > Now that the driver core can properly handle constant struct bus_type,
> > move the hv_bus variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > ---
> >  drivers/hv/vmbus_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> > index edbb38f6956b..c4e6d9f1b510 100644
> > --- a/drivers/hv/vmbus_drv.c
> > +++ b/drivers/hv/vmbus_drv.c
> > @@ -988,7 +988,7 @@ static const struct dev_pm_ops vmbus_pm = {
> >  };
> > 
> >  /* The one and only one */
> > -static struct bus_type  hv_bus = {
> > +static const struct bus_type  hv_bus = {
> >  	.name =		"vmbus",
> >  	.match =		vmbus_match,
> >  	.shutdown =		vmbus_shutdown,
> > 
> > ---
> > base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
> > change-id: 20240204-bus_cleanup-hv-2ca8a4603ebc
> > 
> > Best regards,
> > --
> > Ricardo B. Marliere <ricardo@marliere.net>
> > 
> 

