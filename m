Return-Path: <linux-hyperv+bounces-5478-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E9CAB4826
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 02:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784433AE7B0
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 May 2025 00:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CDAAD51;
	Tue, 13 May 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9x4nIZK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3BA50;
	Tue, 13 May 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094785; cv=none; b=jT4JbzcKxWtfJrIreWOK64OLw+B9UiqfmWevkvA0vDJ92naY9hyGXWLJBSv1HyALT+VYF06oaF7RHGQ3qo9gMTc7wcqmCHym+pQjCcgEliF42F/Y0LquFjSe8ndDkUDo7tFegOatlrjWqHXeQajfIn+wBoe3S/zOuaW3G9gvwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094785; c=relaxed/simple;
	bh=15QlA1RvqwWBPCuQg1QOEhb8GU/p5PFuITDF0PemJyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XT+Jp/Sbx+xIrk+PONHg2bmzvRmVWib2jTSBWugpkfT7gd7CL4AnJ7T2dKgjm9duGBAP3mzKXhgGVyJq2mB2v7dx/Wuap7yrxoRu8dY3J3FcVtzssezr0C3G35dU5lCOyfcC0xv43mibyWSgggwnDm9of+czcrr/X9nOEC0goaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9x4nIZK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e730c05ddso45738815ad.2;
        Mon, 12 May 2025 17:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747094781; x=1747699581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8muQO4QFV9cfTFAot9pQ7G4buAK54OtcnnAyHHxj5uY=;
        b=R9x4nIZK0O6YLd4fJHGWwKR2fwoD4q5OW0dxAAHjBCSjYy6BouFc5DH93i5MgO0N3y
         dE/aQvn7LifHmAzZS012f+ooj3sXJ0/o9+H+ZJOPiwYC9trhb6ftZurQ4PbKEub1FMXc
         YmF1GEMH39XNwK/7Lo3mBoJw3vZABV8cxqm08Dk7EI4FI1d5yiXqWY4FVSBUR91k5D81
         EuQK3kEaKxiRCRrUlQkf2ge55kI3IJFRxCygUtjGf8uXdyOLytVtwPlkZ4Ncg8zghlXM
         4jlBdBgJzHo+Tyb8OiRduRkn/wP4ekSIA0QN5+9HHgZkmqZlJZmXQA0USYwLLY4sGaMx
         4Qtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094781; x=1747699581;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8muQO4QFV9cfTFAot9pQ7G4buAK54OtcnnAyHHxj5uY=;
        b=Aa+unqBk4JU+t1P0BcHxSChWoyzB1gU2K+IouWHAD/UQooRn7kXEQZZ1hvRFEW7NFC
         qsHjJQMTjZizXJiV90HdacRj978f1EHetvY1b0jWRDfiFNvZfMY2mEVk8EBVPzfnkOHr
         E0bRm6Ekh7W6NNT8RmZWg/yzMkb8/jYbGdBjw2wWWrw+QuZkc4siE40hpqJFzc8oZIAg
         SXBq3qIARL5omuB+LB/eaf5wLpIZtaZvXUSKvUqdwH3I1PCHE86MqNEeqO4d3rKQpoYh
         IwOwXFxSaWfBiJjY2n9JFCr9+6udbpUKDsHXAitho1cD0A1WYqt9/a9WT/WIDFWy7Jjx
         +qLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMt+ZzmvJwpuDlahCl/7otsqZMkq5tu510KK81Q+PhcIYRMCHxRlnmmnLGZ8fi65Wb7qWvZxtTNIUaKg==@vger.kernel.org, AJvYcCUlAUAV0rAkVs8eC1y4QUoYJzFqu9Zq5AeU+tjdJsY+sJ3OuK0AtqtEqsfR3FS78MCjmy4AueiS@vger.kernel.org, AJvYcCVqhbAmgeoFDkpHBbFw+KCaM1X4D6NXlXuRzX9ZQbRcKCUa6gEnKZFqm5tqsJLXnWxB0E5kIBwF@vger.kernel.org, AJvYcCXFfVKFJjfuyREPqqlb+IfWJltNhkXi3jsDbaQhKIHElEbUQfYJ+uVf4F072fEj2O/wCYS1IaWDnR4N0E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeMkIhRyMVRkruNCEuqgRvjoT82HxqxU7uYiK6WdYNRlUaA68
	MOLWcEc0QeE/fPLg2do50D5rktoTXEbMZ0bLGgneUPii4SnOA+2+
X-Gm-Gg: ASbGncvAK3Q8X1gC8cmZKOqSSwCx7au3op5KkbXxrJD/d3l52tggBJ4xHDDfJGxRGig
	kk57xT0WB4ugBYbNpHH27L72Na8PFju3qNAX/CyaXMgUWWW0JSMYeDCcryzs9kzVFogDFAr+Ieb
	c5Q1wjZbiclsrKI6xZK40eKd3H+sZp7x7L13j+v+ICndC10auydJT0O8CL/wuQansfo+Dcz7PpG
	wesH4M7NlQHZlIo9CaXc4YamI+8U8S5jlMIiC3RVVj/iv+JUDI7rrU4lDTv/V6GPZlpfWfSfUGW
	eSPUCAKCZf9UVMxkPoRjFlGSF7I0Ctv10p0B3Jk3a3U3YO7X7Q1dPYIcg6CaXugq30YJHs+Hkw+
	/GFaaVxXjIuFyp0DrHhWsYv0RTl6byQ==
X-Google-Smtp-Source: AGHT+IGOdy/5TRdsB8TQMESAds9fv8y6dVMhnUM3bhvm/H593j88ln37N2/fl5wL+AZFbQpPJwnybQ==
X-Received: by 2002:a17:902:ce8b:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22fc8d98ab0mr231086305ad.32.1747094780966;
        Mon, 12 May 2025 17:06:20 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b491sm68470665ad.184.2025.05.12.17.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 17:06:20 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 0/5] hv_netvsc: Fix error "nvsp_rndis_pkt_complete error status: 2"
Date: Mon, 12 May 2025 17:05:59 -0700
Message-Id: <20250513000604.1396-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Starting with commit dca5161f9bd0 in the 6.3 kernel, the Linux driver
for Hyper-V synthetic networking (netvsc) occasionally reports
"nvsp_rndis_pkt_complete error status: 2".[1] This error indicates
that Hyper-V has rejected a network packet transmit request from the
guest, and the outgoing network packet is dropped. Higher level
network protocols presumably recover and resend the packet so there is
no functional error, but performance is slightly impacted. Commit
dca5161f9bd0 is not the cause of the error -- it only added reporting
of an error that was already happening without any notice. The error
has presumably been present since the netvsc driver was originally
introduced into Linux.

This patch set fixes the root cause of the problem, which is that the
netvsc driver in Linux may send an incorrectly formatted VMBus message
to Hyper-V when transmitting the network packet. The incorrect
formatting occurs when the rndis header of the VMBus message crosses a
page boundary due to how the Linux skb head memory is aligned. In such
a case, two PFNs are required to describe the location of the rndis
header, even though they are contiguous in guest physical address
(GPA) space. Hyper-V requires that two PFNs be in a single "GPA range"
data struture, but current netvsc code puts each PFN in its own GPA
range, which Hyper-V rejects as an error in the case of the rndis
header.

The incorrect formatting occurs only for larger packets that netvsc
must transmit via a VMBus "GPA Direct" message. There's no problem
when netvsc transmits a smaller packet by copying it into a pre-
allocated send buffer slot because the pre-allocated slots don't have
page crossing issues.

After commit 14ad6ed30a10 in the 6.14 kernel, the error occurs much
more frequently in VMs with 16 or more vCPUs. It may occur every few
seconds, or even more frequently, in a ssh session that outputs a lot
of text. Commit 14ad6ed30a10 subtly changes how skb head memory is
allocated, making it much more likely that the rndis header will cross
a page boundary when the vCPU count is 16 or more.  The changes in
commit 14ad6ed30a10 are perfectly valid -- they just had the side
effect of making the netvsc bug more prominent.

One fix is to check for adjacent PFNs in vmbus_sendpacket_pagebuffer()
and just combine them into a single GPA range. Such a fix is very
contained. But conceptually it is fixing the problem at the wrong
level. So this patch set takes the broader approach of maintaining
the already known grouping of contiguous PFNs at a higher level in
the netvsc driver code, and propagating that grouping down to the
creation of the VMBus message to send to Hyper-V. Maintaining the
grouping fixes this problem, and has the added benefit of allowing
netvsc_dma_map() to make fewer calls to dma_map_single() to do bounce
buffering in CoCo VMs.

Patch 1 is a preparatory change to allow vmbus_sendpacket_mpb_desc()
to specify multiple GPA ranges. In current code
vmbus_sendpacket_mpb_desc() is used only by the storvsc synthetic SCSI
driver, and it always creates a single GPA range.

Patch 2 updates the netvsc driver to use vmbus_sendpacket_mpb_desc()
instead of vmbus_sendpacket_pagebuffer(). Because the higher levels of
netvsc still don't group contiguous PFNs, this patch is functionally
neutral. The VMBus message to Hyper-V still has many GPA ranges, each
with a single PFN. But it lays the groundwork for the next patch.

Patch 3 changes the higher levels of netvsc to preserve the already
known grouping of contiguous PFNs. When the contiguous groupings are
passed to vmbus_sendpacket_mpb_desc(), GPA ranges containing multiple
PFNs are produced, as expected by Hyper-V. This is point at which the
core problem is fixed.

Patches 4 and 5 remove code that is no longer necessary after the
previous patches.

These changes provide a net reduction of about 65 lines of code, which
is an added benefit.

These changes have been tested in normal VMs, in SEV-SNP and TDX CoCo
VMs, and in Dv6-series VMs where the netvsp implementation is in the
OpenHCL paravisor instead of the Hyper-V host.

These changes are built against kernel version 6.15-rc6.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217503

Michael Kelley (5):
  Drivers: hv: Allow vmbus_sendpacket_mpb_desc() to create multiple
    ranges
  hv_netvsc: Use vmbus_sendpacket_mpb_desc() to send VMBus messages
  hv_netvsc: Preserve contiguous PFN grouping in the page buffer array
  hv_netvsc: Remove rmsg_pgcnt
  Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()

 drivers/hv/channel.c              | 65 ++-----------------------------
 drivers/net/hyperv/hyperv_net.h   | 13 ++++++-
 drivers/net/hyperv/netvsc.c       | 57 ++++++++++++++++++++++-----
 drivers/net/hyperv/netvsc_drv.c   | 62 +++++++----------------------
 drivers/net/hyperv/rndis_filter.c | 24 +++---------
 drivers/scsi/storvsc_drv.c        |  1 +
 include/linux/hyperv.h            |  7 ----
 7 files changed, 83 insertions(+), 146 deletions(-)

-- 
2.25.1


