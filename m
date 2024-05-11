Return-Path: <linux-hyperv+bounces-2100-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3F8C31AD
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 May 2024 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A458B21203
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 May 2024 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B04E535D9;
	Sat, 11 May 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1gXwK/D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70F5336A;
	Sat, 11 May 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434722; cv=none; b=g8sDTcWBsKkIPJhrzIjbLQokzAr3WXqzGwA3q8trlJslRGWHgcD+gn+6YimT7wvGTSS9Evyn9QvPenHsR1vQBybt2W4eQ8x9XOKOcgLBo4U7FnvQQtCkwfgEnyDnuv89MIDN5UeV0xwj/lsc3cluWm5oa73gMAQjQLh9iSnLKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434722; c=relaxed/simple;
	bh=OqBaqr7bnEw6rO87FVZ50xtATfSlYMFCyhoeQBBHomw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxdMUcyp/salhjezrxt4crt4siRi/j4tCqJRAVm+KzueDd1+YxWqksZCtGdVec503+R4ndcqE9XWfUc8+rgxj3Meqz66cCUE3oksYVPK2GPJNU2tyCxrz8k7gYXBXiOWPji7ARl7gjEujmkjFZdvmaB01ItB5+5jEjLM+SpnZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1gXwK/D; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23f9d07829bso1602950fac.3;
        Sat, 11 May 2024 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715434719; x=1716039519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DFWICMD/WCOO9Yd1F/zaNQYZJnd1UcLXgXaWszNeVU=;
        b=c1gXwK/DtHeqeyCedFR3y1TCsGtTiiJcOrbmwC5gpwmYkjTnt6aQ28ryWjrzxgFN3o
         hVfnASV/Tl3bvM5x6NnVd5hyP/kAXp1Ov7WMA1+WuSHIkmii/mwst+ieCSCdV9ACjWOw
         bHfVJMFBMlRok0lwnX3zKrFqc44Q/1mcFKaBm7nMHDsHqn9UybC6WHcPUUuh8M8yx6kz
         6QlMaOEwbshvKybUcuqn8y8eL0AjStB5/aS57XdYqYt40J1p2fh0F6iuQdXeRZCZCNDn
         gjhjb2Vyz6fC9OaliNjKH4T7fGYAo76BKFtmS6Vw1HjAhLUpBdkjgV882KuyHuyXXJq/
         lprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715434719; x=1716039519;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6DFWICMD/WCOO9Yd1F/zaNQYZJnd1UcLXgXaWszNeVU=;
        b=fxzf1hu4gztGTN79i9ttuUZkbhoYBduFRSoR2upSzU1x/USp7Oe+fFsTnkecSzluEY
         WVCVPm+VjP8q/0YsNXuUc1mI7IBwPybwLs96lYy5nJ1DKDSn1crxAiTXFcjl9bbgjVa0
         K1UBk5a6SLdJzDij4LkgIAQjurFR9Axrp+Ovg422FhpS5Zk1zNXifKLuXgoeMa1N0jph
         Rn2vGgLTawQqm5uNpyBeKFKM5oWwKS9PcRs8XOxzIXUi1m86zYiZlEYJULRHMMiBtnS5
         c4PkB5mBQzY5UuHY4XvNzJYUvOSv16zJbDLIvHnE75Qi3FVyV56rNgGVuU57xhUdBygI
         LlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUjdUK/U6OfmS/DXP9R3J7M4Qkb0pDXn1c4OmqQ4P/NNDPFK9q65EDztzRqE+H+QwQKS5nq2qNp8akkV1RAUn3cAvH0DdjPmxh8kibkVsNrtb6Ij2LExdogPX5wk3faIorBWqzJHtY1LmhE9z/uLh0n2Z2T6RsrAhseN0lMls8pCWQwClkb
X-Gm-Message-State: AOJu0YwOx1u6zPKJ5Prh7sOd5+cyFyIB+J0fqkBIhDyjolSx/LvfoJAV
	lKmYAf4XcjMFEou0K0AXp73L6LA7/FocBfg8ibDGd4y0GzX0RSft
X-Google-Smtp-Source: AGHT+IHq0bKnJHe+wXHJcEWwVuU6a0I4Wz9D2EL5ocxSJPlGkxXW1tmNvEOlwFCGs/AMV27D8sXBEQ==
X-Received: by 2002:a05:6871:d282:b0:233:f233:c3ee with SMTP id 586e51a60fabf-24172fc18c8mr6270539fac.50.1715434717764;
        Sat, 11 May 2024 06:38:37 -0700 (PDT)
Received: from localhost.localdomain ([67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f399b656sm767146b3a.139.2024.05.11.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 06:38:37 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] Documentation: hyperv: Improve synic and interrupt handling description
Date: Sat, 11 May 2024 06:38:18 -0700
Message-Id: <20240511133818.19649-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240511133818.19649-1-mhklinux@outlook.com>
References: <20240511133818.19649-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current documentation does not describe how Linux handles the synthetic
interrupt controller (synic) that Hyper-V provides to guest VMs, nor how
VMBus or timer interrupts are handled. Add text describing the synic and
reorganize existing text to make this more clear.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* In clocks.rst, made a hyperlink for the reference to VMBus documentation
  [Easwar Hariharan]

 Documentation/virt/hyperv/clocks.rst | 21 +++++---
 Documentation/virt/hyperv/vmbus.rst  | 79 ++++++++++++++++++----------
 2 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
index a56f4837d443..176043265803 100644
--- a/Documentation/virt/hyperv/clocks.rst
+++ b/Documentation/virt/hyperv/clocks.rst
@@ -62,12 +62,21 @@ shared page with scale and offset values into user space.  User
 space code performs the same algorithm of reading the TSC and
 applying the scale and offset to get the constant 10 MHz clock.
 
-Linux clockevents are based on Hyper-V synthetic timer 0. While
-Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
-timer 0. Interrupts from stimer0 are recorded on the "HVS" line in
-/proc/interrupts.  Clockevents based on the virtualized PIT and
-local APIC timer also work, but the Hyper-V synthetic timer is
-preferred.
+Linux clockevents are based on Hyper-V synthetic timer 0 (stimer0).
+While Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
+timer 0. In older versions of Hyper-V, an interrupt from stimer0
+results in a VMBus control message that is demultiplexed by
+vmbus_isr() as described in the Documentation/virt/hyperv/vmbus.rst
+documentation. In newer versions of Hyper-V, stimer0 interrupts can
+be mapped to an architectural interrupt, which is referred to as
+"Direct Mode". Linux prefers to use Direct Mode when available. Since
+x86/x64 doesn't support per-CPU interrupts, Direct Mode statically
+allocates an x86 interrupt vector (HYPERV_STIMER0_VECTOR) across all CPUs
+and explicitly codes it to call the stimer0 interrupt handler. Hence
+interrupts from stimer0 are recorded on the "HVS" line in /proc/interrupts
+rather than being associated with a Linux IRQ. Clockevents based on the
+virtualized PIT and local APIC timer also work, but Hyper-V stimer0
+is preferred.
 
 The driver for the Hyper-V synthetic system clock and timers is
 drivers/clocksource/hyperv_timer.c.
diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index f0d83ebda626..1dcef6a7fda3 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -102,10 +102,10 @@ resources.  For Windows Server 2019 and later, this limit is
 approximately 1280 Mbytes.  For versions prior to Windows Server
 2019, the limit is approximately 384 Mbytes.
 
-VMBus messages
---------------
-All VMBus messages have a standard header that includes the message
-length, the offset of the message payload, some flags, and a
+VMBus channel messages
+----------------------
+All messages sent in a VMBus channel have a standard header that includes
+the message length, the offset of the message payload, some flags, and a
 transactionID.  The portion of the message after the header is
 unique to each VSP/VSC pair.
 
@@ -137,7 +137,7 @@ control message contains a list of GPAs that describe the data
 buffer.  For example, the storvsc driver uses this approach to
 specify the data buffers to/from which disk I/O is done.
 
-Three functions exist to send VMBus messages:
+Three functions exist to send VMBus channel messages:
 
 1. vmbus_sendpacket():  Control-only messages and messages with
    embedded data -- no GPAs
@@ -165,6 +165,37 @@ performed in this temporary buffer without the risk of Hyper-V
 maliciously modifying the message after it is validated but before
 it is used.
 
+Synthetic Interrupt Controller (synic)
+--------------------------------------
+Hyper-V provides each guest CPU with a synthetic interrupt controller
+that is used by VMBus for host-guest communication. While each synic
+defines 16 synthetic interrupts (SINT), Linux uses only one of the 16
+(VMBUS_MESSAGE_SINT). All interrupts related to communication between
+the Hyper-V host and a guest CPU use that SINT.
+
+The SINT is mapped to a single per-CPU architectural interrupt (i.e,
+an 8-bit x86/x64 interrupt vector, or an arm64 PPI INTID). Because
+each CPU in the guest has a synic and may receive VMBus interrupts,
+they are best modeled in Linux as per-CPU interrupts. This model works
+well on arm64 where a single per-CPU Linux IRQ is allocated for
+VMBUS_MESSAGE_SINT. This IRQ appears in /proc/interrupts as an IRQ labelled
+"Hyper-V VMbus". Since x86/x64 lacks support for per-CPU IRQs, an x86
+interrupt vector is statically allocated (HYPERVISOR_CALLBACK_VECTOR)
+across all CPUs and explicitly coded to call vmbus_isr(). In this case,
+there's no Linux IRQ, and the interrupts are visible in aggregate in
+/proc/interrupts on the "HYP" line.
+
+The synic provides the means to demultiplex the architectural interrupt into
+one or more logical interrupts and route the logical interrupt to the proper
+VMBus handler in Linux. This demultiplexing is done by vmbus_isr() and
+related functions that access synic data structures.
+
+The synic is not modeled in Linux as an irq chip or irq domain,
+and the demultiplexed logical interrupts are not Linux IRQs. As such,
+they don't appear in /proc/interrupts or /proc/irq. The CPU
+affinity for one of these logical interrupts is controlled via an
+entry under /sys/bus/vmbus as described below.
+
 VMBus interrupts
 ----------------
 VMBus provides a mechanism for the guest to interrupt the host when
@@ -176,16 +207,18 @@ unnecessary.  If a guest sends an excessive number of unnecessary
 interrupts, the host may throttle that guest by suspending its
 execution for a few seconds to prevent a denial-of-service attack.
 
-Similarly, the host will interrupt the guest when it sends a new
-message on the VMBus control path, or when a VMBus channel "in" ring
-buffer transitions from empty to non-empty.  Each CPU in the guest
-may receive VMBus interrupts, so they are best modeled as per-CPU
-interrupts in Linux.  This model works well on arm64 where a single
-per-CPU IRQ is allocated for VMBus.  Since x86/x64 lacks support for
-per-CPU IRQs, an x86 interrupt vector is statically allocated (see
-HYPERVISOR_CALLBACK_VECTOR) across all CPUs and explicitly coded to
-call the VMBus interrupt service routine.  These interrupts are
-visible in /proc/interrupts on the "HYP" line.
+Similarly, the host will interrupt the guest via the synic when
+it sends a new message on the VMBus control path, or when a VMBus
+channel "in" ring buffer transitions from empty to non-empty due to
+the host inserting a new VMBus channel message. The control message stream
+and each VMBus channel "in" ring buffer are separate logical interrupts
+that are demultiplexed by vmbus_isr(). It demultiplexes by first checking
+for channel interrupts by calling vmbus_chan_sched(), which looks at a synic
+bitmap to determine which channels have pending interrupts on this CPU.
+If multiple channels have pending interrupts for this CPU, they are
+processed sequentially.  When all channel interrupts have been processed,
+vmbus_isr() checks for and processes any messages received on the VMBus
+control path.
 
 The guest CPU that a VMBus channel will interrupt is selected by the
 guest when the channel is created, and the host is informed of that
@@ -212,10 +245,9 @@ neither "unmanaged" nor "managed" interrupts.
 The CPU that a VMBus channel will interrupt can be seen in
 /sys/bus/vmbus/devices/<deviceGUID>/ channels/<channelRelID>/cpu.
 When running on later versions of Hyper-V, the CPU can be changed
-by writing a new value to this sysfs entry.  Because the interrupt
-assignment is done outside of the normal Linux affinity mechanism,
-there are no entries in /proc/irq corresponding to individual
-VMBus channel interrupts.
+by writing a new value to this sysfs entry. Because VMBus channel
+interrupts are not Linux IRQs, there are no entries in /proc/interrupts
+or /proc/irq corresponding to individual VMBus channel interrupts.
 
 An online CPU in a Linux guest may not be taken offline if it has
 VMBus channel interrupts assigned to it.  Any such channel
@@ -223,15 +255,6 @@ interrupts must first be manually reassigned to another CPU as
 described above.  When no channel interrupts are assigned to the
 CPU, it can be taken offline.
 
-When a guest CPU receives a VMBus interrupt from the host, the
-function vmbus_isr() handles the interrupt.  It first checks for
-channel interrupts by calling vmbus_chan_sched(), which looks at a
-bitmap setup by the host to determine which channels have pending
-interrupts on this CPU.  If multiple channels have pending
-interrupts for this CPU, they are processed sequentially.  When all
-channel interrupts have been processed, vmbus_isr() checks for and
-processes any message received on the VMBus control path.
-
 The VMBus channel interrupt handling code is designed to work
 correctly even if an interrupt is received on a CPU other than the
 CPU assigned to the channel.  Specifically, the code does not use
-- 
2.25.1


