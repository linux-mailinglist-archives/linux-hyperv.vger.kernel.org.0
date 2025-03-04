Return-Path: <linux-hyperv+bounces-4199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A94CA4CFB0
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 01:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C74D170BDE
	for <lists+linux-hyperv@lfdr.de>; Tue,  4 Mar 2025 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8682905;
	Tue,  4 Mar 2025 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KQa6u2Q+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4423B0;
	Tue,  4 Mar 2025 00:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046984; cv=none; b=GyVfWqyxFYlgCTvgMkkc188sXz8PUTNJ3ZdbXgYaDy8PrH4iQT0wXpkDDVeF0gIuOTe6camvzi08QqWRG/fAG8QJVdZ0ITMUhr7rW5YT/uelAxHSu5qYH1zAE21ixCEwmxEKcE0CiM9ClTdApyMl+48NTMcCpBI2x4Y7BlcEYs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046984; c=relaxed/simple;
	bh=xrdgLd9HOza8cAvNLZJ4XKy2abkXxSvPtka7xGD+bwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjGgTR3ZkPjcj55Q5gGSJOmA1M4Qbabv5qx/cBnC1DkvM/Yojrj/9gM29ZiuEq4ptdHq+TusJ1GGXsJzoCfT26Ee4kwooqLhmzYmT8NnHcn2RGlqQWpIk9H2VKkBCCFq2Xu1Nr5AriIRPJdjInF5eM4tdUdiNpYvYt896MwOLtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KQa6u2Q+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3F81E2110497;
	Mon,  3 Mar 2025 16:09:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F81E2110497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741046982;
	bh=sGL5vMQnmyd272zGEBUV5iQcfkqDFbcdr3QsRbGevxo=;
	h=From:To:Cc:Subject:Date:From;
	b=KQa6u2Q+29laT6ujFWkYI0IOEJ44kuP/huBFAUTvr+i0heWirqB9WRHAJDm71D/TK
	 p8SRVBmfKo7tn6COY+3CgqWgXTdqyNLGAjGNcuX/DnuCSQA/cslnXhM6Ua3x2UbYEf
	 eu9JGSerkLu5hMT+9rWQp/pkS/pb2eRYLxJEr08U=
From: Roman Kisel <romank@linux.microsoft.com>
To: eahariha@linux.microsoft.com,
	mhklinux@outlook.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-hyperv@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 0/1] scsi: storvsc: Don't report the host packet status as the hv status
Date: Mon,  3 Mar 2025 16:09:39 -0800
Message-ID: <20250304000940.9557-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch includes fixes for the log statements that are ambigious as
to what they are logging.

Michael Kelley provided a great insight into the history of the code
(** Thank you, Michael! **) and tagged the V1 patch with "Reviewed-by".
I am not keeping the tag as a I added one more change to convert the
status code to hex in addition to what was approved.

[V2]
    - Use "host" instead of opaque "sts".
    ** Thank you, Easwar! **

    - Convert the status to hex everywhere.

[V1]: https://lore.kernel.org/linux-hyperv/20250227233110.36596-1-romank@linux.microsoft.com/

Roman Kisel (1):
  scsi: storvsc: Don't report the host packet status as the hv status

 drivers/scsi/storvsc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 3a7f7785eae7cf012af128ca9e383c91e4955354
-- 
2.43.0


