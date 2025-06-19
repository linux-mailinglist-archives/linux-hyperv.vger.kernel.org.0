Return-Path: <linux-hyperv+bounces-5967-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0107AE0FDD
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Jun 2025 01:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809733AF481
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Jun 2025 23:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5C28C01B;
	Thu, 19 Jun 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mK31NJUj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E930E826;
	Thu, 19 Jun 2025 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374430; cv=none; b=fbE4q17FzT6cXGxq/2Ve5Q7ZwjnGhWhEPChcvgQyPdLmHX5hOyOGnlCkk5ZqUUQgUDxi7J8/dZN+lTpok8BVbnB0ODYRypBuM7TXaQzSJb5ATkzv4099/lBjev76lFtXI+Duxl+IoitV/ri4KRKJHsqgZt+Jf2uSzI2SQj0pfq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374430; c=relaxed/simple;
	bh=QPqzwv4JWMdU8uDAlqgptS1LxGBAo41OkMEdAOJNHrs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=L9HQUn97BUKKzMSXJpQed2jKIYq8T4oMiZIsWdBA0uxdIWbGTiH+XHiSHtEfm3D0aXbpPpQ+WcQtlX79PQYQnOGi0aj6l+arYLM141QQf5NUcj4CGTl3UONReoEdCXepTT3McwRclfJxvE8A8m4qBlpUxBT1UGs8mrajt2UrvJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mK31NJUj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 389E1201C74B; Thu, 19 Jun 2025 16:07:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 389E1201C74B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750374423;
	bh=kQyY1hUIoytHrsY/xErxdgPnnrCXYiOJrPfRqSzXzus=;
	h=From:To:Cc:Subject:Date:From;
	b=mK31NJUjvDH+s+aFFe8jxn9B8DeEREluh0emVnueM7cErquOo2LKurjGHuRrN0V7l
	 zBFnzTl7z7B/OjPPvjbDicsz+pG2XHFrVOsif9q3cluoD5MLRrOLpf1JE+M5Aw5PtF
	 P2dN9ABPjSHRSf5nYAYizd8irSJBc/Mpss+ULKfE=
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	hargar@microsoft.com,
	apais@microsoft.com,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v4 0/2] vmbus: Add DeviceTree support for message connection-id
Date: Thu, 19 Jun 2025 16:06:33 -0700
Message-Id: <1750374395-14615-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This patch series adds support for configuring the VMBus message connection-id
through DeviceTree. The connection-id determines which hypervisor communication
channel the guest should use to talk to the VMBus host.

Changes in v4:
- Split the patch into two separate patches:
  * DeviceTree bindings documentation
  * Implementation changes
- Fix warnings reported by checkpatch

Changes in v3:
- https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com/

Changes in v2:
- https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com/

Changes in v1:
- https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com/

The series consists of two patches:
1. dt-bindings: microsoft: Add vmbus message-connection-id property
2. vmbus: retrieve connection-id from DeviceTree

Testing:
- Tested on Microsoft Hyper-V
- Verified with and without the DeviceTree property
- Confirmed proper fallback to default values
- Validated binding documentation with dt_binding_check

Hardik Garg (2):
  dt-bindings: microsoft: Add vmbus message-connection-id property
  vmbus: retrieve connection-id from DeviceTree

 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml |  9 +++++++++
 drivers/hv/connection.c                                    |  6 ++++--
 drivers/hv/vmbus_drv.c                                    | 13 +++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

-- 
2.40.4

