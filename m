Return-Path: <linux-hyperv+bounces-2477-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7871F912E94
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 22:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13920B27494
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Jun 2024 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC516C84B;
	Fri, 21 Jun 2024 20:32:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3416D4CD;
	Fri, 21 Jun 2024 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001963; cv=none; b=Jq4JAajBeqdERJqC1d9jogZ+P81eIbvx3QvdSccpkdNwEq6s17h0B8qAp5fxp8MbZxLE0A1ArXeMWZYDWbjcBTbVu0/D7bXOXaNGqOUaN4Rm1AgHDRktuVBuoPrRKMdnIq1OCo9DHMwE9kBZDiDRzLKmrV3sQLDvc83jjGEonO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001963; c=relaxed/simple;
	bh=vAeK4Ayp6O1zO9d9Fffwtf/IDcupIiAFBSbIgUf3E4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQY622rvd1rSxlANBmiitrWYUX4idkh6veA5b0Jga0U4j4RpjYYrP+3ht/ZglAmND/q/2QYSzTGAv4ZNQwfAdq7bXlEGeIs3OxRyZpn0SBliQQ69B74M0nJM0v7wZGNE0Hzi612ftHiY1b2/mJWyCP6RKSk2eLM6PKTx6IZ10VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f4a0050b9aso19926295ad.2;
        Fri, 21 Jun 2024 13:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001961; x=1719606761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4T/75yEUWI9QmnMDbKvawY613lpe8URFHiL1wBcQC0=;
        b=jkHlgq4SJUC0Q5LYv92mpYjl/XbtWJBT0mackip4Idxt0FlyOpgGG5hWUZANtTysBa
         aZ/zARMhka2nthyoE7UTZybJB3NsodKR9LyPMKRkRofke6Gr2bPpPEVae99gaooWUMta
         JEMifH0rRBIs+0f95f9FYmoM59hXUNCTmcsrIGG4KAJabeQ9Ztz2iTub5a774QJNhg/M
         O8Fx3WvX6VFOdXvGMX/elzACBasQY2uffeFiAMAJlFGG2GYfoZSD51qOtbLdqZUDtOF9
         +eGtFtWZ30/pP6240z6Vl4XtzXDiklTGml8VaSPRIFjJKgXG1gJXFDvoMLY24lXd+wUr
         k9Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUXFrSjatY8cHijonOLJw42QyqDqy8PN9RfdbPU+LRLh13fCnBP8ec9ByWUd4L4zfDrnzUwveMdmBS9tNWlFmSIxeY83YH3+KuN6oFiis58V5KMV5FkIey7vUwou168U2uMgtswP0Sqr9cbWDQ9lz1KGgVrpo0bxYyCHC+QVfGIgHVv558p
X-Gm-Message-State: AOJu0YzSIL4Ydf6E55wtoLYZFQC+5QumwhLYJZCDF09qyEReycFk4Lfk
	wQq2YqGKgwzvItdYvdMqdvvZk0ZFvyXyHdQ4HfWT6nbiFS+IVmpa
X-Google-Smtp-Source: AGHT+IHQQs9gxpCxk/tH5pi5uy0PgjLOUYKzya+zcxlxyEp/xlUOmbT0lB6mjENELe/ieYsATCsfSQ==
X-Received: by 2002:a17:902:dc84:b0:1f6:6ef0:dae4 with SMTP id d9443c01a7336-1f9aa3eb973mr75432615ad.32.1719001961236;
        Fri, 21 Jun 2024 13:32:41 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb5e406esm18088635ad.221.2024.06.21.13.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 13:32:40 -0700 (PDT)
Date: Fri, 21 Jun 2024 20:32:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
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
Message-ID: <ZnXjYV4oc2ONokld@liuwe-devbox-debian-v2>
References: <20240621014815.263590-1-wei.liu@kernel.org>
 <SN6PR02MB4157C9FD41483E9AC7ED9E70D4C92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZnUbWUdVE7q8oNjj@liuwe-devbox-debian-v2>
 <20240621110327.GA19602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621110327.GA19602@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Fri, Jun 21, 2024 at 04:03:27AM -0700, Saurabh Singh Sengar wrote:
> On Fri, Jun 21, 2024 at 06:19:05AM +0000, Wei Liu wrote:
> > On Fri, Jun 21, 2024 at 03:15:19AM +0000, Michael Kelley wrote:
> > > From: Wei Liu <wei.liu@kernel.org> Sent: Thursday, June 20, 2024 6:48 PM
> > > > 
> > > > The intent of the code snippet is to always return 0 for both fields.
> > > > The check is wrong though. Fix that.
> > > > 
> > > > This is discovered by this call in VFIO:
> > > > 
> > > >     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> > > > 
> > > > The old code does not set *val to 0 because the second half of the check is
> > > > incorrect.
> > > > 
> > > > Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V
> > > > VMs")
> 
> 12 characters are preferred for Fixes commit id.
> 'Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")'

Fixed. Thanks.

