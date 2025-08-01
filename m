Return-Path: <linux-hyperv+bounces-6453-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58176B18070
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Aug 2025 12:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17ACF3BAB87
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Aug 2025 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C4C23535E;
	Fri,  1 Aug 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MFPtCz9E"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E6C2B9A5;
	Fri,  1 Aug 2025 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045541; cv=none; b=pLJ7iszFIHsX+GeDqW3o75gejYXmlANgouD2VRuAdTsoG2zph6cPHd8Ffc44cebOmQbihQBpJFaTwhscz5o/LIvynOCEsu1UVCAuZS/vKjEJhkZK68WtCIk1BpGyg73hCY/xR2IUgBa3//5SgqULnlcw/nBOXAyM6ybJMu+XMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045541; c=relaxed/simple;
	bh=Pq4K8Lbc77aD4fbd+31DfDceIFn4GKRekMM7Bcbhbaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3IUdzDsmkPL0JQea9fGadrN9nXart+x8n0R1OsoYUByik7WSLGoYAgeIotAP3ELOniLkyKNnDh7Ez/vrggKRyQTnfbvKZw0ip1VjRZYtiFNrZeenIxogn8vJmhHQJpPNfOmIgByRwXcTJEWrOUVJqmc3H6TCwUBCfDTFLEMpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MFPtCz9E; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1754045535;
	bh=Pq4K8Lbc77aD4fbd+31DfDceIFn4GKRekMM7Bcbhbaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFPtCz9E09oRpuzc89z+FHmxx7ew/EaVMdUB1wrjQVihZpQ3HrUYJLrAlxozJeVF1
	 uK4CVbyUWqTAersD5/jIxjOlXzs7g3Bfrnwx2JIEUw5/UJ7UZFJcOla5v+ihZAUMl5
	 zhL/ZJwt4hWKd2UP2FPe6lmPk8oC88DdGLyRC/V0=
Date: Fri, 1 Aug 2025 12:52:15 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Long Li <longli@microsoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6.12] Drivers: hv: Make the sysfs node size for the ring
 buffer dynamic
Message-ID: <8f642ca2-04dc-4d87-b120-5d128ec3202e@t-8ch.de>
References: <20250723070200.2775-1-namjain@linux.microsoft.com>
 <SN6PR02MB41579080792040E166B5EB69D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <e1d394bd-93a6-4d8f-b7f9-fc01449df98a@t-8ch.de>
 <SN6PR02MB415792B00B021D4DB76A6014D425A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <4abf15ac-de18-48d4-9420-19d40f26fdd2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4abf15ac-de18-48d4-9420-19d40f26fdd2@linux.microsoft.com>

Hi Naman,

On 2025-07-31 21:13:27+0530, Naman Jain wrote:
> On 7/30/2025 1:15 AM, Michael Kelley wrote:
> > From: Thomas Weißschuh <linux@weissschuh.net> Sent: Tuesday, July 29, 2025 11:47 AM
> > > On 2025-07-29 18:39:45+0000, Michael Kelley wrote:
> > > > From: Naman Jain <namjain@linux.microsoft.com> Sent: Wednesday, July 23, 2025 12:02 AM
<snip>

> > > > Unfortunately, I don't see a fix, short of backporting support for the
> > > > .bin_size function, as this is exactly the problem that function solves.
> > > 
> > > It should work out in practice. (I introduced the .bin_size function)
> > 
> > The race I describe is unlikely, particularly if attribute groups are created
> > once and then not disturbed. But note that the Hyper-V fcopy group can
> > get updated in a running VM via update_sysfs_group(), which also calls
> > create_files(). Such an update might marginally increase the potential for
> > the race and for getting the wrong size. Still, I agree it should work out
> > in practice.
> > 
> > Michael
> > 
> > > 
> > > Thomas
> 
> hi Thomas,
> Would it be possible to port your changes on 6.12 kernel, to avoid such
> race conditions?

Possible, surely. But Greg has to accept it.
And you will need to do the backports.

> Or if it has a lot of dependencies, or if you have a
> follow-up advice, please let us us know.

Not more than mentioned before.


Thomas

