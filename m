Return-Path: <linux-hyperv+bounces-11472-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B0KpCKD2IGrS9wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11472-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:53:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FD563CBBB
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:53:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b="QBd/WNzH";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11472-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11472-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44F6E300FA83
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F84E33F5A7;
	Thu,  4 Jun 2026 03:53:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-m128248.netease.com (mail-m128248.netease.com [103.209.128.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615425B0B1;
	Thu,  4 Jun 2026 03:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545181; cv=none; b=WLGg9A9xwyV64AiQh+1b352px6xBVWNTd6Rpap2eWRUVE+6KV6zKBqLZQev8JBw12NHDie44Hu02UXIUFjL8WvyaENEN4RMPNJPMoF87rhPbXp/NQCFnrChQMbGAlawyT1+cjJul2UOnnCC6EeJ1dHy1Q3Bghy5A1HHgpiRdX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545181; c=relaxed/simple;
	bh=pqJORI/BeSEPC9kKrGebEYTG7dT32Me3VXUFobNTPAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zm//hzk24DD+WETDeoh9pItABhPpnKyQVNs0ZTwx1HnabBBN4upyEYds//ihVmOF481fRxcjXn1rRN9YAACYFvi5yx4wAmEBC7vdMtzRk1+Ic7+He2DZeeWWCJpvHvnEsemn/cA34hgmCd9PhR+lbf6wWNlYQvDd40ryvDL+dIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=QBd/WNzH; arc=none smtp.client-ip=103.209.128.248
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4103cca4d;
	Thu, 4 Jun 2026 11:52:45 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH v2 0/4] Convert remaining buses to generic driver_override handling
Date: Thu,  4 Jun 2026 11:52:35 +0800
Message-Id: <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e90c3184503a1kunm0f81216d28cfb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaH0ofVkkdQk8YSx1KSE5MS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=QBd/WNzH8LJIFfCWteEZ7O5gOK2zi6HbPOPqyAciNXBwGzWyX+BGVc5xSmUYvSbAJ+q9IQW0HUM+SLHOsEsnAjTZx2pDwf8SFt4czz/ENWStIwWQHSNHAbMQ7q4H2AU20MEGpcRmnBeBVHwzWvyyUqLSZGxqkEo8Z/qL8cuiypE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0i30K4Aag2IQ6XA3c4b24FojM+2f3MFxUzei21oNgo8=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11472-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux@armlinux.org.uk,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:nipun.gupta@amd.com,m:nikhil.agarwal@amd.com,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4FD563CBBB

This series converts four remaining buses from bus-private
driver_override handling to the generic driver-core infrastructure:

  - AMBA
  - RPMSG
  - VMBUS
  - CDX

These buses still keep private driver_override storage and read it
directly from their match paths. However, bus match() callbacks can be
reached from __driver_attach() without the device lock held, so those
raw reads can race with updates that replace and free the override
string.

The driver core already provides generic driver_override storage and
matching helpers with the required internal locking. Other buses have
already been converted to that model. This series switches the
remaining users above to the same infrastructure by:

  - removing bus-private driver_override storage
  - dropping bus-local driver_override sysfs handling
  - enabling struct bus_type.driver_override
  - using device_match_driver_override() in match paths

Bus-specific behavior is preserved where needed:

  - VMBUS keeps its dummy-id fallback for override-based binding
  - CDX keeps its override_only matching semantics
  - RPMSG converts its in-kernel override registration path to
    device_set_driver_override() and drops the old transport-local
    frees of bus-private override storage

Before preparing this v2 series, I rechecked the affected source paths
against v7.1-rc6. I also reran the existing report-specific no-device
KCSAN stand-ins on a local v7.1-rc6 guest for all four buses. Those
reruns again produced target-stack reports for the corresponding
driver_override update/match paths.

That runtime validation is still stand-in based rather than direct
hardware execution, but it reuses the real driver_set_override() helper
from the running v7.1-rc6 guest kernel and preserves the relevant
patch-local reader/writer contracts and caller chains.

Since v1:
  - reworked the series around the generic driver_override
    infrastructure instead of trying to serialize bus match() with
    device_lock(dev)
  - split the changes by bus
  - preserved VMBUS dummy-id fallback behavior explicitly
  - preserved CDX override_only matching semantics explicitly
  - converted the RPMSG in-kernel override registration path to the
    core helper
  - reran the four report-specific no-device KCSAN stand-ins on a
    local v7.1-rc6 guest and refreshed the validation basis
  - refreshed the commit messages accordingly

Runyu Xiao (4):
  amba: use generic driver_override infrastructure
  rpmsg: core: use generic driver_override infrastructure
  vmbus: use generic driver_override infrastructure
  cdx: use generic driver_override infrastructure

 drivers/amba/bus.c               | 35 +++++--------------------------
 drivers/cdx/cdx.c                | 40 +++++-------------------------------
 drivers/hv/vmbus_drv.c           | 36 +++++---------------------------
 drivers/rpmsg/qcom_glink_native.c |  2 --
 drivers/rpmsg/rpmsg_core.c       | 41 ++++++-------------------------------
 drivers/rpmsg/virtio_rpmsg_bus.c |  1 -
 include/linux/amba/bus.h         |  5 -----
 include/linux/cdx/cdx_bus.h      |  1 -
 include/linux/hyperv.h           |  6 ------
 include/linux/rpmsg.h            |  4 ----
 10 files changed, 21 insertions(+), 150 deletions(-)

-- 
2.34.1

