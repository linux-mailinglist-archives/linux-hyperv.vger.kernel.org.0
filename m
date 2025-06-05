Return-Path: <linux-hyperv+bounces-5792-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28DFACF31E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A917327D
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 15:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABF18A6B0;
	Thu,  5 Jun 2025 15:33:57 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7061EEE0;
	Thu,  5 Jun 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137637; cv=none; b=LiBsD9LMe7nvEZfrvMrDbaasxGeNg6wXGf9RkUwZV0zqqlK2xJn17ILEqXMavlgxlt5vg+Dxl+lJPXJQ+sIUwKuKciPnSGlQJmv+vW+qCfLXr2SmfISFc0RiUii2sHSvxlfMM3cJ57FT9SKKXyfAKAOlbUrKJKjCHZDJC9gsLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137637; c=relaxed/simple;
	bh=c+F3x1rCTk6FaytU2UJg5KYZcmVP4m/I3g0v8y6tLss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BApXRwW5YL/dTNTGAvjLwq+kD7H8l647uSPZ+BBIYE8Okn0OHeAioMni5SVDmfz3P5zDDJGvznLcV09lFbmTmeIpngzYb2ZlVWA9JByYidt7dbfg2DAOAdB0AcnkFLdS02kcqibM3G83v4LbrV2EnQCC8d1d5TTkLo6X8EUl/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF7F51688;
	Thu,  5 Jun 2025 08:33:36 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F280C3F5A1;
	Thu,  5 Jun 2025 08:33:52 -0700 (PDT)
Date: Thu, 5 Jun 2025 16:33:50 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp
 UUID
Message-ID: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
References: <20250521094049.960056-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521094049.960056-1-anirudh@anirudhrb.com>

(sorry for the delay, found the patch in the spam 🙁)

On Wed, May 21, 2025 at 09:40:48AM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> When Linux is running as the root partition under Microsoft Hypervisor
> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
> 
> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
> of supporting only hvc.
> 
> Boot tested on MSHV guest, MSHV root & KVM guest.
>

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Are they any dependent patches or series using this ? Do you plan to
route it via KVM tree if there are any dependency. Or else I can push
it through (arm-)soc tree. Let me know.

-- 
Regards,
Sudeep

