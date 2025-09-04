Return-Path: <linux-hyperv+bounces-6740-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AD9B44A53
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Sep 2025 01:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B8E7A43F3
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Sep 2025 23:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA7C2853E0;
	Thu,  4 Sep 2025 23:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Skt3gPQ4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B726D4E8;
	Thu,  4 Sep 2025 23:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027907; cv=none; b=RibcaPOhdIXxZO9xA5edYgCBoye5LjEe9OcgFhSBM+JiDLEbljpSVmjB9eaCAEG5gvEAJfWzwz1LyPv4uyD65xjRo6AfU21+JUQzGutGV+iimhStM0rQVakqszJEwh1Bftbp6Gz/TRuoHHGSHkV4vJFduOyhQbF1CPIfpUCFFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027907; c=relaxed/simple;
	bh=RkJAmqqwjArwgZnRwBoIFqpUEP5J28aBW5RVB5pg8O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6XJo/wI0Dr+U2B/cI0znWpnMJijJA5qSCvV5x1BNr3pd+OBg++Q2V2p5uZGf28zPpF+eAJ4pCGOyR8X97D1fRu04TqpQECR028sLCUyC/3Ld/0hjpFVcUqCscmJeXuqbH7lMv9hjocFKjH4hphDNzcbDiZNNUsNBdZ0E78/GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Skt3gPQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CEBC4CEF0;
	Thu,  4 Sep 2025 23:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757027906;
	bh=RkJAmqqwjArwgZnRwBoIFqpUEP5J28aBW5RVB5pg8O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Skt3gPQ4IZ3v7pOobSMv9De+F1KmGawltzVkiC9zOPbEUJzkqizJCm5ALbVn6VRCt
	 SloXMSCesFNyDFPkk7GARD1CQrMMI7ZJiYT9kblxkhRsdaxRSPOVM36s3tAwDovMqY
	 nNheDQ2alIBq2l12EG6wyOFSe+qPUGxwYVO4FYwU0OKGata3H8WvlO8cq73KuLGDHz
	 vVXc8AOmRDacb/ZJTRbvkYi4Dr3ThIw3RDIHgFkycYhPVk77iDjeVEDLNuMyYvA0Kf
	 wWhxJSHCk4M1VNpo2HBguq1Rc6UE75D/2/GC3qqfEy9Nq2WK6Yp6m2fpr/8s/bAAR4
	 kU0F8lxHE/Oow==
Date: Thu, 4 Sep 2025 23:18:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, Li Tian <litian@redhat.com>,
	Philipp Rudo <prudo@redhat.com>
Subject: Re: [PATCH v4] x86/hyperv: Fix kdump on Azure CVMs
Message-ID: <aLoeQXAo5PMDA5hn@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250828091618.884950-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828091618.884950-1-vkuznets@redhat.com>

On Thu, Aug 28, 2025 at 12:16:18PM +0300, Vitaly Kuznetsov wrote:
> Azure CVM instance types featuring a paravisor hang upon kdump. The
> investigation shows that makedumpfile causes a hang when it steps on a page
> which was previously share with the host
> (HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY). The new kernel has no
> knowledge of these 'special' regions (which are Vmbus connection pages,
> GPADL buffers, ...). There are several ways to approach the issue:
> - Convey the knowledge about these regions to the new kernel somehow.
> - Unshare these regions before accessing in the new kernel (it is unclear
> if there's a way to query the status for a given GPA range).
> - Unshare these regions before jumping to the new kernel (which this patch
> implements).
> 
> To make the procedure as robust as possible, store PFN ranges of shared
> regions in a linked list instead of storing GVAs and re-using
> hv_vtom_set_host_visibility(). This also allows to avoid memory allocation
> on the kdump/kexec path.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

No fixes tag for this one?

Should it be marked as a stable backport?

Thanks,
Wei

