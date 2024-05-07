Return-Path: <linux-hyperv+bounces-2084-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A98BE354
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 May 2024 15:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBD71F22214
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 May 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1A715E218;
	Tue,  7 May 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7HyKSyF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE0015DBC0;
	Tue,  7 May 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087792; cv=none; b=IN8fULgJe0Ty+l54oAErCtwUqa0SfPIeuJGrPeQ69DOyeugR4weOdAPKqSV4fmLIJOKOuho+KR05gHvszxGwAZ00Hv9Mg9P+kaPR2+zStUmvSfvNyfOnww6YfM17l/pydOhgAEQKvtXVbTW42jO2tMtDQdHOOjUzrYvXuEjULf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087792; c=relaxed/simple;
	bh=0uKvsasIj33/Tyfsa9oOCGaF+gpRdd5U8GQpflVQ0s0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mGj9Hgg6sKn9kxzr5qnAJ+9xCdvmNotdke/TKwBwBv1enB8xnXKMGxslIuvOduuimSfIiyWCsXS6ygSUbPevTXgH9XTAjyZwGWlfQS07T2oGK0ehq+B7ypI+iY8tq8wwMupcal1I2eCVWmgPOvoBNVBL1o81E/xV7kNEQyrkTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7HyKSyF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4551f2725so3003428b3a.1;
        Tue, 07 May 2024 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715087790; x=1715692590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Qb9gUXAb6B0uEKdTy5ff19pWlQ4SHfnnvxveJ1/rLE=;
        b=C7HyKSyFS+uM5ukYnlpGIAKqw1R3n5+vS2UIdLZML+vv5Oa3qzYX0WfsfPaD83lG/V
         3rQMXpTJZMHeCpHDzoWMW+1KvNTXshrV4i0GJcTwVKK67mafmFMLp3VZeyYl6lPO8v4U
         91WGvo95i9/sGtRks3wlnIPR3E7iMmDomkStg+UHMjdM08rnjeHHUkHz/F72Q7w9vonP
         exPu277jh7xQI2tyjhA2zGNVhc2jEqy1MxkBUhA5qDEVgZ7gKom3GB760aySpF0fNSz2
         Z1N/YIHt30d91JuWqRb2eN8YGtoJCEM64epjAAFV4kv+MUBtESfoiMbW7tSYloSbkFNs
         4Fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715087790; x=1715692590;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Qb9gUXAb6B0uEKdTy5ff19pWlQ4SHfnnvxveJ1/rLE=;
        b=gTezF8XE9CYPOluwxBIPaO9YNY4kzuJdesCFA3GtM9q+uzVOFNDQR/qwKpWq+ZHEgc
         VhY+pqwXPochftHy4no7qUzkn+BHiMkGYjbGjcoSjXvbzBuKNV/5bdR+zk6jnxY94A4/
         gg7WFns42Ggh9KQbxus1Ir45TRip0iQOjS5IUK9i9osZVb1kZkHmlzuZsfnnqcXPHwB9
         tRpuU+M1mm3pLf7Op1SwxVr00zLYtvSFXo83UzviBk3SGoMS4QFoEOgzAbsUSK3UnqFH
         daAbDkAIWHFDzNk7yAi4Qdm/Rv8FM+cF24Lv/7R3OeBgE1lxv0KJqf5UFphnPh7jonkR
         P2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPn0GIKrQ5BaOVCemyb9MXslJx8u6lBRA0o/6spWAbGood5C0NGsRzJttTJIxfjQqrIctC+pGhIaerD2RzgB2cbcAAXyberRXxaJ+c4XwzBAMyB/ivO65FlJ7EzRdK5JoaVT8EzC8mGHp+DciCr/BwiOn6H0oN3bgKQV5QNFot/PrmJZFh
X-Gm-Message-State: AOJu0YxhLE7RcE/ZcyN4VZG7pdifGtbcE70yrTVrOqnWTfsUI2IZ8ehh
	hWb8hR/2S+noGyJDYXd0SEg7uR6SbueIJVVQkGaCJPlyeBINlh3hTNZmoA==
X-Google-Smtp-Source: AGHT+IG2IrpnFoACtA5A61A4XB+TtRNsqtbtyLYV99OhtMdAW5NHuGMGGrCLiF2rhlRex6gnjeYUeA==
X-Received: by 2002:a05:6a00:801:b0:6ed:21d5:fc2c with SMTP id m1-20020a056a00080100b006ed21d5fc2cmr16619970pfk.26.1715087790260;
        Tue, 07 May 2024 06:16:30 -0700 (PDT)
Received: from localhost.localdomain ([67.161.114.176])
        by smtp.gmail.com with ESMTPSA id fi26-20020a056a00399a00b006f3ec69bc09sm9382237pfb.75.2024.05.07.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 06:16:29 -0700 (PDT)
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
Subject: [PATCH 2/2] Documentation: hyperv: Improve synic and interrupt handling description
Date: Tue,  7 May 2024 06:16:07 -0700
Message-Id: <20240507131607.367571-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507131607.367571-1-mhklinux@outlook.com>
References: <20240507131607.367571-1-mhklinux@outlook.com>
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
 Documentation/virt/hyperv/clocks.rst | 21 +++++---
 Documentation/virt/hyperv/vmbus.rst  | 79 ++++++++++++++++++----------
 2 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
index a56f4837d443..919bb92d6d9d 100644
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
+vmbus_isr() as described in the VMBus documentation. In newer versions
+of Hyper-V, stimer0 interrupts can be mapped to an architectural
+interrupt, which is referred to as "Direct Mode". Linux prefers
+to use Direct Mode when available. Since x86/x64 doesn't support
+per-CPU interrupts, Direct Mode statically allocates an x86 interrupt
+vector (HYPERV_STIMER0_VECTOR) across all CPUs and explicitly codes it
+to call the stimer0 interrupt handler. Hence interrupts from stimer0
+are recorded on the "HVS" line in /proc/interrupts rather than being
+associated with a Linux IRQ. Clockevents based on the virtualized
+PIT and local APIC timer also work, but Hyper-V stimer0
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


