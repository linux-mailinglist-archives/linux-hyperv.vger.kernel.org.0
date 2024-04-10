Return-Path: <linux-hyperv+bounces-1950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDB8A01E9
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D007C1C216EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676E1836CC;
	Wed, 10 Apr 2024 21:25:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85628FD;
	Wed, 10 Apr 2024 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784327; cv=none; b=SqZzOguCiL8R12upHIVrxU3VJNimidkjiAArqj4yfbzYaoxX8qxLuUTFAAo8me9k+rxXVSTT3KsUikIxYdxY2SNW14Sh+M/6Sm3Q3yM09wryHYgf8lKcD1t5ALzwdfHMmIyTgru+bnZJiFuOExt9/dy2qTsri/yvEOWtYcpzwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784327; c=relaxed/simple;
	bh=UkFqCQxUVGADrXs/rHR7QYkZkIAK+RQyTkVkEoXHXF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vm/vx0jFReXr681FIr1DfMWSxJejS9ro/hk8cRrd5gR/OJHrvrZTmkYqvJIS1qlT+7eyoR/CzZhPnIEp/lNM5OER6NTaVImshawd4Xe2YE9WDEaU+GySAD8pY7RZjS7feAOy2ZUtttcpXWbBfEb/G0GiOrVOI4SXfQ4UNFCN4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso4786203a12.2;
        Wed, 10 Apr 2024 14:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784326; x=1713389126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovq6mqhcVOyFtIohCNUmxqiI4ZwPqnIiUFg1EJOt/wE=;
        b=XaQv8ANe+TQr+2zVgJdX11au8z7zjZ7Nr0TFdkOqw0ooaCyacVD/z+SNGY3PaLbvB0
         OU0IIOLjYxzmlYN/R+bmaZXfjN3U7sW3/IgeiuMxH1x5HUl4CxNkxDVONkLzJBPP6zkH
         6Tw5fTogWY8NAcYjgx7Q5Kw2EV3R0tOYKk58mG21GX24JaDuwTmqE1VhoL9Urk02yWtv
         hEUbgLDcgdm8Mdq2o7ExCWQQ5ccl+BuKa7fnNZZuvSEJdCj1yoqd1i9XLlpFj51k2ipa
         GX5gu23ImvIjZaFcxY0Gt9kbwnIHe10yBFI5nEC8fjXZpQvZzj8ZnnuSHBSonPtFwO5o
         D/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoPaI05AkP4X99ImuOTw0zGpVzIPHY1Gp8ZjyEoyZe4cRTSsUI8atFtWGgK8fj5RBxpEepKPa6beVTkgcc/NUZou7sGvhxFdRP9bMLjRvoeF1eBs81WQ2NS4EaBwAkDVQSOjhvaJmCFxpB
X-Gm-Message-State: AOJu0YwGNly6IyXgy4aQmbfFWrkO75PqpfB98jhwbG08en515e2l814f
	Zt5JzJlZAQDhBarWCveITma6x73HY5HAZtyMBjuJxOUtTMQdDI8x
X-Google-Smtp-Source: AGHT+IF5iO4xQx0X2bYsefNBkWznhZfggZG/GvhLcLp902OwvFUODpp3lFO5m34+wa5MdkVagnNsOg==
X-Received: by 2002:a17:90b:30d5:b0:2a5:270c:38cc with SMTP id hi21-20020a17090b30d500b002a5270c38ccmr3809321pjb.43.1712784325678;
        Wed, 10 Apr 2024 14:25:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id a18-20020a17090acb9200b002a5e1b215ccsm86134pju.21.2024.04.10.14.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:25:24 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:25:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit()
 family
Message-ID: <ZhcDvNyYO58hH1Le@liuwe-devbox-debian-v2>
References: <20240319034350.1574454-1-lizhijian@fujitsu.com>
 <Zf4WUMyNq38LyDLW@liuwe-devbox-debian-v2>
 <5c1f6aba-bd3c-438c-8e00-548fe29d8136@fujitsu.com>
 <ZgG5O3uO9JgOmU_Q@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgG5O3uO9JgOmU_Q@liuwe-devbox-debian-v2>

On Mon, Mar 25, 2024 at 05:49:47PM +0000, Wei Liu wrote:
> On Mon, Mar 25, 2024 at 09:39:52AM +0000, Zhijian Li (Fujitsu) wrote:
> > 
> > 
> > On 23/03/2024 07:37, Wei Liu wrote:
> > > Hi Zhijian,
> > > 
> > > On Tue, Mar 19, 2024 at 11:43:50AM +0800, Li Zhijian wrote:
> > >> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> > >> or sysfs_emit_at() when formatting the value to be returned to user space.
> > >>
> > >> coccinelle complains that there are still a couple of functions that use
> > >> snprintf(). Convert them to sysfs_emit().
> > >>
> > >> sprintf() and scnprintf() will be converted as well if they have.
> > > 
> > > This sentence seems to have been cut off halfway. If they have what?
> > 
> > Is it hard to understand, what I want to say is:
> > 
> > Sprintf() and scnprintf() will be converted if these files have such abused cases.
> > 
> > Shall I update it and send a V2?
> 
> No need. I can fix up the commit message when I apply the patch. Thanks.

Applied to hyperv-fixes. Thanks.

