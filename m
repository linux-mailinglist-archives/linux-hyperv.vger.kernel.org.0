Return-Path: <linux-hyperv+bounces-5568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B825ABCE4C
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 06:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC761B63D09
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 04:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86142580E4;
	Tue, 20 May 2025 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdWNLzZG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F678F40;
	Tue, 20 May 2025 04:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716281; cv=none; b=XvDo2338rZPuioL5V8gAjeX0jdGO6dIn9KbfncT58sp9kEWFyEv9lK2NKFCIwQzjw1orx6Xe71ZElMXbiRXfOnzWBXwwTSLJI+uGg2Je+2ThcJj73QZNQe1LyeVN7+UzU3e7Rg3NPILdPJn/PmBUCW2do2P/x4O9c+ShyQU+des=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716281; c=relaxed/simple;
	bh=YnFfM7f8Z8P+rMul/3CB9XmIunDT1hRI8VxUzqKxZqE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KRdspFQvvb/zZdwWOI0F5+FXqGnE9nydm8YoeRkAHhwNLS0rwtAkJ+8XTIOBHXGzwTmZLj7NHdgd/amsnQTEKtkO9bk4ePDuBF9RvhxqiaWa5rqk/uom+qgrEjvnCC8z5vV6rilCFk6tTmQgMDbmOzc6578Efz0d81Zz0UVP/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdWNLzZG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7398d65476eso4106795b3a.1;
        Mon, 19 May 2025 21:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747716279; x=1748321079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x+gC3webd+3eZh5NxDuGi3Ku0h6CJz2U1B0TRCfIDb4=;
        b=YdWNLzZGcbs99iRm/VjQQq2XjXx/emWwMXWNs00XyVNbaOPor0D+1DHnao/SACD20z
         0NRk9ikHaHQLj8IWqsqK6wG+RcQc37ojS6/zZTaMl7tzCJWsJupd10kwykXEG+GAwf4C
         c2Jl6VgV/3vAc7LxH9SXPH+6PZquwyXgZnCWJF4k5eDptvZtQO2gW5kEsdVyRQC2+JpO
         PpgohiB7X6mazk/RAXI53Ihu5t3mBSlupPTZDF2Uq1ajC6TOcgN1jSIQOKXq7PTYe6Ij
         lw4EG80v8afhidzNa15C3SNfdGIXv4soA0mT1UdEzNL3PlbwdgxNjJXe3wNo3mM7K+jR
         9wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747716279; x=1748321079;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+gC3webd+3eZh5NxDuGi3Ku0h6CJz2U1B0TRCfIDb4=;
        b=Bub37IQ+X8828WzuUEug6mvc2QnRzQbb9AwQiQMZeZ+gU7CJHt78GzPGV2DvoJFGRk
         msTCXqgWQQaHOZew/+bMHe8+zYLNZDLLKSZcDINH0U0jer4Ys902ox6uinV6KhjIM3sm
         1pW4tlsOzg0i6XQCmzilT+P3M/TNufqfMhn1rP0KazYON14kcJ1MwLvsCPNvnISBBCsr
         Hnwr3XgRSPrliPsd+8VxbiqW/cbtafHE1TBoH6LRD7g3azC+/VZNsYAX5PnKax3rINCx
         PQtrodUf/kZjN+FVaVxpmLLI6ubxStNt7WWe9UgyZBd2DmPCUM2kyebuiAEfQg5YHvgx
         8nJA==
X-Forwarded-Encrypted: i=1; AJvYcCVqsEA9Fb71YAfXeAnoBmAS0qkVhbrxx4QT86i+oKOWawN8ccPu8BOfFSHFvwi1mDF7YT7Zt74MD7V3Hvia@vger.kernel.org, AJvYcCWMr8wbGduKQZZ3aZn5iU+VrNnPhmm1ZnGgeXJicNZWstvIJPzpGWT6nm5QDe8s1txmuB7V/8u9G+E=@vger.kernel.org, AJvYcCXrbf9lZVmu9GRk48bbeIcFbEDko62K59RXFFaIqJjiDK9ZDZxAxgqq2fYfranfM5X8pWmjYZC8UwngHEFx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj4Zd2+p19Guo7cf8KjRsmtfJSVS1vRgqvPjCypAEcMA2Ji3zs
	Od4Uckm2xpTYIx9W3f3mlhb6vDsBCcveya2BUfU+lslmxAprxhfZJyMYYxXiDQ==
X-Gm-Gg: ASbGncsG36oRCW2wRBj6cAKs9WaYooQ4nWsM5MK2zvB1ICSoBqOBYvWLH5XimEnRtO+
	m+JLMiDuqunTCx+EcAWlcjBf7tM+NKlVnWJH6cerefhjQvXHlnyg7pujZktnENWIHzrWAjATe3E
	4ziU3pkDTrZwJakbKM+JQLSuQUJea4SxMGrbb10RIOc+DKug4z8CtviDaKPkzeOrXG1o1n/9owO
	34v9Fkf+G3tgJM3tVs3ikHF000GU//ZmyGM5tQt2jTXJ3DpkfYSaNtK5VrjYrbU0NzEOXEepr1y
	IcciZvuxGLjD2TKnPkSGfRnnXiSeGfl/fENDFBTyhtwcaFlziUhwEAst1+a5UWIBjK20bvQ7cd3
	Gk+QdErrT1SkUqF0kdICPSndalqva+A==
X-Google-Smtp-Source: AGHT+IHOxIJb1D2VNKYuGcGmIorjkELIdH7fwS+5jOp8sysl/eiUbpMpQQBpb9LbPOjeSMCdjgtrrw==
X-Received: by 2002:a05:6a00:845:b0:742:b928:59cb with SMTP id d2e1a72fcca58-742b9285c81mr13726551b3a.7.1747716279466;
        Mon, 19 May 2025 21:44:39 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm7182590a12.72.2025.05.19.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 21:44:39 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation: hyperv: Update VMBus doc with new features and info
Date: Mon, 19 May 2025 21:44:35 -0700
Message-Id: <20250520044435.7734-1-mhklinux@outlook.com>
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

Starting in the 6.15 kernel, VMBus interrupts are automatically
assigned away from a CPU that is being taken offline. Add documentation
describing this case.

Also add details of Hyper-V behavior when the primary channel of
a VMBus device is closed as the result of unbinding the device's
driver. This behavior has not changed, but it was not previously
documented.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 Documentation/virt/hyperv/vmbus.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
index 1dcef6a7fda3..654bb4849972 100644
--- a/Documentation/virt/hyperv/vmbus.rst
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -250,10 +250,18 @@ interrupts are not Linux IRQs, there are no entries in /proc/interrupts
 or /proc/irq corresponding to individual VMBus channel interrupts.
 
 An online CPU in a Linux guest may not be taken offline if it has
-VMBus channel interrupts assigned to it.  Any such channel
-interrupts must first be manually reassigned to another CPU as
-described above.  When no channel interrupts are assigned to the
-CPU, it can be taken offline.
+VMBus channel interrupts assigned to it. Starting in kernel v6.15,
+any such interrupts are automatically reassigned to some other CPU
+at the time of offlining. The "other" CPU is chosen by the
+implementation and is not load balanced or otherwise intelligently
+determined. If the CPU is onlined again, channel interrupts previously
+assigned to it are not moved back. As a result, after multiple CPUs
+have been offlined, and perhaps onlined again, the interrupt-to-CPU
+mapping may be scrambled and non-optimal. In such a case, optimal
+assignments must be re-established manually. For kernels v6.14 and
+earlier, any conflicting channel interrupts must first be manually
+reassigned to another CPU as described above. Then when no channel
+interrupts are assigned to the CPU, it can be taken offline.
 
 The VMBus channel interrupt handling code is designed to work
 correctly even if an interrupt is received on a CPU other than the
@@ -324,3 +332,15 @@ rescinded, neither Hyper-V nor Linux retains any state about
 its previous existence. Such a device might be re-added later,
 in which case it is treated as an entirely new device. See
 vmbus_onoffer_rescind().
+
+For some devices, such as the KVP device, Hyper-V automatically
+sends a rescind message when the primary channel is closed,
+likely as a result of unbinding the device from its driver.
+The rescind causes Linux to remove the device. But then Hyper-V
+immediately reoffers the device to the guest, causing a new
+instance of the device to be created in Linux. For other
+devices, such as the synthetic SCSI and NIC devices, closing the
+primary channel does *not* result in Hyper-V sending a rescind
+message. The device continues to exist in Linux on the VMBus,
+but with no driver bound to it. The same driver or a new driver
+can subsequently be bound to the existing instance of the device.
-- 
2.25.1


