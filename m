Return-Path: <linux-hyperv+bounces-7790-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C8CC81038
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 15:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83633ABCAB
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Nov 2025 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464D030F818;
	Mon, 24 Nov 2025 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="hqrwAbpm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2573101A7;
	Mon, 24 Nov 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994493; cv=pass; b=k48BXlL/6zhl+0XPhr/55iGt8Dwp7V1jHPtYkbZU2iJ34DJa9v0rvVr6SA1UUvf8PZvKJ/IbA14bWJwmACang5M+xCkO5B9wzKt/ERF9qW30XpBw1D2YTMHPsQsK+JycoiRxbQwxvgpzKQ5tICXjS1uxPQqJSif3U3kDigot3TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994493; c=relaxed/simple;
	bh=T0eFmTkSyRhgoE+3UDB9Nh7/MDLNKTinShA43oDhJF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHm2qbOTly6rgZfv4DmugSLR+3ioJ8Vjw3sKXJSw3Bk2UXL0veqOotsxQXwwTByWpO0bmN0s0PM1bBlmHlq0khLkmvutO1iU1sR6sqr+UXsfqx6e2DAp5hgKboT1gTT0I3DW82DJR48GI4J3j4x3mOp9TjVLviqe4gGXfscD85I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=hqrwAbpm; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763994483; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NbmWhDQKEEN4iKpw/X4g/GKPCT2LntZY2GnhrFdJp5HyF01shTTNeDDLwmMvQ8tUBU/Y02EPJdz1ZA2z1AuEp6qwS1h0EVhbxQUV2iGDHyMyRRl8S52uNzgM15NQLUd2++PYJxKvxwnQOwD027mzbjvrUEFDHOg018umD4C0dBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763994483; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X9uCmJAIMPVNPtZ1zX3shzv7bW2LjmoKj5PxDKKKbwY=; 
	b=nEeR3+rFZgYkUFuOVUpW14HPNwuNgXry2pc1bAUTSfF52smqzkknnBmSexOY8ZyNpbv5HyBLqkpJXYzxrJKmiOFzC/XrdijaR2l+teUwEgoOuH+HNMSgYi3AkH2xDEjRp0zGfwBUfKvkcJJlrvM0Y5qJaZLXUEucsCgF3NSqeKE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763994483;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=X9uCmJAIMPVNPtZ1zX3shzv7bW2LjmoKj5PxDKKKbwY=;
	b=hqrwAbpmFUXYCSE1lg3tPkwcI+ub4THQJq5FefwY2X62xG92jEdelwOlDOSbLNUH
	kiH7HTUfDmpvFfkLIX2rFBb+uNzxkGLjTJceWrln6Dku3zSW1IdOoOI560vfVE9jqB+
	peIYRbWx3bIkz4NNMe29q8DyHLT2miHNJ+6PVPdI=
Received: by mx.zohomail.com with SMTPS id 1763994481750688.0247116341232;
	Mon, 24 Nov 2025 06:28:01 -0800 (PST)
Date: Mon, 24 Nov 2025 14:27:57 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <aSRrbfdMFYre4Z0c@anirudh-surface.localdomain>
References: <20251119171708.819072-1-anirudh@anirudhrb.com>
 <20251120065559.GA2858107@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120065559.GA2858107@liuwe-devbox-debian-v2.local>
X-ZohoMailClient: External

On Thu, Nov 20, 2025 at 06:55:59AM +0000, Wei Liu wrote:
> On Wed, Nov 19, 2025 at 05:17:08PM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> > execute a passthrough hypercall targeting the root/parent partition
> > i.e. HV_PARTITION_ID_SELF.
> > 
> > This will be useful for the VMM to query things like supported
> > synthetic processor features, supported VMM capabiliites etc.
> > 
> > Since hypercalls targeting the host partition could potentially perform
> > privileged operations, allow only a limited set of hypercalls. To begin
> > with, allow only:
> > 
> > 	HVCALL_GET_PARTITION_PROPERTY
> > 	HVCALL_GET_PARTITION_PROPERTY_EX
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Applied to hyperv-next.
> 
> I dropped one "inline" keyword that was not needed and modified the
> subject prefix to be "mshv".

Thanks!

Anirudh.

> 
> Wei

