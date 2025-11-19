Return-Path: <linux-hyperv+bounces-7703-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38892C7074A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 18:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B314C4F91F1
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 17:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CB35F8B3;
	Wed, 19 Nov 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="V86sQ1ew"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B730C601;
	Wed, 19 Nov 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572819; cv=pass; b=h/36qRYSphF9JzMUsr78xw+glTjUmslJ14u1hWp0ypEmjTG3pqk5PE0YlNXFtBKiuip7UAmg6yRLL0uvSI2wABshrN/bBmS/+6CGEwu7H86Em5XnDqcKsCAv4sqCyjGZrcIrBmGK5XCE8vBvsFA7dQKTYeRUqesx8bOnSvjJMwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572819; c=relaxed/simple;
	bh=LF5Ahm/afGq+rAPzme8CGp0ZWx5FmjCwCBg64ROBvyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8w6iTY9gAan3Gp6z33a3TUk+toHz0gZXpnThu56Gec66TVJlcjrEzwEGX3/ALFx+J76Xcju64ddPXwtDIq2cwteA+EY77+hktMg7EsSHQ1d8GsOxMdEEF1U0jipM3VfkWJ6QqjkjjLAr0yLYkBdgDAM+0pbG9C21uV9wpyVUlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=V86sQ1ew; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763572804; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fKHtf76xLi0aE5q6NPDn2DcpHDlnvkGS1RP693JGt8p//3uZUuWjXoXCJ++hIXa/Jjne2tr8hIhFCR0d3Ibly6MN4J/vwLke87oXpMj3zaAeslyVKCQuo5Q8jMLJEWaSuD1K4SCvA9wdGKuLVhiMp9WcU5R4rFA+khbVF04+juM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763572804; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bP/YhmM1mmoDa/54vQg3jHi3UajAmuqnFuvdlk0DpWk=; 
	b=QWK/ML31w4i49G6/O8OcZ3RR4RvUnlveV2iivU45QZXnjwz9vzAVTAW30mVUBtLAWb2wZlhOLnjDxxF1I3nmCsyR2jvHW27rVPyc2A+erdjMbE0G68roQNhtQmW5ywu8LH+m5EUlg05DCASTuOKxS5KhBvTzMDqdIcj1g8YF9C4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763572804;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=bP/YhmM1mmoDa/54vQg3jHi3UajAmuqnFuvdlk0DpWk=;
	b=V86sQ1ewVDgK9WHlWlY8NR1a74HSo88bIDYpAfcyNd46j0Ow8GroxTZir8+dD8H3
	XofxytiMbb1q13CTU7rrehs1G0giVZwXDlpHmZm+l15EQalIg+eP1/n5836+0x0jJcd
	vK1PTG8gY4xcPFis8K7oPL4cNdMmt0rCEZdTHY2w=
Received: by mx.zohomail.com with SMTPS id 1763572801743154.60448542766414;
	Wed, 19 Nov 2025 09:20:01 -0800 (PST)
Date: Wed, 19 Nov 2025 22:49:54 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <5jbt7rwfmdwkdozzrndxhy3git2a4yaazoseb3e2oe24pofohi@wqcviepltkdp>
References: <20251117095207.113502-1-anirudh@anirudhrb.com>
 <36ac7105-3aa7-4e53-b87d-b99438f65295@linux.microsoft.com>
 <20251117191827.GC2380208@liuwe-devbox-debian-v2.local>
 <20251117192402.GA2402579@liuwe-devbox-debian-v2.local>
 <d65a1b2d-2fdf-4cd1-bd04-a438205c7a70@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65a1b2d-2fdf-4cd1-bd04-a438205c7a70@linux.microsoft.com>
X-ZohoMailClient: External

On Mon, Nov 17, 2025 at 03:42:19PM -0800, Nuno Das Neves wrote:
> On 11/17/2025 11:24 AM, Wei Liu wrote:
> > On Mon, Nov 17, 2025 at 07:18:27PM +0000, Wei Liu wrote:
> >> On Mon, Nov 17, 2025 at 10:16:12AM -0800, Nuno Das Neves wrote:
> >>> On 11/17/2025 1:52 AM, Anirudh Rayabharam wrote:
> >>>> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> >>>>
> >>>> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> >>>> execute a passthrough hypercall targeting the root/parent partition
> >>>> i.e. HV_PARTITION_ID_SELF.
> >>>>
> >>>
> >>> I think it's worth taking a moment to check and perhaps explain in
> >>> the commit message/a comment any security implications of the VMM
> >>> process being able to call these hypercalls on the root/parent
> >>> partition.
> >>>
> >>> One implication would be: can the VMM process influence other
> >>> processes in the root partition via these hypercalls,

Thanks for the review! This is a really good point.

> >>> e.g. HVCALL_SET_VP_REGISTERS? I would think that the hypervisor
> >>> itself disallows this but we should check. We can ask the
> >>> hypervisor team what they think, and check the hypervisor code.
> >>>
> >>> Specifically we should check on any hypercall that could possibly
> >>> influence partition state, i.e.:
> >>> HVCALL_SET_PARTITION_PROPERTY
> >>> HVCALL_SET_VP_REGISTERS
> >>> HVCALL_INSTALL_INTERCEPT
> >>> HVCALL_CLEAR_VIRTUAL_INTERRUPT
> >>> HVCALL_REGISTER_INTERCEPT_RESULT
> >>> HVCALL_ASSERT_VIRTUAL_INTERRUPT
> >>> HVCALL_SIGNAL_EVENT_DIRECT
> >>> HVCALL_POST_MESSAGE_DIRECT
> >>>
> >>> If it turns out there is something risky we are enabling here, we can
> >>> introduce a new array of hypercalls to restrict which ones can be
> >>> called on HV_PARTITION_ID_SELF.
> >>>
> >>
> >> This is a good point. Please check with the hypervisor team.
> > 
> > I should add: it is always easier to relax restrictions later than to
> > add them back in, so if there is any doubt and we want this code in as
> > quickly as possible, we can start with a new array and expand it later.
> > 
> 
> Agreed. I think that's a good approach here, we can just enable
> HVCALL_GET_PARTITION_PROPERTY and HVCALL_GET_PARTITION_PROPERTY_EX for 
> self-targeted passthru hypercalls.

I've implemented this in v3.

Anirudh

> 
> > Wei
> 

