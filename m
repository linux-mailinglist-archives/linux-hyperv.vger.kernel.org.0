Return-Path: <linux-hyperv+bounces-7903-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C87C96DD0
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 12:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813964E1CD9
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8524BBFD;
	Mon,  1 Dec 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="KTM/3gYS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender3-of-o52.zoho.com (sender3-of-o52.zoho.com [136.143.184.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D7257855;
	Mon,  1 Dec 2025 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588029; cv=pass; b=cAYud9+M49RJcG05wFbOP2vakpktT3xJdaYhjez3M4qztvoQ7KhwsN2FLVCqHFzoxnGHojC4kk7CwqLP9dxXby0WYQgHqpp9Ec7dKSxIehKDu05RgQ8Bc4b+CMLQmKLQBOUlkx7xczYDz+Wmf0rpdJq3RiJ2ZgsF/ddIJ6A2W7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588029; c=relaxed/simple;
	bh=ViNbIAMQ0XteliKsGCNu8E2ukG5ojDYaoza3Ure5jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMJItdAJ3ejTqOCBRkYmHAzP6q7Ru9F7i0Y2+1Gt2o0vkc45T+o9NyHgqFrCey0dewHy1k0U03Ol5YHHfoJPY3w+nN5hw8oGow30YmFG9RdUwNrr7ASJvJZasl1U4l2VJpvUdzPKyyYZl/5yasdb5gjJjs34bMrQlEOyYRjkZ54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=KTM/3gYS; arc=pass smtp.client-ip=136.143.184.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764588019; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AdzwgsVCh9JZtvPQgopOOBq0+o/shlHul9Xk4ClABfy96nAP2XzhUoMnfacbrhLmS9vncvcbN7R6jwgDKzvp7apIdWZtSxxUC7jnr6WhoL14+gwf1NXdPzJCeERD435sx8jQw0gSCnXcpyM6j/G1gY1BhlMl+PEoAajR0CINZfU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764588019; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eAieoB7JEy3CO5AlRQtgPAkADeJnOnBYxuepFDFL6L0=; 
	b=T9NojffbY63kpGVcmO8nWmroHgyyi6ZeE3GWUfT2v23JKyIiNR0poPSlgWEBP9TeUZThEsphZlglBEnnw7dDa5qiNEnvzYo2UMQh44UlovEnW4VGkUcUX0Lv2chtJEUxx7Rg/ejSiZJnPSDtl3Dudn6Hq6CtJBbutx3CGuYyXjQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764588019;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=eAieoB7JEy3CO5AlRQtgPAkADeJnOnBYxuepFDFL6L0=;
	b=KTM/3gYSkkFxsal/MiraJMSZHLGFsGIa42RgnQpQgCgZHgiWrhWCn1iAuwO6ryWq
	dk/6tnjYEF+Bop6Y4rkQabk7NduCVCbbNGP6diL0BhnOcih3zR9L/Px4E2uOCSPoOSs
	GL89IXCWjRKOT2uOZ2dfRkCDcYxN6nNGFSInxFdo=
Received: by mx.zohomail.com with SMTPS id 1764588016223322.4013991709156;
	Mon, 1 Dec 2025 03:20:16 -0800 (PST)
Date: Mon, 1 Dec 2025 11:20:12 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/7] Drivers: hv: Refactor and rename memory region
 handling functions
Message-ID: <aS157CPPvrbkh2yy@anirudh-surface.localdomain>
References: <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176412293200.447063.17654735378558127143.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176412293200.447063.17654735378558127143.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Wed, Nov 26, 2025 at 02:08:52AM +0000, Stanislav Kinsburskii wrote:
> Simplify and unify memory region management to improve code clarity and
> reliability. Consolidate pinning and invalidation logic, adopt consistent
> naming, and remove redundant checks to reduce complexity.
> 
> Enhance documentation and update call sites for maintainability.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   80 +++++++++++++++++++------------------------
>  1 file changed, 36 insertions(+), 44 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


