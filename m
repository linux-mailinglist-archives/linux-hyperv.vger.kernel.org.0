Return-Path: <linux-hyperv+bounces-8065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4ECDACB3
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9181C301175A
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Dec 2025 23:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6721C2DCBF4;
	Tue, 23 Dec 2025 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZyeI+dKs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CC41D47B4;
	Tue, 23 Dec 2025 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766531152; cv=none; b=Q5X5DONROOZYk4/knewm3mL01AaIiC2gmL8x1X7tokCyUy2Iuit7MAfH+5/dDs6B4jKn57UpWbawuTNpGoqyhrDbqa5DUvYk98SLhZUst1IdM0qY3Hb2uiHUzhXuxkPrb/wLD9pQ+KcTCOK7GLLf3MfBDhbGP1TTla9Mh26w2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766531152; c=relaxed/simple;
	bh=5NLpNIkH5RvCAF4tbsu0mjNcyrUSXmtxHc9VNVD0OE8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OVOLhy8Vp/15soREdESmbtkvVkF8opKxnjzxU+DefV0TiL4/rhfZyMr89aZnr3DDCeZdo6v8ZstsK+sQ+Kih/piRLbrsO78UFCpbctMWBCKyjdnrLx9nBJ6KYAaJDWwzOOpnI8Jik5qQbM0upPl47IqSbAGjcB+pP1lnCJZztUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZyeI+dKs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.0.124] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A87F212A423;
	Tue, 23 Dec 2025 15:05:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A87F212A423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1766531149;
	bh=5NLpNIkH5RvCAF4tbsu0mjNcyrUSXmtxHc9VNVD0OE8=;
	h=Date:From:Subject:To:Cc:From;
	b=ZyeI+dKsdslXmAxJhMr0JY1ep60sxFlKYQHYPxTNVZO6pzgevT54t1c+d+w01But+
	 c3rt9tPecjkd9UtR0f5VdHw7RgasJLxRSpTSdtqbIjeNZzqJ6sPeOlXKEf6U9pr89O
	 DQqLQE1pamjzMRKDP3dtuL3G6xAFzYCIl65zjvkU=
Message-ID: <58cb22cb-b0c8-4694-b9e4-971aa7f0f972@linux.microsoft.com>
Date: Tue, 23 Dec 2025 15:05:47 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Hardik Garg <hargar@linux.microsoft.com>
Subject: [PATCH v5 0/2] Add VMBus message connection ID support via DeviceTree
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, mhklinux@outlook.com
Cc: devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 longli@microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 hargar@microsoft.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series adds support for reading the VMBus message
connection ID from DeviceTree. The connection-id determines which
hypervisor communication channel the guest should use to talk to
the VMBus host.

Changes in v5:
- Updated subject line and commit description to clarify what
  connection ID is and why DeviceTree support is required
- Addressed reviewer feedback about zero handling and binding
  constraints
- Revised binding description to clarify version-based selection
  instead of using "defaults" language
- Fixed checkpatch warnings (indentation and alignment)

Changes in v4:
- Split the patch into two separate patches:
  * DeviceTree bindings documentation
  * Implementation changes
- Fixed warnings reported by checkpatch

Changes in v3:
- Added documentation for the new property in DeviceTree bindings
-
https://lore.kernel.org/all/6a92ca86-ad6b-4d49-af6e-1ed7651b8ab8@linux.microsoft.com/

Changes in v2:
- Rebased on hyperv-next branch as requested by maintainers
- Added details about the property name format in the commit message
-
https://lore.kernel.org/all/096edaf7-cc90-42b6-aff4-c5f088574e1e@linux.microsoft.com/

Changes in v1:
- Initial submission
-
https://lore.kernel.org/all/6acee4bf-cb04-43b9-9476-e8d811d26dfd@linux.microsoft.com/

Testing:
- Tested on Microsoft Hyper-V
- Verified with and without the DeviceTree property
- Confirmed proper fallback to version-based connection ID selection
- Validated binding documentation with dt_binding_check

Hardik Garg (2):
  dt-bindings: microsoft: Add vmbus message-connection-id property
  Drivers: hv: vmbus: retrieve connection-id from DeviceTree

 .../devicetree/bindings/bus/microsoft,vmbus.yaml    | 12 ++++++++++++
 drivers/hv/connection.c                             |  7 +++++--
 drivers/hv/vmbus_drv.c                              |  8 ++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.34.1


