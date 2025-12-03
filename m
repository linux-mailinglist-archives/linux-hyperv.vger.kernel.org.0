Return-Path: <linux-hyperv+bounces-7940-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 487BCCA159D
	for <lists+linux-hyperv@lfdr.de>; Wed, 03 Dec 2025 20:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3D3E301E98B
	for <lists+linux-hyperv@lfdr.de>; Wed,  3 Dec 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7818D308F1A;
	Wed,  3 Dec 2025 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V6NVESEv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905C2641CA;
	Wed,  3 Dec 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789673; cv=none; b=CaJP4qYwJVVdMjWWYjgDfZLxqyrOBP/n++fulQRMOCUHNYHH61vnzZhepiZauLznq5J5zLPkQ7iJd5T07TnO4X2EASxGz2VfXG8iounM+YmlvdlTXmkQhUS9Q2i00ckB7dlHKco9nnemMJ+D2HJZ7787DmAW/aHp5CZbUzXd54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789673; c=relaxed/simple;
	bh=JUN0IlYMoZm4ZFLfGVNcM3a7dls5TT+1M8+bCMh27IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOUK1T3DPiQF9/5dcwrj+PsbMMN8svF4s5nQ4ZUpO8IPLr8IZMFq395iQESlhpTE1mtmLzoGsE7nA4grDWuAlreeXhsdLnQmPdxJTjMm7lcELfwJEvfbDYiO4qNxh8EROPebWJYUcR8IQpAONbbC/feFnCmEq6xYuZBt4Sn+4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V6NVESEv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id 432AC212072D;
	Wed,  3 Dec 2025 11:21:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 432AC212072D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764789667;
	bh=TeSXzk+UqATQS1RQ87Q8Py9G8FRjvTwabjueSlCqV6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V6NVESEvL+pIC8LscNK3561LHaf8KE+rGwpuIh+CzoceOXR7c/srdUlN7awroW0QC
	 lI+ncKKpYHdE65JNrlJxhVA/6clDEtqpZ/uNpiaVQMKw+tKxAM+ZhX4m9YJbQEKhTL
	 sAeLuAX2eDS0mRAwX+IZUDRZLUy7ULLIDNDN1f7I=
Date: Wed, 3 Dec 2025 11:21:05 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH 3/3] mshv: Add debugfs to view hypervisor statistics
Message-ID: <aTCNoecOOFHabyZC@skinsburskii.localdomain>
References: <1764784405-4484-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1764784405-4484-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1764784405-4484-4-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Dec 03, 2025 at 09:53:25AM -0800, Nuno Das Neves wrote:
> Introduce a debugfs interface to expose root and child partition stats
> when running with mshv_root.
> 

<snip>
> +static void mshv_debugfs_parent_partition_remove(void)

nit: it makes sense to add __exit to this method.

<snip>

> +
> +void mshv_debugfs_exit(void)

Ditto.

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Thanks,
Stanislav

