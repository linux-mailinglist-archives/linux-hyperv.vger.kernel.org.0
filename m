Return-Path: <linux-hyperv+bounces-6350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0688B0E8F4
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 05:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A0B4E85ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Jul 2025 03:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C91EEA5F;
	Wed, 23 Jul 2025 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i9/Q14H9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA81DF26A;
	Wed, 23 Jul 2025 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753240092; cv=none; b=qV2Ds/zDCiO9x1z2f/iqJDCp6ErfzViswwpTlnO+SXLSXQLcAbUgp4WX7fJYuZLQFqT2I7oRijnJbg1mRd+NzB/I/SC545agaNSvboLApkxndUotRI/b4twK16fXQeTyJrvl2ZKzTSqEyGf/+WIPA7YoUIHiPgfAF7pi2HmzlF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753240092; c=relaxed/simple;
	bh=11NZzGtILvIkTkT+burk1u1dHBQYFKy//0QHhZgzBcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nZ3aeGEQ5smY2ccCAvJKXCnIZ0brAotA8l60YJUH/kE7THOskMhEI8Z6ZLaiad1VFL5jVXLgEwU2X6vv8/yn59yZjqD5f+t87TNLQ+z0xCJYTQGmlGCGCqrxOurhfGszzU9i4aO7frKhgMkIF6BsUEbvg2KlTbmtU+s/A98nA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i9/Q14H9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 00EA32014DE6; Tue, 22 Jul 2025 20:08:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00EA32014DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753240090;
	bh=9iVDLIiS0+o8avGvkJ11y66/XQWME2nzHrsTC0w2cgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i9/Q14H9mkjO+yZ3iGgT6UCuvyZpb7L+eM6oPJSdkccOJ9DGFaezb0Y0dxtsaXuf6
	 j9nwA4VXghN58U+CBuvqq7NSaTQnHmrb3M4GWSz8JVk07J9goFYgDO6ZzIjnelunii
	 +lj9vWCfGzLujOd3VzWcnaXeS6IIE8HL/A52KjcI=
From: Hardik Garg <hargar@linux.microsoft.com>
To: krzk@kernel.org
Cc: apais@microsoft.com,
	conor+dt@kernel.org,
	decui@microsoft.com,
	devicetree@vger.kernel.org,
	haiyangz@microsoft.com,
	hargar@linux.microsoft.com,
	hargar@microsoft.com,
	krzk+dt@kernel.org,
	kys@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	ssengar@linux.microsoft.com,
	wei.liu@kernel.org,
	cho@microsoft.com
Subject: Re: [PATCH v4 1/2] dt-bindings: microsoft: Add vmbus message-connection-id property
Date: Tue, 22 Jul 2025 20:08:09 -0700
Message-Id: <1753240089-29558-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <095a1455-c6ac-4a7d-a219-ddfd0a93d8d6@kernel.org>
References: <095a1455-c6ac-4a7d-a219-ddfd0a93d8d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Host is supposed to have multiple guests, so this feels like you are
> going to prepare for each guest different DTS with different connection
> ID. This feels like poor design. DTS is supposed to be relatively static
> configuration, not runtime choice vmguestid+1.

> The guest cannot access other configuration channels, can it? If it can,
> it would mean it can eavesdrop on other guests? So obviously it cannot.
> Therefore from guest point of view this is completely redundant. Guest
> cannot use any other value, thus guest should not configure it. The
> guest has only one channel and uses only this one which gets to right
> place to the host.

Thank you for your feedback. Let me explain the connection ID in more detail:

1. Message Port Architecture:
   - The connection ID specifies which Hyper-V hypervisor message port (mailbox slot) to use for communication between the host and guest
   - The hypervisor has multiple message ports, but historically VMBus only used one
   - With the introduction of VTL2 (Virtual Trust Level 2), the control plane can now be hosted in VTL2, requiring different message ports for communication

2. Control Plane Communication:
   - The VMBus control plane on the host needs to communicate with the VMBus driver in the guest
   - When the control plane is hosted in VTL2, it requires a different message port than the standard communication path
   - The connection ID tells the guest whether to use the standard or alternate message port for this control plane communication

3. Message Processing:
   - Each message is tagged with an ID
   - If the guest uses an incorrect ID, the host won't recognize the message and will drop it
   - This is not about choosing between multiple available channels - it's about using the correct mailbox slot for communication

4. Security and Isolation:
   - Each guest has its private hypervisor mailbox
   - Multiple guests using the same connection ID cannot interfere with each other
   - The connection ID is more like a "root ID" that helps enumerate devices on the bus, not a channel selector between guests

5. Dynamic Nature:
   - The connection ID is specified when the guest starts running
   - The host can change it during VM lifecycle events (reset/reboot)
   - This is why the VMBus driver needs to know the connection ID every time the kernel starts
   - The ID might be different from what it was during the last guest run




Thanks,
Hardik

