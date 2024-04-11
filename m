Return-Path: <linux-hyperv+bounces-1958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB348A21CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Apr 2024 00:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEE52852B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A13308A;
	Thu, 11 Apr 2024 22:37:46 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9FC205E00;
	Thu, 11 Apr 2024 22:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875066; cv=none; b=GTWl7ZQ9GXhtY1lBTe9bZ6sM5jLdOtsBbqYvrl7xcWmmUErFjrceCmH7gXdkWg/iv7bUqIwwUHATlIESJ8hZd14CgpNSE9qIccIVvRKYE9J9mdMfhTf6CtpKitNSV9j2Q5zExuhdgoaMr/MLr10MlhV24MhOny9DJt2sBlu6a4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875066; c=relaxed/simple;
	bh=0nns8Ff4F6D/hiksCnhah+ogGWHAC7v/9Z1x3syG47o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iQ15o0gJalCwcaDOsWf9lhSLS2ViY9DbgzzAVvgAV0MPRNt5PWFwu3Us97wA53eehgNlIidMolDwCx50bYoR9AU168MGfXbiSJbLFmOHVRSRG4PpGgs9dSkl+pOBPsXncJlTVHiasm6n0a/kzkSWqTcyDAyUnbVk68tBrW49sZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e50a04c317so2222855ad.1;
        Thu, 11 Apr 2024 15:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712875064; x=1713479864;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b2bA0Klb+Banv4xhLIqQoUZ2zEzeFimrSjJDvif4SFE=;
        b=UhxNZ09x3vF3B1GVYcHiEsWADZACtdSzM2ng/gS0a+Cdhoz4OUjbFr94BCK1VriFNs
         OakO+DnKFZVLF60Mlu+PQYdUhuN81e+JsbDvRZDsD7VmuTvRV0AnmZOqm5VX4dSvBJWH
         OxpSLVQWLVMAXng+LlG6M06/zOMFCod+akuNRMmiqcCEU0ll4Cds0XEJDXgiVKCb6DcN
         27LWa4yPqFUbzMps5jMJd/k9hz2GVZ4gb9oJvTqpcHMKyDJT+syufxT6CNH/ixGmb0pe
         JvCUTbuaSA7lyj6wTptnDqMsgQAWVyHcwh8iZXf6vX8B+hUZdqpRCpWsocUgViI8/9gc
         nx6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1ZA8mmKPcbDr0PMXhLL4oaYru2XtWJz4CuuV+hMOPNQz4VSTGdj/uG9N+QlGmxvzU71FZ+xYgORv6+1EeIgoiT2WDCnLmiJrbrjVVe0nsAWJDyzIihgYMcoIVi+mzsUPNDtxcFo8Ojjip
X-Gm-Message-State: AOJu0Yxl8QNR0Ejn5fwd66mzgxh1vKUAu4z+7VdjK3TpgxparGZE/B8T
	DoXHClhiXx6WfYSBsyyAPUdLA6OULNw1i0g0yvDXrT+V5amprBnTF+b1+w==
X-Google-Smtp-Source: AGHT+IGk46rx9QRNj2LvIO8tDcGGIBL3hf6CZAFhV/H+mOG1a4Az7AnbKinIcd+Rh9KZ52dEDnbxZw==
X-Received: by 2002:a17:902:eacd:b0:1e2:23b9:eb24 with SMTP id p13-20020a170902eacd00b001e223b9eb24mr781671pld.33.1712875063994;
        Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001ddb4df7f70sm1687503plx.304.2024.04.11.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:37:43 -0700 (PDT)
Date: Thu, 11 Apr 2024 22:37:35 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.9-rc4
Message-ID: <ZhhmLy_V-B97jAaQ@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240411

for you to fetch changes up to 30d18df6567be09c1433e81993e35e3da573ac48:

  Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted (2024-04-10 21:33:33 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.9-rc4
 - Some cosmetic changes (Erni Sri Satya Vennela, Li Zhijian)
 - Introduce hv_numa_node_to_pxm_info() (Nuno Das Neves)
 - Fix KVP daemon to handle IPv4 and IPv6 combination for keyfile
   format (Shradha Gupta)
 - Avoid freeing decrypted memory in a confidential VM (Rick Edgecombe 
   and Michael Kelley)
----------------------------------------------------------------
Erni Sri Satya Vennela (1):
      x86/hyperv: Cosmetic changes for hv_apic.c

Li Zhijian (1):
      hv: vmbus: Convert sprintf() family to sysfs_emit() family

Michael Kelley (1):
      Drivers: hv: vmbus: Don't free ring buffers that couldn't be re-encrypted

Nuno Das Neves (1):
      mshyperv: Introduce hv_numa_node_to_pxm_info()

Rick Edgecombe (4):
      Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
      Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
      hv_netvsc: Don't free decrypted memory
      uio_hv_generic: Don't free decrypted memory

Shradha Gupta (1):
      hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for keyfile format

 arch/x86/hyperv/hv_apic.c         |  16 +--
 arch/x86/hyperv/hv_proc.c         |  22 +---
 drivers/hv/channel.c              |  29 +++++-
 drivers/hv/connection.c           |  29 ++++--
 drivers/hv/vmbus_drv.c            |  94 ++++++++---------
 drivers/net/hyperv/netvsc.c       |   7 +-
 drivers/uio/uio_hv_generic.c      |  12 ++-
 include/asm-generic/hyperv-tlfs.h |  19 ++--
 include/asm-generic/mshyperv.h    |  14 +++
 include/linux/hyperv.h            |   1 +
 tools/hv/hv_kvp_daemon.c          | 213 ++++++++++++++++++++++++++++++--------
 11 files changed, 307 insertions(+), 149 deletions(-)

