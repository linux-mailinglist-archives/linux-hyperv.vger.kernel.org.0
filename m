Return-Path: <linux-hyperv+bounces-2513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FD91E919
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 22:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD141C20FC2
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 20:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB9E85934;
	Mon,  1 Jul 2024 20:02:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DA818635;
	Mon,  1 Jul 2024 20:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864125; cv=none; b=GyfQobLp3hhI6we74JuZiOW1NugUJF1Fn9pVemI33BAHICxJ0WDGJfEIPzMWUwAsCUjjz9jo4uWLdA6nAQ6SZc8iDPunvlyRR2KswrE0/wu29cGHISCpgNoSaEgdQgoyLuEQ+aA22813ZHxSg8q88CpcDMYDaD8yaB0w3uVDRWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864125; c=relaxed/simple;
	bh=HQ5Ft6X4jirIHI3VzqDzxxDVnkqciQhvpGH3lgBlIoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONFwwClWlAv4SQ1iAS0yo/0E9p3OMfFUXCpYm4JXIv4tTvpN/K1BSMVPPWFqMK6OvOfwyitL766ND1gRe6SMzoi9y4KwZqIX/pbU3WqAuiN1d6Xpv08cY8d1dW9M16IWfTehZVxoX595Mt8zlC/KllR2Ci7rTpF7MXAJyNT2qRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1faad2f1967so33621335ad.0;
        Mon, 01 Jul 2024 13:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864123; x=1720468923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl0ODQwpBTm0P56IW1q19goNWJ90VvENzOaUT1IO7I8=;
        b=O/HBs6NwDBngijUG+2ppAHiKBGAnqtW3wOcZc0xKiJ+19IOo951Ae/7yDuZa17f9SP
         GjDWUrP46uzfw/4tuqcMsCT4Dxxj+HVJVUGC8LTfOWZOS671WABzN5NFSXQFKACcvGFE
         OKfECEvl8+5069Xbkdxn5pD8qFaaR4WzIK7J/xep/m8eEhf4IuEO6kAaPckM2+gRt0On
         zXuUAvPwM5zFz+sF3hzIt8zyeJv2H1KOEtGtHDNavCdu1VPnF0t0ynZrvrQZi7Wi6Fw0
         5LJmcm7SqXOYDmNtISd0djx/IDlfwTwDZE6rF7x3Cl9egj8NwJP/hofdjfLn9rfbhbUZ
         Lugg==
X-Forwarded-Encrypted: i=1; AJvYcCXHAwxCP1yRNdv9/sECU6GmXKJU8nrZgsDcaw/sCKSkTeZLBO9Dzf1ZG6o6WiWg4ryXrzQblxKDN65IKrF3qmM5LNq7PP7508zjdXv7jOqQvxEmmVJF8rp+sTJpXEExmB2gi9sXWdLOzkJB1PZJzhrLvm7jZ1Zbov9lgtWF1mICAONzBMIp
X-Gm-Message-State: AOJu0YzBNIthrkThUswwu/4pWxKUFhh+oeVqAN7hzJ3Nc6KEKpCDhYXs
	bCi6GNNZBmpYUzRs+RkI1D0HxVgKYlzt215mOF46xLqjeVFv4PWy
X-Google-Smtp-Source: AGHT+IE8ONY6SLH1Ct1FYBEHwLtkKXe6kBj84C+6GW1/N9UcQr8yEwlTg5NzsRsv8TUxc/TOIl2m1w==
X-Received: by 2002:a17:902:ccca:b0:1f9:f6a7:9330 with SMTP id d9443c01a7336-1fac7e4c1c5mr165770585ad.9.1719864122962;
        Mon, 01 Jul 2024 13:02:02 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15389b3sm68811735ad.121.2024.07.01.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:02:02 -0700 (PDT)
Date: Mon, 1 Jul 2024 20:01:52 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	stable@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Message-ID: <ZoMLMJ9aIPs1lt8a@liuwe-devbox-debian-v2>
References: <ZoJJsolJJcLUYiVG@liuwe-devbox-debian-v2>
 <20240701172053.GA10100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701172053.GA10100@bhelgaas>

On Mon, Jul 01, 2024 at 12:20:53PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 01, 2024 at 06:16:18AM +0000, Wei Liu wrote:
> > On Wed, Jun 26, 2024 at 10:10:39AM -0500, Bjorn Helgaas wrote:
> > > 1) Capitalize subject to match history
> > 
> > What do you mean here? I got the "PCI: hv: ..." format from recent
> > commits. "PCI" is capitalized. You want to to capitalize "fix"?
> 
> Yes.  Look at the history:
> 
>   $ git log --oneline --no-merges drivers/pci/controller/pci-hyperv.c
>   b5ff74c1ef50 PCI: hv: Fix ring buffer size calculation
>   07e8f88568f5 x86/apic: Drop apic::delivery_mode
>   f741bcadfe52 PCI: hv: Annotate struct hv_dr_state with __counted_by
>   04bbe863241a PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
>   067d6ec7ed5b PCI: hv: Add a per-bus mutex state_lock
>   a847234e24d0 Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
>   add9195e69c9 PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
>   2738d5ab7929 PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
>   ...
> 
> > > 2) Say something more specific than "fix reading ..."
> > > 
> > > Apparently this returns garbage in some case where you want to return
> > > zero?
> > 
> > Yes. *val is not changed in the old code, so garbage is returned.
> > 
> > Here is the updated commit message. I can resend once you confirm you're
> > happy with it.
> > 
> >     PCI: hv: Fix reading of PCI_INTERRUPT_PIN
> 
> Maybe:
> 
>   PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN
> 
> >     The intent of the code snippet is to always return 0 for both
> >     PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> > 
> >     The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> > 
> >     This is discovered by this call in VFIO:
> > 
> >         pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > 
> >     The old code does not set *val to 0 because it misses the check for
> >     PCI_INTERRUPT_PIN. Garbage is returned in this case.
> > 
> >     Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> >     Cc: stable@kernel.org
> >     Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> Looks fine.

Thanks. I will resend with the updated commit message.

