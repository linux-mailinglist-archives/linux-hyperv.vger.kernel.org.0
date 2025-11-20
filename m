Return-Path: <linux-hyperv+bounces-7711-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1701AC724F3
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1F9A34E20A
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 06:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D821ABC1;
	Thu, 20 Nov 2025 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="cnVrQexH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B74BA3D;
	Thu, 20 Nov 2025 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619233; cv=pass; b=PPJOI1RDXrvPKosMaKfsgppS/FRh5selY44PQ/IcytycZ5LxW4E7Vo8VXLBNvsgRfF0RSe6S5KcmYVZzpZbqgX2wS9IHMTbuvtYjmjL/6D7XZfCRnUGBA9DTZya5mapnCfBdnV+W2n2/3+ocz0EQtPaKSkGtm/ldnOAfocXINvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619233; c=relaxed/simple;
	bh=VfBNrEkOoTy/D1aNgPCRR2fuPdov/K7q++EIUV3cVL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im0kNkNtP/REAu0qKFHH4a/UsKXDFIs0NC0tV7edYo/6efM5arDDByhRf9m7av05jWX5+DGDDaOMbM2bGQLtemjDAON0E+S8RC24Ah0duxVpviq3Q+KhkMJUYyxRnc5g2fn9kF5rNUxk7lJ1cU3qSTdtseFpj391G7OBN6hgAvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=cnVrQexH; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1763619221; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PxJLsz4uhRtP6pHLdoUCVi0oHxgRiELfco8pvWzzq3PVa1J1ITzwjhAC/zVwF86NUEYeRC5uevBZfdcOczcDl9VIHwkfkS+zEDdF3aQRqfuRvxtE4sVELF78HDh/GDEZq9gSoDVszJIIagg5US1vcDfFZDSA3r7H1D8MaxqLO5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763619221; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pnhLGKa1bFtcx39IX9zv1ucr+CEIDhQu8CbuzNo5IFk=; 
	b=Cb/y2Lr6Q98FhxI5DdAyiWupXosnKvcA5YCO72+u+HjscNxDNrgFT6QdFbqNlJDHHwhuslDXt9kyypD/IDxVqEDqVfO1JGCSYWldc/jfSpueIYVTyDzHUf1E9mb9nL/pf9mcBfD+W9KERl082munE4e2GzwEQVDUkOsKuusxcoo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763619221;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=pnhLGKa1bFtcx39IX9zv1ucr+CEIDhQu8CbuzNo5IFk=;
	b=cnVrQexH6NRtEWezchbjnO2VmJ5DFuVuhJQAm9iFNfK9S4SKJ/YySvOK5Jvwo5ng
	tgnT/elScgUXiYzmwUT5eW354BeklUIoevvWHImZE+7B16p7RQcdalaiqqzPJW1OxwE
	Jpbjhd5RYGymHwnFNn3om6uyAvSp55QlfgiE9tA0=
Received: by mx.zohomail.com with SMTPS id 1763619217921367.3394134820611;
	Wed, 19 Nov 2025 22:13:37 -0800 (PST)
Date: Thu, 20 Nov 2025 06:13:32 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <aR6xjFJxs9n5vS7Y@anirudh-surface.localdomain>
References: <20251119171708.819072-1-anirudh@anirudhrb.com>
 <20251119213437.GA2848327@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119213437.GA2848327@liuwe-devbox-debian-v2.local>
X-ZohoMailClient: External

On Wed, Nov 19, 2025 at 09:34:37PM +0000, Wei Liu wrote:
> On Wed, Nov 19, 2025 at 05:17:08PM +0000, Anirudh Rayabharam wrote:
> [...]
> > +static inline bool mshv_passthru_hvcall_allowed(u16 code, u64 pt_id)
> 
> There is no need to add inline here. The compiler can decide itself.
> 
> I can drop this when committing.

Okay, sure! That works.

Anirudh

> 
> Wei

