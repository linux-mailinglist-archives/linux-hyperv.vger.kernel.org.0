Return-Path: <linux-hyperv+bounces-4321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABDEA58967
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 00:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE718893B7
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4324321ABAD;
	Sun,  9 Mar 2025 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUuWq3Up"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120FC1CAA6C;
	Sun,  9 Mar 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564609; cv=none; b=UmUX9TLvFFoQD+gKYtaTDFf3aJbiAurDvU/RCA1LlQGfiWWJRKkUJhnJZdAuu6+RbowsBvB5XqaWFv6X8fYiFJ30vUrl92JcKSVjmTIamXwqtHXiHYGZwM6sUwIHuEZOxTWDYZWUvzUHrdLDunLCCy7pAdF2d7a4qZIQygfUwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564609; c=relaxed/simple;
	bh=LddSs4hgGqDTjpXUGJlPBDoaDhWj28W3bV0A08SN7UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usyKN4U87Y51WyMhekdCLlHXLXD7OrCo393oMFrtFfoj0E7WVy936/JhQmJmtMttA9k4AnU4NA3Rlj7nL9PgFnNv2GebJq7GeWvBtzRcghYDM0faun5eNrHaARYA2uoghWvoPnl5kVlV4zP4DFlvHOwBIt6st2DudC96sJRUvv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUuWq3Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AA5C4CEEC;
	Sun,  9 Mar 2025 23:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741564608;
	bh=LddSs4hgGqDTjpXUGJlPBDoaDhWj28W3bV0A08SN7UU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUuWq3Up4ke7Bjslgu8Mcc/mNbS27HB7l6si5f+DgUOK9Qt0XXPXhzrRdE6lvo9gm
	 FagZYvpT3Kvh+Nth3ceMziAUkBR3l2U3qqZipJUEi1jlifYs6XU2XD22WZUmenn8ez
	 x81IFfvfwk7H8TlW4biiH3tUqxtlDfCT9ldkvdC7F7jfI/QAYyPaU+tnTD81d+BkU+
	 bmI67q3XECknylAsKJJx+D4aqvgERn4ANq4ZPlRY3sPuxyWld8PefbSc+QPgLMIGvC
	 P2EW5KHpwiXA8bykNYP6uz1apllP41yxO7OuoqG+ey/mt9O4bGExp68tPpS8mhltTJ
	 IyUxqIJoADe8g==
Date: Sun, 9 Mar 2025 23:56:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, deller@gmx.de, akpm@linux-foundation.org,
	linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	ssengar@microsoft.com, mhklinux@outlook.com
Subject: Re: [PATCH v3 0/2] fbdev: hyperv_fb: framebuffer release cleanup
Message-ID: <Z84qv4Fp-A254kTk@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740845791-19977-1-git-send-email-ssengar@linux.microsoft.com>

On Sat, Mar 01, 2025 at 08:16:29AM -0800, Saurabh Sengar wrote:
> This patch series addresses an issue in the unbind path of the hyperv_fb
> driver, which is resolved in the second patch of this series.
> 
> While working on this fix, it was observed that hvfb_putmem() and its
> child functions could be cleaned up first to simplify the movement of
> hvfb_putmem(). This cleanup is done in the first patch.
> 
> Although hvfb_getmem() could also be cleaned up, it depends on
> vmbus_allocate_mmio(), which is used by multiple other drivers. Since
> addressing hvfb_getmem() is independent of this fix, it will be handled
> in a separate patch series.
> 
> [V3]
>  - Add a patch 1 for cleanup of hvfb_putmem()
>  - Use the simplified hvfb_putmem()
> 
> Saurabh Sengar (2):
>   fbdev: hyperv_fb: Simplify hvfb_putmem
>   fbdev: hyperv_fb: Allow graceful removal of framebuffer

Applied to hyperv-fixes, thanks!

