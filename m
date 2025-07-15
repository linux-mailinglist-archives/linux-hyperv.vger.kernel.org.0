Return-Path: <linux-hyperv+bounces-6251-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14232B051AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 08:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441A44A847E
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 06:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2890226D14;
	Tue, 15 Jul 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/OWgLwc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE312CA8;
	Tue, 15 Jul 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752560756; cv=none; b=oa5rOwNKT5uW3fRBGS+YbBVItc1DUy5in5E/kE/o4k1rB/ebfyYvDPSeBq2OAHTOJ26nJ5EoyaUxAAwOLmVh1LxfynYqnvueWVEkMfXk/O3Qc2Jlwj6i01MrH1NQmNsmdUt/EguI28pokmFymIlmEsg+AC3IdLHCdFoTDqU/wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752560756; c=relaxed/simple;
	bh=53zv7yITO/rILAd5sYXsVnpiloVw8QyX+s8kmTGatiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+wbgO/odGWUblX2fqAxAchwkiQVQtLjQxlY2VufdpIR2GpSIyJsWIKFGsreIS5vWtgpbxd6Y9AGAxSFhH3aFnIoT5+KT/SFk3o4P6vqrX+ZXL1A9FP72ZHTXbLoPzmzCb/s6JHo4kRrQaJoECo7Iei9MqiWZHBvI4zy64Axy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/OWgLwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F55C4CEE3;
	Tue, 15 Jul 2025 06:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752560756;
	bh=53zv7yITO/rILAd5sYXsVnpiloVw8QyX+s8kmTGatiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X/OWgLwckAYDLS6OI6lCYOKJ8ZWSSOt903Pjls54XDOiIvtisj5pJzfPHOz8nAhWz
	 YfE8/eOXuohsi1Gl08NbSPtjkJxZUjHyU0dQ93xn90MeaVOwC7drLHh7ytKAKvlOXi
	 v6JxbLC/hdP9S+Ej+XiWnpgJ1Ay36FC29jY356ecv+zzDu2GOA8ZVJpMhP3gH58Ia6
	 s0hZ78Fx4wxQCoI4tDQvzLgog+lHk5dFum5FtV1kOo/Am5IeNRhnz72XC43Li8jZAD
	 TmRR6ePUSbupJMQ6MhKk2OtIkCLDxsDqDuceTYX5/00a2+9fro8TShfk88RSynZbzY
	 vWn82UrDzJfEQ==
Date: Tue, 15 Jul 2025 06:25:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Olaf Hering <olaf@aepfle.de>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
Message-ID: <aHX0c0VsCIwR27K7@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250711060846.9168-1-namjain@linux.microsoft.com>
 <326fcccb-1563-4cb7-a137-993d4ce3cedc@linux.microsoft.com>
 <DS2PR21MB51816F322B9D204B75D9A4B6CE4AA@DS2PR21MB5181.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS2PR21MB51816F322B9D204B75D9A4B6CE4AA@DS2PR21MB5181.namprd21.prod.outlook.com>

On Sat, Jul 12, 2025 at 08:00:35PM +0000, Long Li wrote:
> > Subject: Re: [PATCH v4] tools/hv: fcopy: Fix irregularities with size of ring buffer
> >
> >
> >
> > On 7/11/2025 11:38 AM, Naman Jain wrote:
> > > Size of ring buffer, as defined in uio_hv_generic driver, is no longer
> > > fixed to 16 KB. This creates a problem in fcopy, since this size was
> > > hardcoded. With the change in place to make ring sysfs node actually
> > > reflect the size of underlying ring buffer, it is safe to get the size
> > > of ring sysfs file and use it for ring buffer size in fcopy daemon.
> > > Fix the issue of disparity in ring buffer size, by making it dynamic
> > > in fcopy uio daemon.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 0315fef2aff9 ("uio_hv_generic: Align ring size to system page")
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Reviewed-by: Long Li <longli@microsoft.com>

Applied to hyperv-fixes. Thanks.

