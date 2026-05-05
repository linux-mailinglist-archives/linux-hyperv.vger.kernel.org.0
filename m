Return-Path: <linux-hyperv+bounces-10628-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FD8ASnz+WmcFQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10628-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:39:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 725964CEA73
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41EBE3044CF9
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808647DD66;
	Tue,  5 May 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2m8SQPR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106293EF0D2;
	Tue,  5 May 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988389; cv=none; b=Nc4537Q8QMvoe2lntRbPXsVRzMzseVoF4bc2rynMcqrFZut7TA4b9sN3Xbs1QAN2pUu51/dT81KQ205dLU1+T5Fdd6cGL/GaSnZyK6s9Pu1MoUHXZf+keNGwNAHiIFQ4qgbJRgASiqb7Erx2VA/efC8oT4Tc9JeHIaI0xVEiUWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988389; c=relaxed/simple;
	bh=lDmxIrb2TXzASfiuCLeb0bitGj5KO4NOFTyIIw2rOK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHNcGx7CG7Xu0nd1/GObr+W2GnirYeWt7PDcQ5Qvf6ybvMZgt2bqO65C4IWhpiFkH4xNQXtHzIsWE/OivPbtMNP+dackZueVbR0RIfbo+qVDQo4WMyJWpJbeUWW4rdXqr3Urde9XEtCXY/O2YxeMMRlHR1J6DEzyhVf5LX31KhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2m8SQPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362D9C2BCB4;
	Tue,  5 May 2026 13:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988388;
	bh=lDmxIrb2TXzASfiuCLeb0bitGj5KO4NOFTyIIw2rOK8=;
	h=From:To:Cc:Subject:Date:From;
	b=L2m8SQPRJ3APZQXbtipIvBXYMXRv6nK126TQs+FDyLprMbkAEfZzwid2Nr4bW2/gH
	 Vm/n9UtyqcIHPQJZj1G27ywzVIT4NQI82fqvm9XqinNGi4aWgsKuM6tAYU6D00YHl6
	 RYZ75swH44LjpA9OTUB1SEtOWaIRXI9L9WSYR+BSeq0a40LZ06KGwrN1PDtTDao0hT
	 PG8FgQFTDCLg586NU3YF1wIUI+C42tvMmorH2WPWhUBEyO+ArGyl9wegHDN6LDssr/
	 NLs5GaL8U+ybDCF6S2ehfV3EDwOmBnTgBsj2wq3y2ucUzn8BI75M9wj6QrSqs+IW7/
	 fuSCZB5AEQ5Qg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linux@armlinux.org.uk,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/5] treewide: Convert buses to use generic driver_override
Date: Tue,  5 May 2026 15:37:20 +0200
Message-ID: <20260505133935.3772495-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 725964CEA73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10628-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.com:url]

This is the follow-up of the driver_override generalization in [1], converting
the remaining 4 busses and removing the now-unused driver_set_override() helper.

All of them are prone to the potential UAF described in [2], caused by accessing
the driver_override field from their corresponding match() callback.

In order to address this, the generalized driver_override field in struct device
is protected with a spinlock. The driver-core provides accessors, such as
device_match_driver_override(), device_has_driver_override() and
device_set_driver_override(), which all ensure proper locking internally.

Additionally, the driver-core provides a driver_override flag in struct
bus_type, which, once enabled, automatically registers generic sysfs callbacks,
allowing userspace to modify the driver_override field.

This series is based on v7.1-rc1 with no additional dependencies, hence those
patches can be picked up by subsystems individually.

[1] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.org/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=220789
[3] https://gitlab.com/driverctl/driverctl/-/blob/0.121/driverctl?ref_type=tags#L99

Changes in v2:
  - Rebase on v7.1-rc1
  - Drop already merged patches
  - vmbus documentation changes as requested by Michael

Danilo Krummrich (5):
  amba: use generic driver_override infrastructure
  cdx: use generic driver_override infrastructure
  Drivers: hv: vmbus: use generic driver_override infrastructure
  rpmsg: use generic driver_override infrastructure
  driver core: remove driver_set_override()

 drivers/amba/bus.c                | 37 +++------------
 drivers/base/driver.c             | 75 -------------------------------
 drivers/cdx/cdx.c                 | 40 +++--------------
 drivers/hv/vmbus_drv.c            | 43 +++++-------------
 drivers/rpmsg/qcom_glink_native.c |  2 -
 drivers/rpmsg/rpmsg_core.c        | 43 +++---------------
 drivers/rpmsg/virtio_rpmsg_bus.c  |  1 -
 include/linux/amba/bus.h          |  5 ---
 include/linux/cdx/cdx_bus.h       |  4 --
 include/linux/device/driver.h     |  2 -
 include/linux/hyperv.h            |  5 ---
 include/linux/rpmsg.h             |  4 --
 12 files changed, 28 insertions(+), 233 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.54.0


