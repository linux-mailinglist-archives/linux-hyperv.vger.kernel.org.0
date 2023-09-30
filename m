Return-Path: <linux-hyperv+bounces-360-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CA57B3E98
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 08:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id A61981C2084F
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 06:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6493FE3;
	Sat, 30 Sep 2023 06:11:41 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E161FA8;
	Sat, 30 Sep 2023 06:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A82AC433C8;
	Sat, 30 Sep 2023 06:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696054300;
	bh=1EphpFWnU/6lrIe7UpyGV+C1tQHUDqUUsCrgVBuTw64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFY4WqNIJlRXHSIHR2qN9YOceoWUE6d5MUL+EisewvqwdxsY/k1Iw+mejf80UAw3a
	 n1xbJv3Iv+bJwy/Dzm1zQ9kaLqL6FMpZCIzIXGUz1OWbknde3uin6PCyzprs1IQqc0
	 8vpCglLu9qFkcWgnyjkrR6+VLfVZieLjc1zMxQ6k=
Date: Sat, 30 Sep 2023 08:11:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	haiyangz@microsoft.com, decui@microsoft.com,
	apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
	ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
	stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <2023093004-evoke-snowbird-363b@gregkh>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> --- /dev/null
> +++ b/include/uapi/linux/mshv.h
> @@ -0,0 +1,306 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

Much better.

> +#ifndef _UAPI_LINUX_MSHV_H
> +#define _UAPI_LINUX_MSHV_H
> +
> +/*
> + * Userspace interface for /dev/mshv
> + * Microsoft Hypervisor root partition APIs
> + * NOTE: This API is not yet stable!

Sorry, that will not work for obvious reasons.

greg k-h

