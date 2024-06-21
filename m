Return-Path: <linux-hyperv+bounces-2470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B3911B76
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 08:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27AC1F24217
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 06:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938CD153580;
	Fri, 21 Jun 2024 06:19:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEC12EBE7;
	Fri, 21 Jun 2024 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950755; cv=none; b=SpqwXdigq+MdBaas0f60HkBhyiMQRaGPM/ubHy4uf13KJiH1UTd8gFGXuvwb8q9TKJYz2asiOVZd0v6P6jPxY8xVg5yhZFyYUtq7c2zSmkJniVKgwEIxRKcVReCMXujYFJHcROxJXfpzyNqpO/p9vEPXdFItGAqpasPhfzGuLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950755; c=relaxed/simple;
	bh=Q7aq0fOpQCJq7F2V7f0fN6ZFA1pO4o0cmFfX4qCWF7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltgRW9+JsNw4ELFf23FFMfgfviV1+CoyfEAIgyF4LfHXbQNoaaFdFBVax7a+rRYsWkhyczZyVmnMVDntq7NmtSvmc3t3ZFIdsbAEgSy2rrnzPq1V3ZWFhnWLrWE6N+j1U2uYxmqMfCsDB9SNpvxW99Bz6BklSK/OSH8LgZv3Ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-713fa1aea36so841948a12.1;
        Thu, 20 Jun 2024 23:19:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950753; x=1719555553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSaqs2iuk6bbR7Lo24Uoxzq+8d0Qih1b+Z3gayAwS6g=;
        b=L7Bma2q/pS1nN04m84LfopT9ID88/vGuFOmcp5yvm8rxlHU8GtZqkmppNQjtPaBvAP
         ezzQNVjZF39fOVkNGTwxH8G7WM/vd6wdjfWcejy7kvuKGzAFBKeHl7i/PoO24zSqsHi5
         AF943waq4bEIvvPwG9T31W7Gsj+beQ7xMPAi3ZLawWyc6S+f4jJKCM69i38gq+GvYPGf
         sbvOB8nI7/WRCiLb/OPHvsHZuoIKYD2akMxqQgiIw5lXuzbdz9tnc5wS3pT94cS3KLiu
         hQF+L2sCdX5tmbfRYqRIdVK3vaCbYJl4L8FClIqo4qCI4PyiTujVNS3dww/M7fuQVsPI
         FQeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8evfshVYbA0FRHUD1qQddVpX+EdYzYT5ld/b26Yws5EVJdtlDxDIcu4HUNqji8f8OHnMs/wX9hpqBszBSFzDZ7OH+EMdZwBklYi68+PHxUtzFJeJSz6eEqWH9JiTU1yCC+s1LYbMWNaHh75BpxXEkEYeGSahrlyw0W41SXwhgoShIVL0w
X-Gm-Message-State: AOJu0YzFk+xdt0zKJslBmMpRHc4MigJtBrV0FYOytn4eW53yVKlgCzki
	dnOkJAHeTWKp9GkaqeujBGT8PwwAFmxEeKT/tQXYrFeVpHvnrBKD
X-Google-Smtp-Source: AGHT+IEuyIQlnydbM3TMY4dfAyVKnExSuGL6YCxekVduLB3ih+rOlqd04UekGVmNtLqelXH3TEzIbA==
X-Received: by 2002:a17:90a:ce90:b0:2c2:db48:aae2 with SMTP id 98e67ed59e1d1-2c7b5dc9c13mr7447980a91.40.1718950753175;
        Thu, 20 Jun 2024 23:19:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e53e2846sm2765014a91.24.2024.06.20.23.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:19:12 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:19:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Message-ID: <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
References: <20240621014815.263590-1-wei.liu@kernel.org>
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jun 21, 2024 at 03:15:19AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, June 20, 2024 6:48 PM
> > 
> > The intent of the code snippet is to always return 0 for both fields.
> > The check is wrong though. Fix that.
> > 
> > This is discovered by this call in VFIO:
> > 
> >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > 
> > The old code does not set *val to 0 because the second half of the check is
> > incorrect.
> > 
> > Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V
> > VMs")
> > Cc: stable@kernel.org
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 5992280e8110..eec087c8f670 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev
> > *hpdev, int where,
> >  		   PCI_CAPABILITY_LIST) {
> >  		/* ROM BARs are unimplemented */
> >  		*val = 0;
> > -	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
> > -		   PCI_INTERRUPT_PIN) {
> > +	} else if ((where == PCI_INTERRUPT_LINE || where == PCI_INTERRUPT_PIN) &&
> > +		   size == 1) {
> 
> Any reason not to continue the pattern of the rest of the function,
> and do the following to fix the bug?
> 
>    	} else if (where >= PCI_INTERRUPT_LINE && where + size <= 
>   		   PCI_MIN_GNT) {
> 
> Your fix doesn't allow PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN
> to be read together as a 2-byte access, though I don't know if that
> matters.

I don't think this is a sane use case. Someone calls
pci_read_config_word on PCI_INTERRUPT_LINE and then breaks the two
fields out from a word size value.

There is only one in-tree instance attempting to read both fields at the
same time.  And it gets away with it because it immediately writes the
same value back to another register.

(Search for PCI_INTERRUPT_LINE in sound/pci/ctxfi/cthw20k1.c)

The rest of the code always does a byte read.

I had a version that looked like this:

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5992280e8110..cdd5be16021d 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
                   PCI_CAPABILITY_LIST) {
                /* ROM BARs are unimplemented */
                *val = 0;
-       } else if (where >= PCI_INTERRUPT_LINE && where + size <=
-                  PCI_INTERRUPT_PIN) {
+       } else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
+                  (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
                /*
                 * Interrupt Line and Interrupt PIN are hard-wired to zero
                 * because this front-end only supports message-signaled

It was consistent with the old style. But I thought it was a bit too
tedious to read, so I changed to the current version.

At the very least I would like to enforce the separation of the two
fields. 

I can send out the older version tomorrow -- just waiting for others to
chime in.

Thanks,
Wei.


> 
> I have a slight preference for the more consistent approach, but
> don't really object to what you've done.  Treat my idea as a
> suggestion to consider, but if you want to go with your approach,
> that's OK too.
> 
> Michael
> 
> >  		/*
> >  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
> >  		 * because this front-end only supports message-signaled
> > --
> > 2.43.0
> > 
> 
> 

