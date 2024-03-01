Return-Path: <linux-hyperv+bounces-1623-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00386DE2D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA39D1C20905
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648626A349;
	Fri,  1 Mar 2024 09:26:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00435B1E2;
	Fri,  1 Mar 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285161; cv=none; b=cIIlQm/4Dt7T7aU3u2eXIYgyQmppyeP4kN6e4+FpqN6JgbFc2+TykyVr5TtA6EUrNLo57wfFVjHvF12EXIx6o8ThdW94HWnFQltNsNtWJDj/AP/eIVbGR5mG/liiI7PKvJYIpLWoUyF8WwrnjlzgJe3BUPXqvQk38ECMnnZ8Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285161; c=relaxed/simple;
	bh=sN1SvxmlzsPc4GNfK/+SfrEzV9RqjLvrfnVGn5gfylQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POpqcCTslQAlp1zt9RaBxLlEUdn2vez7NzdRhZUU3SuXqo22hxhY7WcAT3hECQEhcJxQB4fK8/eFHdmB3s3fhmikPTOqOYLSCNSTSqnSjd/dcXMjPRde+WqkoIW42ehvTDs3pRj12lNC3TiiIHkESyirVP5qriMRW6R0kxi9nV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d911c2103aso3990395ad.0;
        Fri, 01 Mar 2024 01:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285159; x=1709889959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rvBvZAsShRAcxOaAuR2g72h+Alt1DyFcdhhr75XnVWc=;
        b=NqTc9a4D8OPRo6YJd+37Ngtebke4jNc+/QmU7Gj3w1yV8xTYXGUIgavo20g1zSjpbh
         Lwt3uNPDBAQa67n/1uwA4CK+TWuS6ReyTqHqkUf0uFxtzEG3Se1wm47fl93bDTtAlN+I
         EwvERA/twQR2xUxRmFLuWAyNOiR5+EJr6nPoFVKivTzLtsynDCHG7ZCdEqSsDWMMRsTU
         aCHz1wRH2s6MjphuQsVvb8PYddeoGtby7oy5w4byT4G2MpPrifos6s6Qged9NEefuGeu
         P+a6YQUCJWcjH5oVOde+8cZsTGpyjYXoabdxDl+OUi3LAT4yzNWN11HvupmkMjB01fIO
         2zJw==
X-Forwarded-Encrypted: i=1; AJvYcCUxGFFUnmT1qTDU2UpdCYZ30GnZHDe0LULFciciyrcU/IeXJX7gzzL878fXMqm8aum+LVzCC6CT6U3Cfo+7eyKaXFBTE3lsAbKUkx/X5hw330c5+lc4kQ8PX4x1BTaPbYdjtECeDIeoFfmMgBDIYip44bfH/3zhO6b+9nBu5eIu0aPF1Wf5nz/DZKUp
X-Gm-Message-State: AOJu0YzZe7ZQ4FjdDPdxMir2PEiUjyndBAPLjk2XQh8Ub9wajTaZTvpN
	A9kRm3rp9a7sz8RIF1g1O/nBBMyZFKviNAvwoL/1Fyi/9j5jh0mx
X-Google-Smtp-Source: AGHT+IHNKZrSwznz/6W/vqfHTfsBZW3ScbjjlHJkN0z7Xg9qLKLx0WqwGZ3s31af9X1XAWOVS2nlBQ==
X-Received: by 2002:a17:902:d4d0:b0:1db:5b41:c59a with SMTP id o16-20020a170902d4d000b001db5b41c59amr1316686plg.45.1709285159205;
        Fri, 01 Mar 2024 01:25:59 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001dcb063349csm2953127plg.150.2024.03.01.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:25:58 -0800 (PST)
Date: Fri, 1 Mar 2024 09:25:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Remove duplication and cleanup
 code in create_gpadl_header()
Message-ID: <ZeGfJZv-dWMIZJsx@liuwe-devbox-debian-v2>
References: <20240111165451.269418-1-mhklinux@outlook.com>
 <de6c23b2-aa27-494a-a0ec-fe14a4289b38@web.de>
 <SN6PR02MB4157A7AC71EF769E5B88202CD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157D586E6523E5747690FB0D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157D586E6523E5747690FB0D44B2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Feb 09, 2024 at 03:33:24PM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, January 12, 2024 8:19 AM
> > 
> > From: Markus Elfring <Markus.Elfring@web.de> Sent: Friday, January 12,
> > 2024 12:06 AM
> > >
> > > …
> > > > Eliminate the duplication by making minor tweaks to the logic and
> > > > associated comments. While here, simplify the handling of memory
> > > > allocation errors, and use umin() instead of open coding it.
> > > …
> > >
> > > I got the impression that the adjustment for the mentioned macro
> > > should be performed in a separate update step of the presented patch series.
> > > https://elixir.bootlin.com/linux/v6.7/source/include/linux/minmax.h#L95
> > >
> > > See also:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Docu
> > > mentation/process/submitting-patches.rst?h=v6.7#n81
> > >
> > 
> > To me, this is a judgment call.  Breaking out the umin() change into
> > a separate patch is OK, but for consistency then I should probably
> > break out the change to memory allocation errors in the same
> > way.   Then we would have three patches, plus the patch to
> > separately handle the indentation so the changes are reviewable.
> > To me, that's overkill for updates to a single function that have
> > no functionality change.  The intent of the patch is to cleanup
> > and simplify a single 13-year old function, and it's OK to do
> > that in a single patch (plus the indentation patch).
> > 
> > Wei Liu is the maintainer for the Hyper-V code.  Wei -- any
> > objections to keeping a single patch (plus the indentation patch)?
> > But I'll break it out if that's your preference.
> > 
> 
> Wei Liu -- any input on this?  This is just a cleanup/simplification
> patch, so it's not urgent.

These patches are fine. I'll take them via the hyperv-fixes tree.

Thanks,
Wei.

