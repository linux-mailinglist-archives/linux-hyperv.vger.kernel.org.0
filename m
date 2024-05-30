Return-Path: <linux-hyperv+bounces-2259-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAAE8D43C2
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 04:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD47E2852E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A040F9F7;
	Thu, 30 May 2024 02:45:26 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1998480;
	Thu, 30 May 2024 02:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037126; cv=none; b=FuoAUMtApcIjtyhmDp1y5Y74hYYp8mC+a82SelrK3HWaia2L/B6/yszGZFVgXxqGlpYsrqeTQ8iDEaB4XzbQyzATFUVMA0VPs/+0XDYjRx1GziG0zlfNWh3Aah8Kr9AID66usFGxw4kMJs2J1SScB2gaD60X5g0ursonLYVYBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037126; c=relaxed/simple;
	bh=1w47dG6iwVStuKGBIonKiM24BQI7knvVqfrf478mb6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aB6mPK13KQdYvKGhethz9fJSq6ib/hDrXPeBSmb44JHQlU2UnMLApiSz9z9L8EkH8xpVVChoaBIwzZsed8OGIjjThpjUrd1V/+HTy6SFxGthfQg1qLC1SrZ7hUYB0jQwXnz0wYgVdeu1o4Jr/IoXjkjBTdpNgnVlzas90IP72RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-24ca03ad307so237171fac.3;
        Wed, 29 May 2024 19:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717037124; x=1717641924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnKJIrmXi20YB0E74oQIBvd6GDGh12oCc6N2c/VdEwU=;
        b=wlIaBbyOfNCjmBRbbHmrb4cIEoOpTwbc6v7j+2SBKng09Ch8xiXu7RlFDWRrvgGEnV
         xrr0lTbLWaCZ4zlSl6LigONWEY49oSZolZmgdUvEKH2EgvEMy+Jwvo4AD3xzSucGzUO7
         7J/ylT/ZePPv4ywcj7hfA/gnrQXKhksU5cWW4LlIhOPMtxp+XBvywl1FXYF5ifViUnOD
         bn9gG8LOesqV4L0wGDwtLYxK4ixFv0v2ThmGQBsKjgmPTr+oW8ZgJC3c7yrHEjmSRN4F
         y9uaw4UdsTugPWQb0JJEpKd7ZkFnIjJg4KsO00fNhyyWgTt7izfecLagXNA/RqelUl8U
         018g==
X-Forwarded-Encrypted: i=1; AJvYcCUpOTeu9A/IayOnplUxM6+aCwAwehVFS3Y1HzrOkOEOMsbxRdvdQhstxlk5K1N980NEH5YCREs/rNh/jfOZ4d9kWBWgcQz1P+eM2nw9nDQJ4ySMHvMjCNPrOvdpJ5Y9gYgN2DnmTPteZk0e
X-Gm-Message-State: AOJu0YzEizco+Bac82twzJa6DomOuyYfboJj8qvP8uCPPBkejOw/dOwM
	3E7QpUkurZ3pk2H9WQSjxsWWs+M7PCR7i4rccR7u+YDoUWJigGPXgHlMNw==
X-Google-Smtp-Source: AGHT+IGw0sWYovwEDI5ep8+8wprw2L01K+uPlFM0wC4C9zzWPOiCl6Xyrj4D7Rr0Nh5BacT3McxW2A==
X-Received: by 2002:a05:6870:d24e:b0:24f:da39:f649 with SMTP id 586e51a60fabf-25060de9e3cmr1155409fac.50.1717037123354;
        Wed, 29 May 2024 19:45:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7023009490esm389361b3a.78.2024.05.29.19.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 19:45:22 -0700 (PDT)
Date: Thu, 30 May 2024 02:45:18 +0000
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
Subject: Re: [PATCH v5] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <ZlfoPlGF40dc8u4f@liuwe-devbox-debian-v2>
References: <1716998695-32135-1-git-send-email-adityanagesh@linux.microsoft.com>
 <SN6PR02MB41572A8E15A990EB162C60FCD4F22@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41572A8E15A990EB162C60FCD4F22@SN6PR02MB4157.namprd02.prod.outlook.com>

On Wed, May 29, 2024 at 04:29:17PM +0000, Michael Kelley wrote:
> From: Aditya Nagesh <adityanagesh@linux.microsoft.com> Sent: Wednesday, May 29, 2024 9:05 AM
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
> >  to "Drivers: hv: Cosmetic changes for hv.c and balloon.c"
> >  drivers/hv/hv.c         |  37 +++++++-------
> >  drivers/hv/hv_balloon.c | 105 ++++++++++++++--------------------------
> >  2 files changed, 53 insertions(+), 89 deletions(-)
> > 
> 
> [snip]
> 
> > @@ -999,21 +984,14 @@ static void hot_add_req(struct work_struct *dummy)
> >  	rg_start = dm->ha_wrk.ha_region_range.finfo.start_page;
> >  	rg_sz = dm->ha_wrk.ha_region_range.finfo.page_cnt;
> > 
> > -	if ((rg_start == 0) && (!dm->host_specified_ha_region)) {
> > +	if (rg_start == 0 && !dm->host_specified_ha_region) {
> >  		/*
> > -		 * The host has not specified the hot-add region.
> >  		 * Based on the hot-add page range being specified,
> > -		 * compute a hot-add region that can cover the pages
> > -		 * that need to be hot-added while ensuring the alignment
> > -		 * and size requirements of Linux as it relates to hot-add.
> > -		 */
> > -		rg_start = ALIGN_DOWN(pg_start, ha_pages_in_chunk);
> > -		rg_sz = ALIGN(pfn_cnt, ha_pages_in_chunk);
> 
> Hmmm.  The above is not a cosmetic change.  Looks like this
> delta was erroneously introduced in the v5 version.  It wasn't
> there in v4.

This also breaks the build, since now the comment is not terminated.

Please fix this and resubmit.

In general, you should always build test your code before submission.

Thanks,
Wei.

> 
> Everything else LGTM.
> 
> Michael

