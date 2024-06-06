Return-Path: <linux-hyperv+bounces-2331-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9A8FDE73
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 08:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DF6B21AAD
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 06:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0D21DA4C;
	Thu,  6 Jun 2024 06:04:05 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D587F8821;
	Thu,  6 Jun 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653845; cv=none; b=gAQgTsFN0vPAnq2NL8Sg0rMbMDzuYbxhA7DZPH6WTn2yVK8UMAdYlrwolKVI8j2vieZymbxglAZBasfIskP23dkHeMi+n0FDrzlS36qbqwhDfvNBfmFnrmlJdVBPcGmKfrM2eOdHCk5cItnkd0geAJlxvWtzzKagERavNngrIKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653845; c=relaxed/simple;
	bh=q0RkIW1UuOcBaGnX7vu1FHUFaqjIonZ3nWXkvIDOjNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui31+ChYELI/ESi+uaMPq7kL5zSmeGLwH1k4rhdjAn4hUI0w9mJ3Sxnb63g22buPHhc3EiN19GB/qc6bDZCBdYyRg7VFMHjPuUTu5jTEddFkEjQcDH554u1Vuyw8F2ZA7YD7ptKFcRUBSxmk1bUatT/AEpS8W3IwvwcuobAw1g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f480624d0dso5742985ad.1;
        Wed, 05 Jun 2024 23:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717653843; x=1718258643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW+NUheV7568ouqMVknlYZR46EFHvU/7fsxRTr51dSA=;
        b=jTi2AZpIgG3Mnlfq9+peXCZVu82N0zqbqU7TDUgj7EIhjbhovCfJcrLhZ9/eu6bzQd
         fdfgntsRyxM99senHDY+aPxEVQArj0KUBt3F4043lY/6WNm4CQIAQl5TTv4jDOPGTBfA
         mygpZUbEwduLKcxyN+K01YHRH7TIpuFZguLsGG36TUyGeYURagozqCyk6E4uRSNyYyM1
         Hs8MB8ValxUF45ukqWZjqsk3PgbOOcIMduWrWpw8dUwEphK/nCKPSpPAKe8JwEfAWFos
         Lb39t2GE99meAZlLjksB41ZgTSASabiVuQUgU47Ceq+u9uKUW0NgbA3KuFaMr5yVRm8a
         fuQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdIHCYR2QGyVc2ccrZ7tNgeF9lT2veWsI2EBLqCerJVP56K5b2cvGUrS9qAU9I29IKBOpum/3Vv/0Eca5tKOvIiskpZEeruVWuc8dv8vQrNBFWmB0iqEmKs8bFyUBc8kY7aIFqpb8RtEw8
X-Gm-Message-State: AOJu0YxCkyE1uhcpH4K8Lk2XWIyVSvKPl7Xz5e0ZBxjf1O7VygJczKBr
	mTjQEeNuTenvVJiSv88hW3YXJeNWSVGGpJQvzzi5wgykVHBApcx91Or0jg==
X-Google-Smtp-Source: AGHT+IEedURaXgZKthRR+I14MZX7JgvaXsxKqCy9JKFRscKccmM0FEVjcN3PflLAjXihY0+B8ZLs+Q==
X-Received: by 2002:a17:902:e80b:b0:1f4:8358:47d5 with SMTP id d9443c01a7336-1f6a590a9d9mr65401995ad.7.1717653843013;
        Wed, 05 Jun 2024 23:04:03 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7d898asm5809685ad.134.2024.06.05.23.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:04:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 06:03:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Aditya Nagesh <adityanagesh@linux.microsoft.com>,
	"adityanagesh@microsoft.com" <adityanagesh@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <ZmFRTC7mi-67GG_8@liuwe-devbox-debian-v2>
References: <1717152521-6439-1-git-send-email-adityanagesh@linux.microsoft.com>
 <SN6PR02MB4157D719EE0D5BAC19FFA449D4FD2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D719EE0D5BAC19FFA449D4FD2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Sat, Jun 01, 2024 at 04:11:32AM +0000, Michael Kelley wrote:
> From: Aditya Nagesh <adityanagesh@linux.microsoft.com> Sent: Friday, May 31, 2024 3:49 AM
> > 
> > Fix issues reported by checkpatch.pl script in hv.c and
> > balloon.c
> >  - Remove unnecessary parentheses
> >  - Remove extra newlines
> >  - Remove extra spaces
> >  - Add spaces between comparison operators
> >  - Remove comparison with NULL in if statements
> > 
> > No functional changes intended
> > 
> > Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>
> > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V6]
> > Fix build failure and unintended change after rebase
> > 
> > [V5]
> > Rebase to hyperv-fixes
> > 
> > [V4]
> > Fix Alignment issue and revert a line since 100 characters are allowed in a line
> > 
> > [V3]
> > Fix alignment issues in multiline function parameters.
> > 
> > [V2]
> > Change Subject from "Drivers: hv: Fix Issues reported by checkpatch.pl script"
> >  drivers/hv/hv.c         | 37 ++++++++--------
> >  drivers/hv/hv_balloon.c | 98 +++++++++++++++--------------------------
> >  2 files changed, 53 insertions(+), 82 deletions(-)
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 

Applied to hyperv-fixes. Thanks.

