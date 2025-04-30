Return-Path: <linux-hyperv+bounces-5268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF4CAA57D3
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 00:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F7C3AB798
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D136223326;
	Wed, 30 Apr 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="HFqmcz7Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7763422333D;
	Wed, 30 Apr 2025 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050763; cv=none; b=M4Li2SKdJR7/qRg/F5DXuYNwz3KPKCUUrVwaI1d18RDZjxFaTeUDVPYVl0zquIq9H/U4xCMKmbwwXZN8c95+75EpgDptv658Y72FuB6/lkUQU0qxRxvNrWtoGJTZCjI6grtO5VFHic36hgEzTP2AnIu6RFPCMrjrSFTYqObXIuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050763; c=relaxed/simple;
	bh=dZmTYa2WrbG8uU0v4yF3gDzB84pygAVfgeiKLfAVXyU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jvG2eRIqrcoCIcvPDEkQOQD0ivjh0ILfn69zUOIC83Nk3x68DJjWPFP8voZevFqEK+ynUohdCK57tI4+NT5TUDds2D+5iW4j1Xib/eu8L0vwwes3/0sxUbteEr0tajiDPXqTLSP/Al88zJBjArvX1X9xgCW+apMbhXGGRftzy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=HFqmcz7Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id B0FFD204E7F9; Wed, 30 Apr 2025 15:05:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0FFD204E7F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746050759;
	bh=JJgfHJQjS471Xi2mAFpjOUrny8p+UJFVs691sdQaQ+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=HFqmcz7ZVPEsXG5A55Cb/FVB9WRwH1TRmMCNkl8JolYGOYEDU9iTLJB6pdvc8vG2f
	 rnT0MivNh2A19e0cIbSpBSQwjWt5oXag3lv5gzzIQze8hL2QmkYrZkGeqJPL7SoOMk
	 yy0HAoXoOrSVQEQl5WP15qukc8F5q4Z3E3nyRtrs=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 0/4] Fix uio_hv_generic on systems with >4k page sizes
Date: Wed, 30 Apr 2025 15:05:54 -0700
Message-Id: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

UIO framework requires the device memory aligned to page boundary.
Hyper-V may allocate some memory that is Hyper-V page aligned (4k)
but not system page aligned.

Fix this by having Hyper-V always allocate those pages on system page
boundary and expose them to user-mode.

Change in v2:
Added two more patches to the series:
"uio_hv_generic: Adjust ring size according to system page alignment"
"Drivers: hv: Remove hv_free/alloc_* helpers"

Added more details in the commit message of
"uio_hv_generic: Use correct size for interrupt and monitor pages"

Long Li (4):
  Drivers: hv: Allocate interrupt and monitor pages aligned to system
    page boundary
  uio_hv_generic: Use correct size for interrupt and monitor pages
  uio_hv_generic: Adjust ring size according to system page alignment
  Drivers: hv: Remove hv_free/alloc_* helpers

 drivers/hv/connection.c        | 21 +++++++++++-----
 drivers/hv/hv_common.c         | 45 +++-------------------------------
 drivers/uio/uio_hv_generic.c   |  7 ++++--
 include/asm-generic/mshyperv.h |  4 ---
 4 files changed, 23 insertions(+), 54 deletions(-)

-- 
2.34.1


