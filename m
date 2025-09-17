Return-Path: <linux-hyperv+bounces-6909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD637B7FE7E
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727C717D8ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8546A32E72E;
	Wed, 17 Sep 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iXYQYtMU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5AD28488D;
	Wed, 17 Sep 2025 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117758; cv=none; b=MmbV9K+O3G8DKd5b9Lan59oj97PUQ1PIlrBGwoY4Inmu4346EYCWEMO5izeDQeVgJ3rxe6K3OB3l9j+Pl471Kmu7Lbfx2h/UNu6B9dyN1BAFxn5/ZJ5tZGy9OYpuULc4ouZ3ubQ5AoXegC4mFJ+RMj2xgV6awLRAlcm05WILjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117758; c=relaxed/simple;
	bh=bK3ooNUz4HJZuE8jBm4WUs2zTGETA6UazVdFU89XZ4g=;
	h=From:To:Subject:Date:Message-Id; b=D32VlVNZwqnONnqNbqoGA8EM8OFI88CqdDTZndnB2FbskUhd8dXOToZ7f+9UnirTrQ4wyi7ywY5i+L/lw8BRGleygf3gtwndHhzj6Jz8h7nlSjicVG3Vo85GAPBAbYZcs0AI7hH6XrYEd6aDLbTjWC8oPlq9qyxl5EKY14BbDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iXYQYtMU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id E5C2A201B1BD;
	Wed, 17 Sep 2025 07:02:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5C2A201B1BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758117756;
	bh=VLC2Tckh3tcwZAMr/z4UuSQpR3++Fdb4yhz3jPFTmj8=;
	h=From:To:Subject:Date:From;
	b=iXYQYtMUZn8+3BzAe9ItI/R5lcluv4XNWcbOtGuryzS6E1acx3vCywPpp+rOiXItp
	 tIrjL2c9keEvk66+cQNkQKlzZnFO0o45Ik20MDBHCp8fMK0C6DsbGBUWf22m/A/uMo
	 4jwqk4zrRK/2DG0HgIg6xTywhD3JaYVC/fR/xK5U=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	mhklinux@outlook.com,
	ptsm@linux.microsoft.com,
	rdunlap@infradead.org,
	bartosz.golaszewski@linaro.org,
	gonzalo.silvalde@gmail.com,
	arnd@arndb.de,
	tzimmermann@suse.de,
	decui@microsoft.com,
	wei.liu@kernel.org,
	deller@gmx.de,
	kys@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 0/2] deprecate Hyper-V fb driver in favor of Hyper-V DRM driver
Date: Wed, 17 Sep 2025 07:02:28 -0700
Message-Id: <1758117748-20457-1-git-send-email-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The Hyper-V DRM driver is available since kernel version 5.14 and it
provides full KMS support and fbdev emulation via the DRM fbdev helpers.
Deprecate this driver in favor of Hyper-V DRM driver.

Prasanna Kumar T S M (2):
  fbdev/hyperv_fb: deprecate this in favor of Hyper-V DRM driver
  MAINTAINERS: Mark hyperv_fb driver Obsolete

 MAINTAINERS                     | 11 ++++++++++-
 drivers/video/fbdev/Kconfig     |  5 ++++-
 drivers/video/fbdev/hyperv_fb.c |  2 ++
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.49.0


