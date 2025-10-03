Return-Path: <linux-hyperv+bounces-7072-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82391BB7BE4
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 19:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F07519C47FA
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Oct 2025 17:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD424468D;
	Fri,  3 Oct 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8VJeqEq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D25F19D880;
	Fri,  3 Oct 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512627; cv=none; b=F/doD1TK/aWtPfTkd2tOkOz6pucfpF6soRXMlzkGNlrX9goboADmEktyZIAAUVeTEsfjxDeaIUT04mJ3PgEt3VoF1Czw0PUbbF6SvCcMbJPdQsWA4Hyy/Dc8bZ5uh/lv/ZHpaI4JS4pucuuufwQnwlEsViSYCosoZA4AEIYcjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512627; c=relaxed/simple;
	bh=bKcFHluIfrETRlHficKsjNssD6yv+m3BNXXEAZK5oWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4c6kU0Re0ThV1VNyAXIdzt9um/KOmMtkYEdG7nSdsiDUEJ2XzWl5xKVE7bCxanHZ2fIv52qhZcMgIalRon9Q5dfJFkW8DLXRghoQ7CjNAWnmLaGyn4Jv6HqGhilSo1oieCX+7crhOAXdWtc3MCdFoqmW47h4O7S5JXNge2YrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8VJeqEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECD7C4CEFB;
	Fri,  3 Oct 2025 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759512627;
	bh=bKcFHluIfrETRlHficKsjNssD6yv+m3BNXXEAZK5oWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8VJeqEqJRiQImLzV8sXGLQCh9HRup33B8JbRgUXQprFKzjo/JGjhFemxIWGFx0WY
	 n/arZulzWai21cCRYSBti7yjQre8olHYzBiQ3GaPIWpDDMJNbpWMWJiWNJDxuj13hA
	 6MGc6+s60vcQTSdABQr+P6LnAI/Tfxn+Ypnch9mlOnWNqdifeAMsdEL8x9tGVefljT
	 Nmnd2HMCIHkkgS/MTj+Q8IpmlYMzWqdyXUPPt//++e7v5AdcP9DHjfCzydXmuQY6MK
	 E/BbT6XMQUZv5uvFkOgSzdyDFr/gQ7IOyXrJTK/Plh8uE2Yrny8d50Ip0EV+fKNdcl
	 BmVpRQX1I5lXQ==
Date: Fri, 3 Oct 2025 17:30:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v4 0/5] mshv: Fixes for stats and vp state page mappings
Message-ID: <20251003173025.GA1161403@liuwe-devbox-debian-v2.local>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <aNcd60fpoI1b6LUT@skinsburskii.localdomain>
 <96009fb8-0ad6-4e5b-8656-af78874a5605@linux.microsoft.com>
 <aN_6bST3WmeTG3lv@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_6bST3WmeTG3lv@skinsburskii.localdomain>

On Fri, Oct 03, 2025 at 09:31:41AM -0700, Stanislav Kinsburskii wrote:
> On Mon, Sep 29, 2025 at 11:19:51AM -0700, Nuno Das Neves wrote:
> > On 9/26/2025 4:12 PM, Stanislav Kinsburskii wrote:
> > > On Fri, Sep 26, 2025 at 09:23:10AM -0700, Nuno Das Neves wrote:
> > >> There are some differences in how L1VH partitions must map stats and vp
> > >> state pages, some of which are due to differences across hypervisor
> > >> versions. Detect and handle these cases.
> > >>
> > > 
> > > I'm not sure that support for older and actully broken versions on
> > > hypervisor need to be usptreamed, as these versions will go away sooner
> > > or later and this support will become dead weight.
> > > 
> > As far as I know, these changes are relevant for shipped versions of the
> > hypervisor - they are not 'broken' except in some very specific cases
> > (live migration on L1VH, I think?)
> > 
> 
> I'm not sure I understand what "shipped version" of hypervisor actually
> is.
> As of today, the hypervisor is close source and the only product where
> it's used is Azure. In Azure, the older versions of hypervisor are
> replaced with newer on regular basis.
> 
> > The hypervisor team added a feature bit for these changes so that both old
> > and new versions of these APIs can be supported.
> > 
> > > I think we should upstrem only the changes needed for the new versiong
> > > of hypervisors instead and carry legacy support out of tree until it
> > > becomes obsoleted.
> > > 
> > Which version do you suggest to be the cutoff?
> > 
> > I'd prefer to support as many versions of the hypervisor as we can, as
> > long as they are at all relevant. We can remove the support later.
> > Removing prematurely just creates friction. Inevitably some users will
> > find themselves running on an older hypervisor and then it just fails
> > with a cryptic error. This includes myself, since I test L1VH on Azure
> > which typically has older hypervisor versions.
> > 
> 
> Given that these changes are expected to land to a newly released
> kernel, it will take time until this kernel gets to production. At that
> moment it's highly likley that the older versions of hypervisor you are
> trying to support here will be gone for good.

No. This is not 100% certain. The schedule is outside of our control.
Who knows if there is a specialized Azure cluster that is not updated
for some reason.

Interested parties have already started experimenting with this new
setup. I just point them to the upstream tree whenever I can.

> Even if they won't be gone, they will be obsoleted and intended to be
> replaced which effecitively makes this support of older versions a
> dead weight, which - if needed to be caried - is cleaner to keep in house
> and drop when apporiate than keeping in the upstream code base.
> 

While the maintenance burden argument generally applies, the burden in
this case is not big. It is totally fine to have the code.

Wei

> Thanks,
> Stas
> 
> > Nuno
> > 
> > > Thanks,
> > > Stanislav
> > > 
> > > 

