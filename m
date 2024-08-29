Return-Path: <linux-hyperv+bounces-2908-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBA963C4F
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C1286E67
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2024 07:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938016D306;
	Thu, 29 Aug 2024 07:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V6gJL+PA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F45148FE6;
	Thu, 29 Aug 2024 07:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915613; cv=none; b=q+PppZJIN1aMKOzZOzrvnL8ngQggr5s4z/mMXMY/kt9JzSOBWPHbNHvrX1lr2OgMSxHQz5HRpRxygUBL+p6wG+b+fMN4bFMgxUc6ETIpQqUN70kC3pEf2YmpIb9YSBEae1OkN+lKgP5EEMqBntg6+Jrk6mMSYtaQJ78Se0IR+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915613; c=relaxed/simple;
	bh=tEcFevNw0oxFUtM+m+yNRDsYTyi6M9vgmLnz8D58eGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fR+RqTMWDCw4XzreoUTlW7+Ej2AtEHxPAmJIjIraVrtMBziVIsjLD5Xcj/mfn2JV/tJamm+mwOvvFmVso+TVwZwyIZyL+tpAz2icUMh1Ro/ZI0JNumsuinXnduzUambE1CvNkhfIpIPPYbIJdtbZ/jkjShOowyAF9kMZIY864ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V6gJL+PA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0AB2220B7165;
	Thu, 29 Aug 2024 00:13:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AB2220B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724915605;
	bh=owDMFqb60QTXkwAjqxDHIGatU4U3fCR07MmwPLmBwSw=;
	h=From:To:Cc:Subject:Date:From;
	b=V6gJL+PAiP+P1QkmaWAoipM/lfCIbzOddAAW3zyTPNwBYSdHSftYoqgX3u7UCfy2e
	 TUxS1Vl6GMe+gsAHW0Rd6QiQPSRatkMqNXhufFeCacPToqhBMZi0rx1u1cVLpPX66e
	 pXLifIiBTHZneyby20VRmiEjwEGFgcmFFAioekH8=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] Drivers: vmbus: Fix rescind handling in uio_hv_generic
Date: Thu, 29 Aug 2024 12:43:10 +0530
Message-Id: <20240829071312.1595-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few issues in rescind handling in uio_hv_generic driver.
Patches are based on latest linux-next tip.

Steps to reproduce issue:
* Probe uio_hv_generic driver and create channels to use fcopy
* Disable the guest service on host and then Enable it.
or
* repeatedly do cat "/dev/uioX" on the device created for fcopy.

Changes since v1:
https://lore.kernel.org/all/20240822110912.13735-1-namjain@linux.microsoft.com/
* Added stable kernel list to cc
* Updated commit messages for more information
* Explicitly handle rescind callback for primary channel only, and add
  comment: Saurabh, Michael.
* Rebase to latest tip.

Naman Jain (1):
  Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Saurabh Sengar (1):
  uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

 drivers/hv/vmbus_drv.c       |  1 +
 drivers/uio/uio_hv_generic.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)


base-commit: 195a402a75791e6e0d96d9da27ca77671bc656a8
-- 
2.34.1


