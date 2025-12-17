Return-Path: <linux-hyperv+bounces-8047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E98CC600A
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 06:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2540A301CD1F
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Dec 2025 05:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41B258CDA;
	Wed, 17 Dec 2025 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="LPiefPXy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B879239E7D;
	Wed, 17 Dec 2025 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765948153; cv=pass; b=Q1eusDxzn7ZqlpW8RpbCZYRo7q9uPSlCgpTzVJ89wq6E6dCB0TRis5cpUuaYidAkJrh17LgSaj+henv+ZymJjx6qgtWBiqxjsL4G6EMlM+ulzbbchUCr30bkTLvU42S+6s79ZJoKfs0eo+Ryf+RmNshB7vvWpu+GblwvJB6KQdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765948153; c=relaxed/simple;
	bh=dGKoVSYSorKQMpf8epoVc22DOD3rPG9huNjUNRRiwqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9GLtJVk8z36PKcaz2uUs65RlLGShIYj1/cBiHGXJh8ZrwCaklh1Zfyym+oeGXqORlCAVwV1joxfdGuQwxi5M7Syvud86bLXr9gDbQxwK1fvWd3b2vDWN2NVXJ/u2PQb0iDvfHc07M+YvDDOce41NgrV1UF2KbYtOwazJQjHLzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=LPiefPXy; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1765948133; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TZGbXpU5MqTPjuUcfu3kKlqqnsa2lpabsNRVnxazqSuREcG6zwy2JTmFlfENd3vYH/dFIIyaUF5GBKF2suUOEvoEmgYqv+4o8EE3aBfCKvOzLfAeQmWajIz7gRkP62a2QdKrjuoGb43shoMCKk7ZJJqvWhpCHPeLBCxz4/1rqXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765948133; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ay/cmM/WZQ/dWOPMHrfOo1HOzeeAGoRPPR4uGiEjetc=; 
	b=QXTEfhohZhfYuxFeHT869HSu4DAmtrFnrCM5boc9GptO9241noi5jDx6rnd/WuU5VX1kIE5RAJo7FV5pfRDvO0eBBrAcygEcSZvnBlCAv3/+azo7aYBP3WYkEcq9Qnm3VP4i7xHkY4YHGaZZTz0N9XrZVpWwmUah/K5VQRsyeKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765948133;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ay/cmM/WZQ/dWOPMHrfOo1HOzeeAGoRPPR4uGiEjetc=;
	b=LPiefPXyDIs1VlyVGnVBoFP0G0mmYzVeX252GuE4+qseRjCJMmHHogjccAFmHaTj
	Qsor3zwAL56BZfEviwESB/96LmO06j9+ECUdUHRRn9tXLrHaHWKjSZVYLR3hr5VqMJq
	vzWuZeMkdlp/aZ4rI2c4+X4MP6TmYy2/CYVEw2i0=
Received: by mx.zohomail.com with SMTPS id 1765948132906954.2416869670858;
	Tue, 16 Dec 2025 21:08:52 -0800 (PST)
Date: Wed, 17 Dec 2025 10:38:47 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: vdso@mailbox.org
Cc: kys@microsoft.com, decui@microsoft.com, haiyangz@microsoft.com, 
	linux-kernel@vger.kernel.org, longli@microsoft.com, wei.liu@kernel.org, 
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/3] hyperv: add definitions for arm64 gpa intercepts
Message-ID: <jhyqp7vlqsmnps52cgzzuyon3aihcxizog4bknnofuibhud5ry@3nix3cwzwapw>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-2-anirudh@anirudhrb.com>
 <1801063954.177813.1765897665357@app.mailbox.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1801063954.177813.1765897665357@app.mailbox.org>
X-ZohoMailClient: External

On Tue, Dec 16, 2025 at 07:07:45AM -0800, vdso@mailbox.org wrote:
> 
> > On 12/16/2025 6:20 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> 
> [...]
> 
> > +#if IS_ENABLED(CONFIG_ARM64)
> > +union hv_arm64_vp_execution_state {
> > +	u16 as_uint16;
> > +	struct {
> > +		u16 cpl:2;
> 
> That looks oddly x86(-64)-specific (Current Priviledge Level).
> 
> Unless I'm mistaken, CPL doesn't belong here, and the bitfield isn't
> used on ARM64. Provided the layout of the struct is correct, the
> bitfield can have a better name of `reserved0` or something like that.

Hmmm... this is how it is defined in the hypervisor headers though.

Anirudh.

