Return-Path: <linux-hyperv+bounces-2793-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADDD95B379
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9871C22DCB
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Aug 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24B317E8F7;
	Thu, 22 Aug 2024 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="chXTlznD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D65918C31;
	Thu, 22 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724324969; cv=none; b=bz6Q9B4fQMwLNUGdJPusDA6bAUhXP3dCjOni9HTjsrOjWA7aWJnZOwaQ5o9UkKlDU/vuwPq7TJWC3ZWulpbcitkGb2Sw3cP/sMRFFls2yNH+Hvdhf2hJ8/s9kk92FGNzrb9b8xjUmv8jsVeCy3WgWEiNb4bwkE04s+RMnjMZ02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724324969; c=relaxed/simple;
	bh=0VcgQPSPjVqpKzaw4X3+Va+FS4zZZ2J0oC6BMbmmrOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4eDTEedjUwiQLv2Vh9v4a/Mw1umbSc5TrIbQURktxsGSgHa9VaVi1v7Ptd0uwTTjiDM3DCjYvOpYJJAuC3K8gSqqA/DXIjfJ8k8OtzDc/KHIvXgCRHRWqOYAzMaSCQvqQpYuEATNtHj1gWH/DHHKwVxTAiK2kJlOmMSzNBKnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=chXTlznD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [167.220.238.141])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8B5E920B7165;
	Thu, 22 Aug 2024 04:09:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8B5E920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724324962;
	bh=KwxCe7z+khlPS5AVl5+UIYcuhEZhwLBTWQbn0ih1yPg=;
	h=From:To:Cc:Subject:Date:From;
	b=chXTlznDfdVWgRZ3ygBINFcaryMZd2lCZ6UX9GN9IdhDFf7eCTdy26jv20CVFyDiR
	 JveQ2o6yYqzeD0AulXqtFShCbzxFzJKVC9oobMaOiU/0gZzgZU0BQDYCyKvwV3+IfV
	 FfaLFoJRCt5gl3HvWCivA7Zk47i72KG3LbqWFooQ=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: [PATCH 0/2] Drivers: vmbus: Fix rescind handling in uio_hv_generic
Date: Thu, 22 Aug 2024 16:39:10 +0530
Message-Id: <20240822110912.13735-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few issues in rescind handling in uio_hv_generic driver.
Patches are based on linux-next-rc4 tip.

Steps to reproduce issue:
* Probe uio_hv_generic driver and create channels to use fcopy
* Disable the guest service on host and then Enable it.
or
* repeatedly do cat "/dev/uioX" on the device created for fcopy.

Naman Jain (1):
  Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Saurabh Sengar (1):
  uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

 drivers/hv/vmbus_drv.c       |  1 +
 drivers/uio/uio_hv_generic.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)


base-commit: 469f1bad3c1c6e268059f78c0eec7e9552b3894c
-- 
2.34.1


