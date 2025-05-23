Return-Path: <linux-hyperv+bounces-5651-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1956AC27B3
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA2A189EBF3
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB022256E;
	Fri, 23 May 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egaWM7UZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEFEC2;
	Fri, 23 May 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017997; cv=none; b=qy/oZMLfB5y6tup+K7msSgkfPVqGz6EhEgdN01CCvWbnZUxRGi8ItaapdmmRRl5QMxmuPe+b5HhZ7OfdS0BMtbeW7zREHZ+4CdsInHK88Mkp3Ff2JN6QKEX7YOkMRhGn/U825o7aZyeCoyi33jM4yTZroJ0YEZxxXxGDfzoafKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017997; c=relaxed/simple;
	bh=4zfQnOiULpwXWGPMbg6e4kANc/Y8MGte30pOZkJ8pPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exfU4LhlEKamkvVs76YCcooXGjmQY8G4odZTGzdp2sM5mFyqTLrS6lLV/p/OHoRoDDpsMpAqvkXHC1oAjYBMjsB3+RUjcsbaAWhOjIbBcVHSzOvmdBspxsXUoXkmSo70MEYmGM02QBdYrCMXdwGFMkW0uY01eLCdCXzYMenXay0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egaWM7UZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB34C4CEE9;
	Fri, 23 May 2025 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748017995;
	bh=4zfQnOiULpwXWGPMbg6e4kANc/Y8MGte30pOZkJ8pPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egaWM7UZGPW7OAMUcDPCi3C17nWRS6hiJ+t04Cs1P5Tsl9A2fOHQRjX3tXguokXM3
	 75wP9+Pt4NU7XQfzlYfnNWO9ptlJrzxUkL6peFBMNYKCJNZiWoQkM8lOyjzW67D0u5
	 gBwemx9MUP8mrMbZyJTwqpjDnW14Zdnde53tSBbkROWPLQkhoKdm8gXcbC5li1NTMy
	 KO4I8YfbzfEXKYg3F2ZwWubB2frH6VGJszlu70HmJEgxfDwGXKFUbMoiBaGmRSlOaN
	 nHQJyDngKvii2nLNqZlLpzEYMguY+FdLNjulhOry5+F6WVs1A6dUvw8zuhgl59u9Vt
	 ANbyaVPOtDlRw==
Date: Fri, 23 May 2025 16:33:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Add comments about races with
 "channels" sysfs dir
Message-ID: <aDCjSc4w79IuHfD6@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250514225508.52629-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514225508.52629-1-mhklinux@outlook.com>

On Wed, May 14, 2025 at 03:55:08PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The VMBus driver code has some inherent races in the creation of the
> "channels" sysfs subdirectory and its per-channel numbered subdirectories.
> These races have not generally been recognized or understood. Add some
> comments to call them out. No code changes.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next-staging. Thanks.

