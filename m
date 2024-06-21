Return-Path: <linux-hyperv+bounces-2476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E441912DE0
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 21:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A682C283A55
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 19:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0A17BB0D;
	Fri, 21 Jun 2024 19:33:35 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA1D17B50D;
	Fri, 21 Jun 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998415; cv=none; b=h6fPgNdb9Sv7olFuXPXOK+9aMDJlBcuCUUvfuNBPiAjYYul7ImyUh1WoXGeQu1lU7aPN7YciIT+zkFKHSQty5PZxbwnDkz91/YktUuhuLaya815cXI1E9lU6nVW2Jtth77pNYzCL644C5nTyN8kd8I4j2LrVgvrfOBiF+wqt/a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998415; c=relaxed/simple;
	bh=iI+L7i712SZhcAPxwe+PjDhF8zxPu0w/7Hnx+v8CzE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is87YkRsGKdXVORfHCY7g/NFgUN8B2XMVnITAbYbIHI+9AoUHpgHc6fC5Px6BHx9PBHR2JqxpXvhXXjl4Wtt2F/AlsriZ917ue6q3b2Y9fV+mNrzWfOehzCdpuqZybT50r9QRXM/3fOWUvWhwn6Ohp7folNTN9nIDQYUZzXBlzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so1422666a91.0;
        Fri, 21 Jun 2024 12:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998412; x=1719603212;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cm5Jv5fuO8QRKswysU16NBBPz6DZDirM0voo1fYssSI=;
        b=AjSv16Zdphiof/rLUJRPw6Lju0gR7IvxLLi9qAxmUjnmXEDP4v2EtioTmhXv3IfynR
         DWJHSqbzzMFS2eaqAkxW7Y4jNoRwSA2DMJjVd4bQr7ktWxwbMBJJQ6gYIRvBeD7LSb7F
         071MNyFNNaETLKvidOOFj5J3GzYcW55X4CercSiV9J5fRoQLdy08UQruhmGhf4zeEHzg
         p7umCP2UNpnzA94z6ogus9dqkaMf3qsfUVG7exAdr8EHOkITSbhlku+vKzJ5wYUe4ZwF
         cE4NKZ7kWKHQLw6op7MjainHV9ZuJGOpZV9copR+jY/US5cZSJufHeVurhsgiMwFr5GJ
         N93A==
X-Forwarded-Encrypted: i=1; AJvYcCW0N21tM0OYFzkpo1e0RIwq9EVf/SucJ1X4MMuH4OU5oOEDphC0pQ+XKOS9uu7vuEguhhW7zd+H6OjmdmSZQPBeJMZ8QEeNkqShmx2N1UBMNmzeQGdaCyVWsnPGMtbRhGW2yzmzwkDcBi1YMpAaK6GZvnqGd+KvRTZtofDLMwUfRmFjTxUk
X-Gm-Message-State: AOJu0YyV/M9Dq8e5LFXXpq1v4MfDUHbNu9BSxNob9Z44H6qcfxCPjVB6
	MwP4TmzIF+Dw21BGQJ9IODMVdoLFPsl4EZF24zwhPDMfsIUKESg9s2kSBw==
X-Google-Smtp-Source: AGHT+IGE/Z7FqcafjZphknZusfs1seXePC3UZoSxmZCkJHzLFZu+1mTSdCv+F7KypwvQ1l5vmCFSVw==
X-Received: by 2002:a17:90b:50cd:b0:2c7:db01:c9ad with SMTP id 98e67ed59e1d1-2c7db01cbf7mr6557900a91.18.1718998411694;
        Fri, 21 Jun 2024 12:33:31 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4ff97c8sm3999661a91.12.2024.06.21.12.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:33:31 -0700 (PDT)
Date: Fri, 21 Jun 2024 19:33:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Jake Oshins <jakeo@microsoft.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, mhklinux <mhklinux@outlook.com>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: fix reading of PCI_INTERRUPT_LINE and
 PCI_INTERRUPT_PIN
Message-ID: <ZnXVgy_hVz5JXncD@liuwe-devbox-debian-v2>
References: <20240621014815.263590-1-wei.liu@kernel.org>
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
 <20240621110327.GA19602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DM4PR21MB36085B06555AF3CD6244ACEAABC92@DM4PR21MB3608.namprd21.prod.outlook.com>
 <SA1PR21MB13178E3D11B407F9B272E8F4BFC92@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR21MB13178E3D11B407F9B272E8F4BFC92@SA1PR21MB1317.namprd21.prod.outlook.com>

On Fri, Jun 21, 2024 at 06:41:04PM +0000, Dexuan Cui wrote:
> From: Jake Oshins <jakeo@microsoft.com> 
> Sent: Friday, June 21, 2024 9:51 AM
> > [...]
> >On Fri, Jun 21, 2024 at 06:19:05AM +0000, Wei Liu wrote:
> > On Fri, Jun 21, 2024 at 03:15:19AM +0000, Michael Kelley wrote:
> > > From: Wei Liu <mailto:wei.liu@kernel.org> Sent: Thursday, June 20, 2024 6:48 PM
> > > >
> > > > The intent of the code snippet is to always return 0 for both fields.
> > > > The check is wrong though. Fix that.
> > > >
> > > > This is discovered by this call in VFIO:
> > > >
> > > >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > > >
> > > > The old code does not set *val to 0 because the second half of the check is
> > > > incorrect.
> 
> Hi Wei, so you got a non-zero 'pin' value returned by the host when the guest reads
> from the MMIO config page. What's the consequence? Will VFIO try to use the legacy INTx 
> rather than MSI/MSI-X? I'm curious how you noticed the bug. I'm also curious why the
> host doesn't return 0 for the 'PIN' register when the guest reads it from the config page.

It is not the guest reading the register. The VM has not launched yet.
Everything happens on the host side. The host side software is preparing
the device for the VM to use.

The consequence of this bug is that user space code will think INTx is
available while in fact it is not.

VFIO itself doesn't care much. I noticed the bug because our VMM (Cloud
Hypervisor) initializes INTx whenever it is available.

> 
> >  I believe that this fix is correct.  (And I'm frankly surprised that this bug didn't
> > cause a problem before this.  It's been there since I first wrote the code.)
> > -- Jake Oshins
> 
> I suppose it didn't cause any issue because the PCI device drivers use MSI/MSI-X,
> so they don't care about the values of the 'PIN' and 'LINE' registers.

I suspect the same. Drivers almost always prefer MSI / MSI-X over INTx.
No one else triggered that code path before.

Thanks,
Wei.

> 
> Thanks,
> Dexuan
> 

